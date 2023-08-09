//
//  WriteViewController.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/08.
//

import UIKit
import SnapKit

final class WriteViewController: UIViewController {
    private let writeView = WriteView()
    
    private let titleTextField: UITextField
    private let contentTextView: UITextView
    
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
        
        titleTextField.delegate = self
        contentTextView.delegate = self
    }
    
    private func layout() {
        writeView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension WriteViewController: UITextFieldDelegate {
    
}

extension WriteViewController: UITextViewDelegate {
    
}
