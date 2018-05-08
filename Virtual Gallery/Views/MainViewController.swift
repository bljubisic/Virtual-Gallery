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
        
        topLeft = UIImageView(frame: CGRect(x: 0, y: 0, width: ImageSize.imgHeightAndWidth.rawValue, height: ImageSize.imgHeightAndWidth.rawValue))
        topLeft.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        self.addParallaxToView(vw: topLeft)
        self.view.addSubview(topLeft)
        
        topLeft.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.left)
            make.centerY.equalTo(self.view.snp.top)
            make.height.equalTo(ImageSize.imgHeightAndWidth.rawValue)
            make.width.equalTo(ImageSize.imgHeightAndWidth.rawValue)
        }
        
        midLeft = UIImageView(frame: CGRect(x: 0, y: 0, width: ImageSize.imgHeightAndWidth.rawValue, height: ImageSize.imgHeightAndWidth.rawValue))
        midLeft.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        self.addParallaxToView(vw: midLeft)
        self.view.addSubview(midLeft)
        
        midLeft.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.snp.left)
            make.centerY.equalTo(self.view.snp.centerY)
            make.height.equalTo(ImageSize.imgHeightAndWidth.rawValue)
            make.width.equalTo(ImageSize.imgHeightAndWidth.rawValue)
        }
        
        lowLeft = UIImageView(frame: CGRect(x: 0, y: 0, width: ImageSize.imgHeightAndWidth.rawValue, height: ImageSize.imgHeightAndWidth.rawValue))
        lowLeft.backgroundColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        self.addParallaxToView(vw: lowLeft)
        self.view.addSubview(lowLeft)
        
        lowLeft.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.left)
            make.centerY.equalTo(self.view.snp.bottom)
            make.height.equalTo(ImageSize.imgHeightAndWidth.rawValue)
            make.width.equalTo(ImageSize.imgHeightAndWidth.rawValue)
        }
        
        topCenter = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        self.addParallaxToView(vw: topCenter)
        self.view.addSubview(topCenter)
        
        topCenter.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.top)
            make.height.equalTo(ImageSize.imgHeightAndWidth.rawValue)
            make.width.equalTo(ImageSize.imgHeightAndWidth.rawValue)
        }
        
        midCenter = UIImageView(frame: CGRect(x: 0, y: 0, width: ImageSize.imgHeightAndWidth.rawValue, height: ImageSize.imgHeightAndWidth.rawValue))
        self.view.addSubview(midCenter)
        
        midCenter.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
            
            make.height.equalTo(ImageSize.imgHeightAndWidth.rawValue)
            make.width.equalTo(ImageSize.imgHeightAndWidth.rawValue)
        }
        
        lowCenter = UIImageView(frame: CGRect(x: 0, y: 0, width: ImageSize.imgHeightAndWidth.rawValue, height: ImageSize.imgHeightAndWidth.rawValue))
        self.addParallaxToView(vw: lowCenter)
        self.view.addSubview(lowCenter)
        
        lowCenter.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.bottom)
            
            make.width.equalTo(ImageSize.imgHeightAndWidth.rawValue)
            make.height.equalTo(ImageSize.imgHeightAndWidth.rawValue)
        }
        
        topRight = UIImageView(frame: CGRect(x: 0, y: 0, width: ImageSize.imgHeightAndWidth.rawValue, height: ImageSize.imgHeightAndWidth.rawValue))
        self.addParallaxToView(vw: topRight)
        self.view.addSubview(topRight)
        
        topRight.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.right)
            make.centerY.equalTo(self.view.snp.top)
            
            make.height.equalTo(ImageSize.imgHeightAndWidth.rawValue)
            make.width.equalTo(ImageSize.imgHeightAndWidth.rawValue)
        }
        
        midRight = UIImageView(frame: CGRect(x: 0, y: 0, width: ImageSize.imgHeightAndWidth.rawValue, height: ImageSize.imgHeightAndWidth.rawValue))
        self.addParallaxToView(vw: midRight)
        self.view.addSubview(midRight)
        
        midRight.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.right)
            make.centerY.equalTo(self.view.snp.centerY)
            
            make.height.equalTo(ImageSize.imgHeightAndWidth.rawValue)
            make.width.equalTo(ImageSize.imgHeightAndWidth.rawValue)
        }
        
        lowRight = UIImageView(frame: CGRect(x: 0, y: 0, width: ImageSize.imgHeightAndWidth.rawValue, height: ImageSize.imgHeightAndWidth.rawValue))
        self.addParallaxToView(vw: lowRight)
        self.view.addSubview(lowRight)
        
        lowRight.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.right)
            make.centerY.equalTo(self.view.snp.bottom)
            
            make.width.equalTo(ImageSize.imgHeightAndWidth.rawValue)
            make.height.equalTo(ImageSize.imgHeightAndWidth.rawValue)
        }
        
        self.viewModel.getImagesForCentralLine(forCriterium: Criterium(), andCompletion: { images in
            _ = images.map({ (image) -> Image in
                print(image.name)
                return image
            })
            self.viewModel.downloadDataFor(ImageURL: images[0].thumbURL, withCompletion: { (data) in
                self.midLeft.image = UIImage(data: data)
            })
            self.viewModel.downloadDataFor(ImageURL: images[1].thumbURL, withCompletion: { (data) in
                self.viewModel.getFuzzyImages(forTags: images[1].tags) { (images) in
                    _ = images.map({ (image) -> Image in
                        print(image.name)
                        return image
                    })
                    if(images.count >= 6) {
                        self.viewModel.downloadDataFor(ImageURL: images[0].thumbURL, withCompletion: { (data) in
                            self.topLeft.image = UIImage(data: data)
                        })
                        self.viewModel.downloadDataFor(ImageURL: images[1].thumbURL, withCompletion: { (data) in
                            self.topCenter.image = UIImage(data: data)
                        })
                        self.viewModel.downloadDataFor(ImageURL: images[2].thumbURL, withCompletion: { (data) in
                            self.topRight.image = UIImage(data: data)
                        })
                        self.viewModel.downloadDataFor(ImageURL: images[3].thumbURL, withCompletion: { (data) in
                            self.lowLeft.image = UIImage(data: data)
                        })
                        self.viewModel.downloadDataFor(ImageURL: images[4].thumbURL, withCompletion: { (data) in
                            self.lowCenter.image = UIImage(data: data)
                        })
                        self.viewModel.downloadDataFor(ImageURL: images[5].thumbURL, withCompletion: { (data) in
                            self.lowRight.image = UIImage(data: data)
                        })
                    }
                }
                self.midCenter.image = UIImage(data: data)
            })
            self.viewModel.downloadDataFor(ImageURL: images[2].thumbURL, withCompletion: { (data) in
                self.midRight.image = UIImage(data: data)
            })
        })
        

        

        // Do any additional setup after loading the view.
    }
    
    func addParallaxToView(vw: UIView) {
        let amount = 20
        
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        vw.addMotionEffect(group)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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
