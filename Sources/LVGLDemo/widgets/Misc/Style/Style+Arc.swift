//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/17/21.
//

import Foundation
import LVGLSwift

extension Style {
    var arcColor: Color? {
        get {
            return try? getProperty(property: LV_STYLE_ARC_COLOR) as Color
        }

        set {
            guard let color = newValue?.lvColor else {
                return
            }
            
            lv_style_set_arc_color(&lvStyle, color)
        }
    }
    
    var arcWidth: Int {
        get {
            return (try? getProperty(property: LV_STYLE_ARC_WIDTH) as Int) ?? 0
        }
        
        set {
            lv_style_set_arc_width(&lvStyle, lv_coord_t(newValue))
        }
    }
    
    var arcIsRounded: Bool {
        get {
            return (try? getProperty(property: LV_STYLE_ARC_ROUNDED) as Bool) ?? false
        }
        
        set {
            lv_style_set_arc_rounded(&lvStyle, lv_coord_t(newValue ? 1 : 0))
        }
    }

}
