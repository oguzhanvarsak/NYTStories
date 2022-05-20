//
//  DetailViewController.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 19.05.2022.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel?
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        collectionView.collectionViewLayout.invalidateLayout()
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
        
        if let shareUrl = viewModel?.selectedArticle?.url {
            
            let items = [URL(string: shareUrl)]
            
            let activity = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
            present(activity, animated: true)
        }
    }
    
    @IBAction func seeMore(_ sender: UIButton) {
        
        if let fullStoryUrl = viewModel?.selectedArticle?.url, let url = URL(string: fullStoryUrl) {
            
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)
        }
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
                
                cell.articleDateLabel.text = viewModel?.getDate(from: viewModel?.selectedArticle?.published_date)
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
        let safeWidth = self.view.safeAreaLayoutGuide.layoutFrame.size.width
        
        switch indexPath.section {
            case 0:
                return CGSize(width: safeWidth, height: 60)
            default:
                return CGSize(width: safeWidth, height: 500)
        }
    }
}

