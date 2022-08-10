//
//  SingleViewController.swift
//  Persona Planner
//
//  Created by Gwen Bradforth on 5/3/22.
//

import UIKit

class SingleViewController: UIViewController {
    
    var confidants = ConfidantsModel.sharedInstance
    
    @IBOutlet weak var arcanaImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //display confidant name and arcana
        nameLabel.text = confidants.confidant(at: myIndex)?.getName()
        
        if (confidants.confidant(at: myIndex)?.getArcana() ==  "moon")
        {
            arcanaImage.image = UIImage(named: "aMoon.png")
        }
        else if (confidants.confidant(at: myIndex)?.getArcana() ==  "death")
        {
            arcanaImage.image = UIImage(named: "aDeath.png")
        }
        else
        {
            //etc
        }
    }
    
}
