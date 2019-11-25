//
//  Interactor.swift
//  Test
//
//  Created by Андрей Зорькин on 31/10/2019.
//  Copyright © 2019 Antyshev Dmitriy. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol InteractorInput {
    
    func show()
    
    func download()
    
    func cacheClear()
    
}

protocol InteractorOutput {
    
    func showImage(image: UIImage)
    
    func showError(_ error: Interactor.Error)
    
    func didDownload()
    
}

class Interactor {

    enum Error: Swift.Error {
        case downloadError
        case emptyImageCacheError
    }

    private var urlString = "http://icons.iconarchive.com/icons/dtafalonso/ios8/512/Calendar-icon.png"
    
    var output: InteractorOutput?
    
    private var cachedImage: UIImage?
    
    private var imageService: ImageServiceProtocol
    
    init(imageService: ImageServiceProtocol) {
        self.imageService = imageService
        self.imageService.delegate = self
    }
    
}

extension Interactor: InteractorInput {
    
    func show() {
        if let output = output {
            if let cachedImage = cachedImage {
                print("Картинка есть в кэше, показываем")
                output.showImage(image: cachedImage)
            } else {
                print("Картинки нет в кэше, ошибка")
                output.showError(.emptyImageCacheError)
            }
        } else {
            assertionFailure("[Interactor]: output не задан")
        }
    }
    
    func download() {
        if let _ = cachedImage {
            print("Картинка есть в кэше, скачивать не нужно")
        } else {
            print("Картинки нет в кэше, скачиваем")
            guard let url = URL(string: urlString) else {
                assertionFailure("Не удалось сформировать URL из строки")
                return
            }
            imageService.downloadImageByURL(url)
        }
    }
    
    func cacheClear() {
        if let output = output {
            if cachedImage == nil {
                print("Очистка кэша не требуется")
                output.showError(.emptyImageCacheError)
            } else {
                print("Очистка кэша")
                cachedImage = nil
            }
        } else {
            assertionFailure("[Interactor]: output не задан")
        }
    }
    
}

extension Interactor: ImageServiceDelegate {
    
    func imageServiceDidDownload(image: UIImage) {
        if let output = output {
            cachedImage = image
            output.didDownload()
        } else {
            assertionFailure("[Interactor]: output не задан")
        }
    }
    
    func imageServiceDidNotDownloadImage() {
        if let output = output {
            output.showError(.downloadError)
        } else {
            assertionFailure("[Interactor]: output не задан")
        }
    }
    
}
