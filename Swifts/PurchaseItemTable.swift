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
    var items = ["name1", "name2", "3", "4", "5", "6", "createcat"]


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
        return 6
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! ShopItem
        
        cell.imageView.image = UIImage(named: "designhome_item-crop")
        return cell
    }
    

    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    */

    
 
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        print("C")
//        return CGSize(width: 80, height: 100)
//    }
    
}

