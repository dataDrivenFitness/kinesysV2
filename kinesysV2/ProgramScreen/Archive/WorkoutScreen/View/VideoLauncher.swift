//
//  VideoLauncher.swift
//  WorkoutView
//
//  Created by Chris Davis on 1/6/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit
import AVFoundation

protocol VideoViewDelegate: class {
    func closeUIView(_ sender: VideoPlayerView)
}

class VideoPlayerView: UIView { //*** having two classes in one file/viewController
    
    weak var delegate:VideoViewDelegate?
    
    func close() {
        delegate?.closeUIView(self)
    }
    
    let activityIndicatorView: UIActivityIndicatorView = { // may use SVProgressHUD here instead
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white
        button.isHidden = true
        
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        
        return button
    }()
    
    var isPlaying = false
    
    @objc func handlePause() {
        
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
            
        }
        
        isPlaying = !isPlaying
    }
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "cancel")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(white: 1, alpha: 0.5)
        
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        //        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))//**
        
        return button
    }()
    
    @objc func handleDismiss() { //there has got to be a better way to dismiss this video player
        
        close()
        print("hit close button")
        
        //        self.window?.rootViewController = nil
        //        self.window?.resignKey()
        //        self.window?.removeFromSuperview()
        //
        //        self.removeFromSuperview()
        //        self.window?.rootViewController?.dismiss(animated: true, completion: nil)
        //        self.layer.removeFromSuperlayer(playerLayer)
        //        self.player?.removeObserver(self, forKeyPath: "currentItem.loadedTimeRanges")
        //        UIApplication.shared.keyWindow?.willRemoveSubview(self)
        
    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        addSubview(cancelButton)
        
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        //        controlsContainerView.addSubview(pausePlayButton)
        //        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        //        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        //        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        //        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        backgroundColor = UIColor.black
        
    }
    
    var player: AVPlayer?
    
    private func setupPlayerView() { //need to pass in url
        let urlString = "https://firebasestorage.googleapis.com/v0/b/kinesys-app.appspot.com/o/IMG_0241.mov?alt=media&token=c74392ee-74a2-487f-bd4f-74ba005b9fea"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            //player.pause()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //this is when the vidoe is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            pausePlayButton.isHidden = false
            isPlaying = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    
    
    func showVideoPlayer () {
        print("showing video animation")
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            // 16 x 9 is the aspect ratio of all HD vidoe players
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                view.frame = keyWindow.frame
                
            }) { (_) in
                
                let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
                statusBar.isHidden = true
            }
            
        }
        
    }
    
}

//class PlayerViewController: UIViewController, VideoViewDelegate {
//    func closeUIView(_ sender: VideoPlayerView) {
//        self.navigationController?.navigationBar.isHidden = false
//        self.videoPlayerView.removeFromSuperview()
//        self.dismiss(animated: true, completion: nil)
//    }
//}
