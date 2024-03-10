//
//  JokesViewController.swift
//  QuotesApp
//
//  Created by Виталик Молоков on 05.03.2024.
//

import UIKit

class JokesViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private lazy var jokeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get New Joke", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(fetchJoke), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        fetchJoke()
    }
    
    //MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .black
    }
    
    private func setupHierarchy() {
        view.addSubview(jokeLabel)
        view.addSubview(refreshButton)
    }

    private func setupLayout() {
        jokeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalTo(view.layoutMarginsGuide)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    //MARK: - Actions
    
    @objc private func fetchJoke() {
        JokesService().fetchJoke { [weak self] joke, error in
            DispatchQueue.main.async {
                if let joke = joke {
                    self?.jokeLabel.text = joke
                } else {
                    self?.jokeLabel.text = "Could not load a joke. Try again."
                }
            }
        }
    }
}

