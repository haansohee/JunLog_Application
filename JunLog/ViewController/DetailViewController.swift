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
    
    private var barButtonItem: UIBarButtonItem?
    
    private let detailView = DetailView()
    private var viewType: ViewType
    private let viewModel: DetailViewModel
    
    private let titlePlaceholder = "제목을 입력하세요. (15자 이내)"
    private let contentPlaceholder = "내용을 입력하세요. (300자 이내)"
    private var id = 0
    
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
            guard let data = data else { return }
            detailView.titleTextView.text = data.title
            detailView.titleTextView.textColor = .label
            
            detailView.contentTextView.text = data.content
            detailView.contentTextView.textColor = .label
            
            detailView.datePicker.date = viewModel.convertStringToDate(date: data.date)
            
            self.id = data.id
            
        case .write:
            detailView.datePicker.isEnabled = true
            
            detailView.titleTextView.isEditable = true
            detailView.titleTextView.text = titlePlaceholder
            detailView.titleTextView.textColor = .placeholderText
            
            detailView.contentTextView.isEditable = true
            detailView.contentTextView.text = contentPlaceholder
            detailView.contentTextView.textColor = .placeholderText
        }
    }
    
    private func configureBarButtonItem() {
        let title = self.viewType == .read ? "수정하기" : "등록하기"
        self.barButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector (barButtonItemTapped(_:)))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func configurePlaceholder(with textView: UITextView, isEmpty: Bool) {
        guard isEmpty else {
            textView.text = ""
            textView.textColor = .label
            return
        }
        
        if textView == detailView.titleTextView {
            textView.text = self.titlePlaceholder
        } else {
            textView.text = self.contentPlaceholder
        }
        
        textView.textColor = .placeholderText
    }
    
    @objc private func barButtonItemTapped(_ sender: UIBarButtonItem) {
        switch self.viewType {
        case .read:
            detailView.datePicker.isEnabled = true
            detailView.titleTextView.isEditable = true
            detailView.contentTextView.isEditable = true
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정완료", style: .plain, target: self, action: #selector (accessLog))
            
        case .write:
            accessLog()
        }
    }
    
    @objc private func accessLog() {
        var alertMessage = "수정할까요?"
        var alertTitle = "수정하기"
        
        if viewType == .write {
            alertMessage = "업로드 할까요?"
            alertTitle = "업로드"
        }
        
        guard let title = detailView.titleTextView.text else { return }
        guard let content = detailView.contentTextView.text else { return }

        let alert = UIAlertController(title: "쭌로그", message: alertMessage, preferredStyle: .alert)
        
        let confirmAlert = UIAlertAction(title: alertTitle, style: .default) {[weak self] _ in
            guard let date = self?.detailView.datePicker.date,
                  let titlePlaceholder = self?.titlePlaceholder,
                  let contentPlaceholder = self?.contentPlaceholder,
                  let id = self?.id else { return }

            let junLogContent = JunLogContent(
                title: title,
                content: content,
                date: date,
                titlePlaceholder: titlePlaceholder,
                contentPlaceholder: contentPlaceholder
            )
            
            switch self?.viewType {
            case .read:
                self?.viewModel.updateLog(with: junLogContent, id: id)
                
            case .write:
                self?.viewModel.uploadLog(with: junLogContent)
                
            case .none:
                print("ERROR")
            }

            self?.navigationController?.popViewController(animated: true)
        }

        let cancelAlert = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(confirmAlert)
        alert.addAction(cancelAlert)

        present(alert, animated: true, completion: nil)
    }
}

//MARK: TextView Delegate
extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .placeholderText else { return }
        configurePlaceholder(with: textView, isEmpty: false)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.isEmpty else { return }
        configurePlaceholder(with: textView, isEmpty: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            configurePlaceholder(with: textView, isEmpty: true)
        } else if textView.textColor == .placeholderText {
            configurePlaceholder(with: textView, isEmpty: false)
        }
        
        let titleMaxLength = 15
        let contentMaxLength = 300
        
        switch textView {
        case detailView.titleTextView:
            if textView.text.count > titleMaxLength {
                textView.text = String(textView.text.prefix(titleMaxLength))
            }
            
        case detailView.contentTextView:
            if textView.text.count > contentMaxLength {
                textView.text = String(textView.text.prefix(contentMaxLength))
            }
            
        default:
            print("ERROR:")
        }
    }
}
