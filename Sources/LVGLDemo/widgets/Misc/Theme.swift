//
//  File.swift
//  
//
//  Created by Scott Andrew on 6/12/21.
//

import Foundation
import LVGLSwift

typealias ApplyHandler = (_ theme: Theme, _ object: Object) -> Void


protocol ThemeDelegate: AnyObject {
    func applyTheme(_ theme: Theme, toObject: Object);
}

class Theme {
    internal var lvTheme = lv_theme_t()
    weak var delegate: ThemeDelegate?

    var primaryColor: Color {
        get {
            return Color(lvColor: lvTheme.color_primary);
        }
        set {
            lvTheme.color_primary = newValue.lvColor;
        }
    }

    var secondaryColor: Color {
        get {
            return Color(lvColor: lvTheme.color_secondary);
        }
        set {
            lvTheme.color_secondary = newValue.lvColor;
        }
    }

    deinit {
        lvTheme.user_data = nil
    }

    init(primaryColor: Color, secondaryColor: Color, delegate: ThemeDelegate? = nil) {
        // let defaultTheme = lv_theme_basic_init(lv_disp_get_default())
        
        lvTheme.apply_cb = {
                (aTheme: UnsafeMutablePointer<_lv_theme_t>?, toObject: UnsafeMutablePointer<lv_obj_t>?) in

                guard let theme = aTheme?.pointee.user_data, let object = toObject?.pointee.user_data else {
                    return;
                }

                let themeToApply: Theme = bridge(ptr: theme)
                let objectToApplyTo: Object = bridge(ptr: object)
            
            themeToApply.delegate?.applyTheme(themeToApply, toObject: objectToApplyTo)
                //themeToApply.applyHandler?(themeToApply, objectToApplyTo);
            }
        
        lvTheme.parent = nil
        lvTheme.user_data = bridge(obj: self)
        lvTheme.disp = lv_disp_get_default()
        lvTheme.color_primary = primaryColor.lvColor
        lvTheme.color_secondary = secondaryColor.lvColor
        lvTheme.font_small = lv_font_default()
        lvTheme.font_normal = lv_font_default()
        lvTheme.font_large = lv_font_default()
        lvTheme.flags = 0
    }
}


