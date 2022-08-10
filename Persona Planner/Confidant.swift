//
//  Confidant.swift
//  Persona Planner
//
//  Created by Gwen Bradforth on 4/27/22.
//

import UIKit

class Confidant: Codable {
    
    private var name: String;
    private var rank: Double;
    private var arcana: String;
    
    init(name: String, arcana: String, rank: Double = 1){
        self.name = name;
        self.arcana = arcana;
        self.rank = rank
    }
    
    func getName() -> String{
        return name
    }
    func getRank() -> Int{
        return Int(rank);
    }
    func getArcana() -> String {
        return arcana
    }
    
    //mimics rank functionality in-game, slowly increases friendship rank
    func addRank(num: Int)
    {
        rank = rank + Double(num)*0.25
    }
}
