//
//  CollectionTable.swift
//  come-on-chu-chu
//
//  Created by Minooc Choo on 9/25/17.
//  Copyright © 2017 Minooc Choo. All rights reserved.
//

import UIKit
import SpriteKit

class CollectionTable: UITableView, UITableViewDelegate, UITableViewDataSource {

    var cats = ["name1", "name2", "name3", "name4", "name5", "lastcell"]
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1    // need 1 section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
      
        cell.backgroundColor = .clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
    
        if (indexPath.row != cats.count - 1) {
            let img = UIImage(named: "collectionCell")
            cell.imageView?.image = img
        } else {
            
            let createCat = UIImage(named: "Create Cat")
            cell.imageView?.image = createCat
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row != cats.count - 1) {
            print("cat")
        } else {
            print("create cat")
        }

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
