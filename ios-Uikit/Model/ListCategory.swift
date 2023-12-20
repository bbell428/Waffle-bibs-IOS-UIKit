//
//  ListCategory.swift
//  ios-Uikit
//
//  Created by 김종혁 on 12/5/23.
//

import Foundation
struct ListCategory {
    let ListURL = "http://158.179.166.114:8080/"
    
    func fetchList(ListId : String) {
        let urlString = "\(ListURL)\(ListId)/todo"
        print(urlString)
    }
}
