//
//  DownloadImgOperation.swift
//  ClosureAndGCD
//
//  Created by Joaquin Perez on 06/03/2018.
//  Copyright © 2018 Joaquin Perez. All rights reserved.
//

import UIKit

class DownloadImgOperation: Operation {
    
    let urlString:String
    var imageClosure:((Bool ,UIImage?, Error?)->Void)?
    
    var end = false
    
    override var isFinished: Bool {
        
        return end
    }

    
    init(urlString:String)
    {
        self.urlString = urlString
        super.init()
    }
    
    override func main()
    {
        if let endClosure = imageClosure {
            
        let url = URL(string: urlString)
            
    
            
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: { (data, urlResponse, error) in
                if let realData = data {
                     endClosure(true,UIImage(data: realData), nil)
                    
                } else {
                    endClosure(false, nil, error!)
                  
                }
               self.willChangeValue(forKey: "isFinished") // KVO.
               self.end = true
               _ = self.isFinished
               self.didChangeValue(forKey: "isFinished")   // KVO

            
            })

         dataTask.resume()
        }
    }
    
    
}

