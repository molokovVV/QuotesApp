//
//  ChuckNorrisViewController.swift
//  QuotesApp
//
//  Created by Виталик Молоков on 05.03.2024.
//

import UIKit
import SnapKit

class ChuckNorrisViewController: UIViewController {
    
    //MARK: - UI Elements
    private lazy var jokeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
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
        setupLayouts()
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
    
    private func setupLayouts() {
        jokeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }

        refreshButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20) // Отступ от нижней части safe area
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    //MARK: - Actions
    
    @objc private func fetchJoke() {
        NorrisService().fetchChuckNorrisJoke { [weak self] joke, error in
            DispatchQueue.main.async {
                if let joke = joke {
                    self?.jokeLabel.text = joke
                } else {
                    self?.jokeLabel.text = "Failed to load joke."
                }
            }
        }
    }
}


