//
//  NetworkService.swift
//  UrlSessionLesson
//
//  Created by Константин Богданов on 06/11/2019.
//  Copyright © 2019 Константин Богданов. All rights reserved.
//

import UIKit

protocol NetworkServiceInput {
	func getData(at path: String, parameters: [AnyHashable: Any]?, completion: @escaping (Data?) -> Void)
	func getData(at path: URL, completion: @escaping (Data?) -> Void)
}

class NetworkService: NetworkServiceInput {
	let session: URLSession

	init(session: URLSession) {
		self.session = session
	}

	func getData(at path: String, parameters: [AnyHashable: Any]?, completion: @escaping (Data?) -> Void) {
		guard let url = URL(string: path) else {
			completion(nil)
			return
		}
		let dataTask = session.dataTask(with: url) { data, _, _ in
			completion(data)
		}
		dataTask.resume()
	}

	func getData(at path: URL, completion: @escaping (Data?) -> Void) {
		let dataTask = session.dataTask(with: path) { data, _, _ in
			completion(data)
		}
		dataTask.resume()
	}

	func downloadData(of path: URL, completion: @escaping (Data?) -> Void) {
		let downloadTask = session.downloadTask(with: path) { url, _, _ in
			guard let url = url else {
				completion(nil)
				return }
			let data = try? Data(contentsOf: url)
			completion(data)
		}

		downloadTask.resume()
	}
}
