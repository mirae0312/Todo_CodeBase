//
//  ProfileViewController.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 2/1/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    // 사용자 이름을 표시할 UILabel
    private let nameLabel = UILabel()
    // 사용자 나이를 표시할 UILabel
    private let ageLabel = UILabel()

    // 사용자 데이터를 저장할 인스턴스
    let user = UserProfile(userName: "르탄이", userAge: 20, bio: "", link: "", postsCount: 0, followersCount: 0, followingCount: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // 배경색을 흰색으로 설정

        setupNameLabel() // 이름 레이블 설정 메소드 호출
        setupAgeLabel() // 나이 레이블 설정 메소드 호출
        bindUserData() // 사용자 데이터 바인딩 메소드 호출
    }

    // 이름 레이블을 설정하는 메소드
    private func setupNameLabel() {
        nameLabel.textAlignment = .center // 텍스트 중앙 정렬
        nameLabel.textColor = .black // 텍스트 색상 설정
        view.addSubview(nameLabel) // nameLabel을 뷰의 서브뷰로 추가
        
        nameLabel.snp.makeConstraints { make in
            // 오토레이아웃 제약 조건 설정
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20) // 상단 여백 설정
            make.centerX.equalToSuperview() // 가로축 중앙 정렬
            make.left.right.equalToSuperview().inset(20) // 좌우 여백 설정
        }
    }

    // 나이 레이블을 설정하는 메소드
    private func setupAgeLabel() {
        ageLabel.textAlignment = .center // 텍스트 중앙 정렬
        ageLabel.textColor = .black // 텍스트 색상 설정
        view.addSubview(ageLabel) // ageLabel을 뷰의 서브뷰로 추가
        
        ageLabel.snp.makeConstraints { make in
            // 오토레이아웃 제약 조건 설정
            make.top.equalTo(nameLabel.snp.bottom).offset(20) // nameLabel 아래에 위치
            make.centerX.equalToSuperview() // 가로축 중앙 정렬
            make.left.right.equalToSuperview().inset(20) // 좌우 여백 설정
        }
    }

    // 사용자 데이터를 UILabels에 바인딩하는 메소드
    private func bindUserData() {
        nameLabel.text = "Name: \(user.userName)" // 사용자 이름 표시
        ageLabel.text = "Age: \(user.userAge)" // 사용자 나이 표시
    }
}
