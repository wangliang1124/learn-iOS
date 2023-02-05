//
//  SettingsView.swift
//  YouTube
//
//  Created by 王亮 on 2022/11/22.
//

import UIKit

class SettingsView: UIView, UITableViewDelegate, UITableViewDataSource {
    let items = ["Settings", "Terms & privacy policy", "Send Feedback", "Help", "Switch Account", "Cancel"]
    
    var tableView: UITableView = UITableView()
    
    lazy var backgroundView: UIButton = {
        let btn = UIButton()
        btn.alpha = 0
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(hideSettingsView), for: .touchUpInside)
        btn.backgroundColor = .black
        return btn
    }()
    
    var tableViewBottomConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundView)
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: 288),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
        
        tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        tableViewBottomConstraint.constant = 288
        tableViewBottomConstraint.isActive = true
    }
    
    @objc func hideSettingsView() {
        self.tableViewBottomConstraint.constant = self.tableView.bounds.height
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            
            self.layoutIfNeeded()
        }, completion: { _ in
            self.isHidden = true
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.imageView?.image = UIImage(named: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.hideSettingsView()
    }
}
