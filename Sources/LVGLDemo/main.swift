//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/3/21.
//

import Foundation
import LVGLSwift
 
// We need to setup callback
lv_init()
simulation_hal_init()
let theme = DarkTheme()


lv_disp_set_theme(lv_disp_get_default(), &theme.lvTheme)

let screen:Screen = Screen()
let color = lv_color_black()

let button = Button(parent: screen)
let label = Label(parent: button);
let arc = Arc(parent: screen);

arc.setSize(width: 250, height: 250)

button.center();

label.text = "Foo"

screen.load();

button.onClick(handler: { _ in
    print("was clicked")
})

while true {
    lv_task_handler()
    usleep(5 * 1000)
}
