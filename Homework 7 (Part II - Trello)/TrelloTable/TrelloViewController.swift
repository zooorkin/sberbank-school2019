//
//  TrelloViewController.swift
//  TrelloTable
//
//  Created by Андрей Зорькин on 29/10/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

/// Trello-контроллер
class TrelloViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    
    private let spacing: CGFloat = 16.0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trello Table"
        view.backgroundColor = .groupTableViewBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCard))
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NoteCell.self, forCellWithReuseIdentifier: "NoteCell")
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "SVF")
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "SVH")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self;
    
        view.addSubview(collectionView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let topInset = view.safeAreaInsets.top
        let bottomInset = view.safeAreaInsets.bottom
        let height = view.frame.height - topInset - bottomInset
        let width = view.frame.width
        collectionView.frame = CGRect(x: 0, y: topInset, width: width, height: height)
    }
    
    /// Добавление новой карточки
    @objc func addNewCard() {
        let darkView = UIView(frame: view.frame)
        view.addSubview(darkView)
        darkView.backgroundColor = .clear
        UIView.animate(withDuration: 0.1){
            darkView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
        
        let viewForTask = ISSPresentView.forTask()
        self.view.addSubview(viewForTask)
        viewForTask.done = { (text: String) in
            if !text.isEmpty {
                self.data[0].append(text)
                let indexPath = IndexPath(row: self.data[0].count, section: 0)
                self.collectionView.insertItems(at: [indexPath])
            }
            UIView.animate(withDuration: 0.1, animations: {
                darkView.backgroundColor = .clear
            }){ (finished) in
                darkView.removeFromSuperview()
            }
        }
    }

    /// Данные
    private var data: [[String]] = [
        ["Задача 7", "Задача 8", "Задача 9"],
        ["Задача 6"],
        ["Задача 5", "Задача 4"],
        ["Задача 1","Задача 2", "Задача 3"]
    ]
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as? NoteCell else {
            fatalError()
        }
        cell.backgroundColor = .white
        if indexPath.row != 0 && indexPath.row != data[indexPath.section].count + 1{
            switch indexPath.section {
            case 0: cell.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            case 1: cell.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            case 2: cell.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            case 3: cell.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            default: cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
        if indexPath.row == 0 {
            cell.backgroundColor = .clear
            switch indexPath.section {
            case 0: cell.text = "To Do"
            case 1: cell.text = "In Progress"
            case 2: cell.text = "In Review"
            case 3: cell.text = "Done"
            default: fatalError()
            }
            cell.isHeader = true
        } else if indexPath.row == data[indexPath.section].count + 1 {
            cell.isHeader = false
            cell.backgroundColor = .clear
        } else {
            cell.isHeader = false
            cell.text = data[indexPath.section][indexPath.row - 1]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.height > collectionView.frame.width) ?
            (collectionView.frame.width - 8 * spacing - 4 * 2 * 4) / 4 :
            (collectionView.frame.width - 8 * spacing - 4 * 2 * 4) / 8
        if indexPath.row == data[indexPath.section].count + 1 {
            let countOfElementsInSection = CGFloat(integerLiteral: data[indexPath.section].count)
            var height = collectionView.frame.height - (countOfElementsInSection + 2) * (width/2 + spacing / 2) - 48
            if height < 0 {
                height = 32
            }
            return CGSize(width: width, height: height)
        } else {
            let height = width / 2
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SVF", for: indexPath)
            footer.backgroundColor = .clear
            return footer
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SVH", for: indexPath)
            header.backgroundColor = .clear
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 4, height: view.frame.height * 0.6)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 4, height: view.frame.height * 0.6)
    }
    
    /// Перерасчёт порядка
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        let items = coordinator.items
        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath {
            if destinationIndexPath.section != sourceIndexPath.section {
                var destinationIndexPath = destinationIndexPath
                let countOfElementsInDestinationSection = data[destinationIndexPath.section].count
                
                if destinationIndexPath.row == 0 {
                    destinationIndexPath = IndexPath(row: 1, section: destinationIndexPath.section)
                } else if countOfElementsInDestinationSection == 0 {
                    destinationIndexPath = IndexPath(row: 1, section: destinationIndexPath.section)
                } else if destinationIndexPath.row == countOfElementsInDestinationSection + 2 {
                    destinationIndexPath = IndexPath(row: destinationIndexPath.row - 1, section: destinationIndexPath.section)
                }
                print("FROM \(sourceIndexPath) TO \(destinationIndexPath)")
                collectionView.performBatchUpdates({
                    let movingItem = data[sourceIndexPath.section][sourceIndexPath.row - 1]
                    data[sourceIndexPath.section].remove(at: sourceIndexPath.row - 1)
                    data[destinationIndexPath.section].insert(movingItem, at: destinationIndexPath.row - 1)
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                })
                coordinator.drop(items.first!.dragItem, toItemAt: destinationIndexPath)
            } else {
                var destinationIndexPath = destinationIndexPath
                let countOfElementsInDestinationSection = data[destinationIndexPath.section].count
                
                if destinationIndexPath.row == 0 {
                    destinationIndexPath = IndexPath(row: 1, section: destinationIndexPath.section)
                } else if countOfElementsInDestinationSection == 0 {
                    destinationIndexPath = IndexPath(row: 1, section: destinationIndexPath.section)
                } else if destinationIndexPath.row == countOfElementsInDestinationSection + 1 {
                    destinationIndexPath = IndexPath(row: destinationIndexPath.row - 1, section: destinationIndexPath.section)
                }
                if destinationIndexPath.row == sourceIndexPath.row {
                    return
                } else if destinationIndexPath.row > sourceIndexPath.row{
                    collectionView.performBatchUpdates({
                        let movingItem = data[sourceIndexPath.section][sourceIndexPath.row - 1]
                        data[sourceIndexPath.section].remove(at: sourceIndexPath.row - 1)
                        data[destinationIndexPath.section].insert(movingItem, at: destinationIndexPath.row - 2)
                        collectionView.deleteItems(at: [sourceIndexPath])
                        collectionView.insertItems(at: [destinationIndexPath])
                    })
                } else {
                    collectionView.performBatchUpdates({
                        let movingItem = data[sourceIndexPath.section][sourceIndexPath.row - 1]
                        data[sourceIndexPath.section].remove(at: sourceIndexPath.row - 1)
                        data[destinationIndexPath.section].insert(movingItem, at: destinationIndexPath.row - 1)
                        collectionView.deleteItems(at: [sourceIndexPath])
                        collectionView.insertItems(at: [destinationIndexPath])
                    })
                }
            }
        }
    }
    
}

extension TrelloViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if indexPath.row == 0 {
            return []
        }
        if indexPath.row == data[indexPath.section].count + 1 {
            return []
        }
        let item = data[indexPath.section][indexPath.row - 1]
        let itemProvider = NSItemProvider(object: String(item) as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        
        return [dragItem]
    }
}

extension TrelloViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        } else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
           return
        }
        switch coordinator.proposal.operation {
        case .move:
            self.reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
            break
        default:
            return
        }
    }
}
