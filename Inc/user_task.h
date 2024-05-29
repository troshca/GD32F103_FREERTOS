#ifndef __USER_TASKS_H
#define __USER_TASKS_H

#include "main.h"
#include "task.h"

/*FREERTOS*/

void start_task(void *pvParameters);

void task1(void *pvParameters);

void task2(void *pvParameters);

#endif /* __USER_TASKS_H */