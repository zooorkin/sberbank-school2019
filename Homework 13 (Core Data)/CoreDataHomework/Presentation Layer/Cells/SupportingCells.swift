//
//  SupportingCells.swift
//  CoreDataHomework
//
//  Created by Андрей Зорькин on 20/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

protocol CellViewModel: CellViewAnyModel {
    associatedtype CellType: UIView
    func setup(cell: CellType)
}

protocol CellViewAnyModel {
    static var cellAnyType: UIView.Type { get }
    func setupAny(cell: UIView)
}

extension CellViewModel {
    static var cellAnyType: UIView.Type {
        return CellType.self
    }
    func setupAny(cell: UIView){
        setup(cell: cell as! CellType)
    }
}

