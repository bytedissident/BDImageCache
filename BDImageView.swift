//
//  BDImageView.swift
//  ImageCache
//
//  Created by derek lee bronston on 4/6/16.
//  Copyright © 2016 Bytedissident. All rights reserved.
//

import UIKit
import FLAnimatedImage

class BDImageView: FLAnimatedImageView {
    
    let bdCache = BDImageCache()
    
    func imageWithURL(url:String){
        
        self.image = nil
        self.animatedImage = nil
        
        self.bdCache.imageWithURL(url, complete: {[weak self] (img) -> Void in
            
            if let strongSelf = self {
                if let animated = img["animated"] as? FLAnimatedImage {
                    strongSelf.animatedImage = animated
                }else if let image = img["image"] as? UIImage {
                    print("IMAGE \(image)")
                    strongSelf.updateImage(image)
                }
            }
            
            }) { () -> Void in
                
        }
    }
    
    func updateImage(img:UIImage){
        
        dispatch_async(dispatch_get_main_queue()) { // 2
           self.image = img
        }
    }
    
    
}