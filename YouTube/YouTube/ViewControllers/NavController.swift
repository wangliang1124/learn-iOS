//
//  NavController.swift
//  YouTube
//
//  Created by 王亮 on 2022/11/22.
//

import UIKit

class NavController: UINavigationController, PlayerVCDelegate {
    let names = ["Home", "Trending", "Subscriptions", "Account"]
    let hiddenOrigin: CGPoint = {
        let y = UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 9 / 32) - 10
        let x = -UIScreen.main.bounds.width
        return CGPoint(x: x, y: y)
    }()
    
    let minimizedOrigin: CGPoint = {
        let x = UIScreen.main.bounds.width / 2 - 10
        let y = UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 9 / 32) - 10

        return CGPoint(x: x, y: y)
    }()
    
    let fullScreenOrigin = CGPoint(x: 0, y: 0)
    
    lazy var settingsButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "navSettings"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(showSetting), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var searchButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "navSearch"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(showSearch), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = self.names.first
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var settingsView = SettingsView()
    
    var playerView = PlayerView()
    
    var searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeTitle), name: Notification.Name("scrollMenu"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let window = UIApplication.shared.currentWindow {
            window.addSubview(self.playerView)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        self.navigationBar.addSubview(settingsButton)
        self.navigationBar.addSubview(searchButton)
        self.navigationBar.addSubview(titleLabel)

//        navigationBar.barTintColor = UIColor.rgb(r: 228, g: 34, b: 24)
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
//        navigationItem.hidesBackButton = false
//        navigationBar.backgroundColor = .yellow
        // solution 1
//        navigationBar.isTranslucent = false
//        view.backgroundColor = UIColor.rgb(r: 228, g: 34, b: 24)
        
        // solution 2
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.rgb(r: 228, g: 34, b: 24)
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
//        navigationBar.compactAppearance = navigationBar.standardAppearance

        // settingButton
        NSLayoutConstraint.activate([
            settingsButton.heightAnchor.constraint(equalTo: navigationBar.heightAnchor),
            settingsButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -10),
            settingsButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor)
            
        ])
        
        // searchButton
        NSLayoutConstraint.activate([
            searchButton.heightAnchor.constraint(equalTo: navigationBar.heightAnchor),
            searchButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor),
            searchButton.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -10),
            searchButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor)
            
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalTo: navigationBar.heightAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor)
            
        ])
        
        // settingsView
        self.view.addSubview(self.settingsView)
//        self.view.backgroundColor = .blue
        settingsView.translatesAutoresizingMaskIntoConstraints = false
//        settingsView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        settingsView.isHidden = true
        
        // searchView
        searchView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchView)
        searchView.isHidden = true
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        //PLayerView setup
        self.playerView.frame = CGRect(origin: self.hiddenOrigin, size: UIScreen.main.bounds.size)
        self.playerView.delegate = self
    }
    
    @objc
    func changeTitle() {
        
    }
    
    @objc
    func showSetting() {
        self.settingsView.isHidden = false
        self.settingsView.tableViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.settingsView.backgroundView.alpha = 0.5
            self.settingsView.layoutIfNeeded()
        }
    }
    
    @objc
    func showSearch() {
        self.searchView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.searchView.alpha = 1
        }, completion: { _ in
            
            
        })
        
    }
    
    
    // MARK: -PlayerVCDelegate
    func didMinimize() {
        self.animatePlayView(toState: .minimized)
    }
    
    func didMaximize() {
        self.animatePlayView(toState: .fullScreen)
    }
    
    func swipeToMinimize(translation: CGFloat, toState: StateOfVC) {
        switch toState {
        case .fullScreen:
            self.playerView.frame.origin = self.positionDuringSwipe(scaleFactor: translation)
        case .hidden:
            self.playerView.frame.origin.x = UIScreen.main.bounds.width / 2 - abs(translation) - 10
        case .minimized:
            self.playerView.frame.origin = self.positionDuringSwipe(scaleFactor: translation)
        }
    }
    
    func positionDuringSwipe(scaleFactor: CGFloat) -> CGPoint {
        let width = UIScreen.main.bounds.width * 0.5 * scaleFactor
        let height = width * 9 / 16
        let x = (UIScreen.main.bounds.width - 10) * scaleFactor - width
        let y = (UIScreen.main.bounds.height - 10) * scaleFactor - height
        
        return CGPoint(x: x, y: y)
    }
    
    func didEndedSwipe(toState: StateOfVC) {
        self.animatePlayView(toState: toState)
    }
    
    func setPreferStatusBarHidden(_ preferHidden: Bool) {
        self.isHidden = preferHidden
    }
    
    var isHidden = true {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func animatePlayView(toState: StateOfVC) {
        switch toState {
        case .fullScreen:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [.beginFromCurrentState], animations: {
                self.playerView.frame.origin = self.fullScreenOrigin
            })
        case .minimized:
            UIView.animate(withDuration: 0.3, animations: {
                self.playerView.frame.origin = self.minimizedOrigin
            })
        case .hidden:
            UIView.animate(withDuration: 0.3, animations: {
                self.playerView.frame.origin = self.hiddenOrigin
            })
        }
    }
}


extension NavController {
    override var childForStatusBarStyle: UIViewController? {
        visibleViewController
    }
}
