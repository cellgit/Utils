//
//  VLCPlayerViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/3/8.
//

import UIKit
import MobileVLCKit

class VLCPlayerViewController: UIViewController {
    
    let urlString = "https://v.zjy.partner.taozhi.online/89563aeaf51d417a96b64f691e57efa4/0ee8bfe58c17418a9df9749adba8daaa-a594b06793407f9c943be5f59478fd12-ld.mp4"
    let player = VLCMediaPlayer.init(options: nil)
    
    
    let audioPlayer = VLCAudio.init()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initialUI()
    }
    

    func initialUI() {
        player?.drawable = view
        
        guard let url = URL.init(string: urlString) else { return }
        
        player?.media = VLCMedia.init(url: url)
        
        player?.play()
        
        
        
    }
    
    func initialAudio() {
        
    }

}
