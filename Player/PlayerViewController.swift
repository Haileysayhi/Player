//
//  PlayerViewController.swift
//  Player
//
//  Created by 郭蕙瑄 on 2024/8/20.
//

import UIKit

class PlayerViewController: UIViewController {
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
        
        configureLabel(label: songName, text: songList.last?.songName, font: "PingFangTC-Semibold", size: 18, color: .white)
        configureLabel(label: artistName, text: songList.last?.artist, font: "PingFangTC-Regular", size: 16, color: .white)
        configureLabel(label: songDurationStartLabel, text: "--:--", font: "PingFangTC-Regular", size: 12, color: .white)
        configureLabel(label: songDurationEndLabel, text: "--:--", font: "PingFangTC-Regular", size: 12, color: .white)
        
        configureSlider(slider: songLengthSlider)
        configureSlider(slider: volumeSlider)
        
        configureButton(button: backwardBtn, pointSize: 30, systemName: "backward.fill", color: .white)
        configureButton(button: statusBtn, pointSize: 40, systemName: "play.fill", color: .white)
        configureButton(button: forwardBtn, pointSize: 30, systemName: "forward.fill", color: .white)
        configureButton(button: raiseVolumeButton, pointSize: 15, systemName: "speaker.wave.3.fill", color: .white)
        configureButton(button: lowerVolumeButton, pointSize: 15, systemName: "speaker.fill", color: .white)
        configureButton(button: airPlayBtn, pointSize: 20, systemName: "airplayaudio", color: .white)
        configureButton(button: lyrisBtn, pointSize: 19, systemName: "quote.bubble", color: .white)
        configureButton(button: listBtn, pointSize: 21, systemName: "list.bullet", color: .white)

       
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
    }

}


extension PlayerViewController {
    
    private func configureLabel(label: UILabel, text: String?, font: String, size: CGFloat, color: UIColor) {
        label.text = text
        label.font = UIFont(name: font, size: size)
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
    }
    
    private func configureSlider(slider: UISlider) {
        let config = UIImage.SymbolConfiguration(pointSize: 8)
        let image = UIImage(systemName: "circle.fill", withConfiguration: config)
        slider.setThumbImage(image, for: .normal)
        slider.tintColor = .white
        slider.minimumValue = 0.1
        slider.value = 0.0
        slider.maximumValue = 1
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
    }
    
    private func configureButton(button: UIButton, pointSize: CGFloat, systemName: String, color: UIColor) {
        let config = UIImage.SymbolConfiguration(pointSize: pointSize, weight: .regular)
        let image = UIImage(systemName: systemName, withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = color
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
    }
}
