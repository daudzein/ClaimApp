//
//  ClaimService.swift
//  ClaimApp
//
//  Created by daud daud on 21/04/25.
//

import Foundation


class ClaimService {
    func fetchClaims() async throws -> [Claim] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Claim].self, from: data)
    }
}
