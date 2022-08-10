//
//  MusicViewController.swift
//
import UIKit
import AVFoundation


class SoundViewController: UIViewController {
    
    var player:AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //plays the track "Wake Up, Get Up, Get Out There" using AVFoundation
    @IBAction func wakeUp(_ sender: UIButton) {
        let path  = Bundle.main.path(forResource: "wakeUp", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        }
        catch{
            print(error)
        }
        
        player.play()
    }
    
    //plays track, very similar to above
    @IBAction func colorsFlying(_ sender: UIButton) {
        let path  = Bundle.main.path(forResource: "colorsFlying", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        }
        catch{
            print(error)
        }
        
        player.play()
    }
    
    
}

