//
//  ComicsViewController.swift
//  Comics
//
//  Created by Андрей Зорькин on 29/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

/// Интерфейс комикс-контроллера
protocol IComicViewController {
    /// Количество строк с картинками
    var numberOfRows: Int { get set }
    /// Количество столбцов с картинками
    var numberOfColumns: Int { get set }
    /// Страница комикска
    var image: UIImage? { get set }
}

/**
 Комикс-контроллер
 */
class ComicsViewController: UIViewController, UIScrollViewDelegate, IComicViewController {
    

    public var image: UIImage?
    
    public var numberOfRows: Int = 0
    
    public var numberOfColumns: Int = 0
    
    private var scrollView: UIScrollView
    
    var imageView: UIImageView = {
        return UIImageView()
    }()
    
    private var previousContentOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    private var stepWidth: CGFloat = 0
    
    private var stepHeight: CGFloat = 0
    
    private var detailMode = false
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    @objc func tapped(recognizer: UITapGestureRecognizer) {
        detailMode.toggle()
        if detailMode {
            let touchPoint = recognizer.location(in: scrollView)
            let normalPosition = masterNormalPositionOf(touchPoint)
            let xContentOffset = CGFloat(integerLiteral: normalPosition.x) * stepWidth
            let yContentOffset = CGFloat(integerLiteral: normalPosition.y) * stepHeight
            let contentOffset = CGPoint(x: xContentOffset, y: yContentOffset)
            UIView.animate(withDuration: 0.3){
                self.viewWillLayoutSubviews()
                self.scrollView.contentOffset = contentOffset
            }
            previousContentOffset = contentOffset
        } else {
            UIView.animate(withDuration: 0.3){
                self.viewWillLayoutSubviews()
            }
        }

    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        scrollView = UIScrollView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        scrollView = UIScrollView()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        imageView.image = image
        scrollView.addSubview(imageView)
        scrollView.backgroundColor = .black
        scrollView.delegate = self
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(recognizer:)))
        scrollView.addGestureRecognizer(tapGestureRecognizer)
        
        view.backgroundColor = .clear
        imageView.contentMode = .scaleToFill
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let topInset = view.safeAreaInsets.top
        let bottomInset = view.safeAreaInsets.bottom
        let height = view.frame.height - topInset - bottomInset
        let width = view.frame.width
        scrollView.frame = CGRect(x: 0, y: topInset, width: width, height: height)
        
        stepWidth = width
        stepHeight = height
        previousContentOffset = scrollView.contentOffset
        if detailMode {
            let contentWidth = CGFloat(integerLiteral: numberOfColumns) * width
            let contentHeight = CGFloat(integerLiteral: numberOfRows) * height
            imageView.frame = CGRect(x: 0, y: 0, width: contentWidth, height: contentHeight)
            scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        } else {
            imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            scrollView.contentSize = CGSize(width: width, height: height)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scroll(scrollView.contentOffset)
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scroll(previousContentOffset)
    }
    
    func scroll(_ scrollViewOffsetPoint: CGPoint) {
        let newXContentOffset: CGFloat
        let newYContentOffset: CGFloat
        
        let diffOffset = scrollViewOffsetPoint - previousContentOffset
        // X
        if abs(diffOffset.x / stepWidth) >= 0.1 {
            newXContentOffset = diffOffset.x / abs(diffOffset.x) * stepWidth * 0.6
        } else {
            newXContentOffset = 0
        }
        // Y
        if abs(diffOffset.y / stepHeight) >= 0.1 {
            newYContentOffset = diffOffset.y / abs(diffOffset.y) * stepHeight * 0.6
        } else {
            newYContentOffset = 0
        }
        let newContentOffset = CGPoint(x: newXContentOffset, y: newYContentOffset) + previousContentOffset
        var normalPosition = detailNormalPositionOf(newContentOffset)
        if normalPosition.x == numberOfColumns {
            normalPosition = (x: 0, y: normalPosition.y + 1)
            if normalPosition.y == numberOfRows {
                normalPosition = (x: numberOfColumns - 1, y: numberOfRows - 1)
            }
        } else if normalPosition.x == -1 {
            normalPosition = (x: numberOfColumns - 1, y: normalPosition.y - 1)
            if normalPosition.y == -1 {
                normalPosition = (x: 0, y: 0)
            }
        }
        if normalPosition.y == numberOfRows {
            normalPosition = (x: normalPosition.x, y: normalPosition.y - 1)
        }else if normalPosition.y == -1 {
            normalPosition = (x: normalPosition.x, y: 0)
        }
        scrollTo(normalPosition, animated: true)
    }
    
    func detailNormalPositionOf(_ point: CGPoint) -> (x: Int, y: Int) {
        let xSignCoefficient: CGFloat = point.x < 0 ? -1 : 1
        let ySignCoefficient: CGFloat = point.y < 0 ? -1 : 1
        let xNormalPosition = Int((point.x + xSignCoefficient * (stepWidth / 2)) / stepWidth)
        let yNormalPosition = Int((point.y + ySignCoefficient * (stepHeight / 2)) / stepHeight)
        return (xNormalPosition, yNormalPosition)
    }
    
    func masterNormalPositionOf(_ point: CGPoint) -> (x: Int, y: Int) {
        let xNormalPosition = Int((point.x) / stepWidth * CGFloat(integerLiteral: numberOfColumns))
        let yNormalPosition = Int((point.y) / stepHeight * CGFloat(integerLiteral: numberOfRows))
        return (xNormalPosition, yNormalPosition)
    }
    
    func scrollTo(_ normalPosition: (x: Int, y: Int), animated: Bool){
        let xContentOffset = CGFloat(integerLiteral: normalPosition.x) * stepWidth
        let yContentOffset = CGFloat(integerLiteral: normalPosition.y) * stepHeight
        let rect = CGRect(x: xContentOffset, y: yContentOffset, width: stepWidth, height: stepHeight)
        scrollView.scrollRectToVisible(rect, animated: animated)
        previousContentOffset = CGPoint(x: xContentOffset, y: yContentOffset)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    static func * (lhs: Int, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: CGFloat(integerLiteral: lhs) * rhs.x, y: CGFloat(integerLiteral: lhs) * rhs.y)
    }
}
