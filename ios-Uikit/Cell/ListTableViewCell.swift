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
    
    var onPostSuccess: (() -> Void)?
    
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
        alpha0() // 안보이게 설정
        TodoList.isEnabled = false // 텍스트 입력 안되게 설정
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
        ListBackBtn.alpha = 1
        listBackButtonTapped.alpha = 1
        postBackColor.alpha = 1
        postBtnImg.alpha = 1
        postBtn.alpha = 1
        TodoList.isEnabled = true
    }
    
    func alpha0() {
        ListBackBtn.alpha = 0
        listBackButtonTapped.alpha = 0
        postBackColor.alpha = 0
        postBtnImg.alpha = 0
        postBtn.alpha = 0
        TodoList.isEnabled = false
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
            
            DispatchQueue.main.async {
                
                
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    print("success")
                    self.onPostSuccess?()
                }
            }
        }.resume()
        
    }
    //MARK: - Update, todo수정
    func updateContent(id: Int, updatedText: String) {
        // 서버 업데이트를 위한 URL 문자열
        let urlString = "http://158.179.166.114:8080/todo/\(id)/update"
        
        // URL 객체 생성
        guard let url = URL(string: urlString) else {
            print("유효하지 않은 URL")
            return
        }

        // URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"  // HTTP 메서드를 PATCH로 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")  // 요청 헤더 설정

        // HTTP 요청 바디에 담을 데이터 구성
        let requestBody: [String: Any] = ["contents": updatedText, "complete_chk": false]
        
        do {
            // 데이터를 JSON 형식으로 인코딩하여 HTTP 요청 바디에 설정
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
        } catch {
            // JSON 인코딩 오류 처리
            print("JSON 인코딩 오류: \(error)")
            return
        }

        // URLSession을 사용하여 서버와 통신하는 데이터 태스크 생성
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // 네트워크 오류 처리
                print("오류: \(error)")
            } else if let httpResponse = response as? HTTPURLResponse {
                // 서버 응답 처리
                print("상태 코드: \(httpResponse.statusCode)")
                // 여기에서 필요한 경우 응답에 대한 추가 처리를 수행할 수 있습니다.
            }
        }

        // 데이터 태스크 실행
        task.resume()
    }
    
}
