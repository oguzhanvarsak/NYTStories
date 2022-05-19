//
//  HomeTableViewController.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 19.05.2022.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var viewModel: HomeViewModel!
    var service = WebService()
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {

        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        activityIndicator.startAnimating()
        tableView.backgroundView = activityIndicator
        
        getArticles(completion: {_ in })
    }
    
    private func getArticles(completion: @escaping (Bool) -> Void) {
        service.getArticles(url: URL(string: String(format: Url.topStories, Secrets.apiKey))!,
                            completion: { articles in
            if let articles = articles {
                
                self.viewModel = HomeViewModel(articles: articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    
                    completion(true)
                }
            }
        })
    }

    @IBAction func refreshControl(_ sender: UIRefreshControl) {
        getArticles(completion: { completed in
            if completed {
                sender.endRefreshing()
            }
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return self.viewModel == nil ? 0 : self.viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.viewModel.numOfRowsInSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("\("articleCell") not found.")
        }
        
        let articleVM = self.viewModel.articleAtIndex(indexPath.row)
        
        cell.configure(article: articleVM.currentArticle)
        
        return cell
    }
}
