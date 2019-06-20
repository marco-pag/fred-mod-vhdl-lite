// ==============================================================
// File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2017.4
// Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
// 
// ==============================================================

#ifndef XFRED_MOD_H
#define XFRED_MOD_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xfred_mod_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
#else
typedef struct {
    u16 DeviceId;
    u32 Ctrl_bus_BaseAddress;
} XFred_mod_Config;
#endif

typedef struct {
    u32 Ctrl_bus_BaseAddress;
    u32 IsReady;
} XFred_mod;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XFred_mod_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XFred_mod_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XFred_mod_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XFred_mod_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XFred_mod_Initialize(XFred_mod *InstancePtr, u16 DeviceId);
XFred_mod_Config* XFred_mod_LookupConfig(u16 DeviceId);
int XFred_mod_CfgInitialize(XFred_mod *InstancePtr, XFred_mod_Config *ConfigPtr);
#else
int XFred_mod_Initialize(XFred_mod *InstancePtr, const char* InstanceName);
int XFred_mod_Release(XFred_mod *InstancePtr);
#endif

void XFred_mod_Start(XFred_mod *InstancePtr);
u32 XFred_mod_IsDone(XFred_mod *InstancePtr);
u32 XFred_mod_IsIdle(XFred_mod *InstancePtr);
u32 XFred_mod_IsReady(XFred_mod *InstancePtr);
void XFred_mod_EnableAutoRestart(XFred_mod *InstancePtr);
void XFred_mod_DisableAutoRestart(XFred_mod *InstancePtr);

u32 XFred_mod_Get_id(XFred_mod *InstancePtr);
u32 XFred_mod_Get_id_vld(XFred_mod *InstancePtr);
void XFred_mod_Set_mem_in(XFred_mod *InstancePtr, u32 Data);
u32 XFred_mod_Get_mem_in(XFred_mod *InstancePtr);
void XFred_mod_Set_mem_out(XFred_mod *InstancePtr, u32 Data);
u32 XFred_mod_Get_mem_out(XFred_mod *InstancePtr);
u32 XFred_mod_Get_args_BaseAddress(XFred_mod *InstancePtr);
u32 XFred_mod_Get_args_HighAddress(XFred_mod *InstancePtr);
u32 XFred_mod_Get_args_TotalBytes(XFred_mod *InstancePtr);
u32 XFred_mod_Get_args_BitWidth(XFred_mod *InstancePtr);
u32 XFred_mod_Get_args_Depth(XFred_mod *InstancePtr);
u32 XFred_mod_Write_args_Words(XFred_mod *InstancePtr, int offset, int *data, int length);
u32 XFred_mod_Read_args_Words(XFred_mod *InstancePtr, int offset, int *data, int length);
u32 XFred_mod_Write_args_Bytes(XFred_mod *InstancePtr, int offset, char *data, int length);
u32 XFred_mod_Read_args_Bytes(XFred_mod *InstancePtr, int offset, char *data, int length);

void XFred_mod_InterruptGlobalEnable(XFred_mod *InstancePtr);
void XFred_mod_InterruptGlobalDisable(XFred_mod *InstancePtr);
void XFred_mod_InterruptEnable(XFred_mod *InstancePtr, u32 Mask);
void XFred_mod_InterruptDisable(XFred_mod *InstancePtr, u32 Mask);
void XFred_mod_InterruptClear(XFred_mod *InstancePtr, u32 Mask);
u32 XFred_mod_InterruptGetEnabled(XFred_mod *InstancePtr);
u32 XFred_mod_InterruptGetStatus(XFred_mod *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif