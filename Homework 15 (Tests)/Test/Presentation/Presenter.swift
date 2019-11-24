//
//  Presenter.swift
//  Test
//
//  Created by Андрей Зорькин on 31/10/2019.
//  Copyright © 2019 Antyshev Dmitriy. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol PresenterInput {
    
    func show()
    
    func download()
    
    func cacheClear()
    
}

protocol PresenterOutput {
    
    func showImage(image: UIImage)
    
    func showAlert(text: String)
    
    func removeImage()
    
}

class Presenter {

    var output: PresenterOutput?
    var interactor: InteractorInput?
    var router: IRouterInput?
    
}

extension Presenter: PresenterInput {
    
    func show() {
        if let interactor = interactor {
            interactor.show()
        } else {
            assertionFailure("[Presenter]: interactor не задан")
        }
    }
    
    func download() {
        if let interactor = interactor {
            interactor.download()
        } else {
            assertionFailure("[Presenter]: interactor не задан")
        }
    }
    
    func cacheClear() {
        if let view = output {
            view.removeImage()
        } else {
            assertionFailure("[Presenter]: output не задан")
        }
        if let interactor = interactor {
            interactor.cacheClear()
        } else {
            assertionFailure("[Presenter]: interactor не задан")
        }
    }
    
}

extension Presenter: InteractorOutput {
    
    func showImage(image: UIImage) {
        if let view = output {
            view.showImage(image: image)
        } else {
            assertionFailure("[Presenter]: output не задан")
        }
    }
    
    func showError(_ error: Interactor.Error) {
        if let view = output {
            switch error {
            case .downloadError: view.showAlert(text: "Ошибка при скачивании")
            case .emptyImageCacheError: view.showAlert(text: "Кэш не содержит картинки")
            }
        } else {
            assertionFailure("[Presenter]: output не задан")
        }
    }
    
    func didDownload() {
        // OK
    }
    
}
