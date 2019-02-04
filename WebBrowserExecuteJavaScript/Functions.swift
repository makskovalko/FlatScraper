//
//  Functions.swift
//  WebBrowserExecuteJavaScript
//
//  Created by Maxim Kovalko on 2/4/19.
//  Copyright © 2019 Maxim Kovalko. All rights reserved.
//

func compose<A, B>(_ a: A, callback: (A) -> B) -> B {
    return callback(a)
}

func compose<A, B, C>(_ lhs: @escaping (A) -> B,
                      _ rhs: @escaping (B) -> C) -> (A) -> C {
    return { rhs(lhs($0)) }
}

precedencegroup CompositionPrecedence {
    associativity: left
    higherThan: AssignmentPrecedence
}

infix operator |>: CompositionPrecedence
infix operator =>

func |> <A, B>(_ a: A, callback: (A) -> B) -> B {
    return compose(a, callback: callback)
}

func |> <A, B, C>(_ lhs: @escaping (A) -> B,
                  _ rhs: @escaping (B) -> C) -> (A) -> C {
    return compose(lhs, rhs)
}

func curry<A, B, C>(function: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in function(a, b) } }
}

func uncury<A, B, C>(function: @escaping (A) -> (B) -> C) -> (A, B) -> C {
    return { a, b in function(a)(b) }
}

func convert<A, B>(_ value: A?) -> ((A) -> (B?)) -> B? {
    return { call in
        guard let value = value else { return nil }
        return call(value)
    }
}

func convert<A, B>(_ value: A?, transform: (A) -> B?) -> B? {
    guard let value = value else { return nil }
    return transform(value)
}

func |> <A, B>(_ value: A?, transform: (A) -> B?) -> B? {
    guard let value = value else { return nil }
    return transform(value)
}

func identity<A>(_ value: A) -> A {
    return value
}

@discardableResult
func performIf(_ condition: Bool) -> (@escaping () -> Void) -> () {
    return { action in
        guard condition else { return }
        action()
    }
}

func => (_ condition: Bool, execute: @escaping () -> ()) {
    performIf(condition)(execute)
}
