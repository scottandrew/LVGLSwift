//
//  File.swift
//
//
//  Created by Scott Andrew on 6/13/21.
//

import Foundation
import LVGLSwift

enum StyleError: Error {
    case ReadError
    case UnknownType
}

class Style {
    var textColor: Color? {
        get {
            return try? getProperty(property: LV_STYLE_TEXT_COLOR) as Color
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
            return try? getProperty(property: LV_STYLE_BG_COLOR) as Color
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
            return (try? getProperty(property: LV_STYLE_BG_COLOR) as Int) ?? 0
        }

        set {
            lv_style_set_radius(&lvStyle, Int16(newValue))
        }
    }

    var borderWidth: Int {
        set {
            lv_style_set_border_width(&lvStyle, Int16(newValue))
        }

        get {
            return (try? getProperty(property: LV_STYLE_BORDER_WIDTH) as Int) ?? 0
        }
    }

    var backgroundOpacity: Int {
        set {
            lv_style_set_bg_opa(&lvStyle, lv_opa_t(newValue))
        }

        get {
            return (try? getProperty(property: LV_STYLE_BG_OPA) as Int) ?? 0
        }
    }

    internal var lvStyle = lv_style_t()
    
    deinit {
        print("foo");
    }
    init() {
        lv_style_init(&lvStyle)
    }

    internal func getProp(property: lv_style_prop_t) throws -> lv_style_value_t {
        var value = lv_style_value_t()

        guard lv_style_get_prop(&lvStyle, property, &value) == lv_res_t(LV_RES_OK) else {
            throw StyleError.ReadError
        }
        
        return value
    }

    
    internal func getProperty<T>(property: lv_style_prop_t) throws -> T {
        switch T.self {
        case is Int.Type: return try Int(getProp(property: property).num) as! T
        case is Bool.Type: return try Bool(getProp(property: property).num > 0) as! T
        case is Color.Type: return try Color(lvColor: getProp(property: property).color) as! T
    
        default: throw StyleError.UnknownType
        }
    }
    
//    internal func foo() {
//        let fo: String = try! getIntProp(property: LV_STYLE_ARC_COLOR)
//    }
}
