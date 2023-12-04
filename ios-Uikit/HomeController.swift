//
//  HomeController.swift
//  ios-Uikit
//
//  Created by 김종혁 on 11/17/23.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sproduct:ProductList! = nil
    
    let list: [String] = [
        "안녕", "나는", "김종혁"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //테이블뷰의 이벤트, 데이터소스 처리
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - 데이터소스
    //아이템 수 리턴
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    // 테이블 셀의 객체 리턴
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        cell.todoList.text = list[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    //MARK: - 테이블 뷰 마진
    // 셀의 높이값을 리턴
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
