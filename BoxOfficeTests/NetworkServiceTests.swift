//
//  NetworkServiceTests.swift
//  BoxOfficeTests
//
//  Created by Danny, Diana, gama on 4/5/24.
//

import XCTest
@testable import BoxOffice

final class NetworkServiceTests: XCTestCase {
    private var sut: NetworkService!
    
    override func setUpWithError() throws {
        sut = NetworkService()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_일일박스오피스_조회하기() throws {
        // Given
        let todayDate = DateFormatter().fetchTodayDate()
        guard let url = URL(string: URLs.PREFIX + URLs.DAILY_BOX_OFFICE + todayDate) else { return }
        print(url)
        
        // When
        sut.startLoad(url: url, type: BoxOfficeDTO.self)
        
        
        // Then
        
    }

}
