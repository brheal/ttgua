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
    
    private var chats:[String] = [String]()
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
            navItemView.title = "Conversation with \(client.lastName)"
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
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendPressed(sender: AnyObject) {
        
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
        return UITableViewCell()
    }
}


