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
        
        navigationController?.navigationBar.tintColor = .white
        
        // Gradient Background
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.white.cgColor]
        view.layer.insertSublayer(gradient, at: 0)

        // Label
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        // Attributed Text
        let attributedText = NSMutableAttributedString()

        let boldAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 18)]
        let normalAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16)]

        attributedText.append(NSAttributedString(string: "ID Klaim: ", attributes: boldAttrs))
        attributedText.append(NSAttributedString(string: "\(claim.id)\n", attributes: normalAttrs))

        attributedText.append(NSAttributedString(string: "ID Penggugat: ", attributes: boldAttrs))
        attributedText.append(NSAttributedString(string: "\(claim.userId)\n\n", attributes: normalAttrs))

        attributedText.append(NSAttributedString(string: "Judul:\n", attributes: boldAttrs))
        attributedText.append(NSAttributedString(string: "\(claim.title)\n\n", attributes: normalAttrs))

        attributedText.append(NSAttributedString(string: "Deskripsi:\n", attributes: boldAttrs))
        attributedText.append(NSAttributedString(string: "\(claim.body)", attributes: normalAttrs))

        label.attributedText = attributedText

        // Add to view
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
