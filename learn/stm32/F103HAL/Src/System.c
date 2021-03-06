/*
 * System.c
 *
 *  Created on: Jun 1, 2019
 *      Author: ace
 */


#include "stm32f1xx_hal.h"



#define LED_Pin 		GPIO_PIN_6
#define LED_GPIO_Port	GPIOB

void SystemClock_Init() {
	RCC_OscInitTypeDef	RCC_OscInitStruct;
	RCC_OscInitStruct.HSEPredivValue	= RCC_HSE_PREDIV_DIV1;
	RCC_OscInitStruct.HSEState			= RCC_HSE_ON;
	RCC_OscInitStruct.HSIState			= RCC_HSI_ON;
	RCC_OscInitStruct.LSEState			= RCC_LSE_OFF;
	RCC_OscInitStruct.LSIState			= RCC_LSI_OFF;
	RCC_OscInitStruct.PLL.PLLMUL		= RCC_PLL_MUL6;			// 外部晶振是12MHz，所以为了得到72MHz，只需要乘以6
	RCC_OscInitStruct.PLL.PLLSource		= RCC_PLLSOURCE_HSE;
	RCC_OscInitStruct.PLL.PLLState		= RCC_PLL_ON;
	RCC_OscInitStruct.OscillatorType	= RCC_OSCILLATORTYPE_HSI | RCC_OSCILLATORTYPE_HSE | RCC_OSCILLATORTYPE_LSI | RCC_OSCILLATORTYPE_LSE;
	if(HAL_OK != HAL_RCC_OscConfig(&RCC_OscInitStruct)) {
		Error_Handler();
	}

	RCC_ClkInitTypeDef RCC_ClkInitStruct;
	RCC_ClkInitStruct.AHBCLKDivider	= RCC_SYSCLK_DIV1;
	RCC_ClkInitStruct.APB1CLKDivider= RCC_HCLK_DIV2;
	RCC_ClkInitStruct.APB2CLKDivider= RCC_HCLK_DIV1;
	RCC_ClkInitStruct.SYSCLKSource	= RCC_SYSCLKSOURCE_PLLCLK;
	RCC_ClkInitStruct.ClockType		= RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK1;
	if(HAL_OK != HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2)) {
		Error_Handler();
	}
}

void SysTick_Init() {
	//HAL_SysTick_Init();
	//HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);
	//HAL_InitTick(0);
	//HAL_NVIC_EnableIRQ(SysTick_IRQn);
	//HAL_NVIC_DisableIRQ(SysTick_IRQn);
	HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq()/1000);
	HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);
	//HAL_NVIC_ClearPendingIRQ(SysTick_IRQn);
}

volatile uint32_t SysTicks = 0;
void SysTick_IRQ_Handler() {
	SysTicks++;
	HAL_IncTick();
}

void Delay(uint32_t n) {

	uint32_t b = SysTicks;
	while((b+n) > SysTicks);
}

void GPIO_Init() {
	__HAL_RCC_GPIOB_CLK_ENABLE();

	// GPIO 初始化，需要启用相应GPIO Port的时钟
	GPIO_InitTypeDef GPIO_InitStruct;
	GPIO_InitStruct.Mode	= GPIO_MODE_OUTPUT_OD;
	GPIO_InitStruct.Pin		= LED_Pin;
	GPIO_InitStruct.Pull	= GPIO_NOPULL;
	GPIO_InitStruct.Speed	= GPIO_SPEED_FREQ_HIGH;
	HAL_GPIO_Init(LED_GPIO_Port, &GPIO_InitStruct);
}


void SystemSetup() {

	//__HAL_FLASH_PREFETCH_BUFFER_ENABLE();
	HAL_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_2);

	SystemClock_Init();

	SysTick_Init();

#if 1
	__HAL_RCC_AFIO_CLK_ENABLE();
	//__HAL_RCC_PWR_CLK_ENABLE();
	__HAL_AFIO_REMAP_SWJ_NOJTAG();
#endif

	GPIO_Init();
}

void SystemLoop() {
	HAL_GPIO_TogglePin(LED_GPIO_Port, LED_Pin);
	Delay(1000);
}


void SystemEntry() {

	SystemSetup();

	while(1) {
		SystemLoop();
	}
}
