//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/9/21.
//

import Foundation
import LVGLSwift

class Label: Object {
    var text: String {
        get {
            return String(cString: lv_label_get_text(lvObject));
        }
        set {
            lv_label_set_text(lvObject, newValue.cString(using: .utf8));
        }
    }
    
    init(parent: Object) {
        super.init(object: lv_label_create(parent.lvObject));
    }
}
