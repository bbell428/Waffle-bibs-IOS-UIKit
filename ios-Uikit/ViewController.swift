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
        
        
        myCollctionView.backgroundColor = UIColor(hexCode: "DADDEA") // 뒷 배경 색상
        //폰트확인
        for fontFamily in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                print(fontName)
            }
        }
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollctionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
        cell.myImageView.image = itemList[indexPath.row].productImage
        cell.itemLabel.text = itemList[indexPath.row].productName
        cell.itemLabel.textColor = UIColor(hexCode: "1A42D2")
//        cell.myImageView.layer.cornerRadius = 60
        
        return cell
    }
    
    
    
}

