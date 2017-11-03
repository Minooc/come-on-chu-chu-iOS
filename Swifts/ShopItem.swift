//
//  ShopItem.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 10/31/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import UIKit

class ShopItem: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        super.init(frame: frame)
        
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(imageView)
        
        
        layer.cornerRadius = 5.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSize(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        imageView.frame.size.width += width
        imageView.frame.size.height += height
        imageView.frame.origin.x -= x
        imageView.frame.origin.y -= y
    }
    
    
    
    
    
}
