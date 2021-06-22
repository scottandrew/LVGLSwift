//
//  File.swift
//
//
//  Created by Scott Andrew on 6/17/21.
//

import Foundation
import LVGLSwift

extension Style {
    var verticalPadding: Int {
        set {
            lv_style_set_pad_ver(&lvStyle, Int16(newValue))
        }
    
        get {
            return (try? getProperty(property: LV_STYLE_PAD_TOP) as Int) ?? 0
        }
    }

    var horizontalPadding: Int {
        set {
            lv_style_set_pad_hor(&lvStyle, Int16(newValue))
        }
    
        get {
            return (try? getProperty(property: LV_STYLE_PAD_LEFT) as Int) ?? 0
        }
    }

    func setAllPadding(padding: Int) {
        lv_style_set_pad_all(&lvStyle, lv_coord_t(padding))
    }
}
