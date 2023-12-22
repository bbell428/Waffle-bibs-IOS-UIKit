//
//  ListTableViewCell.swift
//  ios-Uikit
//
//  Created by 김종혁 on 12/4/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var todoList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 라벨 Corner Radius 설정
        todoList.layer.cornerRadius = 4
        todoList.layer.masksToBounds = true
    }
}
