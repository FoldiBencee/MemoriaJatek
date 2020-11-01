//
//  SoundManager.swift
//  MemoriaJatek
//
//  Created by foldi bence on 2020. 04. 27..
//  Copyright © 2020. foldi bence. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager
{
    
  static var audioPLayer:AVAudioPlayer?
    enum SoundEffect
    {
        case flip
        case shuffle
        case match
        case nomatch
    }
    
    
  static func playSound(_ effect:SoundEffect)
    {
       var soundFilename = ""
        switch effect {
        case .flip:
            soundFilename = "cardflip"
        case .shuffle:
            soundFilename = "shuffle"
        case .match:
            soundFilename = "dingcorrect"
        case .nomatch:
            soundFilename = "dingwrong"
        default:
            soundFilename = ""
        }
        
       let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")//zenefajlformatum
        
        guard bundlePath != nil else
        {
            print("Zene nem talalható \(soundFilename)a csomagban")
            return
        }
        
        let soundURL = URL(fileURLWithPath: bundlePath!)
        do{
        audioPLayer = try AVAudioPlayer(contentsOf: soundURL)
            
            audioPLayer?.play()
        }
        catch{
            print("Couldnt create the audio object sound file \(soundFilename)")
        }
    }
}
