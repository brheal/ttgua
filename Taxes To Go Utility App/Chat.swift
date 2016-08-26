//
//  Chat.swift
//  Taxes To Go Utility App
//
//  Created by Timothy Barrett on 8/26/16.
//  Copyright © 2016 Rhodes Computer Services. All rights reserved.
//

import UIKit
import ObjectMapper
public class Chat: NSObject, Mappable {
    public var clientSent:Bool?
    public var loginId:Int?
    public var message:String?
    
    public required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    public func mapping(map: Map) {
        clientSent <- map["ClientSent"]
        loginId <- map["LoginId"]
        message <- map["MessageText"]
    }
}
