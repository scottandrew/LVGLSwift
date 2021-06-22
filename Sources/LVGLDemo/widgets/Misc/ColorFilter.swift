//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/18/21.
//

import Foundation
import LVGLSwift

class ColorFilter {
    // we have to work with the raw pointers to support the code for fetching the data
    // out of the pointer and the in/out not lasting past the scope of the getter.
    internal var lvColorFilter: UnsafeMutablePointer<lv_color_filter_dsc_t> = UnsafeMutablePointer.allocate(capacity: MemoryLayout<lv_color_filter_dsc_t>.size)
    var colorFilterCallback: ((Color, Int) -> Color)?
    
    deinit {
        lvColorFilter.deallocate()
    }
    
    init() {
     //   let uint8Pointer = UnsafeMutableRawPointer(mutating: "Hello".cString(using: .utf8)!)
        lvColorFilter.pointee.user_data = bridge(obj: self)//bridge(obj: self)
        lv_color_filter_dsc_init(lvColorFilter) { description, color, opacity in
            guard let data = description?.pointee.user_data else { return Color(hex: 0x0).lvColor }
            let filter:ColorFilter = bridge(ptr: data)
            guard let callback = filter.colorFilterCallback else { return Color(hex: 0x0).lvColor }
            
            return callback(Color(lvColor: color), Int(opacity)).lvColor
        }
        

    }
}
