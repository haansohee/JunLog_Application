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
        
        detailView.titleTextView.delegate = self
        detailView.contentTextView.delegate = self
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
            detailView.titleTextView.text = data.title
            detailView.titleTextView.textColor = .label
            detailView.contentTextView.text = data.content
            detailView.contentTextView.textColor = .label
            
        case .write:
            detailView.datePicker.isEnabled = true
            
            detailView.contentTextView.isEditable = true
            detailView.contentTextView.text = "내용을 입력하세요. (300자 이내)"
            detailView.contentTextView.textColor = .placeholderText
            
            detailView.titleTextView.isEditable = true
            detailView.titleTextView.text = "제목을 입력하세요. (15자 이내)"
            detailView.titleTextView.textColor = .placeholderText
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
            guard let title = detailView.titleTextView.text else { return }
            guard let content = detailView.contentTextView.text else { return }
            
            viewModel.uploadLog(title: title, content: content, date: detailView.datePicker.date)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: TextView Delegate
extension DetailViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let titleMaxLength = 15
        let contentMaxLength = 300
        
        guard let titleText = detailView.titleTextView.text else { return }
        guard let contentText = detailView.contentTextView.text else { return }
        
        if contentText.count > contentMaxLength {
            textView.text = String(contentText.prefix(contentMaxLength))
        }
        
        if titleText.count > titleMaxLength {
            textView.text = String(titleText.prefix(titleMaxLength))
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        switch textView {
        case detailView.titleTextView:
            if detailView.titleTextView.textColor == .placeholderText {
                detailView.titleTextView.textColor = .label
                detailView.titleTextView.text = nil
            }
            
        case detailView.contentTextView:
            if detailView.contentTextView.textColor == .placeholderText {
                detailView.contentTextView.textColor = .label
                detailView.contentTextView.text = nil
            }
        default:
            print("Error")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView {
        case detailView.titleTextView:
            if detailView.titleTextView.text.isEmpty {
                detailView.titleTextView.text = "제목을 입력하세요. (15자 이내)"
                detailView.titleTextView.textColor = .placeholderText
            }
            
        case detailView.contentTextView:
            if detailView.contentTextView.text.isEmpty {
                detailView.contentTextView.text = "내용을 입력하세요. (300자 이내)"
                detailView.contentTextView.textColor = .placeholderText
            }
            
        default:
            print("Error")
        }
    }
}
