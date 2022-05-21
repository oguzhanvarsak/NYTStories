//
//  NYTStoriesUITests.swift
//  NYTStoriesUITests
//
//  Created by Oğuzhan Varsak on 19.05.2022.
//

import XCTest

class NYTStoriesUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    let detailViewControllerTitle = "Story Detail"
    let seeMoreButtonTitle = "See More"
    let homeBackButtonTitle = "Home"
    let activityController = "UIActivityContentView"
    let shareButton = "Share"
    
    func navigateToDetail(for index: Int = 0) {
        
        app.tables.cells.element(boundBy: index).tap()
    }
    
    func navigateToSafari() {
        
        app.buttons[seeMoreButtonTitle].tap()
    }
    
    func launcAndCheckCells() {
        
        app.launch()
        
        XCTAssert(app.tables.cells.element(boundBy: 0).waitForExistence(timeout: 5))
    }
    
    func orientate() {
        
        XCUIDevice.shared.orientation = .landscapeLeft
        sleep(2)
        
        XCUIDevice.shared.orientation = .landscapeRight
        sleep(2)
        
        XCUIDevice.shared.orientation = .portrait
        sleep(2)
    }
    
    func testNavigation() throws {
        
        launcAndCheckCells()
        
        for i in 0 ..< 3 {
            
            navigateToDetail(for: i)
            
            XCTAssert(app.navigationBars[detailViewControllerTitle].exists
                      && app.buttons[seeMoreButtonTitle].exists)
            
            app.navigationBars.buttons[homeBackButtonTitle].tap()
        }
    }
    
    func testShareActivityController() throws {
        
        launcAndCheckCells()
        
        navigateToDetail()
        
        let storyDetailNavigationBar = app.navigationBars[detailViewControllerTitle]
        storyDetailNavigationBar.buttons[shareButton].tap()
        
        XCTAssert(app.navigationBars[activityController].waitForExistence(timeout: 5))
    }
    
    func testScreenOrientations() throws {
        
        launcAndCheckCells()
        
        orientate()
        
        navigateToDetail(for: 0)
        
        orientate()
        
        navigateToSafari()
        
        XCTAssert(app.webViews.element.waitForExistence(timeout: 2))
        
        orientate()
    }
}
