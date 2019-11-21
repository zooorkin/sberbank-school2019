//
//  TableViewModel.swift
//  CoreDataHomework
//
//  Created by Андрей Зорькин on 20/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

class TableViewModel {
    
    private let imagesPersistentStore: ImagesPersistentStore
    
    private let networkService: NetworkService
    
    func imageCellModel(at indexPath: IndexPath) -> ImageCellModel{
        if let imageCellModel = imagesPersistentStore.imageCellModel(at: indexPath) {
            return imageCellModel
        } else {
            return ImageCellModel(description: "Error", image: UIImage())
        }
    }
    
    var numberOfSections: Int {
        return imagesPersistentStore.numberOfSections
    }
    
    func numberOfRows(in section: Int) -> Int{
        return imagesPersistentStore.numberOfRows(in: section)
    }
    
    init(networkService: NetworkService, imagesPersistentStore: ImagesPersistentStore) {
        self.imagesPersistentStore = imagesPersistentStore
        self.networkService = networkService
    }
    
    func addImage(imageCellModel: ImageCellModel){
        imagesPersistentStore.add(imageCellModel: imageCellModel)
    }
    func save(){
        imagesPersistentStore.save()
    }
    
    func downloadImage(at path: URL, completion: @escaping (UIImage?) -> Void) {
        networkService.getData(at: path) { data in
            guard let data = data else {
                print("[TableViewModel]: не удалось загрузить картинку \(path)")
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
    }
    
    func downloadImageList(by searchString: String, perPage: Int, page: Int, completion: @escaping ([FlickrAPI.PhotoModel]) -> Void) {
        let url = FlickrAPI.searchPath(text: searchString, extras: "url_m", perPage: perPage, page: page)
        networkService.getData(at: url) { data in
            guard let data = data else {
                print("[TableViewModel]: не удалось загрузить список картинок по запросу – \(searchString)")
                completion([])
                return
            }
            do {
                let photos = try JSONDecoder().decode(FlickrAPI.PesponseModel.self, from: data).photos.photo
                completion(photos)
            } catch {
                print("[TableViewModel]: " + error.localizedDescription)
                return completion([])
            }
        }
    }
    
    func getImages(completion: @escaping (_ isEmpty: Bool) -> Void){
        imagesPersistentStore.getImages(completion: completion)
    }
    
}
