//
//  TaskCollectionViewCell.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 2/1/24.
//

import UIKit

// 할 일 목록의 각 항목을 표시하는 컬렉션 뷰 셀
class TaskCollectionViewCell: UICollectionViewCell {
    // 수정과 삭제 버튼 액션을 위한 클로저
    var editButtonAction: (() -> Void)?
    var deleteButtonAction: (() -> Void)?

    // 셀 내의 UI 컴포넌트
    private let titleLabel = UILabel()
    private let editButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI() // UI 초기 설정
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 버튼 위치와 크기 조정
        editButton.frame = CGRect(x: contentView.frame.width - 100, y: (contentView.frame.height - 30) / 2, width: 40, height: 30)
        deleteButton.frame = CGRect(x: contentView.frame.width - 50, y: (contentView.frame.height - 30) / 2, width: 40, height: 30)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // 셀 재사용 준비. 필요한 초기화 코드 여기에 작성
    }

    // UI 구성 메소드
    private func setupUI() {
        // 타이틀 레이블 설정
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true

        // 수정 버튼 설정
        editButton.setTitle("Edit", for: .normal)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        contentView.addSubview(editButton)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        // 삭제 버튼 설정
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        contentView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -10).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

    // 수정 버튼 클릭 시 호출되는 메소드
    @objc private func editButtonTapped() {
        editButtonAction?() // 클로저 실행
    }

    // 삭제 버튼 클릭 시 호출되는 메소드
    @objc private func deleteButtonTapped() {
        deleteButtonAction?() // 클로저 실행
    }

    // 셀 구성 메소드: Task 객체와 편집 상태에 따라 UI 업데이트
    func configure(with task: Task, isEditing: Bool) {
        titleLabel.text = task.title // 타이틀 설정
        editButton.isHidden = !isEditing // 편집 상태에 따라 수정 버튼 숨김/표시
        deleteButton.isHidden = !isEditing // 편집 상태에 따라 삭제 버튼 숨김/표시
    }
    
    // 수정 및 삭제 버튼 숨김 메소드
    func hideButtons() {
        editButton.isHidden = true
        deleteButton.isHidden = true
    }
    
    // 수정 및 삭제 버튼 표시 메소드
    func showButtons() {
        editButton.isHidden = false
        deleteButton.isHidden = false
    }
}
