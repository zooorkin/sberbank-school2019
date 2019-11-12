//
//  ImageFilter.swift
//  ImageFilters
//
//  Created by Андрей Зорькин on 11/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

// Делегат ImageFilter'а
protocol ImageFilterDelegate {
    // Результат применения фильтра с индексом index
    func imageFilterDidAppliedFilter(index: Int, image: UIImage)

}

// Сервис для применения фильтров к изображениям
class ImageFilter {

    // Делегат
    public var delegate: ImageFilterDelegate?
    
    // Фильтры
    public let filters: [String] = ["CISepiaTone", "CIFalseColor", "CIPhotoEffectChrome", "CIPhotoEffectInstant", "CIColorCubeWithColorSpace", "CIPhotoEffectProcess", "CIColorInvert","CIColorCube", "CIColorMonochrome", "CIColorPosterize", "CIPhotoEffectNoir"]
    
    // Применение всех фильтров
    func applyFilters(image: UIImage) {
        for (index, filterName) in filters.enumerated() {
            // Уходим с main Queue и асинхронно применяем фильтры в concurrency очереди
            DispatchQueue.global().async {
                self.applyFilter(index: index, image: image, filterName: filterName)
            }
        }
    }
    
    lazy var context = CIContext()
    
    // Применение конкретного фильтра
    private func applyFilter(index: Int, image: UIImage, filterName: String){
        guard let ciImage = CIImage(image: image) else {
            assertionFailure("[ImageFilter]: ciImage is nil")
            return
        }
        guard let filter = CIFilter(name: filterName) else {
            assertionFailure("[ImageFilter]: filter is nil")
            return
        }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        //filter.setValue(0.5, forKey: kCIInputIntensityKey)
        guard let ciOutputImage = filter.outputImage else {
            assertionFailure("[ImageFilter]: ciOutputImage is nil")
            return
        }
        let outputImage = UIImage(ciImage: ciOutputImage)
        
        if let delegate = delegate {
            delegate.imageFilterDidAppliedFilter(index: index, image: outputImage)
        } else {
            assertionFailure("[ImageFilter]: delegate is nil")
        }
    }
    
}
