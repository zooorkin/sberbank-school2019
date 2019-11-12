//
//  FilterViewController.swift
//  ImageFilters
//
//  Created by Андрей Зорькин on 11/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

// View-Контроллер с функционалом применения фильтров к изображениям
class FilterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    // Текущая редактируемая картинка
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    // Область для отображения редактируемой картинки
    var imageView: UIImageView!
    // Область фильтрованных изображений
    var collectionView: UICollectionView!
    // Отступ от границ экрана
    let screenBoundsSpacing: CGFloat = 16.0
    // Сервис для применения фильтров к изображениям
    let imageFilter = ImageFilter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Фильтры для фотографий"
        view.backgroundColor = .white
        setupBarItem()
        setupCollectionView()
        setupImageView()
        imageFilter.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        layoutCollectionView()
        layoutImageView()
    }
    
    // Установка кнопки для выбора изображения из галереи (камеры)
    private func setupBarItem() {
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(imageViewTapped))
        navigationItem.rightBarButtonItem = item
    }
    
    // Установка области фильтрованных изображений
    private func setupCollectionView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.register(FilterImageCell.self, forCellWithReuseIdentifier: "FilterImageCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    // Распознаватель нажатия на редактируемое изображение
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    // Настройка области для отображения редактируемой картинки
    private func setupImageView() {
        imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .groupTableViewBackground
        view.addSubview(imageView)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideOrShowFilters))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
    }

    // Layout области фильтрованных изображений
    private func layoutCollectionView() {
        let verticalSpacing: CGFloat = screenBoundsSpacing
        let width = view.frame.width - 2 * screenBoundsSpacing
        let yPosition = verticalSpacing + 88 + 8 + width
        let height = view.frame.height - yPosition - 2 * verticalSpacing
        collectionView.frame = CGRect(x: screenBoundsSpacing, y: yPosition, width: width, height: height)
    }
    
    // Layout области для отображения редактируемой картинки
    private func layoutImageView() {
        let width = view.frame.width
        imageView.frame = CGRect(x: 0, y: 88 - 16 + 4, width: width, height: width).insetBy(dx: 16, dy: 16)
    }
    
    var isHiddenFilters = false
    private var savedYPositionOfCollectionView: CGFloat = 0
    private var savedCenterOfImageView: CGPoint = .zero
    
    @objc private func hideOrShowFilters() {
        isHiddenFilters.toggle()
        // Спрятать
        if isHiddenFilters {
            savedYPositionOfCollectionView = collectionView.frame.origin.y
            savedCenterOfImageView = imageView.center
            UIView.animate(withDuration: 0.3) {
                self.collectionView.frame.origin.y = self.view.frame.height
                self.imageView.center = self.view.center
            }
        // Показать
        } else {
            UIView.animate(withDuration: 0.3) {
                self.collectionView.frame.origin.y = self.savedYPositionOfCollectionView
                self.imageView.center = self.savedCenterOfImageView
            }
        }
    }
    
    // Реакция на нажатие на правую кнопку в navigationItem
    @objc private func imageViewTapped() {
        let alertController = UIAlertController(title: "Выбреите", message: nil, preferredStyle: .alert)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Камера", style: .default) {
                alertAction in
                self.presentImagePickerController(sourceType: .camera)
            }
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let galleryAction = UIAlertAction(title: "Галерея", style: .default) {
                alertAction in
                self.presentImagePickerController(sourceType: .photoLibrary)
            }
            alertController.addAction(galleryAction)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) {
            alertActon in
        }
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    private func presentImagePickerController(sourceType: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            image = selectedImage
            images = .init(repeating: nil, count: imageFilter.filters.count)
            applyFilters()
        } else {
            assertionFailure("[FilterViewController]: failed casting selectedImage to UIImage")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Применение всех фильтров к текущему изображению
    private func applyFilters() {
        if let image = image {
            imageFilter.applyFilters(image: image)
        }
    }
    
    // Фильтрованные изображения
    lazy var images: [UIImage?] = .init(repeating: nil, count: imageFilter.filters.count)
    // Индикатор загрузки изображения
    lazy var loading: [Bool] = .init(repeating: false, count: imageFilter.filters.count)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageFilter.filters.count
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterImageCell", for: indexPath)
        guard let filterImageCell = cell as? FilterImageCell else {
            assertionFailure("[FilterViewController]: failed casting cell to filterImageCell")
            return cell
        }

        filterImageCell.image = images[indexPath.row]
        filterImageCell.title = imageFilter.filters[indexPath.row]
        filterImageCell.loading = loading[indexPath.row]
        
        return filterImageCell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        image = images[indexPath.row]
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let yPosition = 88 + width
        let height = view.frame.height - yPosition
        return CGSize(width: height - 16, height: height - 16)
    }
    
}

extension FilterViewController: ImageFilterDelegate {
    
    func imageFilterDidAppliedFilter(index: Int, image: UIImage) {
        // Для того, чтобы была плавная загрузка картинок с фильтрами
        DispatchQueue.main.asyncAfter(deadline: .init(uptimeNanoseconds: UInt64(index)*10_000_000)) {
            self.images[index] = image
            self.loading[index] = false
            self.collectionView.reloadItems(at: [.init(row: index, section: 0)])
        }
    }
    
}

// Ячейка фильтрованного изображения
class FilterImageCell: UICollectionViewCell {
    
    // Область фильтрованного изображения
    private var imageView: UIImageView!
    // Названия фильтра
    private var label: UILabel!
    // Индикатор загрузки
    private var activityIndicatorView: UIActivityIndicatorView!
    // Отступ
    private let spacing: CGFloat = 16
    
    // Индикатор загрузки
    var loading: Bool {
        get {
            if let activityIndicatorView = activityIndicatorView {
                return activityIndicatorView.isAnimating
            } else {
                return false
            }
        }
        set {
            if activityIndicatorView == nil {
                let frame = imageFrame()
                activityIndicatorView = UIActivityIndicatorView(frame: frame)
                addSubview(activityIndicatorView)
            }
            let shows = newValue
            activityIndicatorView.isHidden = !shows
            if shows {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }
        }
    }
    
    // Изображние для показа
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            if imageView == nil {
                let frame = imageFrame()
                imageView = UIImageView(frame: frame)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.backgroundColor = .groupTableViewBackground
                addSubview(imageView)
            }
            guard let imageView = imageView else {
                assertionFailure("[filterImageCell]: imageView is nil")
                return
            }
            imageView.image = newValue
        }
    }
    
    // Название фильтра
    var title: String? {
        get {
            return label.text
        }
        set {
            if label == nil {
                let width = bounds.width
                let height = bounds.height
                let frame = CGRect(x: 0, y: height - 2*spacing, width: width, height: 2*spacing)
                let edges = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
                let insetedFrame = frame.inset(by: edges)
                label = UILabel(frame: insetedFrame)
                label.font = .preferredFont(forTextStyle: .caption1)
                label.textAlignment = .center
                addSubview(label)
            }
            guard let label = label else {
                assertionFailure("[filterImageCell]: label is nil")
                return
            }
            label.text = newValue
        }
    }

    private func imageFrame() -> CGRect {
        let edges = UIEdgeInsets(top: 0, left: spacing, bottom: 2*spacing, right: spacing)
        let frame = bounds.inset(by: edges)
        return frame
    }
    
}
