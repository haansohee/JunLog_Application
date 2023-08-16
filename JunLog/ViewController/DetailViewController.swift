//
//  DetailViewController.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/11.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    enum ViewType {
        case write
        case read
    }
    
    private var updateButton: UIBarButtonItem?
    
    private let detailView = DetailView()
    private var viewType: ViewType
    private let viewModel: DetailViewModel
    
    init(data: LogWriteData? = nil) {
        self.viewModel = DetailViewModel()
        viewType = data != nil ? .read : .write
        
        super.init(nibName: nil, bundle: nil)
        
        configureDetailView(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDetailView()
        configureBarButtonItem()
    }
}

extension DetailViewController {
    private func setupDetailView() {
        title = "쭌이 로그"
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        
        detailView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureDetailView(data: LogWriteData? = nil) {
        switch viewType {
        case .read:
            guard let data = data else { return } // data가 있는 경우에만
            detailView.titleTextField.text = data.title
            detailView.contentTextView.text = data.content
            
        case .write:
            detailView.datePicker.isEnabled = true
            detailView.contentTextView.isEditable = true
            detailView.titleTextField.isEnabled = true
            detailView.titleTextField.text = ""
            detailView.titleTextField.placeholder = "제목을 입력해 주세요"
            detailView.contentTextView.text = ""
        }
    }
    
    private func configureBarButtonItem() {
        let title = self.viewType == .read ? "수정하기" : "등록하기"
        self.updateButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector (updateButtonTapped(_:)))
        navigationItem.rightBarButtonItem = updateButton
    }
    
    @objc private func updateButtonTapped(_ sender: UIBarButtonItem) {
        switch self.viewType {
        case .read:
            print("read")
            
        case .write:
            guard let title = detailView.titleTextField.text else { return }
            guard let content = detailView.contentTextView.text else { return }
            
            viewModel.uploadLog(title: title, content: content, date: detailView.datePicker.date)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
