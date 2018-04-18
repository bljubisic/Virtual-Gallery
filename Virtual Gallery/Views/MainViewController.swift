//
//  MainViewController.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 3/24/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var topLeft: UIImageView!
    var topCenter: UIImageView!
    var topRight: UIImageView!
    var midLeft: UIImageView!
    var midCenter: UIImageView!
    var midRight: UIImageView!
    var lowLeft: UIImageView!
    var lowCenter: UIImageView!
    var lowRight: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLeft = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        self.view.addSubview(topLeft)
        
        topLeft.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.left)
            make.centerY.equalTo(self.view.snp.top)
            make.height.equalTo(110)
            make.width.equalTo(110)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
