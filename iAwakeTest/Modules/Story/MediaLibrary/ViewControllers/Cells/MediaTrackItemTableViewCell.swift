//
//  MediaTrackItemTableViewCell.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import UIKit
import SZAVPlayer

enum SZPlayerControllerEventType {
    case none
    case playing
    case paused
    case stalled
    case failed
}

class MediaTrackItemTableViewCell: UITableViewCell {
    @IBOutlet weak var playPauseIconView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackDescriptionLabel: UILabel!
    @IBOutlet weak var trackDurationLabel: UILabel!
    
    var viewModel: MediaTrackItemViewModel! {
        didSet {
            updateCellComponents()
        }
    }
    
    var playerConfig: SZAVPlayerConfig?
    var player: SZAVPlayer?
    
    var onAudioStartPlaying: ((MediaTrackItemTableViewCell?) -> Void)?
    var playerStatus: SZPlayerControllerEventType = .none
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateCellComponents() {
        playPauseIconView.image = viewModel.playPauseIcon
        trackTitleLabel.text = viewModel.title
        trackDescriptionLabel.text = viewModel.description
        trackDurationLabel.text = viewModel.duration
        updateMediaPlayer()
    }

    func updateMediaPlayer() {
        guard !viewModel.trackUrl.isEmpty, let url = URL(string: viewModel.trackUrl) else { return }
        player?.reset()
        playerConfig = nil
        player = nil
        self.setupAudioPlayer(withUrl: url)
    }
    
    private func setupAudioPlayer(withUrl url: URL) {
        guard player == nil else {
            viewModel.audioDuration = player?.player?.currentItem?.asset.duration.seconds ?? 0
            viewModel.currentTime = player?.player?.currentItem?.currentTime().seconds ?? 0
            return
        }
        self.playerConfig = SZAVPlayerConfig(urlStr: url.absoluteString, uniqueID: nil)
        self.player = SZAVPlayer()
        self.player?.delegate = self
        self.player?.setupPlayer(config: self.playerConfig!)
        self.trackDurationLabel.text = viewModel.duration
    }
    
    private func finishPlayerAudioInit() {
        self.viewModel.isPlayerReady = true
        self.viewModel.audioDuration = player?.totalTime ?? 0
        
        trackDurationLabel.text = viewModel.duration
        self.updatePlayPauseIcon()
    }
    
    func updatePlayPauseIcon() {
        playPauseIconView.image = viewModel.playPauseIcon
    }
    
    func tryPlayPause() {
        guard let audioPlayer = player?.player else { return }
        if audioPlayer.rate == 0 {
            onAudioStartPlaying?(self)
            playPlayer()
        }
        else {
            pausePlayer()
        }
    }
    
    func playPlayer() {
        player?.play()
        viewModel.isPlaying = true
        updatePlayPauseIcon()
    }
    
    func pausePlayer() {
        player?.pause()
        viewModel.isPlaying = false
        updatePlayPauseIcon()
    }
}

extension MediaTrackItemTableViewCell: SZAVPlayerDelegate {
    func avplayer(_ avplayer: SZAVPlayer, didReceived remoteCommand: SZAVPlayerRemoteCommand) -> Bool {
        return false
    }
    
    func avplayer(_ avplayer: SZAVPlayer, didChanged status: SZAVPlayerStatus) {
        switch status {
        case .readyToPlay:
            finishPlayerAudioInit()
            if playerStatus == .playing {
                player?.play()
            }
            return
        case .playEnd:
            self.player?.reset()
            viewModel.isPlaying = false
            updatePlayPauseIcon()
        case .loadingFailed:
            debugPrint("Failed to load audio for url \(avplayer.currentURLStr ?? "") error: \(avplayer.playerItem?.error?.localizedDescription ?? "")")
        case .bufferEnd:
            finishPlayerAudioInit()
            viewModel.audioDuration = player?.totalTime ?? 0
            if playerStatus == .stalled {
                player?.play()
            }
            return
        case .playbackStalled:
            playerStatus = .stalled
        default:
            return
        }
    }
    
    func avplayer(_ avplayer: SZAVPlayer, refreshed currentTime: Float64, loadedTime: Float64, totalTime: Float64) {
        viewModel.currentTime = currentTime
        trackDurationLabel.text = viewModel.duration
    }
}
