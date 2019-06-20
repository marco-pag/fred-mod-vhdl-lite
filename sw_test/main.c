#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_cache.h"
#include "sleep.h"

#include "xfred/xfred_mod.h"

#define FRED_ARGS_COUNT 8
#define AR_SIZE 128

static uint32_t dest[AR_SIZE];
static uint32_t src[AR_SIZE];

XFred_mod fred_mod;
XFred_mod_Config fred_mod_config;

void fill_array(uint32_t *array, int size, int seed)
{
	for (unsigned i = 0; i < size; ++i)
		array[i] = i + 100 * seed;
}

int compare_array(const uint32_t *array_1, const uint32_t *array_2, int size)
{
	for (int i = 0; i < size; ++i) {
		if (array_1[i] != array_2[i])
			return -1;
	}

	return 0;
}

void print_array(uint32_t *array, int size)
{
	for (int i = 0; i < size; ++i)
		printf("%lu \t", array[i]);

	printf("\n");
}

int main()
{
	int retval;
	uint32_t args[FRED_ARGS_COUNT];

    init_platform();

    Xil_DCacheDisable();

    args[0] = (uint32_t)dest;
    args[1] = (uint32_t)src;
    args[2] = AR_SIZE;

    printf("Hello World\n");

    fred_mod_config.Ctrl_bus_BaseAddress = XPAR_FRED_MOD_LITE_V1_0_0_BASEADDR;

    retval = XFred_mod_CfgInitialize(&fred_mod, &fred_mod_config);
    if (retval != XST_SUCCESS) {
		printf("ERROR: Could not initialize accelerator.\n");
		return 1;
    }

    for (int i = 0; i < 4; i++) {

    	fill_array(dest, AR_SIZE, i);
    	fill_array(src, AR_SIZE, i);

		XFred_mod_Write_args_Words(&fred_mod, 0, (int *)&args, FRED_ARGS_COUNT);

		if (!XFred_mod_IsReady(&fred_mod)) {
			printf("ERROR: hw_mod is not ready!\n");
			return 1;
		}

		printf("module id %lu starting...\n", XFred_mod_Get_id(&fred_mod));

		XFred_mod_Start(&fred_mod);
		while (!XFred_mod_IsDone(&fred_mod)) {}



		retval = compare_array(dest, src, AR_SIZE);
		if (retval) {
			printf("copy error!\n");
			return -1;
		}

		printf("done\n");
		print_array(dest, 5);
    }

    cleanup_platform();
    return 0;
}
