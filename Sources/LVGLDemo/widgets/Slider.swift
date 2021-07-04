//
//  Slider.swift
//  
//  Wrapper aroudn the LVGL slider.
//
//  Created by Scott Andrew on 6/21/21.
//

import Foundation
import LVGLSwift

extension lv_anim_enable_t {
    init(_ value: Bool) {
        self = value ? LV_ANIM_ON : LV_ANIM_OFF
    }
}

class Slider: Object {
    private var valueChangeHandler: ((Object, Int) -> Void)?
    private var value: Int {
        get {
            return Int(lv_slider_get_value(lvObject))
        }
        
        set {
            setValue(value: newValue)
        }
    }
    
    private var minValue: Int {
        get {
            return Int(lv_slider_get_min_value(lvObject))
        }
    }
    
    private var maxValue: Int {
        get {
            return Int(lv_slider_get_max_value(lvObject))
        }
    }
    
    init(parent: Object) {
        super.init(object: lv_slider_create(parent.lvObject))
    }
    
    func setValue(value: Int, animate: Bool = false) {
        lv_slider_set_value(lvObject, Int32(value), lv_anim_enable_t(animate))
    }
    
    func onValueChanged(_ handler: @escaping (Slider, Int) -> Void) {
        regsiterEvent(event: LV_EVENT_VALUE_CHANGED) {[weak self] object in
            if let slider = object as? Slider, let changeHandler = self?.valueChangeHandler {
                changeHandler(slider, slider.value)
            }
        }
    }
}
