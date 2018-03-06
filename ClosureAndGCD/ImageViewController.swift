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
    
    
    var img1:UIImage?
    
    var img2:UIImage?
    
    var img3:UIImage?

    
    var img4:UIImage?
    
    var closure1:Operation!
    var closure2:Operation!
    var closure3:Operation!
    var closure4:Operation!
    
    let operationQueue = OperationQueue()
    
    let mainOperationQueue = OperationQueue.main

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
    }


    @IBAction func downloadImage(_ sender: Any) {
        
        
        
//        let button = sender as! UIButton
//
//        activityIndicator.startAnimating()
//        button.isEnabled = false
//
//        let myConcurrentQueue = DispatchQueue(label: "MyQueue", attributes: .concurrent)
//
//
//        DispatchQueue.main.async{
//
//                self.activityIndicator.stopAnimating()
//                button.isEnabled = true
//
//            }
        
        // Do any additional setup after loading the view.
        
        closure1 = BlockOperation {
            
            let stringURL = "http://c8.alamy.com/comp/KA3NBR/expo92-district-in-seville-sevilla-spain-white-bioclimatic-sphere-KA3NBR.jpg"
            
            let url = URL(string: stringURL)
            
            let imgData = try! Data.init(contentsOf: url!)  // Heavy task.
            
            self.img1 = UIImage(data: imgData)
            
        }
        
        closure2 = BlockOperation {
            
            let stringURL = "https://www.ecestaticos.com/image/clipping/939/56c9f8853cafb0265da40eb3478269a4/expo.jpg"
            
            let url = URL(string: stringURL)
            
            let imgData = try! Data.init(contentsOf: url!)  // Heavy task.
            
            self.img2 = UIImage(data: imgData)
            
        }
        
        closure3 = BlockOperation {
            
            let stringURL = "http://www.hanedanrpg.com/photos/hanedanrpg/12/55932.jpg"
            
            let url = URL(string: stringURL)
            
            let imgData = try! Data.init(contentsOf: url!)  // Heavy task.
            
            self.img3 = UIImage(data: imgData)
            
        }
        
        closure4 = BlockOperation {
            
            let stringURL = "http://www.alpha-exposiciones.com/wp-content/uploads/2018/03/marathonweek_expo15_mm-106_r1.jpg"
            
            let url = URL(string: stringURL)
            
            let imgData = try! Data.init(contentsOf: url!)  // Heavy task.
            
            self.img4 = UIImage(data: imgData)
            
        }
        
        let viewImage1Operation = BlockOperation {
            
            self.imageView1.image = self.img1
        }
        
        viewImage1Operation.addDependency(closure1)
        
        let viewImage2Operation = BlockOperation {
            
            self.imageView2.image = self.img2
        }
        
        viewImage2Operation.addDependency(closure2)
        viewImage2Operation.addDependency(viewImage1Operation)
        
        let viewImage3Operation = BlockOperation {
            
            self.imageView3.image = self.img3
        }
        
        viewImage3Operation.addDependency(closure3)
        viewImage3Operation.addDependency(viewImage2Operation)
        
        let viewImage4Operation = BlockOperation {
            
            self.imageView4.image = self.img4
        }
        
        viewImage4Operation.addDependency(closure4)
        viewImage4Operation.addDependency(viewImage3Operation)
        
        operationQueue.addOperation(closure1)
        operationQueue.addOperation(closure2)
        operationQueue.addOperation(closure3)
        operationQueue.addOperation(closure4)
        
        mainOperationQueue.addOperation(viewImage1Operation)
        
        mainOperationQueue.addOperation(viewImage2Operation)
        
        mainOperationQueue.addOperation(viewImage3Operation)
        
        mainOperationQueue.addOperation(viewImage4Operation)

    }
}

