//
//  VLCPlayerViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/3/8.
//

import UIKit
import MobileVLCKit
//import SnapKit

class VLCPlayerViewController: UIViewController {
    
    let urlString = "https://v.zjy.partner.taozhi.online/89563aeaf51d417a96b64f691e57efa4/0ee8bfe58c17418a9df9749adba8daaa-a594b06793407f9c943be5f59478fd12-ld.mp4"
    let player = VLCMediaPlayer.init(options: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        initialUI()
    }
    

    func initialUI() {
        
        
        
        
        let drawable = PlayerDrawable.init(view: self.view)
        
        player?.drawable = drawable
        
        
//        guard let lastView = (player?.drawable as? UIView)?.subviews.last else { return }
        
//        drawable.bringSubviewToFront(lastView)
        
        guard let url = URL.init(string: urlString) else { return }
        
        player?.media = VLCMedia.init(url: url)
        
        player?.play()
        
        player?.delegate = self
        
        
        
        view.addSubview(drawable)
        
        
        
    }
    
//    func addOverlayView() {
//        overlayVC = self.storyboard?.instantiateViewController(withIdentifier: "AVPlayerOverlayVC") as! PlayerOverlayVC
//        self.addChildViewController(overlayVC)
//        self.view.addSubview(overlayVC.view)
//        overlayVC.deleget = self
//        overlayVC.didMove(toParentViewController: self)
//    }

}


extension VLCPlayerViewController: VLCMediaPlayerDelegate {
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
        //
    }
}
