//
//  ListTableViewCell.swift
//  ios-Uikit
//
//  Created by 김종혁 on 12/4/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var TodoList: UITextField!
    
    @IBOutlet weak var TodoBack: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 라벨 Corner Radius 설정
        TodoBack.layer.cornerRadius = 4
        TodoBack.layer.masksToBounds = true
    }
}
