//
//  TestAViewController.swift
//  Orientation
//
//  Created by 王亮 on 2022/11/9.
//

import UIKit

class TestAViewController: UIViewController {
    lazy var contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        
        
        let buttonA = UIButton(type: .roundedRect)
        buttonA.setTitle("Change Orientation", for: .normal)
        buttonA.addTarget(self, action: #selector(changeOrientation), for: .touchUpInside)
        buttonA.backgroundColor = .orange
        buttonA.setTitleColor(.white, for: .normal)
        
        let buttonB = UIButton()
        buttonB.setTitle("Open B", for: .normal)
        buttonB.addTarget(self, action: #selector(openTestB), for: .touchUpInside)
        buttonB.backgroundColor = .orange
        
        let stackView = UIStackView(arrangedSubviews: [buttonA, buttonB])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
//        stackView.backgroundColor = .lightGray

        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        return view
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name:  UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        self.title = "TestA"
        
        
        view.addSubview(contentView)
        view.backgroundColor = .orange

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        printOrientation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIDevice.current.setOrientation(orientationMask: self.supportedInterfaceOrientations)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // 视图特征发生变化时会触发，比如页面方向发生变化(可以是通过代码触发而设备并没有真正变化)，
        // 而且如果 supportedInterfaceOrientations 只有一个方向的话，即使设备发生了旋转，也不会触发此回调。
        // 另外，主题颜色发生变化也会触发此回调。
//        print("previousTraitCollection: \(previousTraitCollection)")
        print(#function)
        printOrientation()
    }
    
    // iOS 16.0 之后不起作用
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
    
    func updateOrientation(orientationMask: UIInterfaceOrientationMask) {
        if #available(iOS 16.0, *) {
            (self.navigationController as? MyUINavigationController)?.orientationMask = orientationMask
            self.setNeedsUpdateOfSupportedInterfaceOrientations()
        }
        UIDevice.current.setOrientation(orientationMask: orientationMask)
    }
    // 设备旋转方向的时候会触发，刚打开时被触发了两次
    @objc func orientationChanged() {
        print(#function)
        printOrientation()
    }
    
    func printOrientation(){
        let orientation = UIDevice.current.orientation
        print("orientation: \(orientation)")
        print("screen width, height: \(UIScreen.main.bounds.width), \(UIScreen.main.bounds.height)")
        print(view.frame)
//        print("supportedOritation: \(navigationController?.supportedInterfaceOrientations)")
    }
    
    @objc func changeOrientation() {
//        let orientation = UIApplication.shared.statusBarOrientation // 'statusBarOrientation' was deprecated in iOS 13.0:
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let orientation = windowScene?.interfaceOrientation
//        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            updateOrientation(orientationMask: .portrait)
        } else {
            updateOrientation(orientationMask: .landscape)
        }
    }
    
    @objc func openTestB(){
        let vc = TestBViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
//        navigationController?.present(vc, animated: true)
    }
}

extension UIInterfaceOrientationMask {
    var orientation: UIInterfaceOrientation {
        switch self {
        case .portrait:
            return UIInterfaceOrientation.portrait
        case .landscapeLeft, .landscape:
            return UIInterfaceOrientation.landscapeLeft
        case .landscapeRight:
            return UIInterfaceOrientation.landscapeRight
        case .portraitUpsideDown:
            return UIInterfaceOrientation.portraitUpsideDown
        default:
            return UIInterfaceOrientation.unknown
        }
    }
}

extension UIDevice {
    func setOrientation(orientationMask: UIInterfaceOrientationMask) {
        if #available(iOS 16.0, *) {
            DispatchQueue.main.async {
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: orientationMask)) { error in
                    print(error)
                    print(windowScene?.effectiveGeometry)
                }
            }
        } else {
//            let orientationRawValue = NSNumber(integerLiteral: orientationMask.orientation.rawValue)
//            UIDevice.current.setValue(orientationRawValue, forKey: "orientation")
            self.changeInterfaceOrientation(to: orientationMask.orientation)
        }
    }
}
