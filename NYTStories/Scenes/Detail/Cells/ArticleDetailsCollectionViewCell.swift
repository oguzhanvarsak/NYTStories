//
//  ArticleDetailsCollectionViewCell.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 19.05.2022.
//

import UIKit

protocol ArticleDetailsCollectionViewCellDelegate {
    func presentAlert(description: String)
}

class ArticleDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    
    var delegate: ArticleDetailsCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    func configure(viewModel: ArticleCellViewModel) {
        articleTitleLabel.text = viewModel.articleTitle
        articleDescriptionLabel.text = viewModel.articleDescription
        
        if let mediaUrl = viewModel.articleImage {
            viewModel.fetchImageData(for: mediaUrl, completion: { result in
                switch result {
                    case .success(let data):
                        if let data = data, let image = UIImage(data: data) {
                            self.articleImage.setImageAsync(image)
                        } else {
                            self.articleImage.image = UIImage(named: "nyt-logo")
                        }
                    case .failure(let error):
                        self.delegate?.presentAlert(description: error.localizedDescription)
                }
            })
        } else {
            articleImage.image = UIImage(named: "nyt-logo")
        }
    }
}
