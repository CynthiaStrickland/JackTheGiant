//
//  AudioManager.swift
//  JackTheGiant
//
//  Created by Cynthia Whitlatch on 2/18/17.
//  Copyright © 2017 Fenix Design. All rights reserved.
//

import AVFoundation

class AudioManager {
    static let instance = AudioManager();
    private init() {}
    
    private var audioPlayer: AVAudioPlayer?;
    
    func playBGMusic() {
        let url = Bundle.main.url(forResource: "Background music", withExtension: "mp3");
        
        var err: NSError?;
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!);
            audioPlayer?.numberOfLoops = -1;
            audioPlayer?.prepareToPlay();
            audioPlayer?.play();
        } catch let err1 as NSError {
            err = err1;
        }
        
        if err != nil {
            print(err ?? <#default value#>);
        }
    }
    
    func stopBGMusic() {
        if (audioPlayer?.isPlaying) != nil {
            audioPlayer?.stop();
        }
    }
    
    func isAudioPlayerInitialized() -> Bool {
        return audioPlayer == nil;
    }
}

