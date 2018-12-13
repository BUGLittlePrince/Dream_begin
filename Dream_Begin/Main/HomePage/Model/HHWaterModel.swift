//
//  HHWaterModel.swift
//  Dream_Begin
//
//  Created by hanhong on 2018/5/16.
//  Copyright © 2018年 hanhong. All rights reserved.
//

import UIKit

class HHWaterModel: NSObject {

    var imageUrl = ""
    var desc = ""
    var browseImageName = ""
    var browse = ""
    var praiseImageName = ""
    var praise = ""
    var userIcon = ""
    var userNikeName = ""
    
    static let properties = ["imageUrl", "desc", "browseImageName", "browse", "praiseImageName", "praise", "userIcon", "userNikeName"]
    
    override init() {
        super.init()
    }
    
    init(dict : [String : AnyObject?]) {
        super.init()
        for key in HHWaterModel.properties {
            if dict[key] != nil {
                setValue(dict[key]!, forKey: key)
            }
        }
    }
    
    override func setValuesForKeys(_ keyedValues: [String : Any]) {
        for key in HHWaterModel.properties {
            if keyedValues[key] != nil {
                setValue(keyedValues[key]!, forKey: key)
            }
        }
    }
}
