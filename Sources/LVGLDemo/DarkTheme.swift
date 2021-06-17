//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/13/21.
//

import Foundation
import LVGLSwift

class DarkTheme: Theme {
    internal var screen = Style();
    internal var button = Style();
    
    init() {
        super.init(primaryColor: Color.white);
        
        delegate = self
        
        screen.backgroundColor = Color.black
        screen.textColor = Color.white
        
        button.backgroundColor = Color(red: 0, green: 0, blue: 255);
        button.borderWidth = 0
        button.radius = 5
        button.verticalPadding = Int(lv_disp_dpx(lv_disp_get_default(), 10))
        button.horizontalPadding = Int(lv_disp_dpx(lv_disp_get_default(), 10))
        
       // lv_style_set_radius(<#T##style: UnsafeMutablePointer<lv_style_t>!##UnsafeMutablePointer<lv_style_t>!#>, <#T##value: lv_coord_t##lv_coord_t#>)
    }
}

extension DarkTheme: ThemeDelegate {
    func applyTheme(_ theme: Theme, toObject: Object) {
        print("foo");
        
        switch toObject {
        case is Screen: toObject.addStyle(style: screen)
        case is Button: toObject.addStyle(style: button);
        default: break
        }
    }
}
