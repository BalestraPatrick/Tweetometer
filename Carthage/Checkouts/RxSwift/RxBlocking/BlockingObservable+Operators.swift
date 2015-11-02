//
//  BlockingObservable+Operators.swift
//  Rx
//
//  Created by Krunoslav Zaher on 10/19/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
    import RxSwift
#endif

extension BlockingObservable {
    /**
    Blocks current thread until sequence terminates.
    
    If sequence terminates with error, terminating error will be thrown.
    
    - returns: All elements of sequence.
    */
    public func toArray() throws -> [E] {
        let condition = NSCondition()
        
        var elements: [E] = Array<E>()
        
        var error: ErrorType?
            
        var ended = false

        _ = self.source.subscribe { e in
            switch e {
            case .Next(let element):
                elements.append(element)
            case .Error(let e):
                error = e
                condition.lock()
                ended = true
                condition.signal()
                condition.unlock()
            case .Completed:
                condition.lock()
                ended = true
                condition.signal()
                condition.unlock()
            }
        }
        condition.lock()
        while !ended {
            condition.wait()
        }
        condition.unlock()
        
        if let error = error {
            throw error
        }

        return elements
    }
}

extension BlockingObservable {
    /**
    Blocks current thread until sequence produces first element.
    
    If sequence terminates with error before producing first element, terminating error will be thrown.
    
    - returns: First element of sequence. If sequence is empty `nil` is returned.
    */
    public func first() throws -> E? {
        let condition = NSCondition()
        
        var element: E?
        
        var error: ErrorType?
        
        var ended = false
        
        let d = SingleAssignmentDisposable()
        
        d.disposable = self.source.subscribe { e in
            switch e {
            case .Next(let e):
                if element == nil {
                    element = e
                }
                break
            case .Error(let e):
                error = e
            default:
                break
            }
            
            condition.lock()
            ended = true
            condition.signal()
            condition.unlock()
        }
        
        condition.lock()
        while !ended {
            condition.wait()
        }
        d.dispose()
        condition.unlock()
        
        if let error = error {
            throw error
        }
        
        return element
    }
}

extension BlockingObservable {
    /**
    Blocks current thread until sequence terminates.
    
    If sequence terminates with error, terminating error will be thrown.
    
    - returns: Last element in the sequence. If sequence is empty `nil` is returned.
    */
    public func last() throws -> E? {
        let condition = NSCondition()
        
        var element: E?
        
        var error: ErrorType?
        
        var ended = false
        
        let d = SingleAssignmentDisposable()
        
        d.disposable = self.source.subscribe { e in
            switch e {
            case .Next(let e):
                element = e
                return
            case .Error(let e):
                error = e
            default:
                break
            }
            
            condition.lock()
            ended = true
            condition.signal()
            condition.unlock()
        }
        
        condition.lock()
        while !ended {
            condition.wait()
        }
        d.dispose()
        condition.unlock()
        
        if let error = error {
            throw error
        }
        
        return element
    }
}