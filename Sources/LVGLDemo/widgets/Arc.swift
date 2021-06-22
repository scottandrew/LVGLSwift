//
//  File.swift
//
//
//  Created by Scott Andrew on 6/15/21.
//

import Foundation
import LVGLSwift

class Arc: Object {
    var value: Int {
        get {
            Int(lv_arc_get_value(lvObject))
        }
        
        set {
            lv_arc_set_value(lvObject, Int16(newValue))
        }
    }
    
    var backgroundStartAngle: UInt {
        get {
            return UInt(lv_arc_get_bg_angle_start(lvObject))
        }
        
        set {
            lv_arc_set_bg_start_angle(lvObject, UInt16(newValue))
        }
    }
    
    var backgroundEndAngle: UInt {
        get {
            return UInt(lv_arc_get_bg_angle_end(lvObject))
        }
        
        set {
            lv_arc_set_bg_end_angle(lvObject, UInt16(newValue))
        }
    }
    
    var startAngle: UInt {
        get {
            return UInt(lv_arc_get_angle_start(lvObject))
        }
        
        set {
            lv_arc_set_start_angle(lvObject, UInt16(newValue))
        }
    }
    
    var endAngle: UInt {
        get {
            return UInt(lv_arc_get_angle_end(lvObject))
        }
        
        set {
            lv_arc_set_end_angle(lvObject, UInt16(newValue))
        }
    }
    
    init(parent: Object) {
        super.init(object: lv_arc_create(parent.lvObject))
    }
}
