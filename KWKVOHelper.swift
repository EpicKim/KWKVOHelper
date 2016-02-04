//
//  KWKVOHelper.swift
//  Kvo-Example
//
//  Created by wangk on 16/2/2.
//  Copyright © 2016年 EVER SENSE, INC. All rights reserved.
//

import Foundation

extension NSObject {
    func observe(keypath: String, closure:()->Void) {
        self.addObserver(KWKVOMananger.sharedInstance, forKeyPath: keypath, options: .New, context: nil)
        KWKVOMananger.sharedInstance.add(keypath, closure: closure, object: self.classForCoder)
    }
    
    func removeObserver(keypath: String) {
        KWKVOMananger.sharedInstance.remove(keypath)
    }
}

public class KWKVOObject : NSObject {
    public var closure:()->Void = { }
    public var objectClass:AnyClass?
    public var keyPath:String?
}

public class KWKVOMananger : NSObject  {
    class var sharedInstance:KWKVOMananger {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : KWKVOMananger? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = KWKVOMananger()
        }
        return Static.instance!
    }
    
    var kvoObjects = NSMutableArray()
    
    public func add(keyPath: String, closure:()->Void, object:AnyClass) {
        let newObject = KWKVOObject()
        newObject.closure = closure
        newObject.keyPath = keyPath
        newObject.objectClass = object
        self.kvoObjects.addObject(newObject)
    }
    
    public func remove(keyPath: String) {
        let predicate = NSPredicate(format: "keyPath=%@", keyPath)
        let filteredArray = self.kvoObjects.filteredArrayUsingPredicate(predicate)
        let kvoObject = filteredArray.first as! KWKVOObject
        self.kvoObjects.removeObject(kvoObject)
    }
    
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        let newString = change![NSKeyValueChangeNewKey]
        let predicate = NSPredicate(format: "keyPath=%@", keyPath!)
        let filteredArray = self.kvoObjects.filteredArrayUsingPredicate(predicate)
        
        let kvoObject = filteredArray.first as! KWKVOObject
        kvoObject.closure()
    }
}