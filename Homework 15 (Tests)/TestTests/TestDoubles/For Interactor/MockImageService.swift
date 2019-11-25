//
//  MockImageService.swift
//  TestTests
//
//  Created by Андрей Зорькин on 25/11/2019.
//  Copyright © 2019 Antyshev Dmitriy. All rights reserved.
//

import Foundation
@testable import Test

class MockImageService: ImageServiceProtocol {
    
    /// Число вызовов функции downloadImageByURL
    private var downloadImageByURLCallsCount = 0
    /// Значение переданного аргумента url при вызове downloadImageByURL
    private var downloadImageByURLurl: URL!
    /// Ошибка при скачивании
    var withError = false
    
    var delegate: ImageServiceDelegate?
    
    func downloadImageByURL(_ url: URL) {
        downloadImageByURLurl = url
        downloadImageByURLCallsCount += 1
        if withError {
            delegate?.imageServiceDidNotDownloadImage()
        } else {
            delegate?.imageServiceDidDownload(image: .init())
        }
    }
    
    func verifyDownloadImageByURLCallsCount(block: (Int) -> Void) {
        block(downloadImageByURLCallsCount)
    }
    
    func verifyDownloadImageByURLurl(block: (URL) -> Void) {
        block(downloadImageByURLurl)
    }
    
}
