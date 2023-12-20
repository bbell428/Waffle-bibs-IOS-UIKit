//  Created by 김종혁 on 11/14/23.
//
import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var myCollctionView: UICollectionView!
    @IBOutlet weak var Label1: UILabel!
    
    var itemList = [ProductList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let item = ProductList(productImage: UIImage(named: "Assignment")!, productName: "ASSIGNMENT")
        itemList.append(item)
        let item1 = ProductList(productImage: UIImage(named: "Work")!, productName: "WORK OUT")
        itemList.append(item1)
        let item2 = ProductList(productImage: UIImage(named: "Daily")!, productName: "DAILY")
        itemList.append(item2)
        let item3 = ProductList(productImage: UIImage(named: "Meet")!, productName: "MEET")
        itemList.append(item3)
        
        
        // MARK: - 폰트, 뒷배경
        myCollctionView.backgroundColor = UIColor(hexCode: "DADDEA") // 콜렉션 뷰 뒷 배경 색상
        
        /*
        for fontFamily in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                print(fontName)
            }
        }
        */
    }
}
// MARK: - CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollctionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
        cell.myImageView.image = itemList[indexPath.row].productImage
        cell.itemLabel.text = itemList[indexPath.row].productName
        cell.itemLabel.textColor = UIColor(hexCode: "1A42D2") // 셀 안에 라벨 텍스트 색상
//        cell.myImageView.layer.cornerRadius = 60
        cell.itemButton.tag = indexPath.row
        cell.itemButton.addTarget(self, action: #selector(viewdetail), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: - Button
    
    // collectionView에서 button 누를 시 넘어가는 다음 ViewController
    @objc func viewdetail(sender:UIButton) {
        let indexPath1 = IndexPath(row: sender.tag, section: 0)
        let home = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
        home.sproduct = itemList[indexPath1.row]
        self.navigationController?.pushViewController(home, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // 섹션별로 셀의 inset을 지정하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // UIEdgeInsets를 통해 위아래 마진을 설정
        return UIEdgeInsets(top: 130, left: 38, bottom: 0, right: 38)
    }
    
    // 한 줄에 몇 개의 셀을 표시할지 결정하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 간의 세로 간격을 설정
        return 10
    }
    
}
//변경변경
