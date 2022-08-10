//
//  ConfidantsModel.swift
//  Persona Planner
//
//  Created by Gwen Bradforth on 4/27/22.
//

import Foundation
import Firebase
import FirebaseFirestore

class ConfidantsModel: NSObject {
    private var confidants: [Confidant]
    
    static let sharedInstance = ConfidantsModel()
    
    override init(){
        let c = Confidant(name: "Gwen", arcana: "Death")
        confidants = [c]
        
        //use firestore to save confidant data
        let ref = Firestore.firestore().collection("confidants").document(c.getName())
        ref.setData([
            "name": c.getName(),
            "arcana": c.getArcana(),
            "rank": c.getRank()
        ])
    }
    
    //returns length of confidant list
    func numberOfConfidants() -> Int {
        return confidants.count
    }
    
    //adds confidant to end of list
    func addConfidant(name: String, arcana: String){
        let confToAdd = Confidant(name: name, arcana: arcana)
        confidants.append(confToAdd)
        save()
    }
    
    //Inserts confidant into list
    func insert(name: String, arcana: String, at index: Int){
        let confToAdd = Confidant(name: name, arcana: arcana)
        if (index < numberOfConfidants())
        {
            confidants.insert(confToAdd, at: index)
        }
        save()
    }
    
    //Returns confidant at index
    func confidant(at index: Int) -> Confidant? {
        if (index < numberOfConfidants())
        {
            return confidants[index]
        }
        else
        {
            return nil
        }
    }
    
    //removes confidant at index
    func removeConfidant(at index: Int) {
        if (index < numberOfConfidants()){
            confidants.remove(at: index)
            Firestore.firestore().collection("confidants").document(confidants[index].getName()).delete()
        }
        
        save()
    }
    
    //adds rank to selected confidant
    func addRank(at index: Int, amount: Int)
    {
        if (index < numberOfConfidants())
        {
            confidants[index].addRank(num: amount)
        }
        save()
    }
    
    //save confidant data to firebase database
    func save(){
        for c in confidants where c.getName() != ""
        {
            let ref = Firestore.firestore().collection("confidants").document(c.getName())
            ref.setData([
                "name": c.getName(),
                "arcana": c.getArcana(),
                "rank": c.getRank()
            ])
        }
    }
    
    //load confidant data from firebase database
    func load(){
        let ref = Firestore.firestore().collection("confidants")
        for var c in confidants
        {
            ref.document(c.getName()).getDocument { snap, err in
                if let err = err {
                    print(err)
                    return
                }
                
                if let data = snap?.data(){
                    c = Confidant(name:  data["name"] as! String,arcana: data["arcana"] as! String,rank: data["rank"] as! Double)
                }
            }
        }
        
    }
}
