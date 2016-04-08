//
//  BDCache.swift
//  ImageCache
//
//  Created by derek lee bronston on 4/5/16.
//  Copyright © 2016 Bytedissident. All rights reserved.
//

import Foundation

extension NSCache {
    class var sharedInstance : NSCache {
        struct Static {
            static let instance : NSCache = NSCache()
        } 
        return Static.instance
    }
}