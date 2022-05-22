//
//  HomeTableViewController.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 19.05.2022.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var viewModel: HomeViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    let webService = WebService()
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let article = sender as? Article {
            let controller = segue.destination as! DetailViewController
            
            controller.viewModel = DetailViewModel(article: article)
        }
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        viewModel = HomeViewModel(webService: webService)
        
        activityIndicator.startAnimating()
        tableView.backgroundView = activityIndicator
        
        viewModel.getArticles()
    }

    @IBAction func refreshControl(_ sender: UIRefreshControl) {
        viewModel.getArticles(isRefresh: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection(section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("\("articleCell") not found.")
        }
        
        if let article = viewModel.articleAtIndex(indexPath.row) {
            cell.configure(viewModel: ArticleCellViewModel(article: article))
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let article = viewModel.articleAtIndex(indexPath.row) {
            
            performSegue(withIdentifier: "detailSegue", sender: article)
        }
    }
}

extension HomeTableViewController: HomeViewModelDelegate {
    func reloadItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func endRefreshing() {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
    
    func presentAlert(description: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: description, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: {_ in
                self.viewModel.getArticles(isRefresh: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }   
    }
}
