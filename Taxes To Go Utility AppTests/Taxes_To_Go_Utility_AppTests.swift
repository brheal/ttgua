//
//  Taxes_To_Go_Utility_AppTests.swift
//  Taxes To Go Utility AppTests
//
//  Created by Timothy Barrett on 8/26/16.
//  Copyright © 2016 Rhodes Computer Services. All rights reserved.
//

import XCTest

@testable import Taxes_To_Go_Utility_App


class InterfaceTests: XCTestCase {
    func testGetClientByLastnameAndTaxCode() {
        let exp = expectationWithDescription("Get client by last and tax code")
        
        Interface.sharedInstance.getClient(withTaxCode: 19339, withLastName: "barrett") { (client, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(client?.clientId)
            XCTAssertNotNil(client?.lastName)
            XCTAssertNotNil(client?.taxCode)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testSendChat() {
        let exp = expectationWithDescription("send chat")
        Interface.sharedInstance.getClient(withTaxCode: 19339, withLastName: "barrett") { (client, error) in
            XCTAssertNotNil(client)
            XCTAssertNil(error)
            Interface.sharedInstance.sendChat(String(client!.clientId!), message: "This is a test message from unit testing", completion: { (error) in
                XCTAssertNil(error)
                exp.fulfill()
            })
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testGetChats() {
        let exp = expectationWithDescription("Get chats")
        Interface.sharedInstance.getClient(withTaxCode: 19339, withLastName: "barrett") { (client, error) in
            guard let curClient = client else {
                XCTFail()
                exp.fulfill()
                return
            }
            guard let clientID = curClient.clientId else {
                XCTFail()
                exp.fulfill()
                return
            }
            Interface.sharedInstance.getChats(forClient: String(clientID), completion: { (chats, error) in
                XCTAssertNil(error)
                XCTAssertNotNil(chats)
                XCTAssertGreaterThan(chats!.count, 0)
                let chat = chats?.first!
                XCTAssertNotNil(chat?.message)
                exp.fulfill()
            })
        }
        waitForExpectationsWithTimeout(10, handler: nil)
        
    }
}