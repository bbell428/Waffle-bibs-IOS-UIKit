//
//  CategoryExamVC.swift
//  ios-Uikit
//
//  Created by 이지훈 on 2023/11/28.
//
import UIKit

class CategoryExamVC: UIViewController {

    @IBOutlet weak var Category1: UILabel!
    @IBOutlet weak var Category2: UILabel!
    @IBOutlet weak var Category3: UILabel!
    @IBOutlet weak var Category4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories() // 카테고리 정보를 서버에서 가져오도록 함
        //메서드는 URLSession을 사용하여 비동기적으로 서버에서 데이터를 가져오고, 가져온 데이터를 JSON 디코딩하여 화면의 레이블에 할당합니다.
    }
    
    //클로져 개념을 이해하셔야 코드 읽는데 무리가 없으실거에요
    func fetchCategories() {
        guard let url = URL(string: "http://158.179.166.114:8080/") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                // JSON 데이터 파싱
                //서버로부터 받은 data를 Category 구조체의 배열로 변환합니다. 여기서 Category 구조체는 id와 title 프로퍼티를 가지고 있어야 합니다. decode 메서드는 JSON 데이터를 해당 구조체의 인스턴스로 변환합니다.
                let categories = try JSONDecoder().decode([Category].self, from: data)
                
                //가져온 값을 메인스레드를 통해 label 에 올려두기
                //UI 업데이트는 반드시 메인 스레드에서 진행되어야 하기에 메인스레드에서 값 할당하도록 변경
                //Label의 text 프로퍼티에 삿 title 할당
                DispatchQueue.main.async { // 메인 스레드에서 UI 업데이트를 수행
                    // 데이터를 레이블에 할당
                    // 스웨거에서 아래 순서로 값을 지정햇기 때문에 2,3,0,1 순으로 값을 할당해야 순서가 나옵니다.
                    // 원래는 이미지도 서버에서 뿌려주는게 좋지만 아직 와플이니까 흐린눈으로 넘어갑시다~ㅌ
                    self?.Category1.text = categories[2].title
                    self?.Category2.text = categories[3].title
                    self?.Category3.text = categories[0].title
                    self?.Category4.text = categories[1].title
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

//MARK: 서버에서 받는 데이터 형식을 나타내는 구조체
/// 스웨거의 ResponsBody 를 보고 작성하는데 스웨거에서 Int인지 String인지 등을 보면서 직접 작성해도 되지만 https://quicktype.io/ 에서 ResponsBody 를 긁어 넣고 구조체 이름만 지정해주고 설정만 하면 자동으로 해줍니다 그거 복붙해오면 됩니다.
/// 그리고 보통은 ViewController 내부에 구조체를 작성하지 않고 Model 이라는 Group(폴더) 로 따로 정리해서 거기에 기능별 / 컴포넌트별로 구조체를 모아둡니다. 그렇게 모아둬서 나중에 MVC 혹은 MVVM등의 아키텍쳐로 발전시키는데 지금 단계에서는 그냥 따로 빼서 데이터 형식을 참조후 그 값을 가져올수 있구나 를 아시면 됩니다.
struct Category: Codable {
//    let id: Int
    let title: String
}



//MARK: - Alarmofire로 하게 될 경우...
//import alarmofire
// ...
//func fetchCategoriesWithAlamofire() {
//    let url = "http://158.179.166.114:8080/"
//    Alamofire.request(url).responseJSON { [weak self] response in
//        guard let data = response.data else { return }
//        do {
//            let categories = try JSONDecoder().decode([Category].self, from: data)
//            DispatchQueue.main.async {
//                self?.Category1.text = categories[0].title
//                self?.Category2.text = categories[1].title
//                self?.Category3.text = categories[2].title
//                self?.Category4.text = categories[3].title
//            }
//        } catch {
//            print(error)
//        }
//    }
//}
