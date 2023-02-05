//
//  SearchView.swift
//  YouTube
//
//  Created by 王亮 on 2022/11/22.
//

import UIKit

class SearchView: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    let inputField = {
        let textField = UITextField()
        textField.placeholder = "search"
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var inputWrapper = {
        let view = UIView()
        view.addSubview(inputField)

        view.backgroundColor = .blue
        NSLayoutConstraint.activate([
            inputField.topAnchor.constraint(equalTo: view.topAnchor),
            inputField.heightAnchor.constraint(equalToConstant: 48),
            inputField.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        return tableView
    }()
    
    var suggestions = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        inputField.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        setupUI()
    }
    
    func setupUI() {
        self.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
//        self.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(hideSearchView))
//        self.addGestureRecognizer(tap)
        
        let backgroundView = UIButton()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addTarget(self, action: #selector(hideSearchView), for: .touchUpInside)

        self.addSubview(backgroundView)
        self.addSubview(inputWrapper)
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor),

            inputWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            inputWrapper.widthAnchor.constraint(equalTo: self.widthAnchor),
            inputWrapper.heightAnchor.constraint(equalToConstant: 48),
            
            tableView.topAnchor.constraint(equalTo: inputWrapper.bottomAnchor),
//            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 300),
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func hideSearchView() {
        self.inputField.text = ""
        self.suggestions.removeAll()
        self.inputField.resignFirstResponder()
        self.tableView.isHidden = true
        self.tableView.reloadData()
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { _ in
            self.isHidden = true
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.suggestions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.inputField.text = self.suggestions[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hideSearchView()
        return true
    }
    
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            self.suggestions.removeAll()
            self.tableView.isHidden = true
            return true
        }
        
        if let query = text.addingPercentEncoding(withAllowedCharacters: CharacterSet()),
           let url = URL(string: "https://api.bing.com/osjson.aspx?query=\(query)") {
            let session = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                guard let weakSelf = self else {
                    return
                }
                
                guard error == nil else {
                    return
                }
                
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                   let res = json as? [Any],
                   let suggestions = res[1] as? [String] {
                    DispatchQueue.main.async {
                        weakSelf.suggestions = suggestions
                        if weakSelf.suggestions.count > 0 {
                            weakSelf.tableView.reloadData()
                            weakSelf.tableView.isHidden = false
                        } else {
                            weakSelf.tableView.isHidden = true
                        }
                    }
                }
            })
            session.resume()
        }
        
        return true
    }
    
}

