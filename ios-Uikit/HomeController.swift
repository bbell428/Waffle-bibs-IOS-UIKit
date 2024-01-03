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
    
    @IBOutlet weak var addBtn: UIImageView!
    
    var selectedIndexPath: IndexPath?

    //MARK: - 위에 Outlet
    
    var sproduct:ProductList! = nil
    var list: [String] = []  // 테이블 뷰에 표시할 데이터를 담을 배열
    var num: Int = 0 // 카테고리 선택 시 카테고리 주소번호
    var num2: Int = 0 // 추가입력 누를 시 1, 추가입력 Back 버튼 누를 시 0
    
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
                    //self?.list = todoList.sorted { return $0.id < $1.id }.map { $0.contents }
                    
                    // 내용 출력
                    self?.list = todoList.map{ $0.contents ?? "" }
 
                    //목록 넘어간 후, 리스트 화면에 목록 제목
                    self?.TodoTitle.text = self?.sproduct.productName
                

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
    
    
    //MARK: - 할 일 추가 버튼 클릭 시 배열추가(list)
    
    var isListBackButtonEnabled: Bool = false // 할 일 추가 눌렀을 때만 활성화
    
    @objc func addButtonTapped() {
        print("추가 버튼이 탭되었습니다.")
        num2 += 1
        // 새로운 할 일을 추가할 경우, 빈 문자열을 추가해 둠
        if (num2 == 1) {
            list.append("")

            // 테이블 뷰의 마지막 섹션에 행을 추가
            tableView.insertRows(at: [IndexPath(row: list.count - 1, section: 0)], with: .automatic)

            // 테이블 뷰의 스크롤을 추가된 행으로 이동
            tableView.scrollToRow(at: IndexPath(row: list.count - 1, section: 0), at: .bottom, animated: true)
            
            
            isListBackButtonEnabled = true
        }
    }


    
    //MARK: - ListBackButton, 추가 후 해당 배열 삭제
    @IBAction func listBackButtonTapped(_ sender: Any) {
        // 현재 화면에 표시된 셀 중에서 삭제하려는 셀을 찾기
        if(isListBackButtonEnabled == true) {
            if let visibleIndexPaths = tableView.indexPathsForVisibleRows,
               let lastVisibleIndexPath = visibleIndexPaths.last {
                // 배열에서 해당 행의 데이터를 제거
                list.remove(at: lastVisibleIndexPath.row)

                // 테이블 뷰에서도 해당 행을 삭제
                tableView.deleteRows(at: [lastVisibleIndexPath], with: .automatic)
            }
        }
        isListBackButtonEnabled = false
        num2 = 0
    }
    
    //MARK: - 데이터소스
    //아이템 수 리턴
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    // 테이블 셀의 객체 리턴
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        cell.TodoList.text = list[indexPath.row]
        cell.selectionStyle = .none
        
        cell.num = num
        cell.num2 = num2
        
        // ListTableViewCell에 있는 함수 호출, 추가 버튼 누르기 전 alpha = 0, 누른 후 alpha = 1 ( 마지막 생성된 배열에만 )
            if indexPath.row == list.count - 1 && num2 == 1 {
                cell.alpha1()
            } else {
                cell.alpha0()
            }
        
        return cell
    }
    
    //MARK: - 테이블 뷰 마진
    // 셀의 높이값을 리턴
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

//MARK: - 서버에서 받는 데이터 형식을 나타내는 구조체
struct TodoListElement: Codable {
//    let id: Int
    let title: String?  // 옵셔널로 변경 -> 스웨거에서 title이 Null일 때 옵셔널 안하면 호출이 안됨
    let contents: String?
    let completeChk: Bool?
    let startTime: [Int]?
    let categoryTitle: String

    enum CodingKeys: String, CodingKey {
        case title, contents
        case completeChk = "complete_chk"
        case startTime, categoryTitle
    }
}
