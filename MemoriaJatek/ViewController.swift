//
//  ViewController.swift
//  MemoriaJatek
//
//  Created by foldi bence on 2020. 04. 25..
//  Copyright © 2020. foldi bence. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var model = CardModell()
    var cardArray = [Card]()
    var firstFlippedCardIndex:IndexPath?
    var timer:Timer?
    var miliseconds:Float = 30 * 1000 //10 sec
   // var soundManeger = SoundManager()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SoundManager.playSound(.shuffle)
    }
    
    
    @objc func timerElapsed()
    {
        miliseconds -= 1
        
       let seconds = String(format: "%.2f", miliseconds/1000)
        timerLabel.text = "Hátralévő idő: \(seconds)"
        if miliseconds <= 0
        {
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            checkGameEnded()
        }
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if miliseconds <= 0
        {
            return
        }
        
      let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false
        {
             cell.flip()
            SoundManager.playSound(.flip)
            card.isFlipped = true
            
            
            if firstFlippedCardIndex == nil
            {
                firstFlippedCardIndex = indexPath
            }
                
                
            else
            {
               checkForMatches(indexPath)
            }
        }
        
    }
    
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath)
    {
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        
        //a ket kartya egyezik
       if cardOne.imageName == cardTwo.imageName
            {
                SoundManager.playSound(.match)
                
                cardOne.isMatched = true
                cardTwo.isMatched = true
                
                cardOneCell?.remove()
                cardTwoCell?.remove()
                
                checkGameEnded()
        }
        //ha nem egyezik a ket kartya
        else
        {
            SoundManager.playSound(.nomatch)
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        
        if cardOneCell == nil
        {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        firstFlippedCardIndex = nil
    }
    
    func checkGameEnded()
    {
        var isWon = true
        for card in cardArray
        {
            if card.isMatched == false
            {
                isWon = false
                break
            }
        }
        
        var title = ""
        var message = ""
        
        if isWon == true
        {
            if miliseconds > 0
            {
                timer?.invalidate()
            }
            title = "Gartulálok"
            message = "Nyertél!"
            
        }
        else
        {
         if miliseconds > 0
         {
            return
            }
            title = "Játék vége"
            message = "Vesztettél"
        }
        showAlert(title, message)
    }
    
    func showAlert(_ title:String, _ message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}

