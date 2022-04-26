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
        
        setupViews()
        setupLayout()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchLatestCovidReports()
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.countryCellId)
    }
    
    func setupLayout() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

// MARK: - TableViewDataSource

extension CountriesListViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        reports.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.countryCellId,
            for: indexPath) as? CountryTableViewCell
        else { return .init() }
        
        cell.report = reports[indexPath.row]
        
        return cell
    }
    
}

// MARK: - TableViewDelegate

extension CountriesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapOnCountry(indexPath.row)
    }
    
}
