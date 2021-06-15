#include "SDL.h"
#include "../lvgl/lvgl.h"
//#include "lvgl_drivers/display/monitor.h"
#ifdef TOUCH_DRIVER
#include "custom_drivers/touch_monitor.h"
#else
#include "../lv_drivers/display/monitor.h"
#include "../lv_drivers/indev/mouse.h"
#endif

#include "simulation.h"
//static void memory_monitor(lv_task_t *param);
static int tick_thread(void *data);
static void lv_display_driver_rounder_callback (
                                                lv_disp_drv_t* disp_drv,
                                                lv_area_t* area);

void simulation_hal_init(void)
{
    static lv_disp_t * theDisplay = NULL;
    static lv_disp_draw_buf_t disp_buf1;
    static lv_color_t buf1_1[LV_HOR_RES_MAX * LV_VER_RES_MAX];
    lv_disp_draw_buf_init(&disp_buf1, buf1_1, NULL, LV_HOR_RES_MAX * LV_VER_RES_MAX);
    static lv_indev_drv_t indev_drv;
    /*Create a display*/
    static lv_disp_drv_t disp_drv;
    
    /* Use the 'monitor' driver which creates window on PC's monitor to simulate a display*/
#ifdef TOUCH_DRIVER
    touch_monitor_init();
#else
    monitor_init();
#endif
    
    /*Create a display buffer*/
    lv_disp_drv_init(&disp_drv); /*Basic initialization*/
    disp_drv.draw_buf = &disp_buf1;
    disp_drv.hor_res = LV_HOR_RES_MAX;                 /*Set the horizontal resolution in pixels*/
    disp_drv.ver_res = LV_VER_RES_MAX;
    ///  disp_drv.rounder_cb = lv_display_driver_rounder_callback;x
#ifdef TOUCH_DRIVER
    disp_drv.flush_cb = touch_monitor_flush;
#else
    disp_drv.flush_cb = monitor_flush;
#endif
    theDisplay = lv_disp_drv_register(&disp_drv);
    /* Add the mouse as input device
     * Use the 'mouse' driver which reads the PC's mouse*/
    mouse_init();
    
    lv_indev_drv_init(&indev_drv); /*Basic initialization*/
    indev_drv.type = LV_INDEV_TYPE_POINTER;
    
    /*This function will be called periodically (by the library) to get the mouse position and state*/
    indev_drv.read_cb = mouse_read;
    lv_indev_drv_register(&indev_drv);
    
#ifdef TOUCH_DRIVER
    SDL_ShowCursor(SDL_DISABLE);
#endif
    
    // /*Set a cursor for the mouse*/
    // LV_IMG_DECLARE(mouse_cursor_icon); /*Declare the image file.*/
    // lv_obj_t * cursor_obj = lv_img_create(lv_scr_act(), NULL); /*Create an image object for the cursor */
    // lv_img_set_src(cursor_obj, &mouse_cursor_icon);           /*Set the image source*/
    // lv_indev_set_cursor(mouse_indev, cursor_obj);             /*Connect the image  object to the driver*/
    
    /* Tick init.
     * You have to call 'lv_tick_inc()' in periodically to inform LittelvGL about
     * how much time were elapsed Create an SDL thread to do this*/
    SDL_CreateThread(tick_thread, "tick", NULL);
    
    //  /* Optional:
    //   * Create a memory monitor task which prints the memory usage in
    //   * periodically.*/
    //  lv_task_create(memory_monitor, 5000, LV_TASK_PRIO_MID, NULL);
}

/**
 * Print the memory usage periodically
 * @param param
 */
//static void memory_monitor(lv_task_t *param)
//{
//  (void)param; /*Unused*/
//
//  lv_mem_monitor_t mon;
//  lv_mem_monitor(&mon);
//  printf("used: %6d (%3d %%), frag: %3d %%, biggest free: %6d\n",
//         (int)mon.total_size - mon.free_size, mon.used_pct, mon.frag_pct,
//         (int)mon.free_biggest_size);
//}

/**
 * A task to measure the elapsed time for LVGL
 * @param data unused
 * @return never return
 */
static int tick_thread(void *data)
{
    (void)data;
    
    while (1)
    {
        SDL_Delay(5);   /*Sleep for 5 millisecond*/
        lv_tick_inc(5); /*Tell LittelvGL that 5 milliseconds were elapsed*/
    }
    
    return 0;
}

static void lv_display_driver_rounder_callback (
                                                lv_disp_drv_t* disp_drv,
                                                lv_area_t* area)
{
    area->x1 = 0;
    area->x2 = disp_drv->hor_res - 1;
    area->y1 = 0;
    area->y2 = disp_drv->ver_res - 1;
}
