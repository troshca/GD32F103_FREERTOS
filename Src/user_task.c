#include "user_task.h"

TaskHandle_t StartTask_Handler;
TaskHandle_t Task1_Handler;
TaskHandle_t Task2_Handler;

void start_task(void *pvParameters)
{
    taskENTER_CRITICAL();

    xTaskCreate((TaskFunction_t)task1,
                (const char *)"task1",
                (uint16_t)TASK1_STK_SIZE,
                (void *)NULL,
                (UBaseType_t)TASK1_PRIO,
                (TaskHandle_t *)&Task1_Handler);

    xTaskCreate((TaskFunction_t)task2,
                (const char *)"task2",
                (uint16_t)TASK2_STK_SIZE,
                (void *)NULL,
                (UBaseType_t)TASK2_PRIO,
                (TaskHandle_t *)&Task2_Handler);

    printf("meter_task has been created\n\r");

    vTaskDelete(StartTask_Handler);
    taskEXIT_CRITICAL();
}

void task1(void *pvParameters)
{
    for (;;)
    {
        printf("\n\rTASK1: Set");
        gpio_bit_set(GPIOC, GPIO_PIN_13);
        delay_1ms(1000);
        printf("\n\rTASK1: reset");
        gpio_bit_reset(GPIOC, GPIO_PIN_13);
        delay_1ms(1000);
    }
}

void task2(void *pvParameters)
{
    for(;;)
    {
        vTaskDelay(500);
        printf("\n\rTASK2: Delay...");
    }
}