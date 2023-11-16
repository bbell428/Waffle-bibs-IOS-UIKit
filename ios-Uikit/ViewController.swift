//  Created by 김종혁 on 11/14/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var CollctionView1: UICollectionView!
    @IBOutlet weak var Label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollctionView1.backgroundColor = UIColor(hexCode: "DADDEA")
        
        //폰트확인
        for fontFamily in UIFont.familyNames {
                    for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                        print(fontName)
                    }
                }
    }
}

