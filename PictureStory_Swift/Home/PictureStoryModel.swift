//
//  PictureStoryModel.swift
//  PictureStory_Swift
//
//  Created by edz on 2017/3/23.
//  Copyright © 2017年 com.cocoa_niu. All rights reserved.
//

import UIKit
import SwiftyJSON

class PictureStoryModel: BaseModel {
    var tags : String?
    var img_color : String?
    var thumb : String?
    var avatar : String?
    var story_detail : StoryModel?

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("UndefinedKey \(key) \(value)")
        if key == "id" {
            self.mID = "\(value!)"
        } else if key == "story" {
            let jsonData: Data! = (value as! String).data(using: .utf8)
            if let jsonObject = try?JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String : AnyObject] {
                self.story_detail = StoryModel.init(dict: jsonObject)
            }
        }
    }

}
