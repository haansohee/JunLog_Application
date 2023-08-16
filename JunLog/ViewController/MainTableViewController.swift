//
//  MainTableViewController.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/08.
//

import UIKit
import SnapKit
import RxSwift

final class MainTableViewController: UITableViewController {
    private let viewModel: MainTableViewModel
    
    private var sortButton: UIBarButtonItem?
    private var uploadButton: UIBarButtonItem?
    
    init() {
        self.viewModel = MainTableViewModel()
        super.init(nibName: nil, bundle: nil)
        viewModel.getData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBarButtonItem()
        setupView()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MainTableViewController {
    private func configureBarButtonItem() {
        self.sortButton = UIBarButtonItem(title: "날짜순", style: .plain, target: self, action: #selector (didSelectBarButton(_:)))
        self.sortButton?.tag = 1
        
        self.uploadButton = UIBarButtonItem(title: "업로드", style: .plain, target: self, action: #selector (didSelectBarButton(_:)))
        self.uploadButton?.tag = 2
        
        navigationItem.leftBarButtonItem = sortButton
        navigationItem.rightBarButtonItem = uploadButton
    }
    
    private func setupView() {
        title = "쭌이 로그"
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        tableView.separatorStyle = .singleLine
    }
    
    @objc private func didSelectBarButton(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 1:
            print("날짜 정렬")
            
        case 2:
            let viewController = DetailViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            
        default:
            print("Error")
        }
    }
}

extension MainTableViewController {
    //MARK: DataSource
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.logWriteData.count)
        return viewModel.logWriteData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = viewModel.logWriteData[indexPath.row].title
        cell.dateLabel.text = viewModel.logWriteData[indexPath.row].date
        
        return cell
    }
    
    //MARK: Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.logWriteData[indexPath.row]
        let viewController = DetailViewController(data: data)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteData(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
