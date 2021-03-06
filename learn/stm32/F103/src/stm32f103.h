/*
 * registers.h
 *
 *  Created on: May 24, 2019
 *      Author: ace
 */

#ifndef STM32F103_H_
#define STM32F103_H_


#include <stdint.h>


#define PERIPH_BASE 0x40000000
#define APB1PERIPH_BASE (PERIPH_BASE+0x00000)
#define APB2PERIPH_BASE (PERIPH_BASE+0x10000)
#define AHBPERIPH_BASE  (PERIPH_BASE+0x20000)


#define GPIOA_BASE	(APB2PERIPH_BASE+0x0800)
#define GPIOB_BASE	(APB2PERIPH_BASE+0x0C00)
#define GPIOC_BASE	(APB2PERIPH_BASE+0x1000)
#define GPIOD_BASE	(APB2PERIPH_BASE+0x1400)
#define GPIOE_BASE	(APB2PERIPH_BASE+0x1800)

#define RCC_BASE		(AHBPERIPH_BASE+0x1000)


#endif /* STM32F103_H_ */
