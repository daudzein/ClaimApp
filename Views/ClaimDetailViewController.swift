//
//  ClaimDetailViewController.swift
//  ClaimApp
//
//  Created by daud daud on 21/04/25.
//

import UIKit

class ClaimDetailViewController: UIViewController {
    private let claim: Claim

    init(claim: Claim) {
        self.claim = claim
        super.init(nibName: nil, bundle: nil)
        title = "Detail Klaim"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
        ID Klaim: \(claim.id)
        ID Penggugat: \(claim.userId)

        Judul:
        \(claim.title)

        Deskripsi:
        \(claim.body)
        """
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
