//
//  CountriesListViewController.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import UIKit

class CountriesListViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Constants {
        static let countryCellId = "countryTableViewCell"
    }
    
    // MARK: - Dependenceis
    
    let viewModel: CountriesListViewModelInputProtocol
    var reports: [CountryCovidReport] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Properties
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let refreshControl = UIRefreshControl()
    
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
        print(errorMessage)
    }
    
}

// MARK: - UISetup

private extension CountriesListViewController {
    
    func setupViews() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.countryCellId)
        
        self.refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    func setupLayout() {
        view.addSubview(self.tableView)
        self.tableView.refreshControl = self.refreshControl
    }
    
    func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc
    private func refresh(_ refreshControl: UIRefreshControl) {
        self.viewModel.fetchLatestCovidReports { [weak self] in
            self?.refreshControl.endRefreshing()
        }
        
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