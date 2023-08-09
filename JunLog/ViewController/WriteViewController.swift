//
//  WriteViewController.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/08.
//

import UIKit
import SnapKit
import RealmSwift

final class WriteViewController: UIViewController {
    private let writeView = WriteView()
    
    private let titleTextField: UITextField
    private let contentTextView: UITextView
    
    private lazy var uploadButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "등록", style: .plain, target: self, action: #selector(uploadButtonTapped(_:)))
        
        return button
    }()
    
    init() {
        self.titleTextField = writeView.titleTextField
        self.contentTextView = writeView.contentTextView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
}

extension WriteViewController {
    private func attribute() {
        view.addSubview(writeView)
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = uploadButton
        
        titleTextField.delegate = self
        contentTextView.delegate = self
    }
    
    private func layout() {
        writeView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func uploadButtonTapped(_ sender: UIBarButtonItem) {
        
    }
}

extension WriteViewController: UITextFieldDelegate {
    
}

extension WriteViewController: UITextViewDelegate {
    
}
