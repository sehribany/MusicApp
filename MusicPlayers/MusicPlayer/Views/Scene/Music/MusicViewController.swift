//
//  MusicViewController.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 12.05.2023.
//

import UIKit
import AVFoundation

class MusicViewController: UIViewController, AVAudioPlayerDelegate {
    
    var musicName     : String?
    var selectedMusic : String?
    var musicImage    : String?
    var player        : AVPlayer?
    var playerLayer   : AVPlayerLayer?
    var isPlaying = false
    
    // Views
    
    private let posterImageView : UIImageView = {
        
        let imageView                                       = UIImageView()
        imageView.contentMode                               = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds                             = true
        return imageView
        
    }()
    
    private let containerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    private let playPauseButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title                = musicName
        view.backgroundColor = .secondarySystemBackground
        
        containerView.addSubview(playPauseButton)
        
        view.addSubview(containerView)
        view.addSubview(posterImageView)
        
        self.layoutConstraint()
        
        guard let url = URL(string: selectedMusic!) else {
            
            print("Geçersiz URL")
            
            return
        }
        
        let playerItem            = AVPlayerItem(url: url)
        player                    = AVPlayer(playerItem: playerItem)
        playerLayer               = AVPlayerLayer(player: player)
        playerLayer?.frame        = view.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        
        view.layer.insertSublayer(playerLayer!, at: 0)
        
    }
    
    // Constraints
    
    func layoutConstraint(){
        
        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 70),
            
            playPauseButton.widthAnchor.constraint(equalToConstant: 40),
            playPauseButton.heightAnchor.constraint(equalToConstant: 40),
            playPauseButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            playPauseButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            posterImageView.widthAnchor.constraint(equalToConstant: 390),
            posterImageView.heightAnchor.constraint(equalToConstant: 500)
        
        ])
    }
    
    // Configure
    
    public func configure(with string: String){
        
       guard let url = URL(string: string) else { return }
       posterImageView.kf.setImage(with: url)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        player?.pause()
    }
    
    @objc func playPauseButtonTapped() {
        
        if isPlaying {
            
            player?.pause()
            playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
            
        } else {
            
            player?.play()
            playPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            
        }
        
        isPlaying.toggle()
    }

}
