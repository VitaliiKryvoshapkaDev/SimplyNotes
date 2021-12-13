//
//  MainVC.swift
//  SimplyNotes
//
//  Created by Vitalii Kryvoshapka on 10.12.2021.
//

import Foundation
import UIKit

class MainVC: UIViewController{
    
    //Show User ID
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsLabel.text = user?.debugDescription ?? ""
    }
}
