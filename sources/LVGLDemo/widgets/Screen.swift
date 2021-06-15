//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/9/21.
//

import Foundation
import LVGLSwift

class Screen: Object {
    init() {
        super.init(object: lv_obj_create(nil))
    }
    
    static func currentScreen() -> Screen? {
        let lvScreen = lv_scr_act()
            
        guard let unsafeObject = lvScreen?.pointee.user_data else {
            return nil
        }
        
        let object: Object = bridge(ptr: unsafeObject)
        guard let foundScreen = object as? Screen else {
            return nil;
        }
        
        return foundScreen;
    }
    
    func load() {
        lv_scr_load(lvObject);
    }
}
