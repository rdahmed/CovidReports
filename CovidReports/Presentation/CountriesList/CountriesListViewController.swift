//
//  CountriesListViewController.swift
//  CovidReports
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import UIKit

final class CountriesListViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Constants {
        static let countryCellId = "countryTableViewCell"
    }
    
    // MARK: - Dependenceis
    
    private let viewModel: CountriesListViewModelInputProtocol
    private var reports: [CountryCovidReport] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Initializers
    
    init(viewModel: CountriesListViewModelInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(#function, #file)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupLayout()
        self.setupConstraints()
        
        self.viewModel.fetchLatestCovidReports()
    }
    
}

// MARK: - ViewModelOutput

extension CountriesListViewController: CountriesListViewModelOutputProtocol {
    
    func update(reports: [CountryCovidReport]) {
        self.reports = reports
    }
    
    func update(errorMessage: String) {
        UIAlertController
            .alert(title: "Failed to load data!", message: "Something went wrong. Please try again later")
            .addOk()
            .present(on: self)
    }
    
}

// MARK: - UI Setup

private extension CountriesListViewController {
    
    func setupViews() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.setupSearchController()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.countryCellId)
        
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search..."
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.definesPresentationContext = true
    }
    
    func setupLayout() {
        self.view.addSubview(self.tableView)
        self.tableView.refreshControl = self.refreshControl
        
        let sortBarButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(didTapSort))
        self.navigationItem.rightBarButtonItem = sortBarButton
    }
    
    func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
}

// MARK: - Private Actions

private extension CountriesListViewController {
    
    @objc
    func refresh(_ refreshControl: UIRefreshControl) {
        self.viewModel.fetchLatestCovidReports { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.resetSearchAndSortState()
        }
    }
    
    func resetSearchAndSortState() {
        self.searchController.searchBar.resignFirstResponder()
        self.searchController.searchBar.text = .empty
        self.searchController.dismiss(animated: true)
        
        self.viewModel.searchCountries(.empty)
        self.viewModel.sortCountries(.countryName)
    }
    
    @objc
    func didTapSort() {
        let alert = UIAlertController
            .sheet(title: "Sort by")
            .addCancel()
        
        SortOption.allCases.forEach { option in
            alert.addDefault(title: option.localized) { [weak self] _ in
                self?.viewModel.sortCountries(option)
            }
        }
        
        alert.present(on: self)
    }
    
}

// MARK: - UITableViewDataSource

extension CountriesListViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        self.reports.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.countryCellId,
            for: indexPath) as? CountryTableViewCell
        else { return .init() }
        
        cell.report = self.reports[indexPath.row]
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension CountriesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.didTapOnCountry(indexPath.row)
    }
    
}

// MARK: - UISearchResultsUpdating

extension CountriesListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? .empty
        self.viewModel.searchCountries(searchText)
    }
    
}
