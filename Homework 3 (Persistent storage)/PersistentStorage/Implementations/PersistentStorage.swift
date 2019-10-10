//
//  PersistentStorage.swift
//  PersistentStorage
//
//  Created by Андрей Зорькин on 10/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

/// Постоянное хранилище
final class PersistentStorage: IPersistentStorage, ISharedInstance {
    
    /// Ошибки
    enum PSError: Error {
        case decodeDecodableDidReturnNil
        var localizedDescription: String {
            switch self {
            case .decodeDecodableDidReturnNil:
                return "decodeDecodable did return nil"
            }
        }
    }
    
    public static let sharedInstance = PersistentStorage()
    
    public func save<T>(_ object: T, forName name: String) -> Result<Void, Error>
        where T: Codable {
        return Result {
            let coder = NSKeyedArchiver(requiringSecureCoding: false)
            let dataPath = getDataPath(forName: name)
            try coder.encodeEncodable(object, forKey: name)
            try coder.encodedData.write(to: dataPath)
            return
        }
    }
    
    public func get<T>(_ ObjectType: T.Type, forName name: String) -> Result<T, Error>
        where T: Codable{
        return Result{
            let dataPath = getDataPath(forName: name)
            let data = try Data(contentsOf: dataPath)
            let decoder = try NSKeyedUnarchiver(forReadingFrom: data)
            if let object = decoder.decodeDecodable(ObjectType, forKey: name) {
                return object
            } else {
                throw PSError.decodeDecodableDidReturnNil
            }
        }
    }
    
    private func getDataPath(forName name: String) -> URL {
        return URL(fileURLWithPath: name + ".plist")
    }
    
}
