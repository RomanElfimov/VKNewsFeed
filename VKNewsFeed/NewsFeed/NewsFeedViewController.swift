//
//  NewsFeedViewController.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 27.06.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}


class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    
    // MARK: - External Properties
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    
    
    // MARK: - Internal Properties
    
    private var feedViewModel = FeedViewModel.init(cells: [], footerTitle: nil) // модель данных для новостной ленты - это массив
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
   
    private var titleView = TitleView()
    
    private lazy var footerView = FooterView()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = NewsFeedInteractor()
        let presenter             = NewsFeedPresenter()
        let router                = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: - Routing
    
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTopBars()
        setupTableView()
        
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        interactor?.makeRequest(request: .getNewsFeed)
        interactor?.makeRequest(request: .getUser)
    }

    
    func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        
        case .dispayNewsFeed(let feedViewModel):
            self.feedViewModel = feedViewModel
            
            footerView.setTitle(title: feedViewModel.footerTitle)
            tableView.reloadData()
            refreshControl.endRefreshing()
            
        case .displayUser(let userViewModel):
            titleView.set(userViewModel: userViewModel)
            
        case .displayFooterLoader:
            footerView.showLoader()
            
        }
    }
    
    
    private func setupTableView() {
        
        let topInset: CGFloat = 8
        tableView.contentInset.top = topInset
        
        tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseId)
        tableView.register(NewsFeedCodeCell.self, forCellReuseIdentifier: NewsFeedCodeCell.reuseId)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.addSubview(refreshControl)
        
        // footer view for loading previous posts
        tableView.tableFooterView = footerView
    }
    
    
    private func setupTopBars() {
        // При пролистывании view скрывается
        self.navigationController?.hidesBarsOnSwipe = true
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    
    // Когда долистываем ленту до конца
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            print("hello world")
            interactor?.makeRequest(request: .getNextBatch)
            
        }
    }
    
    // MARK: - Selector
    @objc private func refresh() {
        interactor?.makeRequest(request: .getNewsFeed)
    }
    
}



extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as! NewsFeedCell
       
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCodeCell.reuseId, for: indexPath) as! NewsFeedCodeCell
        
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
}



// MARK: - NewsFeedCodeCellDelegate Protocol

extension NewsFeedViewController: NewsFeedCodeCellDelegate {

    func revealPost(for cell: NewsFeedCodeCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: .revealPostIds(postId: cellViewModel.postId))
    }
}
