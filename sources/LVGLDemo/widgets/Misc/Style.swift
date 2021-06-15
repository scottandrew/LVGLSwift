//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/13/21.
//

import Foundation
import LVGLSwift

class Style {
    var textColor: Color? {
            get {
                var value = lv_style_value_t();

                guard getProp(property: LV_STYLE_TEXT_COLOR, value: &value) == LV_RES_OK else {
                    return nil
                }

                return Color(lvColor: value.color)
            }

            set {
                guard let color = newValue?.lvColor else {
                    return
                }
                
                lv_style_set_text_color(&lvStyle, color)
            }
    }
    var backgroundColor: Color? {
        get {
            var value = lv_style_value_t();

            guard getProp(property: LV_STYLE_BG_COLOR, value: &value) == LV_RES_OK else {
                return nil
            }

            return Color(lvColor: value.color)
        }

        set {
            guard let color = newValue?.lvColor else {
                return
            }
            
            lv_style_set_bg_color(&lvStyle, color)
        }
    }
    
    var radius: Int {
        get {
            var value = lv_style_value_t();

            guard getProp(property: LV_STYLE_BG_COLOR, value: &value) == LV_RES_OK else {
                return 0
            }

            return Int(value.num)
        }
        
        set {
            lv_style_set_radius(&lvStyle, Int16(newValue))
        }
    }
    
    var borderWidth: Int {
        set {
            lv_style_set_border_width(&lvStyle, Int16(newValue))
        }
        
        get{
            var value = lv_style_value_t()
            
            guard getProp(property: LV_STYLE_BORDER_WIDTH, value: &value) == LV_RES_OK else {
                return 0
            }
            
            return Int(value.num)
        }
    }

    var verticalPadding: Int {
        set {
            lv_style_set_pad_ver(&lvStyle, Int16(newValue))
        }
        
        get{
            var value = lv_style_value_t()
            
            guard getProp(property: LV_STYLE_PAD_TOP, value: &value) == LV_RES_OK else {
                return 0
            }
            
            return Int(value.num)
        }
    }
    
    var horizontalPadding: Int {
        set {
            lv_style_set_pad_hor(&lvStyle, Int16(newValue))
        }
        
        get{
            var value = lv_style_value_t()
            
            guard getProp(property: LV_STYLE_PAD_LEFT, value: &value) == LV_RES_OK else {
                return 0
            }
            
            return Int(value.num)
        }
    }
    
    internal var lvStyle = lv_style_t()

    init() {
        lv_style_init(&lvStyle);
    }

    internal func getProp(property: lv_style_prop_t, value: inout lv_style_value_t) -> lv_res_t {
        return lv_style_get_prop(&lvStyle, property, &value)
    }
}
