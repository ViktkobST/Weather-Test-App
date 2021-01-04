//
//  ViewController.swift
//  KrasnayaPolyanaTest
//
//  Created by Виктор Кобыхно on 1/4/21.
//

import UIKit

protocol MainViewProtocol: class {
    func updateData()
}

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol!
    var reuseIdentifier = "weatherViewCell"
    
    lazy var weatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Данные о погоде"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let nibName = UINib(nibName: "WeatherViewCell", bundle: nil)
        self.weatherTableView.register(nibName, forCellReuseIdentifier: reuseIdentifier)
        self.setupLayout()
        self.weatherTableView.tableFooterView = UIView()
    }
    
    private func setupLayout() {
        view.addSubview(weatherTableView)
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        weatherTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.weatherData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! WeatherViewCell
        let weatherData = self.presenter.weatherData?[indexPath.row]
        cell.configureCell(weatherData!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
}

extension MainViewController: MainViewProtocol {
    func updateData() {
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }
}



