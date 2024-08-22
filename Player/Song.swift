//
//  File.swift
//  Player
//
//  Created by 郭蕙瑄 on 2024/8/20.
//

import UIKit

struct SongInfo {
    var songName : String
    var artist : String
    var coverName : String
    var backGroundColor : [CGColor]
}

let songList = [
    
    //index == 0
    SongInfo(
        songName: "rocking chair",
        artist: "Wavcrush",
        coverName: "1",
        backGroundColor: [
            UIColor(red: 143/255, green: 78/255, blue: 174/255, alpha: 1.0).cgColor,
            UIColor(red: 145/255, green: 77/255, blue: 174/255, alpha: 1.0).cgColor,
            UIColor(red: 123/255, green: 80/255, blue: 169/255, alpha: 1.0).cgColor,
            UIColor(red: 75/255, green: 61/255, blue: 112/255, alpha: 1.0).cgColor ]),
    
    //index == 1
    SongInfo(
        songName: "lululemon",
        artist: "Lil Jet",
        coverName: "2",
        backGroundColor: [
            UIColor(red: 59/255, green: 51/255, blue: 54/255, alpha: 1.0).cgColor,
            UIColor(red: 78/255, green: 62/255, blue: 78/255, alpha: 1.0).cgColor,
            UIColor(red: 46/255, green: 38/255, blue: 54/255, alpha: 1.0).cgColor ]),
    
    //index == 2
    SongInfo(
        songName: "Havana",
        artist: "Camila Cabello",
        coverName: "3",
        backGroundColor: [
            UIColor(red: 218/255, green: 75/255, blue: 75/255, alpha: 1.0).cgColor,
            UIColor(red: 237/255, green: 104/255, blue: 93/255, alpha: 1.0).cgColor,
            UIColor(red: 242/255, green: 154/255, blue: 128/255, alpha: 1.0).cgColor,
            UIColor(red: 245/255, green: 183/255, blue: 142/255, alpha: 1.0).cgColor ])
]
