//
//  DataSource.swift
//  Lesson12
//
//  Created by Андрей Зорькин on 23/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

/// Делегат DataSource
protocol DataSourceDelegate {
    /// DataSource обновил данные ячейки
    ///
    /// - Parameter indexPath: индекс ячейки
    func dataSourceDidUpdateData(ofRowAt indexPath: IndexPath)
}

///
protocol MyTableViewDataSource: UITableViewDataSource {
    
    var delegate: DataSourceDelegate? { get set }
    
    func getDataFor(RowAt indexPath: IndexPath) -> String
    
    func updateTitleFor(RowAt indexPath: IndexPath, newTitle: String)
}

// MARK: - Модели
extension DataSource {
    struct CellData {
        let image: UIImage
        let title: String
        let subtitle: String?
        
        init(_ title: String, image: UIImage = UIImage(), subtitle: String? = nil) {
            self.image = image
            self.title = title
            self.subtitle = subtitle
        }
    }
}

///
class DataSource: NSObject, MyTableViewDataSource {
    
    // MARK: - TableViewDataSource
    
    var delegate: DataSourceDelegate?
    
    public func getDataFor(RowAt indexPath: IndexPath) -> String {
        return data[indexPath.section][indexPath.row].title
    }
    
    public func updateTitleFor(RowAt indexPath: IndexPath, newTitle: String) {
        let oldCell = data[indexPath.section][indexPath.row]
        let newCellData = CellData(newTitle, image: oldCell.image, subtitle: oldCell.subtitle)
        data[indexPath.section][indexPath.row] = newCellData
        delegate?.dataSourceDidUpdateData(ofRowAt: indexPath)
        
    }
    
    // MARK: - Data
    
    private var data: [[CellData]] = [
        [CellData("Sign in to your iPhone", image: UIImage(named: "user")!,
                  subtitle: "Set up iCloud, th App Store, and more.")],
        
        [CellData("General", image: UIImage(named: "general")!),
         CellData("Privacy", image: UIImage(named: "02")!)],
        
        [CellData("Password & Accounts", image: UIImage(named: "03")!)],
        
        [CellData("Maps", image: UIImage(named: "04")!),
         CellData("Safari", image: UIImage(named: "05")!),
         CellData("News", image: UIImage(named: "06")!),
         CellData("Siri", image: UIImage(named: "07")!),
         CellData("Photos", image: UIImage(named: "08")!),
         CellData("Game Center", image: UIImage(named: "09")!)],
        
        [CellData("Developer", image: UIImage(named: "10")!)]
        
        ]
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let cell: UITableViewCell
        let cellData = data[indexPath.section][indexPath.row]
        
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "Subtitle"){
                print("REUSABLE \(cellData.title)")
                cell = reusableCell
            } else {
                print("NEW \(cellData.title)")
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Subtitle")
                if let textLabel = cell.textLabel, let detailTextLabel = cell.detailTextLabel {
                    textLabel.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                    detailTextLabel.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                } else {
                    fatalError(#"Color customization of UITableViewCell(style: .subtitle, reuseIdentifier: "Subtitle") is failed"#)
                }
            }
        default:
            guard let reusableCell = tableView.dequeueReusableCell(withIdentifier: "Default") else {
                fatalError("Reusable Cell with identifier Default is not registered")
            }
            print("REUSABLE \(cellData.title)")
            cell = reusableCell
        }
        if let textLabel = cell.textLabel, let imageView = cell.imageView {
            textLabel.text = cellData.title
            textLabel.numberOfLines = 0
            imageView.image = cellData.image
            imageView.contentMode = .scaleAspectFit
        }
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = cellData.subtitle
        }
        cell.accessoryType = indexPath.section == 0 ? .none : .disclosureIndicator
        
        return cell
    }
    
}
