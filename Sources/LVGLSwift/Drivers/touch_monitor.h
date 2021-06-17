/**
 * @file monitor.h
 *
 */

#ifndef TOUCH_MONITOR_H
#define TOUCH_MONITOR_H

#ifdef __cplusplus
extern "C" {
#endif

/*********************
 *      INCLUDES
 *********************/
#ifndef LV_DRV_NO_CONF
#ifdef LV_CONF_INCLUDE_SIMPLE
#include "lv_drv_conf.h"
#else
#include "../lv_drv_conf.h"
#endif
#endif

#if USE_MONITOR

#ifdef LV_LVGL_H_INCLUDE_SIMPLE
#include "lvgl.h"
#else
#include "../lvgl/lvgl.h"
#endif

/*********************
 *      DEFINES
 *********************/

/**********************
 *      TYPEDEFS
 **********************/

/**********************
 * GLOBAL PROTOTYPES
 **********************/
void touch_monitor_init(void);
void touch_monitor_flush(lv_disp_drv_t * disp_drv, const lv_area_t * area, lv_color_t * color_p);
void touch_monitor_flush2(lv_disp_drv_t * disp_drv, const lv_area_t * area, lv_color_t * color_p);

/**********************
 *      MACROS
 **********************/

#endif /* USE_MONITOR */

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif /* MONITOR_H */
