////
////  ProfileDesignView.swift
////  TodoList_CodeBaseUI
////
////  Created by mirae on 1/31/24.
////
//
//import UIKit
//import SnapKit
//
//class ProfileDesignView: UIView {
//    // UI 컴포넌트 선언
//    let titleLabel = UILabel()
//    let menuButton = UIButton()
//    let profileImageView = UIImageView()
//    let usernameLabel = UILabel()
//    let bioLabel = UILabel()
//    let linkLabel = UILabel()
//    let postsTextLabel = UILabel()
//    let followersTextLabel = UILabel()
//    let followingTextLabel = UILabel()
//    let postsCountLabel = UILabel()
//    let followersCountLabel = UILabel()
//    let followingCountLabel = UILabel()
//    let followButton = UIButton()
//    let messageButton = UIButton()
//    let moreButton = UIButton()
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//
//    // 초기화 및 레이아웃 설정
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .white // 배경색 설정
//        addSubviews() // 서브뷰 추가
//        setupLayouts() // 레이아웃 설정
//        configureCollectionView() // 컬렉션 뷰 구성
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // 모든 UI 컴포넌트를 뷰에 추가하는 메서드
//    private func addSubviews() {
//        [titleLabel, menuButton, profileImageView, usernameLabel, bioLabel,
//         linkLabel, postsTextLabel, followersTextLabel, followingTextLabel,
//         postsCountLabel, followersCountLabel, followingCountLabel,
//         followButton, messageButton, moreButton, collectionView].forEach { addSubview($0) }
//    }
//
//    // 각 UI 컴포넌트의 레이아웃을 설정하는 메서드
//    private func setupLayouts() {
//        // titleLabel 설정
//        titleLabel.setupProfileTitleLabel()
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide).offset(20)
//            make.centerX.equalToSuperview()
//        }
//        
//        // menuButton 설정
//        menuButton.setupMenuButton(alignedWith: titleLabel)
//        
//        // profileImageView 설정
//        profileImageView.setupProfileImageView(below: titleLabel)
//        
//        // usernameLabel 설정
//        usernameLabel.setupUsernameLabel(below: profileImageView)
//        
//        // bioLabel 설정
//        bioLabel.setupBioLabel(below: usernameLabel)
//        
//        // linkLabel 설정
//        linkLabel.setupLinkLabel(below: bioLabel)
//        
//        // statsStackView 설정
//        setupStatsStackView(below: profileImageView, alignedWith: usernameLabel)
//        
//        // actionButtonsStackView 설정
//        setupActionButtons(below: linkLabel)
//        
//        // collectionView 설정
//        setupCollectionViewConstraints(below: followButton)
//    }
//    
//    // 컬렉션 뷰 구성 메서드
//    private func configureCollectionView() {
//        collectionView.backgroundColor = .lightGray // 배경색 설정
//        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCollectionViewCell") // 셀 등록
//    }
//    
//    // 각 UI 컴포넌트의 레이아웃을 세부적으로 설정하는 메서드들
//    private func setupStatsStackView(below anchorView: UIView, alignedWith alignView: UIView) {
//        // statsStackView 설정
//        let statsStackView = UIStackView(arrangedSubviews: [postsCountLabel, followersCountLabel, followingCountLabel])
//        statsStackView.axis = .horizontal
//        statsStackView.distribution = .fillEqually
//        statsStackView.alignment = .center
//        addSubview(statsStackView)
//        statsStackView.snp.makeConstraints { make in
//            make.top.equalTo(anchorView.snp.bottom).offset(20)
//            make.leading.equalTo(alignView.snp.leading)
//            make.trailing.lessThanOrEqualToSuperview().offset(-20)
//            make.height.equalTo(50)
//        }
//    }
//
//    private func setupActionButtons(below anchorView: UIView) {
//        // actionButtonsStackView 설정
//        let actionButtonsStackView = UIStackView(arrangedSubviews: [followButton, messageButton, moreButton])
//        actionButtonsStackView.axis = .horizontal
//        actionButtonsStackView.distribution = .fillEqually
//        actionButtonsStackView.spacing = 10
//        addSubview(actionButtonsStackView)
//        actionButtonsStackView.snp.makeConstraints { make in
//            make.top.equalTo(anchorView.snp.bottom).offset(10)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(44)
//        }
//    }
//    
//    // 컬렉션 뷰의 제약조건 설정
//    private func setupCollectionViewConstraints(below anchorView: UIView) {
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
//    }
//}
//
//// UILabel, UIButton, UIImageView, UICollectionView에 대한 확장을 통해 세부 설정 메서드를 추가
//private extension UILabel {
//    func setupProfileTitleLabel() {
//        text = "Profile" // 타이틀 텍스트 설정
//        textColor = .black // 텍스트 색상 설정
//        font = UIFont.boldSystemFont(ofSize: 20) // 폰트 설정
//        textAlignment = .center // 텍스트 정렬 설정
//    }
//
//    func setupUsernameLabel(below anchorView: UIView) {
//        font = UIFont.boldSystemFont(ofSize: 17) // 폰트 설정
//        // 예제 제약조건 (상황에 따라 조정 필요)
//        translatesAutoresizingMaskIntoConstraints = false
//        topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10).isActive = true
//        leadingAnchor.constraint(equalTo: anchorView.leadingAnchor, constant: 20).isActive = true
//        trailingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: -20).isActive = true
//        // 추가적인 제약조건 설정...
//    }
//
//    func setupBioLabel(below anchorView: UIView) {
//        numberOfLines = 0 // 여러 줄 표시를 위해 설정
//        // 예제 제약조건 (상황에 따라 조정 필요)
//        translatesAutoresizingMaskIntoConstraints = false
//        topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10).isActive = true
//        leadingAnchor.constraint(equalTo: anchorView.leadingAnchor, constant: 20).isActive = true
//        trailingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: -20).isActive = true
//        // 추가적인 제약조건 설정...
//    }
//
//    func setupLinkLabel(below anchorView: UIView) {
//        textColor = .blue // 텍스트 색상 설정
//        // 예제 제약조건 (상황에 따라 조정 필요)
//        translatesAutoresizingMaskIntoConstraints = false
//        topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10).isActive = true
//        leadingAnchor.constraint(equalTo: anchorView.leadingAnchor, constant: 20).isActive = true
//        trailingAnchor.constraint(equalTo: anchorView.trailingAnchor, constant: -20).isActive = true
//        // 추가적인 제약조건 설정...
//    }
//}
//
//private extension UIButton {
//    func setupMenuButton(alignedWith anchorView: UIView) {
//        setImage(UIImage(named: "menu_icon"), for: .normal) // 버튼 이미지 설정, 'menu_icon'은 이미지 이름 예시
//        contentMode = .scaleAspectFill // 컨텐츠 모드 설정
//        // 예제 제약조건 (상황에 따라 조정 필요)
//        translatesAutoresizingMaskIntoConstraints = false
//        topAnchor.constraint(equalTo: anchorView.bottomAnchor, constant: 10).isActive = true
//        leadingAnchor.constraint(equalTo: anchorView.leadingAnchor, constant: 20).isActive = true
//        // 추가적인 제약조건 설정...
//    }
//}
