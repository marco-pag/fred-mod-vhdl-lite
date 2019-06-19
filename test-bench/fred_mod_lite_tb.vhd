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

entity tb_fred_mod_lite_v1_0 is
end tb_fred_mod_lite_v1_0;

architecture tb of tb_fred_mod_lite_v1_0 is

    component fred_mod_lite_v1_0
    generic (
        -- Parameters of Axi Slave Bus Interface
        C_S00_AXI_ADDR_WIDTH    : integer    := 7;
        C_S00_AXI_DATA_WIDTH    : integer    := 32;
    
        -- Parameters of Axi Master Bus Interface
        C_M00_AXI_ADDR_WIDTH    : integer    := 32;
        C_M00_AXI_DATA_WIDTH    : integer    := 32
    );
    port (
        interrupt              : out std_logic;
        ap_clk                 : in std_logic;
        ap_rst_n               : in std_logic;
        s_axi_ctrl_bus_awaddr  : in std_logic_vector (c_s00_axi_addr_width-1 downto 0);
        s_axi_ctrl_bus_awvalid : in std_logic;
        s_axi_ctrl_bus_awready : out std_logic;
        s_axi_ctrl_bus_wdata   : in std_logic_vector (c_s00_axi_data_width-1 downto 0);
        s_axi_ctrl_bus_wstrb   : in std_logic_vector ((c_s00_axi_data_width/8)-1 downto 0);
        s_axi_ctrl_bus_wvalid  : in std_logic;
        s_axi_ctrl_bus_wready  : out std_logic;
        s_axi_ctrl_bus_bresp   : out std_logic_vector (1 downto 0);
        s_axi_ctrl_bus_bvalid  : out std_logic;
        s_axi_ctrl_bus_bready  : in std_logic;
        s_axi_ctrl_bus_araddr  : in std_logic_vector (c_s00_axi_addr_width-1 downto 0);
        s_axi_ctrl_bus_arvalid : in std_logic;
        s_axi_ctrl_bus_arready : out std_logic;
        s_axi_ctrl_bus_rdata   : out std_logic_vector (c_s00_axi_data_width-1 downto 0);
        s_axi_ctrl_bus_rresp   : out std_logic_vector (1 downto 0);
        s_axi_ctrl_bus_rvalid  : out std_logic;
        s_axi_ctrl_bus_rready  : in std_logic;
        m_axi_mem_bus_awaddr   : out std_logic_vector (c_m00_axi_addr_width-1 downto 0);
        m_axi_mem_bus_awprot   : out std_logic_vector (2 downto 0);
        m_axi_mem_bus_awvalid  : out std_logic;
        m_axi_mem_bus_awready  : in std_logic;
        m_axi_mem_bus_wdata    : out std_logic_vector (c_m00_axi_data_width-1 downto 0);
        m_axi_mem_bus_wstrb    : out std_logic_vector (c_m00_axi_data_width/8-1 downto 0);
        m_axi_mem_bus_wvalid   : out std_logic;
        m_axi_mem_bus_wready   : in std_logic;
        m_axi_mem_bus_bresp    : in std_logic_vector (1 downto 0);
        m_axi_mem_bus_bvalid   : in std_logic;
        m_axi_mem_bus_bready   : out std_logic;
        m_axi_mem_bus_araddr   : out std_logic_vector (c_m00_axi_addr_width-1 downto 0);
        m_axi_mem_bus_arprot   : out std_logic_vector (2 downto 0);
        m_axi_mem_bus_arvalid  : out std_logic;
        m_axi_mem_bus_arready  : in std_logic;
        m_axi_mem_bus_rdata    : in std_logic_vector (c_m00_axi_data_width-1 downto 0);
        m_axi_mem_bus_rresp    : in std_logic_vector (1 downto 0);
        m_axi_mem_bus_rvalid   : in std_logic;
        m_axi_mem_bus_rready   : out std_logic
    );
    end component;
    
    component slave_sink_lite_v1_0_S00_AXI is
        generic (
            C_S_AXI_DATA_WIDTH    : integer    := 32;
            C_S_AXI_ADDR_WIDTH    : integer    := 9
        );
        port (
            S_AXI_ACLK    : in std_logic;
            S_AXI_ARESETN    : in std_logic;
            S_AXI_AWADDR    : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
            S_AXI_AWPROT    : in std_logic_vector(2 downto 0);
            S_AXI_AWVALID    : in std_logic;
            S_AXI_AWREADY    : out std_logic;
            S_AXI_WDATA    : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
            S_AXI_WSTRB    : in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
            S_AXI_WVALID    : in std_logic;
            S_AXI_WREADY    : out std_logic;
            S_AXI_BRESP    : out std_logic_vector(1 downto 0);
            S_AXI_BVALID    : out std_logic;
            S_AXI_BREADY    : in std_logic;
            S_AXI_ARADDR    : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
            S_AXI_ARPROT    : in std_logic_vector(2 downto 0);
            S_AXI_ARVALID    : in std_logic;
            S_AXI_ARREADY    : out std_logic;
            S_AXI_RDATA    : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
            S_AXI_RRESP    : out std_logic_vector(1 downto 0);
            S_AXI_RVALID    : out std_logic;
            S_AXI_RREADY    : in std_logic
        );
    end component;
    
    constant TB_C_S00_AXI_ADDR_WIDTH : integer := 7;  
    constant TB_C_S00_AXI_DATA_WIDTH : integer := 32;

    constant TB_C_M00_AXI_ADDR_WIDTH : integer := 9;
    constant TB_C_M00_AXI_DATA_WIDTH : integer := 32;

    signal tb_interrupt              : std_logic;
    signal tb_s_axi_ctrl_bus_awaddr  : std_logic_vector (TB_C_S00_AXI_ADDR_WIDTH-1 downto 0);
    signal tb_s_axi_ctrl_bus_awvalid : std_logic;
    signal tb_s_axi_ctrl_bus_awready : std_logic;
    signal tb_s_axi_ctrl_bus_wdata   : std_logic_vector (TB_C_S00_AXI_DATA_WIDTH-1 downto 0);
    signal tb_s_axi_ctrl_bus_wstrb   : std_logic_vector ((TB_C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
    signal tb_s_axi_ctrl_bus_wvalid  : std_logic;
    signal tb_s_axi_ctrl_bus_wready  : std_logic;
    signal tb_s_axi_ctrl_bus_bresp   : std_logic_vector (1 downto 0);
    signal tb_s_axi_ctrl_bus_bvalid  : std_logic;
    signal tb_s_axi_ctrl_bus_bready  : std_logic;
    signal tb_s_axi_ctrl_bus_araddr  : std_logic_vector (TB_C_S00_AXI_ADDR_WIDTH-1 downto 0);
    signal tb_s_axi_ctrl_bus_arvalid : std_logic;
    signal tb_s_axi_ctrl_bus_arready : std_logic;
    signal tb_s_axi_ctrl_bus_rdata   : std_logic_vector (TB_C_S00_AXI_DATA_WIDTH-1 downto 0);
    signal tb_s_axi_ctrl_bus_rresp   : std_logic_vector (1 downto 0);
    signal tb_s_axi_ctrl_bus_rvalid  : std_logic;
    signal tb_s_axi_ctrl_bus_rready  : std_logic;
    signal tb_m_axi_mem_bus_awaddr   : std_logic_vector (TB_C_M00_AXI_ADDR_WIDTH-1 downto 0);
    signal tb_m_axi_mem_bus_awprot   : std_logic_vector (2 downto 0);
    signal tb_m_axi_mem_bus_awvalid  : std_logic;
    signal tb_m_axi_mem_bus_awready  : std_logic;
    signal tb_m_axi_mem_bus_wdata    : std_logic_vector (TB_C_M00_AXI_DATA_WIDTH-1 downto 0);
    signal tb_m_axi_mem_bus_wstrb    : std_logic_vector (TB_C_M00_AXI_DATA_WIDTH/8-1 downto 0);
    signal tb_m_axi_mem_bus_wvalid   : std_logic;
    signal tb_m_axi_mem_bus_wready   : std_logic;
    signal tb_m_axi_mem_bus_bresp    : std_logic_vector (1 downto 0);
    signal tb_m_axi_mem_bus_bvalid   : std_logic;
    signal tb_m_axi_mem_bus_bready   : std_logic;
    signal tb_m_axi_mem_bus_araddr   : std_logic_vector (TB_C_M00_AXI_ADDR_WIDTH-1 downto 0);
    signal tb_m_axi_mem_bus_arprot   : std_logic_vector (2 downto 0);
    signal tb_m_axi_mem_bus_arvalid  : std_logic;
    signal tb_m_axi_mem_bus_arready  : std_logic;
    signal tb_m_axi_mem_bus_rdata    : std_logic_vector (TB_C_M00_AXI_DATA_WIDTH-1 downto 0);
    signal tb_m_axi_mem_bus_rresp    : std_logic_vector (1 downto 0);
    signal tb_m_axi_mem_bus_rvalid   : std_logic;
    signal tb_m_axi_mem_bus_rready   : std_logic;

    constant tb_clk_period : time := 10 ns;
    signal tb_clk : std_logic := '0';
    signal tb_done : std_logic := '0';
    signal tb_resetn : std_logic := '1';
    
    signal write_start : std_logic := '0';
    signal write_done : std_logic := '0';
    
    signal read_start : std_logic := '0';
    signal read_done : std_logic := '0';
    
    signal axi_addr_read_reg : std_logic_vector (TB_C_S00_AXI_ADDR_WIDTH-1 downto 0);
    signal axi_data_read_reg : std_logic_vector (TB_C_S00_AXI_DATA_WIDTH-1 downto 0);
    signal axi_addr_write_reg : std_logic_vector (TB_C_S00_AXI_ADDR_WIDTH-1 downto 0);
    signal axi_data_write_reg : std_logic_vector (TB_C_S00_AXI_DATA_WIDTH-1 downto 0);
    
    type axi_read_state_t is (S0, S1);
    signal axi_read_state : axi_read_state_t;
    
    type axi_write_state_t is (S0, S1, S2);
    signal axi_write_state : axi_write_state_t;
    
    signal arg0 : std_logic_vector (TB_C_S00_AXI_DATA_WIDTH-1 downto 0);
    signal arg1 : std_logic_vector (TB_C_S00_AXI_DATA_WIDTH-1 downto 0);
    signal arg2 : std_logic_vector (TB_C_S00_AXI_DATA_WIDTH-1 downto 0);

begin

    dut : fred_mod_lite_v1_0
    generic map(
        C_S00_AXI_ADDR_WIDTH => TB_C_S00_AXI_ADDR_WIDTH,
        C_S00_AXI_DATA_WIDTH => TB_C_S00_AXI_DATA_WIDTH, 
        C_M00_AXI_ADDR_WIDTH => TB_C_M00_AXI_ADDR_WIDTH,
        C_M00_AXI_DATA_WIDTH => TB_C_M00_AXI_DATA_WIDTH
    )
    port map (
        interrupt              => tb_interrupt,
        ap_clk                 => tb_clk,
        ap_rst_n               => tb_resetn,
        s_axi_ctrl_bus_awaddr  => tb_s_axi_ctrl_bus_awaddr,
        s_axi_ctrl_bus_awvalid => tb_s_axi_ctrl_bus_awvalid,
        s_axi_ctrl_bus_awready => tb_s_axi_ctrl_bus_awready,
        s_axi_ctrl_bus_wdata   => tb_s_axi_ctrl_bus_wdata,
        s_axi_ctrl_bus_wstrb   => tb_s_axi_ctrl_bus_wstrb,
        s_axi_ctrl_bus_wvalid  => tb_s_axi_ctrl_bus_wvalid,
        s_axi_ctrl_bus_wready  => tb_s_axi_ctrl_bus_wready,
        s_axi_ctrl_bus_bresp   => tb_s_axi_ctrl_bus_bresp,
        s_axi_ctrl_bus_bvalid  => tb_s_axi_ctrl_bus_bvalid,
        s_axi_ctrl_bus_bready  => tb_s_axi_ctrl_bus_bready,
        s_axi_ctrl_bus_araddr  => tb_s_axi_ctrl_bus_araddr,
        s_axi_ctrl_bus_arvalid => tb_s_axi_ctrl_bus_arvalid,
        s_axi_ctrl_bus_arready => tb_s_axi_ctrl_bus_arready,
        s_axi_ctrl_bus_rdata   => tb_s_axi_ctrl_bus_rdata,
        s_axi_ctrl_bus_rresp   => tb_s_axi_ctrl_bus_rresp,
        s_axi_ctrl_bus_rvalid  => tb_s_axi_ctrl_bus_rvalid,
        s_axi_ctrl_bus_rready  => tb_s_axi_ctrl_bus_rready,
        m_axi_mem_bus_awaddr   => tb_m_axi_mem_bus_awaddr,
        m_axi_mem_bus_awprot   => tb_m_axi_mem_bus_awprot,
        m_axi_mem_bus_awvalid  => tb_m_axi_mem_bus_awvalid,
        m_axi_mem_bus_awready  => tb_m_axi_mem_bus_awready,
        m_axi_mem_bus_wdata    => tb_m_axi_mem_bus_wdata,
        m_axi_mem_bus_wstrb    => tb_m_axi_mem_bus_wstrb,
        m_axi_mem_bus_wvalid   => tb_m_axi_mem_bus_wvalid,
        m_axi_mem_bus_wready   => tb_m_axi_mem_bus_wready,
        m_axi_mem_bus_bresp    => tb_m_axi_mem_bus_bresp,
        m_axi_mem_bus_bvalid   => tb_m_axi_mem_bus_bvalid,
        m_axi_mem_bus_bready   => tb_m_axi_mem_bus_bready,
        m_axi_mem_bus_araddr   => tb_m_axi_mem_bus_araddr,
        m_axi_mem_bus_arprot   => tb_m_axi_mem_bus_arprot,
        m_axi_mem_bus_arvalid  => tb_m_axi_mem_bus_arvalid,
        m_axi_mem_bus_arready  => tb_m_axi_mem_bus_arready,
        m_axi_mem_bus_rdata    => tb_m_axi_mem_bus_rdata,
        m_axi_mem_bus_rresp    => tb_m_axi_mem_bus_rresp,
        m_axi_mem_bus_rvalid   => tb_m_axi_mem_bus_rvalid,
        m_axi_mem_bus_rready   => tb_m_axi_mem_bus_rready
    );
    
    slave_sink : slave_sink_lite_v1_0_S00_AXI
    generic map (
        C_S_AXI_DATA_WIDTH => TB_C_M00_AXI_DATA_WIDTH,
        C_S_AXI_ADDR_WIDTH => TB_C_M00_AXI_ADDR_WIDTH
    )
    port map (
        S_AXI_ACLK      => tb_clk,
        S_AXI_ARESETN   => tb_resetn,
        S_AXI_AWADDR    => tb_m_axi_mem_bus_awaddr,
        S_AXI_AWPROT    => tb_m_axi_mem_bus_awprot,
        S_AXI_AWVALID   => tb_m_axi_mem_bus_awvalid,
        S_AXI_AWREADY   => tb_m_axi_mem_bus_awready,
        S_AXI_WDATA     => tb_m_axi_mem_bus_wdata,
        S_AXI_WSTRB     => tb_m_axi_mem_bus_wstrb,
        S_AXI_WVALID    => tb_m_axi_mem_bus_wvalid,
        S_AXI_WREADY    => tb_m_axi_mem_bus_wready,
        S_AXI_BRESP     => tb_m_axi_mem_bus_bresp,
        S_AXI_BVALID    => tb_m_axi_mem_bus_bvalid,
        S_AXI_BREADY    => tb_m_axi_mem_bus_bready,
        S_AXI_ARADDR    => tb_m_axi_mem_bus_araddr,
        S_AXI_ARPROT    => tb_m_axi_mem_bus_arprot,
        S_AXI_ARVALID   => tb_m_axi_mem_bus_arvalid,
        S_AXI_ARREADY   => tb_m_axi_mem_bus_arready,
        S_AXI_RDATA     => tb_m_axi_mem_bus_rdata,
        S_AXI_RRESP     => tb_m_axi_mem_bus_rresp,
        S_AXI_RVALID    => tb_m_axi_mem_bus_rvalid,
        S_AXI_RREADY    => tb_m_axi_mem_bus_rready
    );
   
    -- tb clock generation process
    clk_proc : process
    begin
      if (tb_done = '1') then
        tb_clk <= '0';
        report "sim done" severity failure;
      else
        tb_clk <= '0';
        wait for tb_clk_period / 2;
        tb_clk <= '1';
        wait for tb_clk_period / 2;
      end if;
    end process;

      axi_read : process(tb_clk)
      begin
        if (tb_resetn = '0') then
          read_done <= '0';
          axi_read_state <= S0;
          tb_s_axi_ctrl_bus_arvalid <= '0';
          tb_s_axi_ctrl_bus_rready <= '0';
          axi_data_read_reg <= (others => '0');
        elsif rising_edge(tb_clk) then
          case axi_read_state is
            when S0 =>
              if (read_start = '1') then
                read_done <= '0';
                tb_s_axi_ctrl_bus_araddr <= axi_addr_read_reg;
                tb_s_axi_ctrl_bus_arvalid <= '1';
                tb_s_axi_ctrl_bus_rready <= '1';
                axi_read_state <= S1;
              end if;
            when S1 =>
              if (tb_s_axi_ctrl_bus_arready = '1') then
                tb_s_axi_ctrl_bus_arvalid <= '0';
              end if;
              if (tb_s_axi_ctrl_bus_rvalid = '1') then
                axi_data_read_reg <= tb_s_axi_ctrl_bus_rdata;
                tb_s_axi_ctrl_bus_rready <= '0';
              end if;
              if (tb_s_axi_ctrl_bus_arvalid = '0' and tb_s_axi_ctrl_bus_rready = '0') then
                read_done <= '1';
                axi_read_state <= S0;
              end if;
          end case;
        end if;
      end process axi_read;
      
      axi_write : process(tb_clk)
      begin
        if (tb_resetn = '0') then
          write_done <= '0';
          axi_write_state <= S0;
          tb_s_axi_ctrl_bus_awvalid <= '0';
          tb_s_axi_ctrl_bus_wvalid <= '0';
          tb_s_axi_ctrl_bus_bready <= '0';
        elsif rising_edge(tb_clk) then
          case axi_write_state is
            when S0 =>
              if (write_start = '1') then
                write_done <= '0';
                tb_s_axi_ctrl_bus_wstrb <= b"1111";
                tb_s_axi_ctrl_bus_awaddr <= axi_addr_write_reg;
                tb_s_axi_ctrl_bus_wdata <= axi_data_write_reg;
                tb_s_axi_ctrl_bus_awvalid <= '1';
                tb_s_axi_ctrl_bus_wvalid <= '1';
                axi_write_state <= S1;
              end if;
            when S1 =>
              if (tb_s_axi_ctrl_bus_awready = '1') then
                tb_s_axi_ctrl_bus_awvalid <= '0';
              end if;
              if (tb_s_axi_ctrl_bus_wready = '1') then
                tb_s_axi_ctrl_bus_wvalid <= '0';
              end if;
              if (tb_s_axi_ctrl_bus_awvalid = '0' and tb_s_axi_ctrl_bus_wvalid = '0') then  
                tb_s_axi_ctrl_bus_bready <= '1';
                axi_write_state <= S2;
              end if;
            when S2 =>
              if (tb_s_axi_ctrl_bus_bvalid = '1') then
                tb_s_axi_ctrl_bus_bready <= '0';
                write_done <= '1';
                axi_write_state <= S0;
              end if;
          end case;
        end if;
      end process axi_write;
        
    tb : process
    begin
      read_start <= '0';
      write_start <= '0';

      -- Reset generation
      tb_resetn <= '0';
      wait for tb_clk_period * 2;
      tb_resetn <= '1';
      
      wait for tb_clk_period * 4;
      
      -- Read reg  0x00 : Control signals
      axi_addr_read_reg <= std_logic_vector(to_unsigned(16#00#, tb_s_axi_ctrl_bus_araddr'length));
      read_start <= '1';
      wait for tb_clk_period;
      read_start <= '0';
      wait until read_done = '1';

      wait for tb_clk_period * 4;
              
      arg0 <= std_logic_vector(to_unsigned(8 * 4, arg0'length));
      arg1 <= std_logic_vector(to_unsigned(0 * 4, arg0'length));
      arg2 <= std_logic_vector(to_unsigned(8, arg0'length));
      wait for tb_clk_period;
              
      -- Write addr_out 0x3f : Memory 'args' (8 * 32b)
      axi_addr_write_reg <= std_logic_vector(to_unsigned(16#20# + 4 * 0, tb_s_axi_ctrl_bus_awaddr'length));
      axi_data_write_reg <= arg0;
      write_start <= '1';
      wait for tb_clk_period;
      write_start <= '0';
      wait until write_done = '1';
      
      wait for tb_clk_period * 4;
      
      -- Write addr_in 0x3f : Memory 'args' (8 * 32b)
      axi_addr_write_reg <= std_logic_vector(to_unsigned(16#20# + 4 * 1, tb_s_axi_ctrl_bus_awaddr'length));
      axi_data_write_reg <= arg1;
      write_start <= '1';
      wait for tb_clk_period;
      write_start <= '0';
      wait until write_done = '1';
      
      wait for tb_clk_period * 4;
      
      -- Write count 0x3f : Memory 'args' (8 * 32b)
      axi_addr_write_reg <= std_logic_vector(to_unsigned(16#20# + 4 * 2, tb_s_axi_ctrl_bus_awaddr'length));
      axi_data_write_reg <= arg2;
      write_start <= '1';
      wait for tb_clk_period;
      write_start <= '0';
      wait until write_done = '1';
      
      wait for tb_clk_period * 4;

      -- Read back args registers
      axi_addr_read_reg <= std_logic_vector(to_unsigned(16#20# + 4 * 0, tb_s_axi_ctrl_bus_araddr'length));
      read_start <= '1';
      wait for tb_clk_period;
      read_start <= '0';
      wait until read_done = '1';
      assert axi_data_read_reg = arg0 report "arg 0 read error" severity failure;

      wait for tb_clk_period * 4;

      axi_addr_read_reg <= std_logic_vector(to_unsigned(16#20# + 4 * 1, tb_s_axi_ctrl_bus_araddr'length));
      read_start <= '1';
      wait for tb_clk_period;
      read_start <= '0';
      wait until read_done = '1';
      assert axi_data_read_reg = arg1 report "arg 1 read error" severity failure;

      wait for tb_clk_period * 4;
      
      axi_addr_read_reg <= std_logic_vector(to_unsigned(16#20# + 4 * 2, tb_s_axi_ctrl_bus_araddr'length));
      read_start <= '1';
      wait for tb_clk_period;
      read_start <= '0';
      wait until read_done = '1';
      assert axi_data_read_reg = arg2 report "arg 2 read error" severity failure;

      wait for tb_clk_period * 4;             
      
      -- Start
      -- Read reg  0x00 : Control signals
      axi_addr_read_reg <= std_logic_vector(to_unsigned(16#00#, tb_s_axi_ctrl_bus_araddr'length));
      read_start <= '1';
      wait for tb_clk_period;
      read_start <= '0';
      wait until read_done = '1';

      wait for tb_clk_period * 2;
      
      axi_addr_write_reg <= std_logic_vector(to_unsigned(16#00#, tb_s_axi_ctrl_bus_araddr'length));
      --axi_data_write_reg <= (0 => '1', others => '0');
      axi_data_write_reg <= (axi_data_read_reg and x"00000080") or x"00000001";
      write_start <= '1';
      wait for tb_clk_period;
      write_start <= '0';
      wait until write_done = '1';
      
      -- TODO : replace with a read
      wait for tb_clk_period * 150;
      
      -- Start again
      
      arg0 <= std_logic_vector(to_unsigned(0 * 4, arg0'length));
      arg1 <= std_logic_vector(to_unsigned(5 * 4, arg0'length));
      arg2 <= std_logic_vector(to_unsigned(2, arg0'length));
      wait for tb_clk_period;
      
      -- Write addr_out 0x3f : Memory 'args' (8 * 32b)
      axi_addr_write_reg <= std_logic_vector(to_unsigned(16#20# + 4 * 0, tb_s_axi_ctrl_bus_awaddr'length));
      axi_data_write_reg <= arg0;
      write_start <= '1';
      wait for tb_clk_period;
      write_start <= '0';
      wait until write_done = '1';
      
      wait for tb_clk_period * 4;
      
      -- Write addr_in 0x3f : Memory 'args' (8 * 32b)
      axi_addr_write_reg <= std_logic_vector(to_unsigned(16#20# + 4 * 1, tb_s_axi_ctrl_bus_awaddr'length));
      axi_data_write_reg <= arg1;
      write_start <= '1';
      wait for tb_clk_period;
      write_start <= '0';
      wait until write_done = '1';
      
      wait for tb_clk_period * 4;
      
      -- Write count 0x3f : Memory 'args' (8 * 32b)
      axi_addr_write_reg <= std_logic_vector(to_unsigned(16#20# + 4 * 2, tb_s_axi_ctrl_bus_awaddr'length));
      axi_data_write_reg <= arg2;
      write_start <= '1';
      wait for tb_clk_period;
      write_start <= '0';
      wait until write_done = '1';
      
      wait for tb_clk_period * 4;
      
      -- Start
      -- Read reg  0x00 : Control signals
      axi_addr_read_reg <= std_logic_vector(to_unsigned(16#00#, tb_s_axi_ctrl_bus_araddr'length));
      read_start <= '1';
      wait for tb_clk_period;
      read_start <= '0';
      wait until read_done = '1';

      wait for tb_clk_period * 2;
      
      axi_addr_write_reg <= std_logic_vector(to_unsigned(16#00#, tb_s_axi_ctrl_bus_araddr'length));
      --axi_data_write_reg <= (0 => '1', others => '0');
      axi_data_write_reg <= (axi_data_read_reg and x"00000080") or x"00000001";
      write_start <= '1';
      wait for tb_clk_period;
      write_start <= '0';
      wait until write_done = '1';
      
      -- TODO : replace with a read
      wait for tb_clk_period * 150;

      tb_done <= '1';
    end process;

end tb;

