//
//  SessionFactory.swift
//  UrlSessionLesson
//
//  Created by Константин Богданов on 06/11/2019.
//  Copyright © 2019 Константин Богданов. All rights reserved.
//

import UIKit

class SessionFactory {
	func createDefaultSession() -> URLSession {
		let configuration = URLSessionConfiguration.default
		let session = URLSession(configuration: configuration)
		return session
	}
}
