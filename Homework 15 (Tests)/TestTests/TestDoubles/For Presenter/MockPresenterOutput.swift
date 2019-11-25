//
//  MockPresenterOutput.swift
//  TestTests
//
//  Created by Андрей Зорькин on 25/11/2019.
//  Copyright © 2019 Antyshev Dmitriy. All rights reserved.
//

import UIKit
@testable import Test

class MockPresenterOutput: PresenterOutput {
    
    /// Число вызовов функции showImage
    private var showImageCallsCount = 0
    /// Число вызовов функции showAlert
    private var showAlertCallsCount = 0
    /// Число вызовов функции removeImage
    private var removeImageCallsCount = 0
    /// Значение переданного аргумента text при showAlert
    private var savedText: String = ""
    
    func showImage(image: UIImage) {
        showImageCallsCount += 1
    }
    
    func showAlert(text: String) {
        savedText = text
        showAlertCallsCount += 1
    }
    
    func removeImage() {
        removeImageCallsCount += 1
    }
    
    func verifyShowImageCallsCount(block: (Int) -> Void) {
        block(showImageCallsCount)
    }
    func verifyShowAlertCallsCount(block: (Int) -> Void) {
        block(showAlertCallsCount)
    }
    func verifyRemoveImageCallsCount(block: (Int) -> Void) {
        block(removeImageCallsCount)
    }
    func verifySavedText(block: (String) -> Void) {
        block(savedText)
    }
    
}
