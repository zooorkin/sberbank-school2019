//
//  MockInteractorOutput.swift
//  TestTests
//
//  Created by Андрей Зорькин on 25/11/2019.
//  Copyright © 2019 Antyshev Dmitriy. All rights reserved.
//

import UIKit
@testable import Test

class MockInteractorOutput: InteractorOutput {
    
    /// Число вызовов функции showImage
    private var showImageCallsCount = 0
    /// Число вызовов функции showError
    private var showErrorCallsCount = 0
    /// Число вызовов функции didDownload
    private var didDownloadCallsCount = 0
    
    func showImage(image: UIImage) {
        showImageCallsCount += 1
    }
    
    func showError(_ error: Interactor.Error) {
        showErrorCallsCount += 1
    }
    
    func didDownload() {
        didDownloadCallsCount += 1
    }
    
    func verifyShowImageCallsCount(block: (Int) -> Void) {
        block(showImageCallsCount)
    }
    func verifyshowErrorCallsCount(block: (Int) -> Void) {
        block(showErrorCallsCount)
    }
    func verifyDidDownloadCallsCount(block: (Int) -> Void) {
        block(didDownloadCallsCount)
    }
    
}
