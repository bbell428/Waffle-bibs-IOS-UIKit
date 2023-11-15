//  Created by 김종혁 on 11/14/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Label1: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Label1.text = "Hi my name is"
        
        for fontFamily in UIFont.familyNames {
                    for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                        print(fontName)
                    }
                }
    }
}

