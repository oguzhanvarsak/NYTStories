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
    
    func configure(article: Article) {
        self.articleTitleLabel.text = article.title ?? ""
        self.articleAuthorLabel.text = article.byline ?? ""
        
        if let mediaUrl = article.multimedia?[2].url {
            fetchImage(from: mediaUrl)
        } else {
            setArticleImage()
        }
    }
    
    private func fetchImage(from url: String) {
        
        WebService().loadImage(for: url, completion: { image in
            self.setArticleImage(with: image)
        })
    }
    
    private func setArticleImage(with image: UIImage? = UIImage(named: "nyt-logo")!) {
        DispatchQueue.main.async {
            self.articleImage.image = image
        }
    }
}
