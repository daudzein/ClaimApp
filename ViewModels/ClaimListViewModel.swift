//
//  ClaimListViewModel.swift
//  ClaimApp
//
//  Created by daud daud on 21/04/25.
//

import Foundation


class ClaimListViewModel {
    private let service = ClaimService()
    
    private(set) var claims: [Claim] = []
    private(set) var filteredClaims: [Claim] = []
    
    var onUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    func fetchClaims() async {
        do {
            let data = try await service.fetchClaims()
            self.claims = data
            self.filteredClaims = data
            DispatchQueue.main.async {
                self.onUpdate?()
            }
        } catch {
            DispatchQueue.main.async {
                self.onError?(error)
            }
        }
    }

    func filterClaims(with query: String) {
        if query.isEmpty {
            filteredClaims = claims
        } else {
            filteredClaims = claims.filter {
                $0.title.lowercased().contains(query.lowercased()) ||
                $0.body.lowercased().contains(query.lowercased())
            }
        }
        onUpdate?()
    }

    func claim(at index: Int) -> Claim {
        return filteredClaims[index]
    }

    var count: Int {
        return filteredClaims.count
    }
}
