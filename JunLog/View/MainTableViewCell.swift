//
//  MainTableViewCell.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/08.
//

import UIKit
import SnapKit

final class MainTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트 제목"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        label.numberOfLines = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트 날짜"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTableViewCell {
    private func layout() {
        [
            titleLabel,
            dateLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.trailing.equalToSuperview().offset(-8)
            $0.width.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.trailing.equalTo(dateLabel.snp.leading).offset(-8)
        }
    }
}
