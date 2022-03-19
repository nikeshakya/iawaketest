//
//  MediaProgramItemTableViewCell.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import UIKit

class MediaProgramItemTableViewCell: UITableViewCell {
    @IBOutlet weak var programBannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tracksCountLabel: UILabel!
    
    var viewModel: MediaProgramItemViewModel! {
        didSet {
            updateCellComponents()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateCellComponents() {
        programBannerImageView.setImage(withUrlString: viewModel.bannerThumbnailUrl, placeholderImage: .albumPlaceholder)
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        tracksCountLabel.text = viewModel.tracksCount
    }
}
