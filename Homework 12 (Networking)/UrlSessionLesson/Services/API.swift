//
//  API.swift
//  UrlSessionLesson
//
//  Created by Константин Богданов on 06/11/2019.
//  Copyright © 2019 Константин Богданов. All rights reserved.
//

import UIKit

//https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=dab4052df3cc23ed39745a8cca163e0a&text=cat&extras=url_s&format=json&nojsoncallback=1

class API {

	private static let apiKey = "dab4052df3cc23ed39745a8cca163e0a"
	private static let baseUrl = "https://www.flickr.com/services/rest/"


    static func searchPath(text: String, extras: String, perPage: Int, page: Int) -> URL {
		guard var components = URLComponents(string: baseUrl) else {
			return URL(string: baseUrl)!
		}

		let methodItem = URLQueryItem(name: "method", value: "flickr.photos.search")
		let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
		let textItem = URLQueryItem(name: "text", value: text)
		let extrasItem = URLQueryItem(name: "extras", value: extras)
		let formatItem = URLQueryItem(name: "format", value: "json")
		let nojsoncallbackItem = URLQueryItem(name: "nojsoncallback", value: "1")
        let perPageItem = URLQueryItem(name: "per_page", value: String(perPage))
        let pageItem = URLQueryItem(name: "page", value: String(page))

		components.queryItems = [methodItem, apiKeyItem, textItem, extrasItem,
                                 formatItem, nojsoncallbackItem,
                                perPageItem, pageItem]

		return components.url!
	}
}
