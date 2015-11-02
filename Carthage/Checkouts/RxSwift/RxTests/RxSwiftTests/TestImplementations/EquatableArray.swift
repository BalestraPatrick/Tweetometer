//
//  EquatableArray.swift
//  RxTests
//
//  Created by Krunoslav Zaher on 10/15/15.
//
//

import Foundation

struct EquatableArray<Element: Equatable> : Equatable {
    let elements: [Element]
    init(_ elements: [Element]) {
        self.elements = elements
    }
}

func == <E: Equatable>(lhs: EquatableArray<E>, rhs: EquatableArray<E>) -> Bool {
    return lhs.elements == rhs.elements
}
