//
//  MainViewController.swift
//  Virtual Gallery
//
//  Created by Bratislav Ljubisic on 3/24/18.
//  Copyright © 2018 Bratislav Ljubisic. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {
    
    var viewModel: GalleryViewModel!
    
    var topLeft: UIImageView!
    var topCenter: UIImageView!
    var topRight: UIImageView!
    var midLeft: UIImageView!
    var midCenter: UIImageView!
    var midRight: UIImageView!
    var lowLeft: UIImageView!
    var lowCenter: UIImageView!
    var lowRight: UIImageView!
    
    var disposableBag: DisposeBag!

    override func viewDidLoad() {
        super.viewDidLoad()
        disposableBag = DisposeBag()
        
        self.view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        topLeft = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        topLeft.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        self.view.addSubview(topLeft)
        
        topLeft.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.left)
            make.centerY.equalTo(self.view.snp.top)
            make.height.equalTo(110)
            make.width.equalTo(110)
        }
        
        midLeft = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 100))
        topLeft.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        self.view.addSubview(midLeft)
        
        midLeft.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.left)
            make.centerY.equalTo(self.view.snp.centerY)
            make.height.equalTo(110)
            make.width.equalTo(110)
        }
        
        lowLeft = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        topLeft.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        self.view.addSubview(lowLeft)
        
        lowLeft.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.left)
            make.centerY.equalTo(self.view.snp.bottom)
            make.height.equalTo(110)
            make.width.equalTo(110)
        }
        
        self.viewModel.getImagesForCentralLine(forCriterium: Criterium(), andCompletion: { images in
            _ = images.map({ (image) -> Image in
                print(image.name)
                return image
            })
            self.viewModel.downloadDataFor(ImageURL: images[0].thumbURL, withCompletion: { (data) in
                self.topLeft.image = UIImage(data: data)
            })
            self.viewModel.downloadDataFor(ImageURL: images[1].thumbURL, withCompletion: { (data) in
                self.midLeft.image = UIImage(data: data)
            })
            self.viewModel.downloadDataFor(ImageURL: images[2].thumbURL, withCompletion: { (data) in
                self.lowLeft.image = UIImage(data: data)
            })
        })
        

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
