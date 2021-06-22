//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/10/21.
//

import Foundation
import LVGLSwift

class Color {
    internal let lvColor: lv_color_t;
    
    // static helpers.
    static var black: Color { return Color(lvColor: lv_color_black())}
    static var white: Color {
        return Color(lvColor: lv_color_white())
    }
    
    internal init(lvColor: lv_color_t) {
        self.lvColor = lvColor;
    }
    
    init(hex: Int) {
        self.lvColor = lv_color_hex(UInt32(hex));
    }
    
    init(red: Int, green: Int, blue: Int) {
        lvColor = lv_color_make(UInt8(red), UInt8(green), UInt8(blue))
    }
    
    func darken(opacity: Int) -> Color {
        return Color(lvColor: lv_color_darken(lvColor, lv_opa_t(opacity)))
    }
}
