//
//  HomeController.swift
//  ios-Uikit
//
//  Created by 김종혁 on 11/17/23.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var TodoTitle: UILabel!
    
    @IBOutlet weak var backBtn: UIImageView!
    
    @IBOutlet weak var deleteBtn: UIImageView!
    
    @IBOutlet weak var addBtn: UIImageView!
    
    var sproduct:ProductList! = nil
    var list: [String] = []  // 테이블 뷰에 표시할 데이터를 담을 배열
    var num: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //테이블뷰의 이벤트, 데이터소스 처리
        tableView.delegate = self
        tableView.dataSource = self
        
        // sproduct 또는 다른 식별자를 사용하여 표시할 데이터 결정
        // CollectionVioew에서 선택한 카테고리로 넘어올 때
        if let productName = sproduct?.productName {
            switch productName {
            case "ASSIGNMENT":
                num = 1
            case "WORK OUT":
                num = 2
            case "DAILY":
                num = 3
            case "MEET":
                num = 4
            default:
                print("해당 카테고리가 없습니다.")
            }
        }
        fetchTodoList() // 카테고리 정보를 서버에서 가져오도록 함
        
        //MARK: - (+) 할일 추가
        let addTapGesture = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped))
        addBtn.isUserInteractionEnabled = true
        addBtn.addGestureRecognizer(addTapGesture)
        
        //MARK: - 뒤로가기 버튼
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        backBtn.isUserInteractionEnabled = true // 사용자 인터랙션 활성화
        backBtn.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: - JSON 데이터 파싱
    func fetchTodoList() {
        guard let url = URL(string: "http://158.179.166.114:8080/\(num)/todo/") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let todoList = try JSONDecoder().decode([TodoListElement].self, from: data)

                DispatchQueue.main.async {
                    //TodoListElement에서 title을 가져와 list 배열에 저장, id 값으로 오름차순
                    // $0.contents 첫번째 매개변수
                    self?.list = todoList.sorted { return $0.id < $1.id }.map { $0.contents }
 
                    //배열의 첫 번째 요소를 옵셔널로 반환. 배열이 비어있으면 nil
                    //first를 통해 반복되어 가져오는 타이틀이 아닌 1번만 가져옴
                    if let selectTodo = todoList.first {
                        self?.TodoTitle.text = selectTodo.categoryTitle
                    } else {
                        // todoList가 비어있을 때의 처리
                        print("해당 카테고리가 없습니다.")
                    }

                    self?.tableView.reloadData() // 테이블 뷰를 업데이트
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    //MARK: - 뒤로가기 버튼 액션 구현
    @objc func backButtonTapped() {
           // 뒤로가기 버튼 액션 구현
           self.navigationController?.popViewController(animated: true)
       }
    
    //MARK: - 할 일 추가 버튼 액션 구현
    @objc func addButtonTapped() {
            let alertController = UIAlertController(title: "할 일 추가", message: "추가 하시겠습니까?", preferredStyle: .alert)

            // Yes 액션 추가
            let confirm = UIAlertAction(title: "Yes", style: .default) { action in
                // Yes를 선택한 경우
                self.showAddTodoAlert()  // 할 일을 추가하는 알림창을 띄우는 함수
            }
            // No 액션 추가
            let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            alertController.addAction(confirm)
            alertController.addAction(cancel)

            // 알림창 표시
            present(alertController, animated: true, completion: nil)
        }

        // Yes를 선택한 경우의 동작을 구현하는 함수
        func showAddTodoAlert() {
            // Yes를 선택한 경우의 동작을 구현
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
//        cell.selectionStyle = .none
        return cell
    }
    
    
    //MARK: - 테이블 뷰 마진
    // 셀의 높이값을 리턴
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: - POST
//    @objc func addButtonTapped() {
//            // JSON 데이터 준비
//            let parameters: [String: Any] = [
//                "categoryTitle": "string",
//                "complete_chk": true,
//                "contents": "string",
//                "id": 0,
//                "startTime": "2023-12-20",
//                "title": "string"
//            ]
//
//            // URL 설정
//            guard let url = URL(string: "http://158.179.166.114:8080/1/todo/add") else { return }
//
//            // URLRequest 생성
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            // HTTP 바디 설정
//            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
//
//            // URLSession 요청
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    print("Error: \(error)")
//                    return
//                }
//
//                guard let data = data else { return }
//                do {
//                    // JSON 응답 처리
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                } catch {
//                    print("Error parsing JSON: \(error)")
//                }
//            }.resume()
//        }


//MARK: - 서버에서 받는 데이터 형식을 나타내는 구조체
struct TodoListElement: Codable {
    let id: Int
    let title, contents: String
    let completeChk: Bool
    let startTime: [Int]
    let categoryTitle: String

    enum CodingKeys: String, CodingKey {
        case id, title, contents
        case completeChk = "complete_chk"
        case startTime, categoryTitle
    }
}
