//
//  Page.swift
//  OdysseiaUITests
//
//  Created by lcr on 2020/12/11.
//

import XCTest

protocol Page {
    var app: XCUIApplication { get }
    init(app: XCUIApplication)
}
