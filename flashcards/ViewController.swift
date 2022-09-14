//
//  ViewController.swift
//  flashcards
//
//  Created by Yana Sivakova on 9/13/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var backlabel: UILabel!
    @IBOutlet weak var frontlabel: UILabel!
    @IBAction func didTaponFlashcard(_ sender: Any) {
        frontlabel.isHidden = true
    }
}

