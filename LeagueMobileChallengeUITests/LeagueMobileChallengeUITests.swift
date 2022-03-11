//
//  LeagueMobileChallengeUITests.swift
//  LeagueMobileChallengeUITests
//
//  Created by Kelvin Lau on 2019-01-09.
//  Copyright © 2019 Kelvin Lau. All rights reserved.
//

import XCTest

class LeagueMobileChallengeUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginIn() {
        XCUIApplication()/*@START_MENU_TOKEN@*/.staticTexts["Login As Guest"]/*[[".buttons[\"Login As Guest\"].staticTexts[\"Login As Guest\"]",".staticTexts[\"Login As Guest\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

    func testPostViews() {
        let app = XCUIApplication()
        let table = app.tables.element(boundBy: 0)
        let lastCell = table.cells.element(boundBy: table.cells.count-1)
        table.scrollToElement(element: lastCell)
    }
    
    func testLogOut() {
        let logoutButton = XCUIApplication().navigationBars["Posts"].buttons["Logout"]
        logoutButton.tap()
        logoutButton.tap()
    }
}

extension XCUIElement {

    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }

    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
    
    func forceTap() {
           coordinate(withNormalizedOffset: CGVector(dx:0.5, dy:0.5)).tap()
       }
}
