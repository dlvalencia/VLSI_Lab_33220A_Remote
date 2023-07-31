#include "xparameters.h"
#include "xil_printf.h"
#include "xil_exception.h"
#include "xscugic.h"
#include "xil_io.h"
#include <stdio.h>

//FPGA PL BRAM Controller Interrupt ID
#define FPGA_INTR_ID XPAR_FABRIC_XIL_ADC_BRAM_CONTROL_0_ADC_BRAM_INTR_INTR

//Interrupt Controller ID
#define GIC_DEVICE_ID XPAR_SCUGIC_0_DEVICE_ID

//Interrupt Handler
#define INTC_HANDLER XScuGic_InterruptHandler

// IRQ Handling Function
void IRQ_Handler(void *CallbackRef);

// GIC Configuration
static int GIC_Setup(XScuGic* GicInst, u16 IntrId);

//AXI BRAM Controller Address
#define BRAM_CTRL_ADDRESS XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR

//PL BRAM Controller Address
#define ADC_BRAM_CTRL_ADDRESS XPAR_XIL_ADC_BRAM_CONTROL_0_BASEADDR

//ADC DECIMATOR Address
#define ADC_DECIMATOR_ADDRESS XPAR_AXI_ADC_DECIMATOR_0_BASEADDR

// Instance of the General Interrupt Controller
XScuGic GIC;

volatile int PL_Finished;
const int LOOP_INPUTS = 16;
const int DECIMATION_FACTOR = 4;

int main(void)
{
	PL_Finished = 0;
	Xil_Out32(ADC_BRAM_CTRL_ADDRESS, 0);
	int Status;
	int Decimation_Factor;
	int temp_df;
	Status = GIC_Setup(&GIC, FPGA_INTR_ID);
	if (Status != XST_SUCCESS) {
	return XST_FAILURE;
	}
	Xil_Out32(ADC_BRAM_CTRL_ADDRESS+16, LOOP_INPUTS);
	Xil_Out32(ADC_DECIMATOR_ADDRESS, DECIMATION_FACTOR);
	Decimation_Factor = Xil_In32(ADC_DECIMATOR_ADDRESS);
	float xadc_sample_rate = 40.0/(float)Decimation_Factor;
	//LOOP_INPUTS = Xil_In32(ADC_BRAM_CTRL_ADDRESS+16);
	while(1){
		//Decimation_Factor = Xil_In32(ADC_DECIMATOR_ADDRESS);
		//printf("Current decimation factor: %d (%8.4f kS/s)\n\r", Decimation_Factor, xadc_sample_rate);
		//printf("Enter new decimation factor or 0 to leave the same: ");
		//scanf("%d", &temp_df);
		//if(temp_df != 0){
		//	Xil_Out32(ADC_DECIMATOR_ADDRESS, temp_df);
		//	Decimation_Factor = Xil_In32(ADC_DECIMATOR_ADDRESS);
		//	xadc_sample_rate = 40.0/(float)Decimation_Factor;
		//	printf("\n\rUpdated decimation factor: %d (%8.4f kS/s)\n\r", Decimation_Factor, xadc_sample_rate);
		//}
		//printf("Enter number of ADC values to read: ");
		//scanf("%d", &LOOP_INPUTS);
		//printf("\n\r");
		//xil_printf("\n\rThe value of LOOP_INPUTS is %d\n\r", LOOP_INPUTS);
		//Xil_Out32(ADC_BRAM_CTRL_ADDRESS+16, LOOP_INPUTS);
		Xil_Out32(ADC_BRAM_CTRL_ADDRESS, 1);
		PL_Finished = 0;
		while(PL_Finished == 0);
	}

return 1;
}

static int GIC_Setup(XScuGic *GicInst,
u16 IntrId)
{
	int Status;

	XScuGic_Config *IntcConfig;

	//Initialize the interrupt controller.
	IntcConfig = XScuGic_LookupConfig(GIC_DEVICE_ID);
	if (NULL == IntcConfig) {
		return XST_FAILURE;
	}

	Status = XScuGic_CfgInitialize(GicInst, IntcConfig,
	IntcConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XScuGic_SetPriorityTriggerType(GicInst, IntrId,
	0xA0, 0x3);

	//Connect the interrupt handler to the GIC.
	Status = XScuGic_Connect(GicInst, IntrId,
	(Xil_ExceptionHandler)IRQ_Handler,
	0);
	if (Status != XST_SUCCESS) {
		return Status;
	}

	//Enable the interrupt for this specific device.
	XScuGic_Enable(GicInst, IntrId);

	//Initialize the exception table.
	Xil_ExceptionInit();

	//Register the interrupt controller handler with the exception table.
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
	(Xil_ExceptionHandler) INTC_HANDLER,
	GicInst);

	//Enable non-critical exceptions.
	Xil_ExceptionEnable();

return XST_SUCCESS;
}

// IRQ Handling function
void IRQ_Handler(void *CallbackRef)
{
	unsigned int readValue = 0;
	for(int i = 0; i < LOOP_INPUTS; i++){
		readValue = Xil_In32(BRAM_CTRL_ADDRESS + i*4);
		//xil_printf("%08x", readValue);
		xil_printf("%04d", readValue);
	}
	PL_Finished = 1;
	Xil_Out32(ADC_BRAM_CTRL_ADDRESS, 0);
}

