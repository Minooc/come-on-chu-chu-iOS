//
//  PurchaseItemTable.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 10/31/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import UIKit
import SpriteKit

class PurchaseItemTable: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {


    var category: String?
    var items = [""]


    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    
//        self.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Item")
        self.register(ShopItem.self, forCellWithReuseIdentifier: "Item")
        
        let cellWidth : CGFloat = self.frame.size.width / 4.3
        let cellheight : CGFloat = self.frame.size.height - 2.0
        let cellSize = CGSize(width: cellWidth , height:cellheight)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.itemSize = cellSize
        flowLayout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.minimumInteritemSpacing = 1.0
        self.setCollectionViewLayout(flowLayout, animated: true)
        
        self.delegate = self
        self.dataSource = self
        

        self.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! ShopItem
        
        if (category == "furniture") {
            cell.imageView.image = UIImage(named: "Furniture \(items[indexPath.row])")
        }
        
        if (category == "props") {
            cell.imageView.image = UIImage(named: "Props \(items[indexPath.row])")
        }
        
        if (category == "floor") {
            cell.imageView.image = UIImage(named: "\(items[indexPath.row])")
        }
        

        
        return cell
    }
    

    func furniture_generator() {
        items = []
        for i in 1...16 {
            items.append("\(i)")
            items.append("\(i)-1")
            items.append("\(i)-2")
        }
//        print(items)
    }
    
    func floor_generator() {
        items = []
        for i in 1...37 {
            items.append("Floor \(i)")
        }
        for i in 1...16 {
            items.append("Wallpaper \(i)")
        }
        
    }
    
   func prop_generator() {
        items = []
        for i in 1...9 {
            items.append("\(i)")
            items.append("\(i)-1")
            items.append("\(i)-2")
        }
        for i in 10...36 {
                items.append("\(i)")
        }
    }

    
}

