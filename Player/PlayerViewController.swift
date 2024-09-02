//
//  PlayerViewController.swift
//  Player
//
//  Created by 郭蕙瑄 on 2024/8/20.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class PlayerViewController: UIViewController {
    
    // UI
    private let bgView = UIView()
    private let musicCoverImageView = UIImageView()
    
    private let songName = UILabel()
    private let artistName = UILabel()
    
    private let songDurationStartLabel = UILabel()
    private let songDurationEndLabel = UILabel()
    
    private let moreBtn = UIButton()
    
    private let backwardBtn = UIButton()
    private let statusBtn = UIButton()
    private let forwardBtn = UIButton()
    
    private let songLengthSlider = UISlider()
    private let volumeSlider = UISlider()
    
    private let raiseVolumeButton = UIButton()
    private let lowerVolumeButton = UIButton()
    
    private let lyrisBtn = UIButton()
    private let airPlayBtn = UIButton()
    private let listBtn = UIButton()
    
    private let gradientLayer = CAGradientLayer()
    
    // Player
    let player = AVPlayer()
    var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupPlayer()
        observePlayerTimeUpdates()
    }
    
    private func configureUI() {
        
        musicCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        musicCoverImageView.layer.cornerRadius = 15
        musicCoverImageView.layer.shadowOffset = CGSize(width: 0, height: 10)
        musicCoverImageView.clipsToBounds = true
        musicCoverImageView.image = UIImage(named: "3")
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.layer.cornerRadius = 15
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        bgView.layer.shadowRadius = 25.0
        bgView.layer.shadowOpacity = 0.5
        bgView.addSubview(musicCoverImageView)
        
        view.addSubview(bgView)
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors =  songList.last?.backGroundColor
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        if #available(iOS 15.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .regular)
            let hierarchicalConfig = config.applying(UIImage.SymbolConfiguration(hierarchicalColor: .white))
            let image = UIImage(systemName: "ellipsis.circle.fill", withConfiguration: hierarchicalConfig)
            moreBtn.setImage(image, for: .normal)
            moreBtn.translatesAutoresizingMaskIntoConstraints = false
        }
        view.addSubview(moreBtn)
        
        configureLabel(for: songName, text: songList.last?.songName, font: "PingFangTC-Semibold", size: 18, color: .white)
        configureLabel(for: artistName, text: songList.last?.artist, font: "PingFangTC-Regular", size: 16, color: .white)
        configureLabel(for: songDurationStartLabel, text: "--:--", font: "PingFangTC-Regular", size: 12, color: .white)
        configureLabel(for: songDurationEndLabel, text: "--:--", font: "PingFangTC-Regular", size: 12, color: .white)
        
        configureSlider(songLengthSlider)
        configureSlider(volumeSlider)
        
        configureButton(for: backwardBtn, pointSize: 30, systemName: "backward.fill", color: .white)
        configureButton(for: statusBtn, pointSize: 40, systemName: "play.fill", color: .white)
        configureButton(for: statusBtn, pointSize: 40, systemName: "pause.fill", color: .white)
        configureButton(for: forwardBtn, pointSize: 30, systemName: "forward.fill", color: .white)
        configureButton(for: raiseVolumeButton, pointSize: 15, systemName: "speaker.wave.3.fill", color: .white)
        configureButton(for: lowerVolumeButton, pointSize: 15, systemName: "speaker.fill", color: .white)
        configureButton(for: airPlayBtn, pointSize: 20, systemName: "airplayaudio", color: .white)
        configureButton(for: lyrisBtn, pointSize: 19, systemName: "quote.bubble", color: .white)
        configureButton(for: listBtn, pointSize: 21, systemName: "list.bullet", color: .white)
        
        
        NSLayoutConstraint.activate([
            
            bgView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80),
            bgView.widthAnchor.constraint(equalToConstant: 300),
            bgView.heightAnchor.constraint(equalToConstant: 300),
            bgView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            musicCoverImageView.widthAnchor.constraint(equalToConstant: 300),
            musicCoverImageView.heightAnchor.constraint(equalToConstant: 300),
            musicCoverImageView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            musicCoverImageView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            musicCoverImageView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            musicCoverImageView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            
            moreBtn.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 50),
            moreBtn.centerYAnchor.constraint(equalTo: songName.bottomAnchor),
            moreBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            songName.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 50),
            songName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            artistName.topAnchor.constraint(equalTo: songName.bottomAnchor),
            artistName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            songLengthSlider.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 30),
            songLengthSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            songLengthSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            songDurationStartLabel.topAnchor.constraint(equalTo: songLengthSlider.bottomAnchor, constant: 15),
            songDurationStartLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            
            songDurationEndLabel.topAnchor.constraint(equalTo: songLengthSlider.bottomAnchor, constant: 15),
            songDurationEndLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            statusBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            statusBtn.topAnchor.constraint(equalTo: songLengthSlider.bottomAnchor, constant: 60),
            
            backwardBtn.centerYAnchor.constraint(equalTo: statusBtn.centerYAnchor),
            backwardBtn.trailingAnchor.constraint(equalTo: statusBtn.trailingAnchor, constant: -80),
            
            forwardBtn.centerYAnchor.constraint(equalTo: statusBtn.centerYAnchor),
            forwardBtn.leadingAnchor.constraint(equalTo: statusBtn.leadingAnchor, constant: 80),
            
            volumeSlider.topAnchor.constraint(equalTo: statusBtn.bottomAnchor, constant: 60),
            volumeSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60),
            volumeSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60),
            
            raiseVolumeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            raiseVolumeButton.centerYAnchor.constraint(equalTo: volumeSlider.centerYAnchor),
            
            lowerVolumeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            lowerVolumeButton.centerYAnchor.constraint(equalTo: volumeSlider.centerYAnchor),
            
            airPlayBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            airPlayBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            lyrisBtn.trailingAnchor.constraint(equalTo: airPlayBtn.leadingAnchor, constant: -60),
            lyrisBtn.centerYAnchor.constraint(equalTo: airPlayBtn.centerYAnchor),
            
            listBtn.leadingAnchor.constraint(equalTo: airPlayBtn.trailingAnchor, constant: 60),
            listBtn.centerYAnchor.constraint(equalTo: airPlayBtn.centerYAnchor),
            
        ])
        
        statusBtn.addTarget(self, action: #selector(updataStatusButton(sender:)), for: .touchUpInside)
        volumeSlider.addTarget(self, action: #selector(changeVolumeSliderValue), for: .touchDragInside)
        songLengthSlider.addTarget(self, action: #selector(changeSongLengthSliderValue), for: .touchUpInside)
        
    }
    
}


extension PlayerViewController {
    
    private func configureLabel(for label: UILabel, text: String?, font: String, size: CGFloat, color: UIColor) {
        label.text = text
        label.font = UIFont(name: font, size: size)
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
    }
    
    private func configureSlider(_ slider: UISlider) {
        let config = UIImage.SymbolConfiguration(pointSize: 8)
        let image = UIImage(systemName: "circle.fill", withConfiguration: config)
        slider.setThumbImage(image, for: .normal)
        slider.tintColor = .white
        slider.minimumValue = 0.0
        slider.value = 0.3
        slider.maximumValue = 1
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
    }
    
    private func configureButton(for button: UIButton, pointSize: CGFloat, systemName: String, color: UIColor) {
        let config = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .regular)
        let image = UIImage(systemName: systemName, withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = color
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
    }
    
    @objc private func updataStatusButton(sender: UIButton) {
        if player.timeControlStatus == .playing {
            configureButton(for: statusBtn, pointSize: 40, systemName: "play.fill", color: .white)
            player.pause()
            print("now is pause")
        } else if player.timeControlStatus == .paused {
            configureButton(for: statusBtn, pointSize: 40, systemName: "pause.fill", color: .white)
            player.play()
            print("now is play")
        }
        
    }
    
    private func setupPlayer() {
        let url = Bundle.main.url(forResource: songList[2].mp3Name, withExtension: "mp3")!
        playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    private func updatePlayerInfo() {
        let currentSongDurationInSecs = CMTimeGetSeconds(player.currentTime())
        let currentSongDurationSec = String(format: "%02d", Int(currentSongDurationInSecs) % 60)
        let currentSongDurationMin = String(Int(currentSongDurationInSecs / 60))
        self.songDurationStartLabel.text = "\(currentSongDurationMin):\(currentSongDurationSec)"
        let duration = playerItem!.asset.duration // TODO: remove "!"
        let currentSongTotalDurationInSecs = CMTimeGetSeconds(duration)
        let remainingSongDuration = currentSongTotalDurationInSecs - currentSongDurationInSecs
        let remainingSongDurationSec = String(format: "%02d", Int(remainingSongDuration) % 60)
        let remainingSongDurationMin = String(Int(remainingSongDuration / 60))
        self.songDurationEndLabel.text = "-\(remainingSongDurationMin):\(remainingSongDurationSec)"
        
        songLengthSlider.maximumValue = Float(currentSongTotalDurationInSecs)
        songLengthSlider.value = Float(currentSongDurationInSecs)
    }
    
    private func observePlayerTimeUpdates() {
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: .main) { [weak self] _ in
            self?.updatePlayerInfo()
        }
    }
    
    @objc private func changeVolumeSliderValue(_ sender: UISlider) {
        player.volume = volumeSlider.value
    }
    
    @objc private func changeSongLengthSliderValue(_ sender: UISlider) {
        let currentSongSec = Int64(songLengthSlider.value)
        let targetTime = CMTimeMake(value: currentSongSec, timescale: 1)
        player.seek(to: targetTime)
    }
    
}
