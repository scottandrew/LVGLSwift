//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/9/21.
//

import Foundation
import LVGLSwift

class Button: Object {
    init(parent: Object) {
        super.init(object: lv_btn_create(parent.lvObject))
    }
    
    func onClick(handler: @escaping EventHandler) {
        regsiterEvent(event: LV_EVENT_CLICKED, handler: handler);
    }
}
