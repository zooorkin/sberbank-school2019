//
//  InteractorTests.swift
//  TestTests
//
//  Created by Андрей Зорькин on 24/11/2019.
//  Copyright © 2019 Antyshev Dmitriy. All rights reserved.
//

import XCTest
@testable import Test

class InteractorTests: XCTestCase {

    var interactor: Interactor!
    var mockImageService: MockImageService!
    var mockInteractorOutput: MockInteractorOutput!

    override func setUp() {
        super.setUp()
        mockImageService = MockImageService()
        mockInteractorOutput = MockInteractorOutput()
        interactor = Interactor(imageService: mockImageService)
        
        interactor.output = mockInteractorOutput
        
        // Эту строчку добавлять не нужно, делагат настраиваетя при инциализации Interactor
        // mockImageService.delegate = interactor
    }

    override func tearDown() {
        interactor = nil
        mockImageService = nil
        mockInteractorOutput = nil
        super.tearDown()
    }
    
    // MARK: - Взаимодействие с output

    /// Interactor's show() calls output's showError(_:) one time
    /// когда картинка не загружена
    func testInteractorShowCallsOutputShowErrorWhenImageWasNotDownloadedOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        interactor.show()
        // Assert
        mockInteractorOutput.verifyshowErrorCallsCount{ realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    /// Interactor's show() calls output's showImage(image:) one time
    /// когда картинку успешно загрузили
    func testInteractorShowCallsOutputShowImageWithSuccessfulDownloadingOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        interactor.download()
        interactor.show()
        // Assert
        mockInteractorOutput.verifyShowImageCallsCount { realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    /// Interactor's download() calls output's showError(_:) one time
    /// когда картинку загрузить не удалось
    func testInteractorDownloadCallsOutputShowErrorWithErrorDownloadingOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        mockImageService.withError = true
        interactor.download()
        // Assert
        mockInteractorOutput.verifyshowErrorCallsCount { realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    
    /// Interactor's cacheClear() calls output's showError(_:) one time
    /// когда картинка не загружена
    func testInteractorCacheClearCallsOutputShowErrorWhenImageWasNotDownloadedOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        interactor.cacheClear()
        // Assert
        mockInteractorOutput.verifyshowErrorCallsCount{ realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    /// Interactor's cacheClear() calls output's showError(_:) zero times
    /// когда картинку успешно загрузили
    func testInteractorCacheClearCallsOutputShowErrorWithSuccessfulDownloadingZeroTimes() {
        // Arrange
        let expectedCalls = 0
        // Act
        interactor.download()
        interactor.cacheClear()
        // Assert
        mockInteractorOutput.verifyshowErrorCallsCount{ realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    /// Interactor's twice cacheClear() calls output's showError(_:) one time
    /// когда картинку успешно загрузили
    func testInteractorTwiceCacheClearNotCallsOutputShowErrorWithSuccessfulDownloadingOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        interactor.download()
        interactor.cacheClear()
        interactor.cacheClear()
        // Assert
        mockInteractorOutput.verifyshowErrorCallsCount{ realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    /// Interactor's download() calls output's didDownload(_:) one time
    /// когда картинку успешно загрузили
    func testInteractorDownloadCallsOutputDidDownloadWithSuccessfulDownloadingOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        interactor.download()
        // Assert
        mockInteractorOutput.verifyDidDownloadCallsCount { realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    // MARK: - Взаимодействие с imageService
    
    /// Interactor's download() calls imageService's downloadImageByURL(_:) one time
    func testInteractorDownloadCallsImageServiceDownloadImageByURLOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        interactor.download()
        // Assert
        mockImageService.verifyDownloadImageByURLCallsCount { realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }
    
    /// Interactor's download() calls imageService's downloadImageByURL(_:) with necessary url
    func testInteractorDownloadCallsImageServiceDownloadImageByURLWithNecessaryUrl() {
        // Arrange
        let expectedUrl = URL(string: "http://icons.iconarchive.com/icons/dtafalonso/ios8/512/Calendar-icon.png")!
        // Act
        interactor.download()
        // Assert
        mockImageService.verifyDownloadImageByURLurl { realUrl in
            XCTAssertEqual(realUrl, expectedUrl)
        }
    }
    
    /// Interactor's twice download() calls imageService's downloadImageByURL(_:) one time
    func testInteractorTwiceDownloadCallsImageServiceDownloadImageByURLOneTime() {
        // Arrange
        let expectedCalls = 1
        // Act
        interactor.download()
        interactor.download()
        // Assert
        mockImageService.verifyDownloadImageByURLCallsCount { realCalls in
            XCTAssertEqual(realCalls, expectedCalls)
        }
    }

}
