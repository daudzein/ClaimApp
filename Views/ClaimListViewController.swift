//
//  ClaimListViewController.swift
//  ClaimApp
//
//  Created by daud daud on 21/04/25.
//

import UIKit

class ClaimListViewController: UIViewController {
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Klaim Asuransi"
        view.backgroundColor = .systemBackground
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ClaimListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 0 }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}


