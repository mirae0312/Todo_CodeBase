////
////  ProfileDesignUIViewController.swift
////  TodoList_CodeBaseUI
////
////  Created by mirae on 1/31/24.
////
//
//import Foundation
//import UIKit
//import SnapKit
//
//class ProfileDesignUIViewController: UIViewController {
//    // MARK: - Properties
//    // UI 컴포넌트 선언
//    let titleLabel = UILabel()
//    let menuButton = UIButton()
//    let profileImageView = UIImageView()
//    let usernameLabel = UILabel()
//    let bioLabel = UILabel()
//    let linkLabel = UILabel()
//    // 게시물, 팔로워, 팔로잉 수를 보여줄 레이블
//    let postsTextLabel = UILabel()
//    let followersTextLabel = UILabel()
//    let followingTextLabel = UILabel()
//    let postsCountLabel = UILabel()
//    let followersCountLabel = UILabel()
//    let followingCountLabel = UILabel()
//    // 팔로우 및 메시지 보내기 버튼
//    let followButton = UIButton()
//    let messageButton = UIButton()
//    let moreButton = UIButton()
//    // 사용자의 게시물을 보여줄 컬렉션 뷰
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white   // 뷰의 배경색을 흰색으로 설정
//        setupLayout()                   // UI 컴포넌트의 레이아웃을 설정하는 메서드 호출
//        configureCollectionView()       // 컬렉션 뷰를 구성하는 메서드 호출
//    }
//    
//    // MARK: - Setup
//    // UI 레이아웃 설정 메서드
//    private func setupLayout() {
//        setupTitleLabel()           // 상단 titleLabel 설정
//        setupMenuButton()           // 상단 Menu버튼 설정
//        setupProfileImageView()     // profileImageView 설정
//        setupUserProfileSection()   // 사용자 프로필 섹션(usernameLabel, bioLabel, bioLabel) 설정
//        setupStatsStackView()       // post, follower, following 정보를 보여주는 스택 뷰 설정
//        setupActionButtons()        // followButton 및 messageButton, moreButton 설정
//    }
//    
//    // titleLabel 설정 메서드
//    private func setupTitleLabel() {
//        view.addSubview(titleLabel)  // 뷰에 titleLabel 추가
//        titleLabel.text = "nabaecamp"  // titleLabel 텍스트 설정
//        titleLabel.textColor = UIColor.black  // 텍스트 색상 설정
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 20) // 글꼴 및 글꼴 크기 설정
//        titleLabel.textAlignment = .center  // 텍스트 정렬을 가운데로 설정
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)  // 상단 safe area로부터 20pt 아래에 위치하도록 설정
//            make.left.right.equalToSuperview()  // 좌우 여백 없이 뷰의 좌우에 꽉 차도록 설정
//        }
//    }
//    
//    // setupMenuButton 설정 메서드
//    private func setupMenuButton() {
//        menuButton.setImage(UIImage(named: "Menu"), for: .normal)
//        menuButton.contentMode = .scaleAspectFill // 이미지를 가득 채우도록 설정
//        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
//        view.addSubview(menuButton)
//
//        menuButton.snp.makeConstraints { make in
//            make.height.equalTo(30) // 버튼 높이를 원하는 크기로 조절 (예: 30 포인트)
//            make.width.equalTo(menuButton.snp.height)
//            make.centerY.equalTo(titleLabel.snp.centerY)
//            make.right.equalToSuperview().offset(-20)
//        }
//    }
//    
//    @objc private func menuButtonTapped() {
//        // 매뉴 버튼이 탭되었을 때 수행할 동작 정의
//    }
//    
//    // profileImageView 설정 메서드
//    private func setupProfileImageView() {
//        view.addSubview(profileImageView)  // 뷰에 프로필 이미지 뷰를 추가
//        profileImageView.image = UIImage(named: "Ellipse 1")// 프로필 이미지 설정
//        profileImageView.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(14)  // 타이틀 레이블 아래로 14pt 떨어진 위치에 설정
//            make.left.equalToSuperview().offset(20)  // 왼쪽 여백을 20pt로 설정
//            make.width.height.equalTo(88)  // 프로필 이미지의 너비와 높이를 각각 80pt로 설정
//        }
//    }
//    
//    // 사용자 프로필 섹션(usernameLabel, bioLabel, bioLabel) 설정 메서드
//    private func setupUserProfileSection() {
//        // 사용자 이름 레이블 설정 및 레이아웃 정의
//        view.addSubview(usernameLabel)
//        usernameLabel.text = "르탄이"
//        usernameLabel.font = UIFont.boldSystemFont(ofSize: 17) // 글꼴 및 글꼴 크기 설정
//        usernameLabel.snp.makeConstraints { make in
//            make.top.equalTo(profileImageView.snp.bottom).offset(15)  // 프로필 이미지 뷰 아래로 8pt
//            make.left.equalTo(profileImageView.snp.left)  // 프로필 이미지 뷰와 좌우 정렬
//        }
//        
//        // 사용자 소개 라벨 설정 및 레이아웃 정의
//        view.addSubview(bioLabel)
//        bioLabel.text = "iOS Developer 🍎"
//        bioLabel.numberOfLines = 0
//        bioLabel.snp.makeConstraints { make in
//            make.top.equalTo(usernameLabel.snp.bottom).offset(4)  // 사용자 이름 레이블 아래로 4pt
//            make.left.equalTo(usernameLabel.snp.left)  // 사용자 이름 레이블과 좌우 정렬
//            make.right.lessThanOrEqualToSuperview().offset(-20)  // 오른쪽 여백 설정
//        }
//        
//        // 사용자 링크 라벨 설정 및 레이아웃 정의
//        view.addSubview(linkLabel)
//        linkLabel.text = "spartacodingclub.kr"
//        linkLabel.textColor = .systemBlue  // 링크 색상으로 강조
//        linkLabel.snp.makeConstraints { make in
//            make.top.equalTo(bioLabel.snp.bottom).offset(4)  // 사용자 소개 라벨 아래로 4pt
//            make.left.equalTo(bioLabel.snp.left)  // 사용자 소개 라벨과 좌우 정렬
//        }
//    }
//    
//    // post, follower, following 정보를 보여주는 스택 뷰 설정 메서드
//    private func setupStatsStackView() {
//        // 게시물 수를 위한 스택 뷰 설정
//        let postsStackView = createStatsStackView(countLabel: postsCountLabel, textLabel: postsTextLabel, countText: "7", labelText: "post")
//        
//        // 팔로워 수를 위한 스택 뷰 설정
//        let followersStackView = createStatsStackView(countLabel: followersCountLabel, textLabel: followersTextLabel, countText: "0", labelText: "followers")
//        
//        // 팔로잉 수를 위한 스택 뷰 설정
//        let followingStackView = createStatsStackView(countLabel: followingCountLabel, textLabel: followingTextLabel, countText: "0", labelText: "following")
//        
//        // 게시물, 팔로워, 팔로잉 정보를 수평으로 배치하기 위한 스택 뷰
//        let statsHorizontalStackView = UIStackView(arrangedSubviews: [postsStackView, followersStackView, followingStackView])
//        statsHorizontalStackView.axis = .horizontal  // 스택 뷰의 축을 수평으로 설정
//        statsHorizontalStackView.distribution = .fillEqually  // 스택 뷰 내의 요소들이 동일한 비율로 채워지도록 설정
//        statsHorizontalStackView.alignment = .center  // 스택 뷰 내의 요소들이 중앙 정렬되도록 설정
//        view.addSubview(statsHorizontalStackView)  // 뷰에 스택 뷰 추가
//        
//        statsHorizontalStackView.snp.makeConstraints { make in
//            make.centerY.equalTo(profileImageView.snp.centerY)  // 스택 뷰를 프로필 이미지 뷰의 센터 Y축에 맞춤
//            make.left.equalTo(profileImageView.snp.right).offset(20)  // 프로필 이미지 뷰의 오른쪽에서 20pt 떨어진 위치에 설정
//            make.right.equalToSuperview().offset(-20)  // 뷰의 오른쪽 여백을 20pt로 설정
//        }
//    }
//    
//    // post, follower, following 정보를 보여주는 스택 뷰를 생성하는 메서드
//    private func createStatsStackView(countLabel: UILabel, textLabel: UILabel, countText: String, labelText: String) -> UIStackView {
//        countLabel.text = countText  // 카운트 레이블에 텍스트 설정
//        countLabel.font = UIFont.boldSystemFont(ofSize: 16)  // 카운트 레이블의 폰트 설정
//        textLabel.text = labelText  // 텍스트 레이블에 텍스트 설정
//        textLabel.font = UIFont.systemFont(ofSize: 14)  // 텍스트 레이블의 폰트 설정
//        
//        // 카운트 레이블과 텍스트 레이블을 포함하는 스택 뷰 생성
//        let stackView = UIStackView(arrangedSubviews: [countLabel, textLabel])
//        stackView.axis = .vertical  // 스택 뷰의 축을 수직으로 설정
//        stackView.alignment = .center  // 스택 뷰 내의 요소들이 중앙 정렬되도록 설정
//        stackView.distribution = .equalSpacing  // 스택 뷰 내의 요소들 사이의 간격을 동일하게 설정
//        
//        return stackView  // 설정이 완료된 스택 뷰 반환
//    }
//    
//    // followButton 및 messageButton, moreButton 설정 메서드
//    private func setupActionButtons() {
//        // 개별 버튼 설정
//        setupFollowButton()  // 팔로우 버튼 설정
//        setupMessageButton()  // 메시지 버튼 설정
//        let moreButton = setupMoreButton()  // 더보기 버튼 설정
//        
//        // 팔로우 버튼과 메시지 버튼을 담을 스택 뷰 설정
//        let actionButtonsStackView = UIStackView(arrangedSubviews: [followButton, messageButton])
//        actionButtonsStackView.axis = .horizontal  // 수평 방향으로 설정
//        actionButtonsStackView.alignment = .center  // 요소들을 중앙에 정렬
//        actionButtonsStackView.distribution = .fillEqually  // 요소들이 동일한 크기로 채워지도록 설정
//        actionButtonsStackView.spacing = 8  // 요소들 사이의 간격 설정
//        
//        // 스택 뷰를 뷰에 추가하고 제약 조건 설정
//        view.addSubview(actionButtonsStackView)
//        actionButtonsStackView.snp.makeConstraints { make in
//            make.top.equalTo(linkLabel.snp.bottom).offset(12)  // 링크 레이블 아래로 12pt 떨어진 위치에 배치
//            make.left.equalToSuperview().offset(20)  // 왼쪽 가장자리로부터 20pt 떨어진 위치에 배치
//        }
//        
//        // 더보기 버튼을 뷰에 추가하고 제약 조건 설정
//        view.addSubview(moreButton)
//        moreButton.snp.makeConstraints { make in
//            make.width.height.equalTo(30)  // 가로 및 세로 크기를 30pt로 설정
//            make.centerY.equalTo(actionButtonsStackView.snp.centerY)  // 스택 뷰의 수직 중앙에 맞춤
//            make.left.equalTo(actionButtonsStackView.snp.right).offset(8)  // 스택 뷰 오른쪽으로부터 8pt 떨어진 위치에 배치
//            make.right.equalToSuperview().offset(-20)  // 오른쪽 가장자리로부터 20pt 떨어진 위치에 배치
//        }
//    }
//
//    // setupFollowButton 설정
//    private func setupFollowButton() {
//        followButton.setTitle("Follow", for: .normal)  // 버튼의 텍스트를 "Follow"로 설정
//        followButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)  // 폰트 크기
//        followButton.backgroundColor = .systemCyan  // 배경색을 파란색으로 설정
//        followButton.layer.cornerRadius = 3  // 모서리를 둥글게 처리 (반지름 3pt)
//        followButton.layer.borderWidth = 1  // 테두리 두께 설정
//        followButton.layer.borderColor = UIColor.systemCyan.cgColor  // 테두리 색상 설정
//        view.addSubview(followButton)  // 팔로우 버튼을 뷰에 추가
//        followButton.snp.makeConstraints { make in
//            make.height.equalTo(30)  // 높이를 30pt로 설정
//        }
//    }
//
//    // setupMessageButton 설정
//    private func setupMessageButton() {
//        messageButton.setTitle("Message", for: .normal)  // 버튼의 텍스트를 "Message"로 설정
//        messageButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)  // 폰트 크기
//        messageButton.setTitleColor(.black, for: .normal)  // 색상을 검은색으로 설정
//        messageButton.backgroundColor = .white  // 배경색을 회색으로 설정
//        messageButton.layer.cornerRadius = 3  // 모서리를 둥글게 처리 (반지름 3pt)
//        messageButton.layer.borderWidth = 1  // 테두리 두께 설정
//        messageButton.layer.borderColor = UIColor.lightGray.cgColor  // 테두리 색상 설정
//        view.addSubview(messageButton)  // 메시지 버튼을 뷰에 추가
//        messageButton.snp.makeConstraints { make in
//            make.height.equalTo(30)  // 버튼의 높이를 30pt로 설정
//            make.size.equalTo(followButton.snp.size)  // 팔로우 버튼과 동일한 크기로 설정
//        }
//    }
//
//    // setupMoreButton
//    private func setupMoreButton() -> UIButton {
//        moreButton.setImage(UIImage(named: "More"), for: .normal) // 버튼에 이미지 적용
//        moreButton.layer.cornerRadius = 3  // 버튼의 모서리를 둥글게 처리 (반지름 3pt)
//        moreButton.layer.borderWidth = 1  // 테두리 두께 설정
//        moreButton.layer.borderColor = UIColor.lightGray.cgColor  // 테두리 색상 설정
//        return moreButton  // 설정된 더보기 버튼 반환
//    }
//    
//    // MARK: - CollectionView 구성 및 layout 설정
//    // CollectionView 구성 및 layout 설정 메서드
//    private func configureCollectionView() {
//        collectionView.backgroundColor = .brown  // 컬렉션 뷰의 배경색
//        view.addSubview(collectionView)  // 뷰에 컬렉션 뷰 추가
//        collectionView.dataSource = self  // 컬렉션 뷰의 데이터 소스를 현재 뷰 컨트롤러로 설정
//        collectionView.delegate = self  // 컬렉션 뷰의 델리게이트를 현재 뷰 컨트롤러로 설정
//        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")  // 컬렉션 뷰 셀 등록
//        
//        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(followButton.snp.bottom).offset(12)  // 팔로우 버튼 아래로 12pt 떨어진 위치에 설정
//            make.left.right.bottom.equalToSuperview()  // 뷰의 좌우 하단에 꽉 차게 설정
//        }
//    }
//}
//
//// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
//extension ProfileDesignViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    // 컬렉션 뷰 섹션당 아이템의 개수를 정의하는 메서드
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 7  // 예시로 7개의 아이템을 설정
//    }
//    
//    // 컬렉션 뷰 셀을 구성하는 메서드
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
//            fatalError("Unable to dequeue ImageCollectionViewCell")
//        }
//        // 여기에서 셀의 내용을 구성(cell.imageView.image = ...)
//        return cell
//    }
//}
//
//// MARK: - ImageCollectionViewCell
//class ImageCollectionViewCell: UICollectionViewCell {
//    let imageView = UIImageView()  // 셀 내의 이미지 뷰
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupLayout()  // 셀 레이아웃 설정 메서드 호출
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // 셀 레이아웃 설정 메서드
//    private func setupLayout() {
//        contentView.addSubview(imageView)  // 셀의 콘텐츠 뷰에 이미지 뷰 추가
//        imageView.contentMode = .scaleAspectFill  // 이미지의 종횡비를 유지하며 채우기
//        imageView.clipsToBounds = true  // 이미지가 뷰의 경계를 넘어서지 않도록 설정
//        imageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()  // 이미지 뷰의 모든 가장자리를 셀의 콘텐츠 뷰와 일치시킴
//        }
//    }
//}
