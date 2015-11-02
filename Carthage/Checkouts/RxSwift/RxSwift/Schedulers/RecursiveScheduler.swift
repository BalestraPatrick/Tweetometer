//
//  RecursiveScheduler.swift
//  RxSwift
//
//  Created by Krunoslav Zaher on 6/7/15.
//  Copyright (c) 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation

class RecursiveScheduler<State, S: SchedulerType>: AnyRecursiveScheduler<State, S.TimeInterval> {
    let scheduler: S
    
    init(scheduler: S, action: Action) {
        self.scheduler = scheduler
        super.init(action: action)
    }
    
    override func scheduleRelativeAdapter(state: State, dueTime: S.TimeInterval, action: State -> Disposable) -> Disposable {
        return scheduler.scheduleRelative(state, dueTime: dueTime, action: action)
    }
    
    override func scheduleAdapter(state: State, action: State -> Disposable) -> Disposable {
        return scheduler.schedule(state, action: action)
    }
}

/**
Type erased recursive scheduler.
*/
class AnyRecursiveScheduler<State, TimeInterval> {
    typealias Action =  (state: State, scheduler: AnyRecursiveScheduler<State, TimeInterval>) -> Void

    let lock = NSRecursiveLock()
    
    // state
    let group = CompositeDisposable()
    
    var action: Action?
    
    init(action: Action) {
        self.action = action
    }

    // abstract methods

    func scheduleRelativeAdapter(state: State, dueTime: TimeInterval, action: State -> Disposable) -> Disposable {
        abstractMethod()
    }
    
    func scheduleAdapter(state: State, action: State -> Disposable) -> Disposable {
        abstractMethod()
    }
    
    /**
    Schedules an action to be executed recursively.
    
    - parameter state: State passed to the action to be executed.
    - parameter dueTime: Relative time after which to execute the recursive action.
    */
    func schedule(state: State, dueTime: TimeInterval) {

        var isAdded = false
        var isDone = false
        
        var removeKey: CompositeDisposable.DisposeKey? = nil
        let d = scheduleRelativeAdapter(state, dueTime: dueTime) { (state) -> Disposable in
            // best effort
            if self.group.disposed {
                return NopDisposable.instance
            }
            
            let action = self.lock.calculateLocked { () -> Action? in
                if isAdded {
                    self.group.removeDisposable(removeKey!)
                }
                else {
                    isDone = true
                }
                
                return self.action
            }
            
            if let action = action {
                action(state: state, scheduler: self)
            }
            
            return NopDisposable.instance
        }
            
        lock.performLocked {
            if !isDone {
                removeKey = group.addDisposable(d)
                isAdded = true
            }
        }
    }

    /**
    Schedules an action to be executed recursively.
    
    - parameter state: State passed to the action to be executed.
    */
    func schedule(state: State) {
            
        var isAdded = false
        var isDone = false
        
        var removeKey: CompositeDisposable.DisposeKey? = nil
        let d = scheduleAdapter(state) { (state) -> Disposable in
            // best effort
            if self.group.disposed {
                return NopDisposable.instance
            }
            
            let action = self.lock.calculateLocked { () -> Action? in
                if isAdded {
                    self.group.removeDisposable(removeKey!)
                }
                else {
                    isDone = true
                }
                
                return self.action
            }
           
            if let action = action {
                action(state: state, scheduler: self)
            }
            
            return NopDisposable.instance
        }
        
        lock.performLocked {
            if !isDone {
                removeKey = group.addDisposable(d)
                isAdded = true
            }
        }
    }
    
    func dispose() {
        self.lock.performLocked {
            self.action = nil
        }
        self.group.dispose()
    }
}

/**
Type erased recursive scheduler.
*/
class RecursiveImmediateScheduler<State> {
    typealias Action =  (state: State, recurse: State -> Void) -> Void
    
    var lock = SpinLock()
    let group = CompositeDisposable()
    
    var action: Action?
    let scheduler: ImmediateSchedulerType
    
    init(action: Action, scheduler: ImmediateSchedulerType) {
        self.action = action
        self.scheduler = scheduler
    }
    
    // immediate scheduling
    
    /**
    Schedules an action to be executed recursively.
    
    - parameter state: State passed to the action to be executed.
    */
    func schedule(state: State) {
        
        var isAdded = false
        var isDone = false
        
        var removeKey: CompositeDisposable.DisposeKey? = nil
        let d = self.scheduler.schedule(state) { (state) -> Disposable in
            // best effort
            if self.group.disposed {
                return NopDisposable.instance
            }
            
            let action = self.lock.calculateLocked { () -> Action? in
                if isAdded {
                    self.group.removeDisposable(removeKey!)
                }
                else {
                    isDone = true
                }
                
                return self.action
            }
            
            if let action = action {
                action(state: state, recurse: self.schedule)
            }
            
            return NopDisposable.instance
        }
        
        lock.performLocked {
            if !isDone {
                removeKey = group.addDisposable(d)
                isAdded = true
            }
        }
    }
    
    func dispose() {
        self.lock.performLocked {
            self.action = nil
        }
        self.group.dispose()
    }
}