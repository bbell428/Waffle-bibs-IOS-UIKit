//
//  ListTableViewCell.swift
//  ios-Uikit
//
//  Created by 김종혁 on 12/4/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    var num: Int = 0
    var num2: Int = 0
    var test: Int = 123
    
    @IBOutlet weak var TodoList: UITextField!
    
    @IBOutlet weak var TodoBack: UIView!
    
    @IBOutlet weak var ListBackBtn: UIImageView!
        
    @IBOutlet weak var listBackButtonTapped: UIButton!
    
    @IBOutlet weak var postBackColor: UIImageView!
    @IBOutlet weak var postBtnImg: UIImageView!
    @IBOutlet weak var postBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 라벨 Corner Radius 설정
        TodoBack.layer.cornerRadius = 4
        TodoBack.layer.masksToBounds = true
        alpha0()
    }

    
    @IBAction func postBtn(_ sender: Any) {
        if num2 == 1 {
            if let newTodo = TodoList.text {
                postTodo(with: newTodo) // 버튼 클릭으로 POST 요청
                num2 = 0
            }
        }
    }

    func alpha1() {
        print("호출 성공")
        ListBackBtn.alpha = 1
        listBackButtonTapped.alpha = 1
        postBackColor.alpha = 1
        postBtnImg.alpha = 1
        postBtn.alpha = 1
    }
    func alpha0() {
        print("호출 성공")
        ListBackBtn.alpha = 0
        listBackButtonTapped.alpha = 0
        postBackColor.alpha = 0
        postBtnImg.alpha = 0
        postBtn.alpha = 0
    }
    
    //MARK: - POST
    @objc func postTodo(with newTodo: String) {
        // JSON 데이터 준비
        let parameters: [String: Any] = [
            "categoryTitle": "string",
            "complete_chk": true,
            "contents": newTodo,
            "id": 0,
            "startTime": "2023-12-20",
            "title": "string"
        ]

        // URL 설정
        guard let url = URL(string: "http://158.179.166.114:8080/\(num)/todo/add") else { return }

        // URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // HTTP 바디 설정
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        // URLSession 요청
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data else { return }
            do {
                // JSON 응답 처리
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }.resume()
    }
}
