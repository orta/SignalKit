//
//  Signal.swift
//  SignalKit
//
//  Created by Yanko Dimitrov on 8/12/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation

public final class Signal<T>: SignalType {
    public typealias Item = T
    
    private var observer: Disposable?
    
    public var disposableSource: Disposable?
    public let dispatcher: Dispatcher<Item>
    
    public init(lock: LockType? = nil) {
        
        dispatcher = Dispatcher<Item>(lock: lock)
    }
    
    deinit {
        
        dispose()
    }
    
    public func observe<U where U:Observable, U.Item == Item>(observable: U) {
        
        dispose()
        
        observer = observable.addObserver { [weak self] in
            
            self?.dispatch($0)
        }
    }
    
    public func dispose() {
        
        observer?.dispose()
        observer = nil
        
        disposableSource?.dispose()
    }
}
