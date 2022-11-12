//
//  ViewController.swift
//  Orientation
//
//  Created by 王亮 on 2022/11/9.
//

import UIKit

class ViewController: UIViewController {
    var contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
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
        self.title = "Test"
        
        
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
        updateOrientation(orientationMask: .landscape)
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
    
    
//    ios 16.0 已废弃
//    override var shouldAutorotate: Bool {
//        return false
//    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .all
//    }
    
    func updateOrientation(orientationMask: UIInterfaceOrientationMask) {
        if #available(iOS 16.0, *) {
            DispatchQueue.main.async {
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                (self.navigationController as? MyUINavigationController)?.orientationMask = orientationMask
                self.setNeedsUpdateOfSupportedInterfaceOrientations()
                windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: orientationMask)) { error in
                    print(error)
                    print(windowScene?.effectiveGeometry)
                }
            }
        } else {
            UIDevice.current.setValue(orientationMask.orientation, forKey: "orieantation")
        }
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
