-------------------------------------------------------------------------------
--
-- Fred for Linux. Experimental support.
-- VHDL AXI lite stub for HLS-like Fred modules
-- 
-------------------------------------------------------------------------------
-- 
-- Copyright (C) 2019, Marco Pagani, ReTiS Lab.
-- <marco.pag(at)outlook.com>
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fred_mod_lite_v1_0_core is
generic (
  C_S_AXI_ADDR_WIDTH	: integer	:= 32;
  C_S_AXI_DATA_WIDTH	: integer	:= 32;
  C_M_AXI_ADDR_WIDTH	: integer	:= 32;
  C_M_AXI_DATA_WIDTH	: integer	:= 32
);

port (
  aclk                  : in   std_logic;
  aresetn               : in   std_logic;

  -- AXI slaver internal control signals
  -- mem_in and mem_out are not used by FRED (HLS limitation)
  ap_start              : in   std_logic;
  ap_done               : out  std_logic;
  ap_ready              : out  std_logic;
  ap_idle               : out  std_logic;
  id                    : out  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
  id_ap_vld             : out  std_logic;
  args_address0         : out  std_logic_vector(2 downto 0);
  args_ce0              : out  std_logic;
  args_q0               : in   std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
--  mem_in                : in   std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
--  mem_out               : in   std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);

-- AXI master internal control signals
  IW_EXEC               : out  std_logic;
  IW_DONE               : in   std_logic;
  IW_ADDR               : out  std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
  IW_DATA               : out  std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);

  IR_EXEC               : out  std_logic;
  IR_DONE               : in   std_logic;
  IR_ADDR               : out  std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
  IR_DATA               : in   std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0)
);

end fred_mod_lite_v1_0_core;

architecture fred_mod_lite_v1_0_core_arch of fred_mod_lite_v1_0_core is
  
  -- Fred module id
  constant module_id : integer := 700;
  
  constant offset : unsigned(C_M_AXI_ADDR_WIDTH-1 downto 0) := to_unsigned(C_M_AXI_DATA_WIDTH / 8, C_M_AXI_ADDR_WIDTH);

  type core_state_t is ( IDLE,
                         WF_ARG_0,
                         LOAD_ARG_0,
                         WF_ARG_1,
                         LOAD_ARG_1,
                         WF_ARG_2,
                         LOAD_ARG_2,
                         WF_COPY );
 
  type loop_state_t is ( IDLE,
                         INIT_READ,
                         WF_READ,
                         INIT_WRITE,
                         WF_WRITE );

  signal core_state : core_state_t;
  signal loop_state : loop_state_t;
  
  signal arg_addr_dest : std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
  signal arg_addr_src  : std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
  signal arg_count  : std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
  signal data : std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
  
  signal copy_start : std_logic;
  signal copy_done : std_logic;
  signal addr_dest : std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
  signal addr_src  : std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
  signal count : unsigned(C_M_AXI_ADDR_WIDTH-1 downto 0);
  
begin

  core_ctrl : process(aclk)
  begin
    if (rising_edge(aclk)) then
      if (aresetn = '0') then
        core_state <= IDLE;
        copy_start <= '0';
        ap_done <= '0';
        ap_ready <= '1';
        ap_idle <= '1';
        id <= std_logic_vector(to_unsigned(module_id, id'length));
        id_ap_vld <= '1';
        args_ce0 <= '0';
      else
        case core_state is
          when IDLE =>
            ap_done <= '0';
            if (ap_start = '1') then
              ap_idle <= '0';
              ap_ready <= '0';
              args_address0 <= "000";
              args_ce0 <= '1';
              core_state <= WF_ARG_0;
            end if;
          when WF_ARG_0 =>
            core_state <= LOAD_ARG_0;
          when LOAD_ARG_0 =>
            arg_addr_dest <= args_q0(C_M_AXI_ADDR_WIDTH-1 downto 0);  -- sample destination addresses
            args_address0 <= "001";
            core_state <= WF_ARG_1;
          when WF_ARG_1 =>
            core_state <= LOAD_ARG_1;
          when LOAD_ARG_1 =>
            arg_addr_src <= args_q0(C_M_AXI_ADDR_WIDTH-1 downto 0);  -- sample source addresses
            args_address0 <= "010";
            core_state <= WF_ARG_2;
          when WF_ARG_2 =>
            core_state <= LOAD_ARG_2;
          when LOAD_ARG_2 =>
            arg_count <= args_q0(C_M_AXI_ADDR_WIDTH-1 downto 0);  -- sample number of elements to copy
            copy_start <= '1';  -- start copy
            core_state <= WF_COPY;
          when WF_COPY =>
            copy_start <= '0';
            if (copy_done = '1') then
              ap_idle <= '1';
              ap_ready <= '1';
              ap_done <= '1';
              core_state <= IDLE;
            end if;
        end case;
      end if;
    end if;
  end process;
  
  
  copy_loop : process(aclk)
  begin
    if (rising_edge(aclk)) then
      if (aresetn = '0') then
        loop_state <= IDLE;
        IW_EXEC <= '0';
        IR_EXEC <= '0';
        copy_done <= '0';
        addr_dest <= (others => '0');
        addr_src <= (others => '0');
        count <= (others => '0');
      else
        case loop_state is
          when IDLE =>
            copy_done <= '0';
            if (copy_start = '1') then
              addr_dest <= arg_addr_dest;
              addr_src <= arg_addr_src;
              count <= (others => '0');
              loop_state <= INIT_READ;
            end if;
          when INIT_READ =>
            IR_ADDR <= addr_src;
            IR_EXEC <= '1';
            loop_state <= WF_READ;
          when WF_READ =>
            IR_EXEC <= '0';
            if (IR_DONE = '1') then
              data <= IR_DATA;
              loop_state <= INIT_WRITE;
            end if;
          when INIT_WRITE =>
            IW_ADDR <= addr_dest;
            IW_DATA <= data;
            IW_EXEC <= '1';
            loop_state <= WF_WRITE;
          when WF_WRITE =>
            IW_EXEC <= '0';
            if (IW_DONE = '1') then
              if (count < unsigned(arg_count) - 1) then
                count <= count + 1;
                addr_src <= std_logic_vector(unsigned(addr_src) + offset);
                addr_dest <= std_logic_vector(unsigned(addr_dest) + offset);
                loop_state <= INIT_READ;
              else
                copy_done <= '1';
                loop_state <= IDLE;
              end if;
            end if;
        end case;
      end if;
    end if;
  end process;

end fred_mod_lite_v1_0_core_arch;
