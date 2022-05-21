//
//  NYTStoriesTests.swift
//  NYTStoriesTests
//
//  Created by Oğuzhan Varsak on 19.05.2022.
//

import XCTest
@testable import NYTStories

class WebServiceTests: XCTestCase {

    var sut: WebService!
    var articles: [Article]?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func setupData() {
        
        sut = WebService()
    }
    
    func testFetchStoryList() throws {
        
        setupData()
        
        let expected = XCTestExpectation(description: "WebService fetchs stories and runs the callback closure")
        
        sut.getArticles(url: URL(string: String(format: Url.topStories, Secrets.apiKey))!, completion: { result in
            self.articles = result
            expected.fulfill()
        })
        
        wait(for: [expected], timeout: 5)
        
        XCTAssertNotNil(articles)
    }
    
    func testLoadImage() throws {
        
        setupData()
        
        let expected = XCTestExpectation(description: "WebService loads image and runs the callback closure")
        
        var uiImage: UIImage? = nil
        
        sut.loadImage(from: Urls.imageUrl, completion: { image in
            
            uiImage = image
            expected.fulfill()
        })
        
        wait(for: [expected], timeout: 5)
        
        XCTAssertTrue(uiImage != nil)
    }
    
    func testLoadData() throws {
        
        setupData()
        
        let expected = XCTestExpectation(description: "WebService loads data and runs the callback closure")
        
        var imageData: Data? = nil
        
        sut.loadData(from: Urls.imageUrl, completion: { data in
            
            imageData = data
            expected.fulfill()
        })
        
        wait(for: [expected], timeout: 5)
        
        XCTAssertTrue(imageData != nil)
    }
}
