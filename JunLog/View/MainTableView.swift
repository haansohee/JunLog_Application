//
//  MainTableView.swift
//  JunLog
//
//  Created by 한소희 on 2023/08/08.
//

import UIKit

final class MainTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTableView {
    private func attribute() {
        self.backgroundColor = .systemBackground
        self.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        self.separatorStyle = .singleLine
        self.rowHeight = 70
    }
}
