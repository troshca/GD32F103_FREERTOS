#include "main.h"

extern TaskHandle_t StartTask_Handler;

/*!
    \brief      main function
    \param[in]  none
    \param[out] none
    \retval     none
*/
int main(void)
{
    /*System*/
    SystemInit();
    systick_config();

    /*Global interrupts for FREERTOS*/
    NVIC_SetPriorityGrouping(0);
    nvic_priority_group_set(NVIC_PRIGROUP_PRE4_SUB0);

    /* enable the LED clock */
    rcu_periph_clock_enable(RCU_GPIOC);
    /* configure LED GPIO port */
    gpio_init(GPIOC, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, GPIO_PIN_13);
    gpio_bit_reset(GPIOC, GPIO_PIN_13);
    gpio_bit_set(GPIOC, GPIO_PIN_13);

    xTaskCreate((TaskFunction_t)start_task,
                (const char *)"start_task",
                (uint16_t)START_STK_SIZE,
                (void *)NULL,
                (UBaseType_t)START_TASK_PRIO,
                (TaskHandle_t *)&StartTask_Handler);

    printf("start_task has been created\n\r");
    printf("sheduler is starting...\n\r");

    vTaskStartScheduler();

    while(1)
    {
        
    }
}