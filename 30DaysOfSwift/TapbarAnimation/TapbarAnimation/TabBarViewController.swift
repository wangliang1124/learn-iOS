//
//  TabBarViewController.swift
//  TapbarAnimation
//
//  Created by 王亮 on 2022/8/14.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemTeal
        tabBar.backgroundColor = .white
        setupVCs()
    }

    func setupVCs(){
        // Create Tab one
        let firstTab = FirstTabViewController()
        firstTab.tabBarItem = UITabBarItem(title: "FriendRead", image: UIImage(named: "tabbarHomeHighlighted"), selectedImage: UIImage(named: "tabbarHomeHighlighted"))
        
        // Create Tab two
        let secondTab = SecondTabViewController()
        secondTab.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(named: "tabbarExploreHighlighted"), selectedImage: UIImage(named: "tabbarExploreHighlighted"))
        
        // Create Tab three
        let thirdTab = ThirdViewController()
        thirdTab.tabBarItem = UITabBarItem(title: "ReadLater", image: UIImage(named: "tabbarProfileHighlighted"), selectedImage: UIImage(named: "tabbarProfileHighlighted"))
        
        
        viewControllers = [firstTab, secondTab, thirdTab]
    }
    
    // Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}

