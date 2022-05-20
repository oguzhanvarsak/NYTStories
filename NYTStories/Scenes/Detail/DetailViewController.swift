//
//  DetailViewController.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 19.05.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }

    var screenWidth = UIScreen.main.bounds.width
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {

        collectionView.delegate = self
        collectionView.dataSource = self
        
        registerCells()
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: "ArticleInformationCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "ArticleInformationCollectionViewCell")
        
        collectionView.register(UINib(nibName: "ArticleDetailsCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: "ArticleDetailsCollectionViewCell")
    }
    
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        // TODO: ActivityViewController & Share Actions
    }
    
    @IBAction func seeMore(_ sender: UIButton) {
        // TODO: Present article using its url in sheet
    }
}

extension DetailViewController: DetailViewModelDelegate {
    
    func reloadItems() {
        
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            case 0:
                let cell: ArticleInformationCollectionViewCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "ArticleInformationCollectionViewCell",
                    for: indexPath
                ) as! ArticleInformationCollectionViewCell
                
                

                
                cell.articleDateLabel.text = Formatter().getDate(from: (viewModel?.selectedArticle?.created_date!)!)
                cell.authorLabel.text = viewModel?.selectedArticle?.byline
                
                return cell
            default:
                let cell: ArticleDetailsCollectionViewCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "ArticleDetailsCollectionViewCell",
                    for: indexPath
                ) as! ArticleDetailsCollectionViewCell
                
                if let article = viewModel?.selectedArticle {
                    
                    cell.configure(viewModel: ArticleCellViewModel(article: article))
                }
                
                return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
            case 0:
                return CGSize(width: screenWidth, height: 60)
            default:
                return CGSize(width: screenWidth, height: collectionView.frame.height)
        }
    }
}
