//
//  MediaLibraryTrackListViewController.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import UIKit

class MediaLibraryTrackListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MediaProgramTrackListViewModel!
    var refreshControl = UIRefreshControl()
    var currentPlayigAudio: MediaTrackItemTableViewCell?
    
    private struct CellIdentifiers {
        static let MediaTrackItemTableViewCell = "MediaTrackItemTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tracks"
        setupTableView()
        tableView.reloadData()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension MediaLibraryTrackListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel != nil else { return 0}
        return viewModel.tracksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.getTrackItem(at: indexPath.row)
        let trackItemCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MediaTrackItemTableViewCell) as! MediaTrackItemTableViewCell
        trackItemCell.viewModel = MediaTrackItemViewModel(model: model)
        trackItemCell.onAudioStartPlaying = {
            [weak self] playerCell in
            if self?.currentPlayigAudio != playerCell {
                self?.currentPlayigAudio?.pausePlayer()
                self?.currentPlayigAudio = playerCell
            }
        }
        return trackItemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MediaTrackItemTableViewCell else { return }
        cell.tryPlayPause()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let audioCell = cell as? MediaTrackItemTableViewCell {
            audioCell.pausePlayer()
            if self.currentPlayigAudio?.viewModel.model.key == audioCell.viewModel.model.key {
                self.currentPlayigAudio = nil
            }
        }
    }
}
