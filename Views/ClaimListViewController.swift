//
//  ClaimListViewController.swift
//  ClaimApp
//
//  Created by daud daud on 21/04/25.
//

import UIKit

class ClaimListViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = ClaimListViewModel()
    private let spinner = UIActivityIndicatorView(style: .large)
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Klaim Asuransi"
        view.backgroundColor = .systemBackground
        setupTableView()
        setupSearch()
        setupSpinner()
        bindViewModel()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupSearch() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func setupSpinner() {
        view.addSubview(spinner)
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.spinner.stopAnimating()
            self?.tableView.reloadData()
        }

        viewModel.onError = { [weak self] error in
            self?.spinner.stopAnimating()
            let alert = UIAlertController(title: "Gagal", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    
}

// MARK: - TableView DataSource & Delegate
extension ClaimListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let claim = viewModel.claim(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = claim.title
        content.secondaryText = claim.body
        content.secondaryTextProperties.numberOfLines = 2
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let claim = viewModel.claim(at: indexPath.row)
        let detailVC = ClaimDetailViewController(claim: claim)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - SearchBar Delegate
extension ClaimListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterClaims(with: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filterClaims(with: "")
    }
}


