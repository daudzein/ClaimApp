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
        
        tableView.register(ClaimTableViewCell.self, forCellReuseIdentifier: ClaimTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        
        setupTableView()
        setupSearch()
        setupSpinner()
        bindViewModel()
        
        Task {
            await viewModel.fetchClaims()
        }
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClaimTableViewCell.identifier, for: indexPath) as? ClaimTableViewCell else {
                return UITableViewCell()
            }
        
            let claim = viewModel.filteredClaims[indexPath.row]
            cell.configure(with: claim)
            return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let claim = viewModel.claim(at: indexPath.row)
        let detailVC = ClaimDetailViewController(claim: claim)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1
        }
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


