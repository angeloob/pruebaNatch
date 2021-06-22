//
//  Popup.swift
//  pruebaNatch
//
//  Created by Angel Olvera on 22/06/21.
//

import UIKit

class Popup: UIViewController {

    @IBOutlet weak var watchPhotoOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func takePhoto(_ sender: Any) {
    }
    
    @IBAction func watchPhoto(_ sender: Any) {
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
