//
//  PresenterTests.swift
//  TestTests
//
//  Created by Андрей Зорькин on 24/11/2019.
//  Copyright © 2019 Antyshev Dmitriy. All rights reserved.
//

import XCTest
@testable import Test

class PresenterTests: XCTestCase {
    
    var presenter: Presenter!
    var mockPresenterOutput: MockPresenterOutput!
    var mockInteractor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        presenter = Presenter()
        mockPresenterOutput = MockPresenterOutput()
        mockInteractor = MockInteractor()
        presenter.output = mockPresenterOutput
        presenter.interactor = mockInteractor
    }
    
    override func tearDown() {
        presenter = nil
        mockPresenterOutput = nil
        mockInteractor = nil
        super.tearDown()
    }

    // MARK: - Взаимодействие с interactor
    
    /// Presnter's show() calls interactor's show() one time
    func testPresenterShowCallsInteractorShowOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        presenter.show()
        // Assert
        mockInteractor.verifyShowCallsCount{ realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    /// Presnter's download() calls interactor's download() one time
    func testPresenterDownloadCallsInteractorDownloadOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        presenter.download()
        // Assert
        mockInteractor.verifyDownloadCallsCount{ realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    /// Presnter's cacheClear() calls interactor's cacheClear() one time
    func testPresenterCacheClearCallsInteractorCacheClearOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        presenter.cacheClear()
        // Assert
        mockInteractor.verifyCacheClearCallsCount{ realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    // MARK: - Взаимодействие с output
    
    /// Presnter's showError(.downloadError) calls output's showAlert(_:) with necessary message
    func testPresenterShowErrorWithDownloadErrorCallsOutputShowAlertWithNecessaryMessage() {
        // Arrange
        let expectedMessage = "Ошибка при скачивании"
        // Act
        presenter.showError(.downloadError)
        // Assert
        mockPresenterOutput.verifySavedText{ realMessage in
            XCTAssertEqual(realMessage, expectedMessage)
        }
    }
    
    /// Presnter's showError(.emptyImageCacheError) calls output's showAlert(_:) with necessary message
    func testPresenterShowErrorWithEmptyImageCacheErrorCallsOutputShowAlertWithNecessaryMessage() {
        // Arrange
        let expectedMessage = "Кэш не содержит картинки"
        // Act
        presenter.showError(.emptyImageCacheError)
        // Assert
        mockPresenterOutput.verifySavedText{ realMessage in
            XCTAssertEqual(realMessage, expectedMessage)
        }
    }
    
    /// Presnter's showError(_:) calls output's showAlert(_:) one time
    func testPresenterShowErrorCallsOutputShowAlertOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        presenter.showError(.downloadError)
        // Assert
        mockPresenterOutput.verifyShowAlertCallsCount { realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    /// Presnter's showImage(image:) calls output's showImage(image:) one time
    func testPresenterShowImageCallsOutputShowImageOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        presenter.showImage(image: .init())
        // Assert
        mockPresenterOutput.verifyShowImageCallsCount{ realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    /// Presnter's cacheClear() calls output's removeImage() one time
    func testPresenterCacheClearCallsOutputRemoveImageOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        presenter.cacheClear()
        // Assert
        mockPresenterOutput.verifyRemoveImageCallsCount { realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    
}
