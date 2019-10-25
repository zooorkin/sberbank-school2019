//
//  TableViewController.swift
//  Lesson12
//
//  Created by Андрей Зорькин on 18/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

/// Экран "Settings"
class TableViewController: UIViewController, UITableViewDelegate,
    DetailViewControllerNewTitleDelegate, DataSourceDelegate {

    let tableView  = UITableView(frame: .zero, style: .grouped)
    
    let dataSource: MyTableViewDataSource = DataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.title = "Settings"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        dataSource.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    override func viewWillLayoutSubviews() {
        tableView.frame = view.frame
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = dataSource.getDataFor(RowAt: indexPath)
        let detailViewController = DetailViewController()
        detailViewController.delegate = self
        detailViewController.myIndexPath = indexPath
        detailViewController.detailTitle = title
        self.navigationController?.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - DetailViewControllerNewTitleDelegate
    
    func detailViewControllerDidChangeTitle(newTitle: String, forRowAt indexPath: IndexPath) {
        dataSource.updateTitleFor(RowAt: indexPath, newTitle: newTitle)
    }
    
    // MARK: - DataSourceDelegate
    
    func dataSourceDidUpdateData(ofRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
    }

}

