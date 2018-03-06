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
    
    
    var img1:UIImage?{
        didSet {
            DispatchQueue.main.async {
                self.imageView1.image = self.img1
            }
        }
    }
    
    
    var img2:UIImage?{
        didSet {
            DispatchQueue.main.async {
                self.imageView2.image = self.img2
            }
        }
    }
    
    
    var img3:UIImage?{
        didSet {
            DispatchQueue.main.async {
                self.imageView3.image = self.img3
            }
        }
    }
    

    
    var img4:UIImage?{
        didSet {
            DispatchQueue.main.async {
                self.imageView4.image = self.img4
            }
        }
    }
    
    
    var closure1:nothingToNothing!
    var closure2:nothingToNothing!
    var closure3:nothingToNothing!
    var closure4:nothingToNothing!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closure1 = {
            
            let stringURL = "http://c8.alamy.com/comp/KA3NBR/expo92-district-in-seville-sevilla-spain-white-bioclimatic-sphere-KA3NBR.jpg"
            
            let url = URL(string: stringURL)
            
            let imgData = try! Data.init(contentsOf: url!)  // Heavy task.
            
            self.img1 = UIImage(data: imgData)
            
        }
        
        closure2 = {
            
            let stringURL = "https://www.ecestaticos.com/image/clipping/939/56c9f8853cafb0265da40eb3478269a4/expo.jpg"
            
            let url = URL(string: stringURL)
            
            let imgData = try! Data.init(contentsOf: url!)  // Heavy task.
            
            self.img2 = UIImage(data: imgData)
            
        }
        
        closure3 =  {
            
            let stringURL = "http://www.hanedanrpg.com/photos/hanedanrpg/12/55932.jpg"
            
            let url = URL(string: stringURL)
            
            let imgData = try! Data.init(contentsOf: url!)  // Heavy task.
            
            self.img3 = UIImage(data: imgData)
            
        }
        
        closure4 = {
            
            let stringURL = "http://www.alpha-exposiciones.com/wp-content/uploads/2018/03/marathonweek_expo15_mm-106_r1.jpg"
            
            let url = URL(string: stringURL)
            
            let imgData = try! Data.init(contentsOf: url!)  // Heavy task.
            
            self.img4 = UIImage(data: imgData)
            
        }
        

        
        
    }


    @IBAction func downloadImage(_ sender: Any) {
        
        
        
        let button = sender as! UIButton

        activityIndicator.startAnimating()
        button.isEnabled = false

        let myConcurrentQueue = DispatchQueue(label: "MyQueue", attributes: .concurrent)
        
        myConcurrentQueue.async(execute: closure1)
        myConcurrentQueue.async(execute: closure2)
        myConcurrentQueue.async(execute: closure3)
        myConcurrentQueue.async(execute: closure4)


        DispatchQueue.main.async{

                self.activityIndicator.stopAnimating()
                button.isEnabled = true

            }
        


    }
}

