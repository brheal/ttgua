//
//  Client.swift
//  Taxes To Go Utility App
//
//  Created by Timothy Barrett on 8/26/16.
//  Copyright © 2016 Rhodes Computer Services. All rights reserved.
//

import UIKit

class Client: NSObject {
    internal(set) var lastName:String!
    internal(set) var taxCode:String!
    init(lastName:String, taxCode:String) {
        self.lastName = lastName
        self.taxCode = taxCode
    }
}
