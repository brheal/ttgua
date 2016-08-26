//
//  Client.swift
//  Taxes To Go Utility App
//
//  Created by Timothy Barrett on 8/26/16.
//  Copyright © 2016 Rhodes Computer Services. All rights reserved.
//

import UIKit
import ObjectMapper
public class Client: NSObject,  Mappable{
    public internal(set) var lastName:String?
    public internal(set) var taxCode:String?
    public var clientId:Int?
    public init(lastName:String, taxCode:String) {
        self.lastName = lastName
        self.taxCode = taxCode
    }
    
    public override init() { super.init() }
    
    public required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
    
    public func mapping(map: Map) {
        print(map["BasicInformation.TaxPayerLastName"].currentValue)
        lastName <- map["BasicInformation.TaxPayerLastName"]
        taxCode <- map["BasicInformation.SecurityCode"]
        clientId <- map["BasicInformation.LoginId"]
    }
}
