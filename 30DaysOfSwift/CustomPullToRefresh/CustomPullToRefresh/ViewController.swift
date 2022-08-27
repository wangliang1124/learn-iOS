//
//  ViewController.swift
//  CustomPullToRefresh
//
//  Created by 王亮 on 2022/8/8.
//

import UIKit

class ViewController: UIViewController {
    var dataArray = ["😂", "🤗", "😳", "😌", "😊"]
    var labelsArray = [UILabel]()
    var isAnimating = false
    var timer: Timer!
    var currentColorIndex = 0
    var currentLabelIndex = 0
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .yellow
        return tableView
    }()
    
    lazy var refreshControlLabels: UIStackView = {
        for char in "#30DAYSSWIFT" {
            let label = UILabel()
            label.text = String(char)
            label.textColor = .darkGray
            label.textAlignment = .center
            labelsArray.append(label)
        }
        
        let stackView = UIStackView(arrangedSubviews: labelsArray)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        refreshControl.tintColor = .clear
//        refreshControl.translatesAutoresizingMaskIntoConstraints = false // 如果添加这行，就会有布局问题
        
        refreshControl.addSubview(refreshControlLabels)
        
        NSLayoutConstraint.activate([
            refreshControlLabels.centerXAnchor.constraint(equalTo: refreshControl.centerXAnchor),
            refreshControlLabels.centerYAnchor.constraint(equalTo: refreshControl.centerYAnchor),
            refreshControlLabels.leadingAnchor.constraint(equalTo: refreshControl.leadingAnchor, constant: 20),
//            refreshControlLabels.topAnchor.constraint(equalTo: refreshControl.topAnchor, constant: 0)
        ])
        
        return refreshControl
        
        
//        class CustomRefreshControl: UIRefreshControl {
//            init(subview: UIView) {
//                super.init(frame: .zero)
//
//                tintColor = .clear
//                backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
//
//                addSubview(subview)
//
//                NSLayoutConstraint.activate([
//                    subview.centerXAnchor.constraint(equalTo: centerXAnchor),
//                    subview.centerYAnchor.constraint(equalTo: centerYAnchor),
//                    subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//                    subview.topAnchor.constraint(equalTo: topAnchor, constant: 0)
//                ])
//            }
//
//            required init?(coder: NSCoder) {
//                fatalError("init(coder:) has not been implemented")
//            }
//        }
//
//        return CustomRefreshControl(subview: self.refreshControlLabels)
    }()
    
    override func loadView() {
        self.view = tableView
        tableView.refreshControl = refreshControl
        view.backgroundColor = .white
//        view.addSubview(refreshControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCellIdentifier")
    }
    
    
    func animateRefreshStep1() {
        isAnimating = true
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 4))
            self.labelsArray[self.currentLabelIndex].textColor = self.getNextColor()
        }, completion: { _ in
            UIView.animate(withDuration: 0.05, delay: 0, options: .curveLinear, animations: {
                self.labelsArray[self.currentLabelIndex].transform = .identity
                self.labelsArray[self.currentLabelIndex].textColor = .black
            }, completion: { _ in
                self.currentLabelIndex += 1
                if self.currentLabelIndex < self.labelsArray.count {
                    self.animateRefreshStep1()
                } else {
                    self.animateRefreshStep2()
                }
            })
        })
    }
    
    func animateRefreshStep2() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
            let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
            for label in self.labelsArray {
                label.transform = scale
            }
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
                for label in self.labelsArray {
                    label.transform = .identity
                }
            }, completion: { _ in
                if self.refreshControl.isRefreshing {
                    self.currentLabelIndex = 0
                    self.animateRefreshStep1()
                } else {
                    self.isAnimating = false
                    self.currentLabelIndex = 0
                    for label in self.labelsArray {
                        label.transform = .identity
                        label.textColor = .black
                    }
                }
            })
        })
    }
    
    func getNextColor() -> UIColor {
        let colors:[UIColor] = [.magenta, .brown, .yellow, .red, .blue, .green, .orange]
        if currentColorIndex == colors.count {
            currentColorIndex = 0
        }
        
        let color = colors[currentColorIndex]
        currentColorIndex += 1
        return color
    }
    
    func fetchData() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(endedOfWork), userInfo: nil, repeats: true)
    }
    
    @objc func endedOfWork() {
        refreshControl.endRefreshing()
        timer.invalidate()
        timer = nil
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshControl.isRefreshing {
            if !isAnimating {
                fetchData()
                animateRefreshStep1()
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellIdentifier", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
}
