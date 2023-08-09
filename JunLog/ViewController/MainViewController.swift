//
//  MainViewController.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/08.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "날짜순", style: .plain, target: self, action: #selector(buttonTapped(_:)))
        button.tag = 1
        
        return button
    }()
    
    private lazy var uploadButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "업로드", style: .plain, target: self, action: #selector(buttonTapped(_:)))
        button.tag = 2
        
        return button
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: #selector(buttonTapped(_:)))
        button.tag = 3
        
        return button
    }()
    
    private let mainTableView = MainTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
}

extension MainViewController {
    private func attribute() {
        title = "쭌이 로그"
        navigationItem.leftBarButtonItem = sortButton
        navigationItem.rightBarButtonItem = uploadButton
        navigationItem.backBarButtonItem = backButton
        view.backgroundColor = .systemBackground
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
    }
    
    private func layout() {
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func buttonTapped(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 1:
            print("날짜 정렬")
            
        case 2:
            self.navigationController?.pushViewController(WriteViewController(), animated: true)
            
        case 3:
            self.navigationController?.popViewController(animated: true)
            
        default:
            print("Error")
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
}
