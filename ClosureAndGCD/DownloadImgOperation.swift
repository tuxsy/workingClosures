//
//  DownloadImgOperation.swift
//  ClosureAndGCD
//
//  Created by Bruno Anglés Robles on 24/3/18.
//  Copyright © 2018 Joaquin Perez. All rights reserved.
//

import UIKit

class DownloadImgOperation: Operation {
    
    let urlString: String
    var imageClosure: ((Bool, UIImage?, Error?) -> Void)?
    
    init(urlString: String) {
        self.urlString = urlString
        
        super.init()
        
    }
    
    override func main() {
        if let endClosure = imageClosure {
            let url = URL(string: urlString)
            
            do {
                let imgData = try Data.init(contentsOf: url!)  // Heavy task.
                endClosure(true, UIImage(data: imgData)!, nil)
            } catch {
                endClosure(false, nil, error)
            }
        }
    }

}
