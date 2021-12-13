//
//  ViewController.swift
//  SimplyNotes
//
//  Created by Vitalii Kryvoshapka on 10.12.2021.
//

import UIKit
import FBSDKLoginKit
import AVFoundation

class AccountViewController: UIViewController {
    
    @IBOutlet weak var videoLayer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Video background on Account View
        playVideo()
        
        //FB login Button
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        //loginButton.delegate = self
        loginButton.permissions = ["email", "public_profile"]
        view.addSubview(loginButton)
    }
    
    //Video Background Player on main queue
    func playVideo(){
        
        DispatchQueue.main.async {
            
            guard let path = Bundle.main.path(forResource: "videoBackground", ofType: "mov") else {
                return
            }
            let player = AVPlayer(url: URL(fileURLWithPath: path))
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            playerLayer.videoGravity = .resizeAspectFill
            self.videoLayer.layer.addSublayer(playerLayer)
            
            player.play()
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mainVC = segue.destination as? MainVC,
           let user = sender as? User{
            mainVC.user = user
        }
    }
}
