//
//  ArticleTableViewCell.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 19.05.2022.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.articleImage.image = nil
    }
    
    func configure(viewModel: ArticleCellViewModel) {
        self.articleTitleLabel.text = viewModel.articleTitle
        self.articleAuthorLabel.text = viewModel.articleAuthor
        
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
                        print(error.localizedDescription)
                }
            })
        } else {
            articleImage.image = UIImage(named: "nyt-logo")
        }
    }
}
