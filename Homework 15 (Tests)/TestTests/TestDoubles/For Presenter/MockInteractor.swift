//
//  MockInteractor.swift
//  TestTests
//
//  Created by Андрей Зорькин on 25/11/2019.
//  Copyright © 2019 Antyshev Dmitriy. All rights reserved.
//

import Foundation
@testable import Test

class MockInteractor: InteractorInput {
    
    /// Число вызовов функции show
    private var showCallsCount = 0
    /// Число вызовов функции download
    private var downloadCallsCount = 0
    /// Число вызовов функции cacheClear
    private var cacheClearCallsCount = 0
    
    func show() {
        showCallsCount += 1
    }
    
    func download() {
        downloadCallsCount += 1
    }
    
    func cacheClear() {
        cacheClearCallsCount += 1
    }
    
    func verifyShowCallsCount(block: (Int) -> Void) {
        block(showCallsCount)
    }
    func verifyDownloadCallsCount(block: (Int) -> Void) {
        block(downloadCallsCount)
    }
    func verifyCacheClearCallsCount(block: (Int) -> Void) {
        block(cacheClearCallsCount)
    }
    
}

