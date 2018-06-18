/*
 * ------------------------------------------------------------------------
 *   File Name: app.cpp
 *      Author: Zhao Yanbai
 *              2018-06-18 16:01:26 Monday CST
 * Description: none
 * ------------------------------------------------------------------------
 */
#include <AceAvr.h>

uint8_t debug_task_stack[TASK_STACK_SIZE];
void debug_task() {
    while(1) {
        Serial.println("debug task");
        task_delay(1000);
    }
}

uint8_t led_task_stack[TASK_STACK_SIZE];
void led_task() {
    uint8_t pin = 13;
    set_digital_pin_mode(pin, OUTPUT);
    while(1) {
        digital_write(pin, HIGH);
        task_delay(10);
        digital_write(pin, LOW);
        task_delay(10);
    }
}

uint8_t user_task1_stack[TASK_STACK_SIZE];
void user_task1() {
    while(1) {
        Serial.println("user task 1");
        task_delay(100);
    }
}




void app_main() {
    Serial.begin(9600);
    create_task(led_task, led_task_stack, 0);
    create_task(user_task1, user_task1_stack, 1);
    create_task(debug_task, debug_task_stack, 3);
}

