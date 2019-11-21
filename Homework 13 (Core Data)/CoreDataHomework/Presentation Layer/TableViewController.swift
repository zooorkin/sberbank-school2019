//
//  TableViewController.swift
//  CoreDataHomework
//
//  Created by Андрей Зорькин on 20/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var model: TableViewModel
    
    
    init(style: UITableView.Style, model: TableViewModel) {
        self.model = model
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Core Data"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(nibModels: [ImageCellModel.self])
        load()
        model.getImages { isEmpty in
            if isEmpty {
                self.alertWithMessage(title: "Андрей 💁🏻‍♂️", message: "В Core Data нет сохранённых картинок") {
                    self.alertWithMessage(title: "Андрей 💁🏻‍♂️", message: "Загружаем...") {
                        self.download()
                    }
                }
            } else {
                self.alertWithMessage(title: "Андрей 💁🏻‍♂️", message: "Картинки загружены из Core Data", completion: nil)
            }
        }
    }
    
    /// Загружаем картинки из Core Data. Если их не оказалось, то скачиваем из интернета
    func load() {

    }
    
    // Выполнить поиск
    @objc private func download() {
        model.downloadImageList(by: "architecture of bauhaus", perPage: 100, page: 1) { [weak self] models in
            if let `self` = self {
                self.loadImages(with: models, perPage: 100, page: 1)
            }
        }
    }
    
    // Загрузить картинки по моделям
    private func loadImages(with models: [FlickrAPI.PhotoModel], perPage: Int, page: Int) {
        let group = DispatchGroup()
        for photoModel in models {
            group.enter()
            guard let urlString = photoModel.url_m, let imageUrl = URL(string: urlString) else {
                group.leave()
                continue
            }
            model.downloadImage(at: imageUrl) { image in
                guard let image = image else {
                    group.leave()
                    return
                }
                let imageCellModel = ImageCellModel(description: photoModel.title, image: image)
                self.model.addImage(imageCellModel: imageCellModel)
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            self.model.save()
            self.alertWithMessage(title: "Андрей 💁🏻‍♂️",
                                  message: "Картинки загружены, перезапустите приложение", completion: nil)
        }
    }
    
    /// Вывести сообщение
    func alertWithMessage(title: String, message: String, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { alertAction in
            completion?()
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 7.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageViewController = ImageViewController()
        imageViewController.imageCellModel = model.imageCellModel(at: indexPath)
        if let navigationController = navigationController {
            navigationController.pushViewController(imageViewController, animated: true)
        } else {
            assertionFailure("[TableViewController]: navigationController is nil")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel: CellViewAnyModel
        cellModel = model.imageCellModel(at: indexPath)
        return tableView.dequeueReusableCell(withModel: cellModel, for: indexPath)
    }


}

