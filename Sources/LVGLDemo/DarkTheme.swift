//
//  File.swift
//
//
//  Created by Scott Andrew on 6/13/21.
//

import Foundation
import LVGLSwift

class DarkTheme: Theme {
    internal var screen = Style()
    internal var button = Style()
    internal var arcIndicator = Style()
    internal var arcIndicatorPrimary = Style()
    internal var knob = Style()
    internal var darkenFilter = ColorFilter()
    internal var primaryMuted = Style()
    
    internal var pressed = Style()
    internal var circle = Style()
    
    init() {
        super.init(primaryColor: Color.white, secondaryColor: Color.black)
        
        delegate = self
        
        darkenFilter.colorFilterCallback = { color, opacity in color.darken(opacity: opacity) }
        pressed.colorFilter = darkenFilter
        pressed.colorFilterOpacity = 35
        
        print(pressed.colorFilter!)
        screen.backgroundColor = Color.black
        screen.backgroundOpacity = LV_OPA_COVER
        screen.textColor = Color.white
        
        button.backgroundColor = Color(red: 0, green: 0, blue: 255)
        button.borderWidth = 0
        button.radius = 5
        button.verticalPadding = Int(lv_dpx(10))
        button.horizontalPadding = Int(lv_dpx(10))
        button.backgroundOpacity = LV_OPA_COVER
        
        arcIndicator.arcColor = Color(hex: 0x909090)
        arcIndicator.arcWidth = Int(lv_dpx(15))
        arcIndicator.arcIsRounded = true
        
        arcIndicatorPrimary.arcColor = Color(hex: 0xE0E0E0)
        
        knob.backgroundColor = primaryColor
        knob.backgroundOpacity = LV_OPA_COVER
        knob.radius = Int(LV_RADIUS_CIRCLE)
        knob.setAllPadding(padding: Int(lv_dpx(6)))
        
        primaryMuted.backgroundColor = primaryColor
        primaryMuted.textColor = primaryColor
        pressed.backgroundOpacity = LV_OPA_20
        
        circle.radius = Int(LV_RADIUS_CIRCLE)
    }
}

extension DarkTheme: ThemeDelegate {
    func applyTheme(_ theme: Theme, toObject: Object) {
        switch toObject {
            case is Screen: toObject.addStyle(style: screen)
            case is Button:
                toObject.addStyle(style: button)
                toObject.addStyle(style: pressed, selector: LV_STATE_PRESSED)
            
            case is Arc:
                toObject.addStyle(style: arcIndicator)
                toObject.addStyle(style: arcIndicator, selector: LV_PART_INDICATOR)
                toObject.addStyle(style: arcIndicatorPrimary, selector: LV_PART_INDICATOR)
                toObject.addStyle(style: knob, selector: LV_PART_KNOB)
            
            case is Slider:
                toObject.addStyle(style: primaryMuted)
                toObject.addStyle(style: circle)
                toObject.addStyle(style: circle, selector: LV_PART_INDICATOR)
                toObject.addStyle(style: knob, selector: LV_PART_KNOB)
                
//                lv_obj_add_style(obj, &styles->bg_color_primary_muted, 0);
//                lv_obj_add_style(obj, &styles->circle, 0);
//                lv_obj_add_style(obj, &styles->outline_primary, LV_STATE_FOCUS_KEY);
//                lv_obj_add_style(obj, &styles->outline_secondary, LV_STATE_EDITED);
//                lv_obj_add_style(obj, &styles->bg_color_primary, LV_PART_INDICATOR);
//                lv_obj_add_style(obj, &styles->circle, LV_PART_INDICATOR);
//                lv_obj_add_style(obj, &styles->knob, LV_PART_KNOB);
            default: break
        }
    }
}
