//
//  MediaLibraryProgramListViewController.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import UIKit

class MediaLibraryProgramListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private struct CellIdentifiers {
        static let MediaProgramItemTableViewCell = "MediaProgramItemTableViewCell"
    }
    
    var viewModel: MediaLibraryProgramListViewModel!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Free Media Library"
        viewModel = MediaLibraryProgramListViewModel()
        handleViewModelActionHandlers()
        setupTableView()
        loadFreeMediaPrograms()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        loadFreeMediaPrograms()
    }
    
    func loadFreeMediaPrograms() {
        guard isViewLoaded else {
            self.refreshControl.endRefreshing()
            return
        }
        guard !viewModel.isFetching else { return }
        self.showAppLoader()
        viewModel.fetchFreeLibraries()
    }
    
    private func handleViewModelActionHandlers() {
        viewModel.onFreeLibraryFetchSuccess = { [weak self] in
            self?.hideAppLoader()
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
        viewModel.onFreeLibraryFetchError = { [weak self] (error) in
            self?.hideAppLoader()
            self?.handleError(error: error)
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func gotoTracksView(with model: [Track]) {
        let tracksVC = UIStoryboard.getViewController(inStoryboard: .MediaLibrary, identifier: .MediaProgramTracksVC) as! MediaLibraryTrackListViewController
        tracksVC.viewModel = MediaProgramTrackListViewModel(model: model)
        self.navigationController?.pushViewController(tracksVC, animated: true)
    }
}

extension MediaLibraryProgramListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel != nil else { return 0}
        return viewModel.programsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.getProgramItem(at: indexPath.row)
        let programItemCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MediaProgramItemTableViewCell) as! MediaProgramItemTableViewCell
        programItemCell.viewModel = MediaProgramItemViewModel(model: model)
        return programItemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let program = viewModel.getProgramItem(at: indexPath.row)
        guard let tracks = program.tracks, tracks.count > 0 else { return }
        self.gotoTracksView(with: tracks)
    }
}
