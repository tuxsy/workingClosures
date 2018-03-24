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
    let mainOperationQueue = OperationQueue.main
    
    
    var img1:UIImage?
    var img2:UIImage?
    var img3:UIImage?
    var img4:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func giveMeDownloadOperationFor(urlString: String, withClosure: @escaping ((UIImage) -> Void))  -> DownloadImgOperation{
        let downloadOperation = DownloadImgOperation(urlString: urlString)
        downloadOperation.imageClosure = { (success, uiImage, error) in
            if success {
                withClosure(uiImage!)
            } else {
                print(error!)
            }
        }
        return downloadOperation
    }
    
    func giveMeViewOperationFor(downloadOperation: DownloadImgOperation, dependsOn: BlockOperation?, withClosure: @escaping (()->Void)) -> BlockOperation {
        
        let viewOperation = BlockOperation(block: withClosure)
        viewOperation.addDependency(downloadOperation)
        
        if let dependecy = dependsOn {
            viewOperation.addDependency(dependecy)
        }
        
        return viewOperation
    }
    
    @IBAction func downloadImage(_ sender: Any) {
        
        
        
        let button = sender as! UIButton

        activityIndicator.startAnimating()
        button.isEnabled = false
        
        // ---- Img 1
        let downloadOperation1 = giveMeDownloadOperationFor(urlString: "http://c8.alamy.com/comp/KA3NBR/expo92-district-in-seville-sevilla-spain-white-bioclimatic-sphere-KA3NBR.jpg") { [unowned self] uiImage in
            self.img1 = uiImage
        }
        let viewOperation1 = giveMeViewOperationFor(downloadOperation: downloadOperation1, dependsOn: nil) {
            [unowned self] in
            self.imageView1.image = self.img1
        }
        
        // ---- Img 2
        let downloadOperation2 = giveMeDownloadOperationFor(urlString: "https://www.ecestaticos.com/image/clipping/939/56c9f8853cafb0265da40eb3478269a4/expo.jpg") { [unowned self] uiImage in
            self.img2 = uiImage
        }
        
        let viewOperation2 = giveMeViewOperationFor(downloadOperation: downloadOperation2, dependsOn: viewOperation1) {
            [unowned self] in
            self.imageView2.image = self.img2
        }
        
        // ---- Img 3
        let downloadOperation3 = giveMeDownloadOperationFor(urlString: "http://www.hanedanrpg.com/photos/hanedanrpg/12/55932.jpg") { [unowned self] uiImage in
            self.img3 = uiImage
        }
        let viewOperation3 = giveMeViewOperationFor(downloadOperation: downloadOperation3, dependsOn: viewOperation2) {
            [unowned self] in
            self.imageView3.image = self.img3
        }
        
        // ---- Img 4
        let downloadOperation4 = giveMeDownloadOperationFor(urlString: "http://www.alpha-exposiciones.com/wp-content/uploads/2018/03/marathonweek_expo15_mm-106_r1.jpg") { [unowned self] uiImage in
            self.img4 = uiImage
        }
        let viewOperation4 = giveMeViewOperationFor(downloadOperation: downloadOperation4, dependsOn: viewOperation3) {
            [unowned self] in
            self.imageView4.image = self.img4
        }
        
        
        let userViewOperation = BlockOperation {
            self.activityIndicator.stopAnimating()
            button.isEnabled = true
        }
        userViewOperation.addDependency(viewOperation4)
        
        mainOperationQueue.addOperations([viewOperation4, viewOperation3, viewOperation2, viewOperation1, userViewOperation], waitUntilFinished: false)
        
        operationQueue.addOperations([downloadOperation1, downloadOperation2, downloadOperation3, downloadOperation4], waitUntilFinished: false)
        
        
    }
}

