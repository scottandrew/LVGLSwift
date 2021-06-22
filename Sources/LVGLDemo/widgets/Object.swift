//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/3/21.
//

import Foundation
import LVGLSwift

typealias EventHandler = (Object) -> Void;

class Object {
    internal let lvObject: UnsafeMutablePointer<lv_obj_t>
    private var eventHanlderMap = [UInt32: EventHandler]();
    
    deinit {
        lv_obj_del(lvObject)
    }
    
    internal init(object: UnsafeMutablePointer<lv_obj_t>) {
        lvObject = object;
        
        object.pointee.user_data = bridge(obj:self);

        // We hae to double theme apply which sucks.. But we can't pass the theme into constructor and object doesn't have user
        // data This is to get around our issues so we can see our swift objects when apply is called.
        lv_theme_apply(object);
        
        lv_obj_add_event_cb(object, { event in
            if let event = event?.pointee {
                let ourObject: Object = bridge(ptr: event.target.pointee.user_data)
            
                if event.code == LV_EVENT_DELETE {
                    event.target.pointee.user_data = nil;
                }
                
                ourObject.eventHanlderMap[event.code.rawValue]?(ourObject);
            }
                
        }, LV_EVENT_ALL, nil);
    }
    
    func regsiterEvent(event: lv_event_code_t, handler: @escaping EventHandler) {
        eventHanlderMap[event.rawValue] = handler;
    }
    
    func addStyle(style: Style, selector: Int = 0) {
        lv_obj_add_style(lvObject, &style.lvStyle, lv_style_selector_t(selector));
    }
    
    func setSize(width: Int, height: Int) {
        lv_obj_set_size(lvObject, lv_coord_t(width), lv_coord_t(height))
    }
    
    func center() {
        lv_obj_center(lvObject);
    }
}
