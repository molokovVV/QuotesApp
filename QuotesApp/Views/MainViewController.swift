//
//  ViewController.swift
//  QuotesApp
//
//  Created by Виталик Молоков on 04.03.2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    
    let categories = [
        "attitude", "beauty", "best", "birthday", "business", "car", "change",
        "communication", "computers", "cool", "courage", "dad", "dating", "death",
        "design", "dreams", "education", "environmental", "equality", "experience",
        "failure", "faith", "family", "famous", "fear", "fitness", "food",
        "forgiveness", "freedom", "friendship", "funny", "future", "god", "good",
        "government", "graduation", "great", "happiness", "health", "history",
        "home", "hope", "humor", "imagination", "inspirational", "intelligence",
        "jealousy", "knowledge", "leadership", "learning", "legal", "life", "love",
        "marriage", "medical", "men", "mom", "money", "morning", "movies", "success"
    ]
    var quotes: [Quote] = []
    
    //MARK: - UI Elements
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "categoryCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    //MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].capitalized
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        QuotesService().fetchQuotes(category: category) { [weak self] quotes, error in
            guard let self = self, let quotes = quotes, !quotes.isEmpty, error == nil else {
                print(error?.localizedDescription ?? "An error occurred")
                return
            }

            ImageService().fetchImage { [weak self] image in
                DispatchQueue.main.async {
                    let detailVC = DetailViewController()
                    let quote = quotes.first!.quote
                    detailVC.configure(with: quote, image: image)
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                }
            }
        }
    }
}



