//
//  ImageViewController.swift
//  ClosureAndGCD
//
//  Created by Joaquin Perez on 05/03/2018.
//  Copyright © 2018 Joaquin Perez. All rights reserved.
//

import UIKit

typealias nothingToNothing = () -> Void

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let operationQueue = OperationQueue()
    let mainOpQueue = OperationQueue.main
    
    
    @objc var img1:UIImage?
    
    @objc var img2:UIImage?
    
    @objc var img3:UIImage?
    @objc var img4:UIImage?
    
    var observer: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observer = self.observe(\ImageViewController.img4, options: [.new], changeHandler: { (opQueue, change) in
            
            if let img = change.newValue {
                DispatchQueue.main.async {
                  
                     self.imageView4.image = img
                    
                    self.observer = nil
                }
            }
            
        })
        
    }
    
func giveMeDownloadOperationFor(index:Int) -> DownloadImgOperation
{
        var urlString = ""
    
        switch index {
        case 1:
            urlString = "http://c8.alamy.com/comp/KA3NBR/expo92-district-in-seville-sevilla-spain-white-bioclimatic-sphere-KA3NBR.jpg"
        case 2:
            urlString = "https://www.ecestaticos.com/image/clipping/939/56c9f8853cafb0265da40eb3478269a4/expo.jpg"
        case 3:
            urlString = "http://www.hanedanrpg.com/photos/hanedanrpg/12/55932.jpg"
        default:
            urlString = "http://www.alpha-exposiciones.com/wp-content/uploads/2018/03/marathonweek_expo15_mm-106_r1.jpg"
        }
        
        let downloadOperation = DownloadImgOperation(urlString: urlString)
        
        downloadOperation.imageClosure = { (succes:Bool, image:UIImage?, error:Error?) in
            if succes {
//                switch index {
//                case 1:
//                    self.img1 = image
//
//                case 2:
//                    self.img2 = image
//
//                case 3:
//                    self.img3 = image
//
//                default:
//                    self.img4 = image
//                }
              self.setValue(image, forKey: "img\(index)")
                

             
            } else {
                print(error!)
            }
    }
            
            return downloadOperation
        
    }


    @IBAction func downloadImage(_ sender: Any) {
    
        
        let button = sender as! UIButton

        activityIndicator.startAnimating()
        button.isEnabled = false
        
        let viewOperation1 = BlockOperation {
            self.imageView1.image = self.img1
        }
        let downloadOperation1 = self.giveMeDownloadOperationFor(index: 1)
        viewOperation1.addDependency(downloadOperation1)
        
        let viewOperation2 = BlockOperation {
            self.imageView2.image = self.img2
        }
       let downloadOperation2 = self.giveMeDownloadOperationFor(index: 2)
       viewOperation2.addDependency(downloadOperation2)
       viewOperation2.addDependency(viewOperation1)
        
        let viewOperation3 = BlockOperation {
            self.imageView3.image = self.img3
        }
        let downloadOperation3 = self.giveMeDownloadOperationFor(index: 3)
        viewOperation3.addDependency(downloadOperation3)
        viewOperation3.addDependency(viewOperation2)
        
//        let viewOperation4 = BlockOperation {
//            self.imageView4.image = self.img4
//        }
         let downloadOperation4 = self.giveMeDownloadOperationFor(index: 4)
     //   viewOperation4.addDependency(downloadOperation4)
      //  viewOperation4.addDependency(viewOperation3)
        
    
        
        
        mainOpQueue.addOperation(viewOperation3)
        mainOpQueue.addOperation(viewOperation2)
        mainOpQueue.addOperation(viewOperation1)
        
        let userViewOperation = BlockOperation {
            self.activityIndicator.stopAnimating()
            button.isEnabled = true
            
        }
        
      //  userViewOperation.addDependency(viewOperation4)
    //    mainOpQueue.addOperation(userViewOperation)
        
       // operationQueue.maxConcurrentOperationCount = 1
    operationQueue.addOperations([downloadOperation1,downloadOperation2,downloadOperation3,downloadOperation4], waitUntilFinished: false)
        
            

 
        
      print("Guarde todas")

    }
}

