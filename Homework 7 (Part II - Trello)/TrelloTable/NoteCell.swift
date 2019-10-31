//
//  NoteCell.swift
//  TrelloTable
//
//  Created by Андрей Зорькин on 31/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

/// Ячейка задачи
class NoteCell: UICollectionViewCell {
    
    let textLabel: UILabel = UILabel()
    var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }
    var isHeader: Bool = false {
        didSet {
            if isHeader {
                textLabel.font = .preferredFont(forTextStyle: .title1)
                textLabel.textColor = .black
            } else {
                textLabel.font = .preferredFont(forTextStyle: .title2)
                textLabel.textAlignment = .center
                textLabel.textColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        addSubview(textLabel)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        textLabel.textColor = .white
        textLabel.numberOfLines = 0
    }
    
    override func layoutSubviews() {
        let width = frame.width
        let height = frame.height
        let insets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        textLabel.frame = CGRect(x: 0, y: 0, width: width, height: height).inset(by: insets)
    }
    
}
