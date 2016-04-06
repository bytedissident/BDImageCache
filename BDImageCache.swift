//
//  BDImageCache.swift
//  ImageCache
//
//  Created by derek lee bronston on 4/5/16.
//  Copyright © 2016 Bytedissident. All rights reserved.
//

import UIKit
import FLAnimatedImage


class BDImageCache: NSObject {
    
    var useDiskCache = true
    
    func imageWithURL(url:String,complete:(img:Dictionary<String,AnyObject>)->Void,fail:()->Void){
        self.loadImageFromCache(url, complete: { (img) -> Void in
            complete(img: img)
            }) { () -> Void in
                fail()
        }
    }
    

    func saveImageToCache(url:String,data:NSData,contentType:String,complete:(img:Dictionary<String,AnyObject>)->Void,fail:()->Void){
        
        if contentType == "image/gif" {
            let img = FLAnimatedImage(animatedGIFData: data)
            if let animatedImage = img {
                NSCache.sharedInstance.setObject(["animated":animatedImage], forKey: url)
                complete(img: ["animated":animatedImage])
            }else{
                fail()
            }
        }else{
            let img = UIImage(data: data)
            if let image = img {
                NSCache.sharedInstance.setObject(["image":image], forKey: url)
                complete(img: ["image":image])
            }else{
                fail()
            }
        }
        
    }
    
    func loadImageFromCache(url:String,complete:(img:Dictionary<String,AnyObject>)->Void,fail:()->Void){
        if let image = NSCache.sharedInstance.objectForKey(url) as? Dictionary<String,AnyObject> {
            complete(img:image)
        }else{
           
            self.loadImageFromWeb(url, complete: {[weak self] (data, contentType) -> Void in
                
                if let strongSelf = self {
                    strongSelf.saveImageToCache(url, data: data,contentType: contentType, complete: { (img) -> Void in
                        complete(img: img)
                        }, fail: { () -> Void in
                            fail()
                    })
                }

                }, fail: { () -> Void in
                    fail()
            })
        }
    }
    
    
    func loadImageFromWeb(url:String,complete:(data:NSData,contentType:String)->Void,fail:()->Void){
        print("load from web")
        let url:NSURL = NSURL(string: url)!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.cachePolicy = NSURLRequestCachePolicy.ReturnCacheDataElseLoad
      
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                fail();
                return
            }
            
            let fields = response as! NSHTTPURLResponse
            let field = fields.allHeaderFields["Content-Type"] as? String
            //print(response);
            complete(data: data!,contentType: field!)
        }
        
        task.resume()
    }
}
