//
//  DetailView.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/11.
//

import UIKit
import SnapKit

final class DetailView: UIView {
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20, weight: .bold)
        textField.textColor = .label
        textField.isEnabled = false
        textField.textAlignment = .left
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.isEnabled = false
        
        return datePicker
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 20)
        textView.textAlignment = .left
        textView.textColor = .label
        textView.backgroundColor = .systemBackground
        textView.layer.borderColor = UIColor.label.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 10

        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailView {
    private func layout() {
        [
            titleTextField,
            datePicker,
            contentTextView
        ].forEach {
            addSubview($0)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.leading.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-8)
            $0.height.equalTo(50)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-8)
            $0.height.equalTo(30)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(8)
            $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).offset(-8)
        }
    }}
