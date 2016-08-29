//
//  DetailViewController.swift
//  Taxes To Go Utility App
//
//  Created by Timothy Barrett on 8/26/16.
//  Copyright © 2016 Rhodes Computer Services. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var chatViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatField: UITextField!
    @IBOutlet weak var chatViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatBar: UIVisualEffectView!
    @IBOutlet weak var sendProgress: UIProgressView!
    
    private var chats:[Chat] = [Chat]()
    var detailItem: Client? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        guard let client = detailItem else {
            if self.chatBar != nil {
                self.chatBar.hidden = true
            }
            if let navItemView = self.navItem {
                navItemView.title = ""
            }
            return
        }
        refreshChats(forClient: client)
        if self.chatBar != nil {
            self.chatBar.hidden = false
        }
        if let navItemView = self.navItem {
            navItemView.title = "Conversation with \(client.lastName!)"
        }
        
        
    }
    
    private func clearView() {
//        if let label = self.detailDescriptionLabel {
//            label.text = ""
//        }
//        if let detailTitle = self.detailNavItem {
//            detailTitle.title = ""
//        }
        
    }
    
    private func refreshChats(forClient client:Client) {
        Interface.sharedInstance.getChats(forClient: String(client.clientId!)) { (chats, error) in
            if chats != nil {
                dispatch_async(dispatch_get_main_queue(), { 
                    self.chats = chats!
                    if let table = self.tableView {
                        table.reloadData()
                    }
                    
                })
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerNib(UINib(nibName: ReceiverCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ReceiverCell.reuseIdentifier)
        tableView.registerNib(UINib(nibName: SenderCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SenderCell.reuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 50.0, right: 0.0)
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendPressed(sender: AnyObject) {
        if chatField.text?.characters.count != 0 {
            Interface.sharedInstance.sendChat(String(detailItem!.clientId!), message: chatField.text!, completion: { (error) in
                if error == nil {
                    self.refreshChats(forClient: self.detailItem!)
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.chatField.text = nil
                    })
                }
            })
        }
    }
}

extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let chat = chats[indexPath.row]
        if chat.clientSent == true {
            let cell = tableView.dequeueReusableCellWithIdentifier(ReceiverCell.reuseIdentifier, forIndexPath: indexPath) as! ReceiverCell
            cell.messageLabel.text = chat.message
            cell.senderName.text = detailItem?.lastName
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(SenderCell.reuseIdentifier, forIndexPath: indexPath) as! SenderCell
            cell.messageLabel.text = chat.message
            cell.senderLabel.text = "YOU"
            return cell
        }
    }
}


