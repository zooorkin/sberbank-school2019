//
//  ViewModels.swift
//  CoreDataHomework
//
//  Created by Андрей Зорькин on 20/11/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import Foundation

extension ImageCellModel: CellViewModel {

    func setup(cell: ImageCell) {
        cell.myImageView.image = image
        cell.myLabel.text = description
    }

}

