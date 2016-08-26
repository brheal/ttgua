//
//  AddTaxUserViewController.swift
//  Taxes To Go Utility App
//
//  Created by Timothy Barrett on 8/26/16.
//  Copyright © 2016 Rhodes Computer Services. All rights reserved.
//

import UIKit
protocol AddTaxUserViewControllerDelegate:class {
    func didAddUser(view:AddTaxUserViewController, user:Client)
}
class AddTaxUserViewController: UIViewController {
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var taxCodeField: UITextField!
    weak var delegate:AddTaxUserViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        lastNameField.text = "Barrett"
        taxCodeField.text = "19339"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addUserPressed(sender : AnyObject) {
        if lastNameField.text?.characters.count != 0 && taxCodeField.text?.characters.count != 0 {
            Interface.sharedInstance.getClient(withTaxCode: Int(taxCodeField.text!)!, withLastName: lastNameField.text!, completion: { (client, error) in
                if error == nil {
                    self.delegate?.didAddUser(self, user: client!)
                }
                
            })
//            let user = Client(lastName: lastNameField.text!, taxCode: taxCodeField.text!)
//            delegate?.didAddUser(self, user: user)
        }
    }

}
