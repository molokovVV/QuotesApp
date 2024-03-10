//
//  SceneDelegate.swift
//  QuotesApp
//
//  Created by Виталик Молоков on 04.03.2024.
//

import UIKit
import SnapKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: SegmentSwitchViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

