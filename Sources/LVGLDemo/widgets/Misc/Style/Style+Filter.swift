//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/18/21.
//

import Foundation
import LVGLSwift

var filterMap: [Int: ColorFilter] = [:]

extension Style {
    var colorFilter: ColorFilter? {
        set {
            if let filter = newValue {
                //let value = lv_style_value_t(ptr: &filter.lvColorFilter)
                
                //filterMap[Int(value.num)] = filter

              //  let bar = UnsafeRawPointer(&filter.lvColorFilter)
                
                
    lv_style_set_color_filter_dsc(&lvStyle, filter.lvColorFilter)
            }
        }
        
        get {
            var value = lv_style_value_t()
            
            guard lv_style_get_prop(&lvStyle, LV_STYLE_COLOR_FILTER_DSC, &value) == LV_RES_OK else {
                return nil
            }
            
            let goo = value.ptr!.load(as: lv_color_filter_dsc_t.self)

            if let data = goo.user_data {
                return bridge(ptr: data) as ColorFilter
            }
            return nil

    }
    }
    
    var colorFilterOpacity: Int {
        set {
            lv_style_set_color_filter_opa(&lvStyle, lv_opa_t(newValue))
        }
        
        get {
            return (try? getProperty(property: LV_STYLE_COLOR_FILTER_OPA) as Int) ?? 0
        }
    }
}
