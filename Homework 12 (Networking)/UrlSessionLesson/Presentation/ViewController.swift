//
//  ViewController.swift
//  UrlSessionLesson
//
//  Created by Константин Богданов on 06/11/2019.
//  Copyright © 2019 Константин Богданов. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    private enum ReusedID {
        static let tableViewCell = "UITableViewCellreuseId"
    }
    
    // Текст для поиска
    private var searchedText: String
    // Количество картинок на страницу
    private var perPage = 60
    // Текущая страница для запроса
    private var page = 1
    // Таймер для выполнения запроса
    private var timer: Timer?
    // Таймер для обновления ProgressView
    private var timerToUpdateProgressBar: Timer?
    // Время задержки для выполнения запроса
    private let delayTimeInterval: TimeInterval = 0.8
    // Время для обновления ProgressView
    private var timeInterval: TimeInterval = 0
    
    // Индикатор отсылки запроса (для красоты)
    let progressView = UIProgressView(progressViewStyle: .bar)
    // Центр уведомлений (для красоты)
    let notificationCenter = UNUserNotificationCenter.current()
    // Таблица
    let tableView: UITableView
    // Контроллер поиска
    let searchController = UISearchController(searchResultsController: nil)
    // Картинки для отображения
    var images: [ImageViewModel]
    // Интерактор
	let interactor: InteractorInput
    
    // Инициализатор
	init(interactor: InteractorInput) {
        searchedText = "Cat"
		self.interactor = interactor
        tableView = UITableView(frame: .zero, style: .grouped)
        images = []
		super.init(nibName: nil, bundle: nil)
        
	}
    
    required init?(coder: NSCoder) {
        fatalError("Метод не реализован")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "www.fglickr.com"
        setupTableView()
        setupSearchBar()
        setupNotifications()
	}
    
    // Настройка центра уведомлений
    private func setupNotifications() {
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert]) { (success, error) in
            if success {
                DispatchQueue.main.async {
                   self.showNotification(text: "Уведомления включены")
                }
            }
        }
    }
    
    // Настройка TableView
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReusedID.tableViewCell)
        tableView.dataSource = self
        tableView.delegate = self
    }

    // Настройка SearchBar'а
    private func setupSearchBar() {
        progressView.progress = 1.0
        view.addSubview(progressView)
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск картинок"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    
    // Layout
    override func viewWillLayoutSubviews() {
        if let maxYofBar = navigationController?.navigationBar.frame.maxY {
            progressView.frame = CGRect(x: 0, y: maxYofBar, width: view.frame.width, height: 2)
        }
    }
    
    // Выполнить поиск
    @objc private func search() {
        interactor.loadImageList(by: searchedText, perPage: perPage, page: page) { [weak self] models in
            if let `self` = self {
                self.loadImages(with: models, perPage: self.perPage, page: self.page)
            }
		}
    }
    
    // Загрузить картинки по моделям
    private func loadImages(with models: [ImageModel], perPage: Int, page: Int) {
        let group = DispatchGroup()
        if page == 1 {
            DispatchQueue.main.sync {
                self.images = []
                self.tableView.reloadData()
            }
        }
        var images: [ImageViewModel] = []
        for model in models {
            group.enter()
            self.interactor.loadImage(at: model.path) { image in
                guard let image = image else {
                    group.leave()
                    return
                }
                let viewModel = ImageViewModel(image: image, description: model.description)
                images.append(viewModel)
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            if page == 1 {
                self.images = images
                self.tableView.reloadData()
            } else {
                var rowsToInsert: [IndexPath] = []
                for itemIndex in 0..<images.count {
                    let index = IndexPath(row: self.images.count + itemIndex, section: 0)
                    rowsToInsert.append(index)
                }
                if rowsToInsert.count != 0 {
                    self.images += images
                    self.tableView.insertRows(at: rowsToInsert, with: .bottom)
                }
            }
            self.showNotification(text: "Страница \(page) загружена")
            self.page += 1
        }
    }
    
    // Отобразать уведомление
    private func showNotification(text: String) {
        let content = makeNotification(text: text)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(identifier: "0R1E2I3F4I5T6N7E8D9I",
                                            content: content,
                                            trigger: trigger)
        notificationCenter.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // Создать уведомление
    private func makeNotification(text: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.badge = 0
        content.body = text
        content.title = "Поиск"
        content.categoryIdentifier = "categoryIdentifier"
        return content
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReusedID.tableViewCell, for: indexPath)
        let model = images[indexPath.row]
        if let textLabel = cell.textLabel,
            let imageView = cell.imageView {
            imageView.image = model.image
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            textLabel.text = model.description
        } else {
            assertionFailure("[ViewController]: textLabel or imageView is nil")
        }
        return cell
    }
    
}

// Делагат UITableView
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == images.count - 1 {
            search()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
    }
    
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

// Делегат UISearchBar'а
extension ViewController: UISearchBarDelegate {
    
    @objc func updateProgressBar() {
        timeInterval -= 0.001
        if timeInterval < 0 {
            timerToUpdateProgressBar?.invalidate()
        }
        DispatchQueue.main.async {
            self.progressView.progress = 1 - Float(self.timeInterval) / Float(self.delayTimeInterval)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        progressView.progress = 0
        page = 1
        searchedText = searchText == "" ? " " : searchText
        print("Набирается текст... \(searchText)")
        
        if let timer = timer {
            timer.invalidate()
        }
        if let timerToUpdateProgressBar = timerToUpdateProgressBar {
            timerToUpdateProgressBar.invalidate()
        }
        
        timeInterval = delayTimeInterval
        
        timer = Timer.scheduledTimer(timeInterval: delayTimeInterval, target: self, selector: #selector(search), userInfo: nil, repeats: false)
        
        timerToUpdateProgressBar = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateProgressBar), userInfo: nil, repeats: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar(searchBar, textDidChange: " ")
    }
    
}

// Уведомления
extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
}
