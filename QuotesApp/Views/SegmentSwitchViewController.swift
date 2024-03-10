//
//  BaseViewController.swift
//  QuotesApp
//
//  Created by Виталик Молоков on 05.03.2024.
//

import UIKit

class SegmentSwitchViewController: UIViewController {
    
    //MARK: - Properties
    
    private let segmentedControl = UISegmentedControl(items: ["Quotes", "Jokes", "Chuck Norris"])
    private var currentViewController: UIViewController?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        switchViewController(segmentedControl)
    }
    
    //MARK: - Setups
    
    private func setupSegmentedControl() {
        navigationItem.titleView = segmentedControl
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .darkGray
        segmentedControl.selectedSegmentTintColor = UIColor.black

        // Установка цвета текста для названий сегментов
        let normalTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray] // Для неактивных сегментов
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white] // Для активного сегмента

        segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.addTarget(self, action: #selector(switchViewController), for: .valueChanged)
    }
    
    //MARK: - Actions
    
    @objc private func switchViewController(_ sender: UISegmentedControl) {
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParent()
        
        switch sender.selectedSegmentIndex {
        case 0:
            let quotesVC = MainViewController()
            addChild(quotesVC)
            view.addSubview(quotesVC.view)
            quotesVC.view.frame = view.bounds
            currentViewController = quotesVC
        case 1:
            let jokesVC = JokesViewController()
            addChild(jokesVC)
            view.addSubview(jokesVC.view)
            jokesVC.view.frame = view.bounds
            currentViewController = jokesVC
        case 2:
            let chuckNorrisVC = ChuckNorrisViewController()
            addChild(chuckNorrisVC)
            view.addSubview(chuckNorrisVC.view)
            chuckNorrisVC.view.frame = view.bounds
            currentViewController = chuckNorrisVC
        default:
            break
        }
        currentViewController?.didMove(toParent: self)
    }
}

