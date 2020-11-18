//
//  XCTxContext.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/12.
//

import XCTest

// https://github.com/shindyu/XCTestExtensions/blob/master/XCTestExtensions/XCTxContext.swift

public protocol ContextExecutable {
    func XCTxContext(_ named: String, shouldSetUp: Bool, shouldTearDown: Bool, block: () -> Void)
}

extension XCTestCase: ContextExecutable {
    /// Execute runActivity with setup, teardown
    ///
    /// - Parameters:
    ///   - named: Name of runActivity.
    ///   - shouldSetUp: Flag for execute setup
    ///   - shouldTearDown: Flag for execute tearDown
    ///   - block: Contents of the test to be executed
    public func XCTxContext(_ named: String, shouldSetUp: Bool = false, shouldTearDown: Bool = false, block: () -> Void) {
        if shouldSetUp {
            self.setUp()
        }
        XCTContext.runActivity(named: named, block: { _ in block() })
        if shouldTearDown {
            self.tearDown()
        }
    }
}
