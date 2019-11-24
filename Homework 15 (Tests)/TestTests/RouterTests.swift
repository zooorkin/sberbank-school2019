//
//  RouterTests.swift
//  TestTests
//
//  Created by Андрей Зорькин on 24/11/2019.
//  Copyright © 2019 Antyshev Dmitriy. All rights reserved.
//

import XCTest
@testable import Test

class RouterTests: XCTestCase {
    
    var router: Router!

    override func setUp() {
        router = Router()
    }

    override func tearDown() {
        router = nil
    }

}
