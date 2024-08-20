//
//  TabBarRouterTests.swift
//  KueskiMovieDBTests
//
//  Created by Francisco Rosales on 20/08/24.
//

import XCTest
@testable import KueskiMovieDB

final class TabBarRouterTests: XCTestCase {
    
    func testTabsConfiguresTabBarItems() {
        // Arrange
        let nowPlayingViewController = UIViewController()
        let popularViewController = UIViewController()
        let submodules = TabBarRouter.Submodules(
            nowPlaying: nowPlayingViewController,
            popular: popularViewController
        )
        
        // Act
        let configuredTabs = TabBarRouter.tabs(usingSubmodules: submodules)
        
        // Assert
        XCTAssertNotNil(configuredTabs.nowPlaying.tabBarItem, "NowPlaying view controller should have a tab bar item")
        XCTAssertNotNil(configuredTabs.popular.tabBarItem, "Popular view controller should have a tab bar item")
        
        XCTAssertEqual(configuredTabs.nowPlaying.tabBarItem?.title, TabBarConstants.nowPlayingTabBarTitle, "NowPlaying tab bar item title should be correctly set")
        XCTAssertEqual(configuredTabs.popular.tabBarItem?.title, TabBarConstants.popularTabBarTitle, "Popular tab bar item title should be correctly set")
        
        XCTAssertEqual(configuredTabs.nowPlaying.tabBarItem?.image, TabBarConstants.nowPlayingUnselectedTabBarItem, "NowPlaying tab bar item image should be correctly set")
        XCTAssertEqual(configuredTabs.popular.tabBarItem?.image, TabBarConstants.popularUnselectedTabBarItem, "Popular tab bar item image should be correctly set")
        
        XCTAssertEqual(configuredTabs.nowPlaying.tabBarItem?.selectedImage, TabBarConstants.nowPlayingSelectedTabBarItem, "NowPlaying tab bar item selected image should be correctly set")
        XCTAssertEqual(configuredTabs.popular.tabBarItem?.selectedImage, TabBarConstants.popularSelectedTabBarItem, "Popular tab bar item selected image should be correctly set")
    }
}
