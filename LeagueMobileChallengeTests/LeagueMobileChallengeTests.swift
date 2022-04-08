//
//  LeagueMobileChallengeTests.swift
//  LeagueMobileChallengeTests
//
//  Created by Kelvin Lau on 2019-01-09.
//  Copyright © 2019 Kelvin Lau. All rights reserved.
//

import XCTest
import Combine

@testable import LeagueMobileChallenge

class LeagueMobileChallengeTests: XCTestCase {

    var suite: PostsViewModel!
    var interactor: MockInteractor!
    var postsOutPut: MockPostModelDelegate!
    
    override func setUp() {
        super.setUp()
        
        interactor = MockInteractor()
        postsOutPut = MockPostModelDelegate()
        suite = PostsViewModel(interactorDelegate: interactor)
        suite.postsModel = postsOutPut
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessPosts() {
        let posts: ([User], [Post]) = ([User(id: 1, name: "Sample Name", avatar: nil)], [Post(userId: 1, id: 4, title: "Sample Text", body: "Sample Body")])
        interactor.fetchUserPosts = CurrentValueSubject(posts).eraseToAnyPublisher()
        suite.loadPosts()
        XCTAssertEqual(postsOutPut.posts.count, 1)
        XCTAssertEqual(postsOutPut.posts[0].user?.name, "Sample Name")
        XCTAssertEqual(postsOutPut.posts[0].post?.id, 4)
        XCTAssertEqual(postsOutPut.posts[0].post?.userId, 1)
        XCTAssertEqual(postsOutPut.posts[0].post?.body, "Sample Body")
    }
    
    func testFailPosts() {
        let error = NSError()
        interactor.fetchUserPosts = Fail(error: error).eraseToAnyPublisher()
        suite.loadPosts()
        XCTAssertEqual(postsOutPut.posts.count, 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class MockInteractor: Interactor {
    
    var fetchUserPosts: AnyPublisher<([User], [Post]), Error>?
    
    override func fetchUsersPosts() -> AnyPublisher<([User], [Post]), Error> {
        if let response = fetchUserPosts {
            return response
        } else {
            fatalError("No Response Observed")
        }
    }
}

class MockPostModelDelegate: PostsModelDelegate {
    
    func fetchLatestPostsFailed() {
        
    }
    
    var posts = [UserPost]()
    func fetchLatestPosts(userPosts: [UserPost]?) {
        if let userPosts = userPosts {
            posts = userPosts
        }
    }
}
