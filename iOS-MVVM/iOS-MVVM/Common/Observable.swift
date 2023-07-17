//
//  Observable.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 17/07/2023.
//

import Foundation

public final class Observable<T> {
    
    struct Observer<T> {
        weak var observer: AnyObject?
        let block: (T) -> Void
    }
    
    private var observers = [Observer<T>]()
    
    public var value: T {
        didSet {
            notifyObservers()
        }
    }
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func observe(on observer: AnyObject, forceObserverFirstTime: Bool = false, observerBlock: @escaping (T) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
        if forceObserverFirstTime {
            observerBlock(self.value)
        }
    }
    
    public func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    
    private func notifyObservers() {
        for observer in observers {
            DispatchQueue.main.async { observer.block(self.value) }
        }
    }
}
