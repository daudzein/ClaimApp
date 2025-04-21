//
//  ClaimServiceTests.swift
//  ClaimAppTests
//
//  Created by daud daud on 21/04/25.
//

import XCTest
@testable import ClaimApp

class ClaimServiceTests: XCTestCase {

    func testDecodingMockClaim() throws {
        let json = """
        {
            "userId": 101,
            "id": 2001,
            "title": "Kerusakan kendaraan",
            "body": "Ditabrak dari belakang di lampu lalu lintas..."
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let claim = try decoder.decode(Claim.self, from: json)

        XCTAssertEqual(claim.userId, 101)
        XCTAssertEqual(claim.id, 2001)
        XCTAssertEqual(claim.title, "Kerusakan kendaraan")
        XCTAssertEqual(claim.body, "Ditabrak dari belakang di lampu lalu lintas...")
    }

    func testFetchClaimsSuccess() async throws {
        let service = ClaimService()
        do {
            let claims = try await service.fetchClaims()
            XCTAssertFalse(claims.isEmpty, "Expected non-empty claims array")
            XCTAssertNotNil(claims.first?.title)
        } catch {
            XCTFail("Fetching claims failed with error: \(error)")
        }
    }

    // Optional: Simulate failure with mock URLSession if kamu mau test error handling
}
