//
//  MessageCollectionViewController.swift
//  OnTheHouse
//
//  Created by Michael Hyun on 5/13/17.
//  Copyright © 2017 CMPE137. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

private let reuseIdentifier = "Cell"

class MessageCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var navigationTitle: UINavigationItem!

    @IBOutlet weak var textField: UITextField!
    
    var toUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle.title = toUser.name!
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "table_cell")

        // Do any additional setup after loading the view.
    }

    @IBAction func sendButtonPressed(_ sender: Any) {
        
        let ref = FIRDatabase.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let uid = FIRAuth.auth()?.currentUser?.uid
        let timestamp = NSDate.timeIntervalSinceReferenceDate
        let values = ["text": self.textField.text!,
                      "toID" : toUser.uid!,
                      "fromID" : uid,
                      "timestamp" : timestamp] as [String : Any]
        
        childRef.updateChildValues(values)
        
        self.textField.text = ""
    }



}
