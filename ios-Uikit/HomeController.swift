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
    var list: [String] = []  // 테이블 뷰에 표시할 데이터를 담을 배열
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //테이블뷰의 이벤트, 데이터소스 처리
        tableView.delegate = self
        tableView.dataSource = self
        
        // sproduct 또는 다른 식별자를 사용하여 표시할 데이터 결정
        if let productName = sproduct?.productName {
            switch productName {
            case "WORK OUT":
                list = ["운동 1", "운동 2", "운동 3"]
            case "MEET":
                list = ["미팅 1", "미팅 2", "미팅 3"]
            default:
                list = ["기본 데이터 1"]
            }
        }
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
