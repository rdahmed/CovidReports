//
//  CountryReportViewController.swift
//  Covid-19-meter
//
//  Created by Radwa Ahmed on 26/04/2022.
//

import UIKit

class CountryReportViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Constants {
        static let reportFieldCellId = "reportFieldCellId"
    }
    
    // MARK: - Dependencies
    
    let viewModel: CountryReportViewModelInputProtocol
    var reportFields: [ReportFieldData] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Properties
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Initializers
    
    init(viewModel: CountryReportViewModelInputProtocol) {
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
        
        self.viewModel.fetchReportFields()
    }
    
}

// MARK: - UISetup

private extension CountryReportViewController {
    
    func setupViews() {
        self.tableView.isScrollEnabled = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(
            ReportFieldTableViewCell.self,
            forCellReuseIdentifier: Constants.reportFieldCellId
        )
    }
    
    func setupLayout() {
        view.addSubview(self.tableView)
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
    
}

extension CountryReportViewController: CountryReportViewModelOutputProtocol {
    func update(reportFields: [ReportFieldData]) {
        self.reportFields = reportFields
    }
}

// MARK: - UITableViewDataSource

extension CountryReportViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        self.reportFields.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.reportFieldCellId,
            for: indexPath) as? ReportFieldTableViewCell
        else { return .init() }
        
        cell.fieldData = self.reportFields[indexPath.row]
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension CountryReportViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}