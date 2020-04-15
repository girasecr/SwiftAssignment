//
//  DataListViewController.swift
//  SwiftAssignment
//
//  Created by Chetan Girase on 13/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import UIKit

class DataListViewController: UIViewController {
    
    //**************************************************
    // MARK: Properties/Constants
    //**************************************************
    
    struct CONSTANTS {
        static let pullToRefresh = "Pull to refresh"
        static let alertTitle = "No Internet Connection"
        static let alertMessage = "Internet Connection is required fot this application to run properly"
        static let alertButtonTitle = "Ok"
    }
    
    private var viewModel: DataViewModel? // ViewModel
    let tableView = UITableView() // view
    var refreshControl = UIRefreshControl()
    
    //**************************************************
    // MARK: View life cycle
    //**************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTavleview()
        loadModelData()
        setupPullToRefresh()
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        addReachabilityNotifier()
    //    }
    
    //**************************************************
    // MARK: - Required Methods
    //**************************************************
    
    private func setupTavleview() {
        view.addSubview(tableView)
        
        //Add tableview constraint
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        //Set tableview delegate and datasource
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        //Register tableview cell
        tableView.register(DataTableviewCell.self, forCellReuseIdentifier: DataTableviewCell.cellIdentifier())
        tableView.tableFooterView = UIView()
    }
    
    private func loadModelData() {
        viewModel = DataViewModel()
        viewModel?.addReachabilityNotifier()
        viewModel?.reachabilityDelegate = self //Setting reachability delegate
        observeEvents()
    }
    
    /// Function to observe various event call backs from the viewmodel as well as Notifications.
    private func observeEvents() {
        viewModel?.updateUI = { [weak self] in
            DispatchQueue.main.async(execute: {
                self?.title = self?.viewModel?.navTitle
                self?.tableView.reloadData()
            })
        }
    }
}

//**************************************************
// MARK: Delegate methods UITableViewDataSource, UITableViewDelegate
//**************************************************

extension DataListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DataTableviewCell.cellIdentifier(), for: indexPath) as? DataTableviewCell
        
        let rowData = viewModel?.rowsArray[indexPath.row]
        cell?.row = rowData
        cell?.layer.shouldRasterize = true
        cell?.layer.rasterizationScale = UIScreen.main.scale
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//**************************************************
// MARK: Pull to refresh
//**************************************************

extension DataListViewController {
    
    private func setupPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: CONSTANTS.pullToRefresh)
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        // Code to refresh table view
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
}

//**************************************************
// MARK: - Reachability Delegate Methods
//**************************************************

extension DataListViewController: ReachabilityProtocol {
    func networkConnectionDidConnected() {
        
        DispatchQueue.main.async {
            self.viewModel?.loadApiData()
        }
    }
    
    func networkConnectionDidDisconnected() {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: CONSTANTS.alertTitle, message: CONSTANTS.alertMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: CONSTANTS.alertButtonTitle, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
