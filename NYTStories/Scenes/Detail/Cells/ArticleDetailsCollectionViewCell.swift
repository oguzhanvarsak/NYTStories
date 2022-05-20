//
//  ArticleDetailsCollectionViewCell.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 19.05.2022.
//

import UIKit

class ArticleDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    func configure(viewModel: ArticleCellViewModel) {
        
        articleTitleLabel.text = viewModel.articleTitle
        articleDescriptionLabel.text = viewModel.articleDescription
        
        if let mediaUrl = viewModel.articleImage {
            
            viewModel.fetchImage(for: mediaUrl, completion: { data in
                
                if let data = data, let image = UIImage(data: data) {
                    
                    self.articleImage.setImageAsync(image)
                }
            })
        } else {
            
            articleImage.image = UIImage(named: "nyt-logo")
        }
    }
}
