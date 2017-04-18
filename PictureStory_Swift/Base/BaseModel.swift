//
//  TestModel.swift
//  PictureStory_Swift
//
//  Created by edz on 2017/3/22.
//  Copyright © 2017年 com.cocoa_niu. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    
    var mID : String?
    
    
    
    public init(dict:[String:AnyObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        print("Key \(key) \(value)")
        
        super.setValue(value, forKey: key)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("UndefinedKey \(key) \(value)")
        if key == "id" {
            mID = value as! String?
        }
    }
    
}


