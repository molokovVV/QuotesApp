//
//  DetailViewController.swift
//  QuotesApp
//
//  Created by Виталик Молоков on 05.03.2024.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var quoteText: String?
    var image: UIImage?
    
    //MARK: - UI Elements
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.text = quoteText
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        return imageView
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
    }
    
    private func setupHierarchy() {
        view.addSubview(imageView)
        view.addSubview(quoteLabel)
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(imageView.snp.width)
        }
        
        quoteLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    //MARK: - Methods
    
    func configure(with quote: String, image: UIImage?) {
        self.quoteText = quote
        self.image = image
    }
}
