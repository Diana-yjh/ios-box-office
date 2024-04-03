//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Danny, Gama, Diana on 4/2/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {
    private var sut: JSONDecoder!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = JSONDecoder()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func test_JSONParser가_정상적으로작동하는지_확인할수있다() {
        let result = sut.decode("box_office_sample", type: DailyBoxOffice.self)
        
        XCTAssertFalse(result == nil)
    }
    
    func test_JSON파일명이_올바르지_않은지_확인하기() {
        // When
        let result = sut.decode("box_office_sample_test", type: DailyBoxOffice.self)
        
        // Then
        XCTAssertTrue(result == nil)
    }
}
