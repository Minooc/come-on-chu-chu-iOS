//
//  PurchaseItemTable.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 10/31/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import UIKit
import SpriteKit

class MeowshopTable: UICollectionView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    var category: String?
    var items = ["1", "1-1", "1-2", "2", "2-1", "2-2"]
    
    
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
        
        
        category = "can-and-coin"
        
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
        if category == "ultra-booster" {
            return 6
        }
        return 9
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! ShopItem
        
        if (category == "can-and-coin") {
            switch(indexPath.row) {
            case 0: cell.imageView.image = UIImage(named: "meowshop-1-watch-video"); break
            case 1: cell.imageView.image = UIImage(named: "meowshop-2-cool-tuna"); break
            case 2: cell.imageView.image = UIImage(named: "meowshop-3-1000tuna");
//            cell.configureSize(x: 0, y: 9.8, width: 2, height: 14.2); break
            case 3: cell.imageView.image = UIImage(named: "meowshop-4-3000tuna"); break
            case 4: cell.imageView.image = UIImage(named: "meowshop-5-8000tuna");
//            cell.configureSize(x: 0, y: 10.5, width: 0, height: 10); break
            case 5: cell.imageView.image = UIImage(named: "meowshop-6-goldcoin"); break
            case 6: cell.imageView.image = UIImage(named: "meowshop-7-goldcoin2"); break
            case 7: cell.imageView.image = UIImage(named: "meowshop-8-goldcoin3");
//            cell.configureSize(x: 0, y: 7, width: 0, height: 10);break
            case 8: cell.imageView.image = UIImage(named: "meowshop-9-goldcoin4"); break
            default: break
            
            }
        }
        
        else if (category == "ultra-booster") {
            switch(indexPath.row) {
            case 0: cell.imageView.image = UIImage(named: "ultrabooster-1"); break
            case 1: cell.imageView.image = UIImage(named: "ultrabooster-2"); break
            case 2: cell.imageView.image = UIImage(named: "ultrabooster-3");
            case 3: cell.imageView.image = UIImage(named: "ultrabooster-4"); break
            case 4: cell.imageView.image = UIImage(named: "ultrabooster-5");
            case 5: cell.imageView.image = UIImage(named: "ultrabooster-6"); break
            default: break
            }
        }
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


