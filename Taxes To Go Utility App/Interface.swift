//
//  Interface.swift
//  Taxes To Go Utility App
//
//  Created by Timothy Barrett on 8/26/16.
//  Copyright © 2016 Rhodes Computer Services. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
public class Interface: NSObject {
    private let taxyear:Int = 2015
    private let affilate:Int = 0
    private let baseURL:String = "https://services.taxslayerpro.com/depot/api/"
    public static let sharedInstance:Interface = Interface()
    private override init() { super.init() }
    private let defaultHeaders:[String:String] = ["X-ProAppAuthTok":"-<?8C7f'n|/,A&,GR*Q6Gp^bB+tk'J(L(", "x-TaxYear":"2015"]
    public func getChats(forClient userId:String, completion:(chats:[Chat]?, error:NSError?)->Void) {
        Alamofire.request(.GET, "\(baseURL)/PrefillDocument/TextMessagesAfterDate", parameters: ["taxyear":2015, "userId":userId, "date":"1753-01-01T12:00:00"], encoding: .URLEncodedInURL, headers: defaultHeaders).responseJSON { (response) in
            switch(response.result) {
            case .Success(let data):
                var chats = [Chat]()
                guard let objects = data as? Array<[String:AnyObject]> else {
                    completion(chats: nil, error: nil)
                    return
                }
                for object in objects {
                    if let chat = Chat(Map(mappingType: .FromJSON, JSONDictionary: object)) {
                        chats.append(chat)
                    }
                }
                completion(chats: chats, error: nil)
                
            case .Failure(let error):
                print(error)
                completion(chats: nil, error: error)
            }
        }
    }
    
    public func sendChat() {
        
    }
    
    public func getClient(withTaxCode code:Int, withLastName name:String, completion:(client:Client?, error:NSError?)->Void) {
        var params = [String:AnyObject]()
        params["lastname"] = name
        params["code"] = code
        params["affilateId"] = affilate
        params["taxYear"] = taxyear
        
        Alamofire.request(.GET, "\(baseURL)/TaxInformation", parameters: params, encoding: .URLEncodedInURL, headers: defaultHeaders).responseObject { (response: Response<Client, NSError>) in
            switch(response.result) {
            case .Success(let data):
                completion(client: data, error: nil)
                
            case .Failure(let error):
                completion(client: nil, error: error)
            }
        }
    }
}
