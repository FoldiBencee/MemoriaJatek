//
//  CardModell.swift
//  MemoriaJatek
//
//  Created by foldi bence on 2020. 04. 25..
//  Copyright © 2020. foldi bence. All rights reserved.
//

import Foundation
class CardModell{
    
    func getCards() -> [Card]
    {
        var generatedNumbersArray = [Int]()
        var generatedCardsArray = [Card]()
        
        //randomizalas forciklusban
        while generatedNumbersArray.count < 8 {
        
          let randomNumber = arc4random_uniform(13) + 1
            
            if generatedNumbersArray.contains(Int(randomNumber)) == false
            {
                print("Generating a random number\(randomNumber)")
                
                generatedNumbersArray.append(Int(randomNumber))
                          
                          //elso kartya objektum letrahozasa
                          let cardOne = Card()
                          cardOne.imageName = "card\(randomNumber)"
                          
                          generatedCardsArray.append(cardOne)
                          
                          //masodik kartya objektum letrahozasa
                          let cardTwo = Card()
                          cardTwo.imageName = "card\(randomNumber)"
                          
                          generatedCardsArray.append(cardTwo)
            }
            
          
            
        }
        for i in 0...generatedCardsArray.count-1
        {
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
            
            let temporaryStorage = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = temporaryStorage
            
            
        }
        
        return generatedCardsArray
    }
    
}
