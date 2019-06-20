// ==============================================================
// File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2017.4
// Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
// 
// ==============================================================

#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xfred_mod.h"

#define XPAR_XFRED_MOD_NUM_INSTANCES 1
XFred_mod_Config XFred_mod_ConfigTable[XPAR_XFRED_MOD_NUM_INSTANCES];

XFred_mod_Config *XFred_mod_LookupConfig(u16 DeviceId) {
	XFred_mod_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XFRED_MOD_NUM_INSTANCES; Index++) {
		if (XFred_mod_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XFred_mod_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XFred_mod_Initialize(XFred_mod *InstancePtr, u16 DeviceId) {
	XFred_mod_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XFred_mod_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XFred_mod_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif
