//
//  ProfileDesignViewController.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 1/31/24.
//
//
//  ProfileDesignUIViewController.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 1/31/24.
//

import Foundation
import UIKit
import SnapKit
import Tabman
import Pageboy

class ProfileDesignViewController: UIViewController {
    // MARK: - Properties
    // UI 컴포넌트 선언
    let titleLabel = UILabel()
    let menuButton = UIButton()
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let bioLabel = UILabel()
    let linkLabel = UILabel()
    // 게시물, 팔로워, 팔로잉 수를 보여줄 레이블
    let postsTextLabel = UILabel()
    let followersTextLabel = UILabel()
    let followingTextLabel = UILabel()
    let postsCountLabel = UILabel()
    let followersCountLabel = UILabel()
    let followingCountLabel = UILabel()
    // 팔로우 및 메시지 보내기 버튼
    let followButton = UIButton()
    let messageButton = UIButton()
    let moreButton = UIButton()
    // 사용자의 게시물을 보여줄 컬렉션 뷰
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    // 탭바 인덱스 수
    private var selectedTabIndex = 0
    // 하단 탭바
    let bottomTabBar = UIView()
    let tabItem1 = UIButton()
    let tabProfile = UIButton()
    let tabItem3 = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white   // 뷰 배경색
        
        setupLayout()                   // UI 컴포넌트의 레이아웃을 설정하는 메서드 호출
        setupTabBarViewController()     // 탭바 뷰 컨트롤러 설정 호출
        setupBottomTabBar()             // 하단 탭바 메서드 호출
        configureCollectionView()       // collectionView 구성 메서드 호출
    }
    
    // MARK: - Setup
    // UI 레이아웃 설정 메서드
    private func setupLayout() {
        setupTitleLabel()           // 상단 titleLabel 설정
        setupMenuButton()           // 상단 Menu버튼 설정
        setupProfileImageView()     // profileImageView 설정
        setupUserProfileSection()   // 사용자 프로필 섹션(usernameLabel, bioLabel, bioLabel) 설정
        setupStatsStackView()       // post, follower, following 정보를 보여주는 스택 뷰 설정
        setupActionButtons()        // followButton 및 messageButton, moreButton 설정
    }
    
    // titleLabel 설정 메서드
    private func setupTitleLabel() {
        view.addSubview(titleLabel)  // 뷰에 titleLabel 추가
        titleLabel.text = "nabaecamp"  // titleLabel 텍스트 설정
        titleLabel.textColor = UIColor.black  // 텍스트 색상 설정
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20) // 글꼴 및 글꼴 크기 설정
        titleLabel.textAlignment = .center  // 텍스트 정렬을 가운데로 설정
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)  // 상단 safe area로부터 20pt 아래에 위치하도록 설정
            make.left.right.equalToSuperview()  // 좌우 여백 없이 뷰의 좌우에 꽉 차도록 설정
        }
    }
    
    // setupMenuButton 설정 메서드
    private func setupMenuButton() {
        menuButton.setImage(UIImage(named: "Menu"), for: .normal)
        menuButton.contentMode = .scaleAspectFill // 이미지를 가득 채우도록 설정
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        view.addSubview(menuButton)
        
        menuButton.snp.makeConstraints { make in
            make.height.equalTo(30) // 버튼 높이를 원하는 크기로 조절 (예: 30 포인트)
            make.width.equalTo(menuButton.snp.height)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    @objc private func menuButtonTapped() {
        // 매뉴 버튼이 탭되었을 때 수행할 동작 정의
    }
    
    // profileImageView 설정 메서드
    private func setupProfileImageView() {
        view.addSubview(profileImageView)  // 뷰에 프로필 이미지 뷰를 추가
        profileImageView.image = UIImage(named: "Ellipse 1")// 프로필 이미지 설정
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)  // 타이틀 레이블 아래로 14pt 떨어진 위치에 설정
            make.left.equalToSuperview().offset(20)  // 왼쪽 여백을 20pt로 설정
            make.width.height.equalTo(88)  // 프로필 이미지의 너비와 높이를 각각 80pt로 설정
        }
    }
    
    // 사용자 프로필 섹션(usernameLabel, bioLabel, bioLabel) 설정 메서드
    private func setupUserProfileSection() {
        // 사용자 이름 레이블 설정 및 레이아웃 정의
        view.addSubview(usernameLabel)
        usernameLabel.text = "르탄이"
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 17) // 글꼴 및 글꼴 크기 설정
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(15)  // 프로필 이미지 뷰 아래로 8pt
            make.left.equalTo(profileImageView.snp.left)  // 프로필 이미지 뷰와 좌우 정렬
        }
        
        // 사용자 소개 라벨 설정 및 레이아웃 정의
        view.addSubview(bioLabel)
        bioLabel.text = "iOS Developer 🍎"
        bioLabel.numberOfLines = 0
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(4)  // 사용자 이름 레이블 아래로 4pt
            make.left.equalTo(usernameLabel.snp.left)  // 사용자 이름 레이블과 좌우 정렬
            make.right.lessThanOrEqualToSuperview().offset(-20)  // 오른쪽 여백 설정
        }
        
        // 사용자 링크 라벨 설정 및 레이아웃 정의
        view.addSubview(linkLabel)
        linkLabel.text = "spartacodingclub.kr"
        linkLabel.textColor = .systemBlue  // 링크 색상으로 강조
        linkLabel.snp.makeConstraints { make in
            make.top.equalTo(bioLabel.snp.bottom).offset(4)  // 사용자 소개 라벨 아래로 4pt
            make.left.equalTo(bioLabel.snp.left)  // 사용자 소개 라벨과 좌우 정렬
        }
    }
    
    // post, follower, following 정보를 보여주는 스택 뷰 설정 메서드
    private func setupStatsStackView() {
        // 게시물 수를 위한 스택 뷰 설정
        let postsStackView = createStatsStackView(countLabel: postsCountLabel, textLabel: postsTextLabel, countText: "7", labelText: "post")
        
        // 팔로워 수를 위한 스택 뷰 설정
        let followersStackView = createStatsStackView(countLabel: followersCountLabel, textLabel: followersTextLabel, countText: "0", labelText: "followers")
        
        // 팔로잉 수를 위한 스택 뷰 설정
        let followingStackView = createStatsStackView(countLabel: followingCountLabel, textLabel: followingTextLabel, countText: "0", labelText: "following")
        
        // 게시물, 팔로워, 팔로잉 정보를 수평으로 배치하기 위한 스택 뷰
        let statsHorizontalStackView = UIStackView(arrangedSubviews: [postsStackView, followersStackView, followingStackView])
        statsHorizontalStackView.axis = .horizontal  // 스택 뷰의 축을 수평으로 설정
        statsHorizontalStackView.distribution = .fillEqually  // 스택 뷰 내의 요소들이 동일한 비율로 채워지도록 설정
        statsHorizontalStackView.alignment = .center  // 스택 뷰 내의 요소들이 중앙 정렬되도록 설정
        view.addSubview(statsHorizontalStackView)  // 뷰에 스택 뷰 추가
        
        statsHorizontalStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)  // 스택 뷰를 프로필 이미지 뷰의 센터 Y축에 맞춤
            make.left.equalTo(profileImageView.snp.right).offset(20)  // 프로필 이미지 뷰의 오른쪽에서 20pt 떨어진 위치에 설정
            make.right.equalToSuperview().offset(-20)  // 뷰의 오른쪽 여백을 20pt로 설정
        }
    }
    
    // post, follower, following 정보를 보여주는 스택 뷰를 생성하는 메서드
    private func createStatsStackView(countLabel: UILabel, textLabel: UILabel, countText: String, labelText: String) -> UIStackView {
        countLabel.text = countText  // 카운트 레이블에 텍스트 설정
        countLabel.font = UIFont.boldSystemFont(ofSize: 16)  // 카운트 레이블의 폰트 설정
        textLabel.text = labelText  // 텍스트 레이블에 텍스트 설정
        textLabel.font = UIFont.systemFont(ofSize: 14)  // 텍스트 레이블의 폰트 설정
        
        // 카운트 레이블과 텍스트 레이블을 포함하는 스택 뷰 생성
        let stackView = UIStackView(arrangedSubviews: [countLabel, textLabel])
        stackView.axis = .vertical  // 스택 뷰의 축을 수직으로 설정
        stackView.alignment = .center  // 스택 뷰 내의 요소들이 중앙 정렬되도록 설정
        stackView.distribution = .equalSpacing  // 스택 뷰 내의 요소들 사이의 간격을 동일하게 설정
        
        return stackView  // 설정이 완료된 스택 뷰 반환
    }
    
    // followButton 및 messageButton, moreButton 설정 메서드
    private func setupActionButtons() {
        // 개별 버튼 설정
        setupFollowButton()  // 팔로우 버튼 설정
        setupMessageButton()  // 메시지 버튼 설정
        let moreButton = setupMoreButton()  // 더보기 버튼 설정
        
        // 팔로우 버튼과 메시지 버튼을 담을 스택 뷰 설정
        let actionButtonsStackView = UIStackView(arrangedSubviews: [followButton, messageButton])
        actionButtonsStackView.axis = .horizontal  // 수평 방향으로 설정
        actionButtonsStackView.alignment = .center  // 요소들을 중앙에 정렬
        actionButtonsStackView.distribution = .fillEqually  // 요소들이 동일한 크기로 채워지도록 설정
        actionButtonsStackView.spacing = 8  // 요소들 사이의 간격 설정
        
        // 스택 뷰를 뷰에 추가하고 제약 조건 설정
        view.addSubview(actionButtonsStackView)
        actionButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(linkLabel.snp.bottom).offset(12)  // 링크 레이블 아래로 12pt 떨어진 위치에 배치
            make.left.equalToSuperview().offset(20)  // 왼쪽 가장자리로부터 20pt 떨어진 위치에 배치
        }
        
        // 더보기 버튼을 뷰에 추가하고 제약 조건 설정
        view.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)  // 가로 및 세로 크기를 30pt로 설정
            make.centerY.equalTo(actionButtonsStackView.snp.centerY)  // 스택 뷰의 수직 중앙에 맞춤
            make.left.equalTo(actionButtonsStackView.snp.right).offset(8)  // 스택 뷰 오른쪽으로부터 8pt 떨어진 위치에 배치
            make.right.equalToSuperview().offset(-20)  // 오른쪽 가장자리로부터 20pt 떨어진 위치에 배치
        }
    }
    
    // setupFollowButton 설정
    private func setupFollowButton() {
        followButton.setTitle("Follow", for: .normal)  // 버튼의 텍스트를 "Follow"로 설정
        followButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)  // 폰트 크기
        followButton.backgroundColor = .systemCyan  // 배경색을 파란색으로 설정
        followButton.layer.cornerRadius = 3  // 모서리를 둥글게 처리 (반지름 3pt)
        followButton.layer.borderWidth = 1  // 테두리 두께 설정
        followButton.layer.borderColor = UIColor.systemCyan.cgColor  // 테두리 색상 설정
        view.addSubview(followButton)  // 팔로우 버튼을 뷰에 추가
        followButton.snp.makeConstraints { make in
            make.height.equalTo(30)  // 높이를 30pt로 설정
        }
    }
    
    // setupMessageButton 설정
    private func setupMessageButton() {
        messageButton.setTitle("Message", for: .normal)  // 버튼의 텍스트를 "Message"로 설정
        messageButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)  // 폰트 크기
        messageButton.setTitleColor(.black, for: .normal)  // 색상을 검은색으로 설정
        messageButton.backgroundColor = .white  // 배경색을 회색으로 설정
        messageButton.layer.cornerRadius = 3  // 모서리를 둥글게 처리 (반지름 3pt)
        messageButton.layer.borderWidth = 1  // 테두리 두께 설정
        messageButton.layer.borderColor = UIColor.lightGray.cgColor  // 테두리 색상 설정
        view.addSubview(messageButton)  // 메시지 버튼을 뷰에 추가
        messageButton.snp.makeConstraints { make in
            make.height.equalTo(30)  // 버튼의 높이를 30pt로 설정
            make.size.equalTo(followButton.snp.size)  // 팔로우 버튼과 동일한 크기로 설정
        }
    }
    
    // setupMoreButton
    private func setupMoreButton() -> UIButton {
        moreButton.setImage(UIImage(named: "More"), for: .normal) // 버튼에 이미지 적용
        moreButton.layer.cornerRadius = 3  // 버튼의 모서리를 둥글게 처리 (반지름 3pt)
        moreButton.layer.borderWidth = 1  // 테두리 두께 설정
        moreButton.layer.borderColor = UIColor.lightGray.cgColor  // 테두리 색상 설정
        return moreButton  // 설정된 더보기 버튼 반환
    }
    
    // MARK: - CollectionView 구성 및 layout 설정
    // CollectionView 구성 및 layout 설정 메서드
    private func configureCollectionView() {
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 2 // 셀 간의 간격
        let totalSpacing = (spacing * 2) // 총 간격 (양 옆 간격)
        let width = (view.frame.size.width - totalSpacing) / 3 // 3등분하여 셀의 너비 계산
        layout.itemSize = CGSize(width: width, height: width) // 셀의 크기 설정
        layout.minimumLineSpacing = spacing // 줄 간의 최소 간격
        layout.minimumInteritemSpacing = spacing // 아이템 간의 최소 간격
        collectionView.collectionViewLayout = layout
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(fakeTabBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.bottom.equalTo(bottomTabBar.snp.top) // 하단 탭바의 상단에 맞춤
        }
    }
    
    // MARK: - 가짜 탭바 추후 삭제예정.
    let fakeTabBar = UIView()
    let tabBarButton = UIButton()
    private func setupTabBarViewController() {
        // 가짜 탭바 설정
        fakeTabBar.backgroundColor = .clear // 배경색 설정
        fakeTabBar.layer.borderWidth = 1 // 테두리 두께 설정
        fakeTabBar.layer.borderColor = UIColor.lightGray.cgColor // 테두리 색상 설정
        view.addSubview(fakeTabBar)
        fakeTabBar.snp.makeConstraints { make in
            make.top.equalTo(followButton.snp.bottom).offset(10) // followButton 아래에 위치
            make.left.right.equalToSuperview()
            make.height.equalTo(45) // 높이 설정
        }
        
        // 탭바 버튼 설정
        tabBarButton.setImage(UIImage(named: "Grid"), for: .normal) // 사용할 이미지 설정
        fakeTabBar.addSubview(tabBarButton)
        tabBarButton.snp.makeConstraints { make in
            let tabBarWidth = UIScreen.main.bounds.width / 3 // 화면을 3등분
            make.left.equalToSuperview().offset(tabBarWidth / 2 - 15) // 왼쪽 중앙에 위치하도록 조정
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30) // 버튼 크기 설정
        }
    }
    
    // 하단 탭바
    private func setupBottomTabBar() {
        bottomTabBar.backgroundColor = .white // 탭바의 배경색 설정
        view.addSubview(bottomTabBar)
        bottomTabBar.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50) // 탭바의 높이
        }
        
        // 첫 번째 탭 아이템 이미지 설정
        tabItem1.setImage(UIImage(named: "icon1"), for: .normal)
        
        // 두 번째 탭 아이템 (tabProfile) 이미지 설정
        tabProfile.setImage(UIImage(named: "Profile"), for: .normal)
        
        // 세 번째 탭 아이템 (tabItem3) 이미지 설정
        tabItem3.setImage(UIImage(named: "icon3"), for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [tabItem1, tabProfile, tabItem3])
        stackView.distribution = .fillEqually // 내부 뷰들에게 동등한 공간 분배
        stackView.alignment = .center // 중앙 정렬
        stackView.axis = .horizontal // 수평 스택
        
        bottomTabBar.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // 스택뷰를 탭바 내부에 꽉 차게
        }
        
        // 탭 아이템에 액션 추가
        tabItem1.addTarget(self, action: #selector(tabItem1Tapped), for: .touchUpInside)
        tabProfile.addTarget(self, action: #selector(tabProfileTapped), for: .touchUpInside)
        tabItem3.addTarget(self, action: #selector(tabItem3Tapped), for: .touchUpInside)
    }
    
    // 탭 아이템 액션 메서드
    @objc func tabItem1Tapped() {
        // 첫 번째 탭 아이템이 탭됐을 때의 동작
    }
    
    @objc func tabProfileTapped() {
        let profileVC = ProfileViewController()
        present(profileVC, animated: true, completion: nil)
    }
    
    @objc func tabItem3Tapped() {
        // 세 번째 탭 아이템이 탭됐을 때의 동작
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ProfileDesignViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 // 사진의 총 개수
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Unable to dequeue ImageCollectionViewCell")
        }
        
        // Picture 1부터 Picture 7까지 순환하며 이미지 설정
        let pictureNumber = (indexPath.item % 7) + 1
        cell.imageView.image = UIImage(named: "Picture \(pictureNumber)")
        return cell
    }
    
}

// tapman 탭바 구성 예정 미완
extension ProfileDesignViewController: ProfileTabBarDelegate {
    // ProfileTabBarDelegate 메서드 구현
    func tabDidChange(to index: Int) {
        selectedTabIndex = index
        collectionView.reloadData() // 콜렉션뷰 데이터 갱신
    }
    
    //    func setupTabBarViewController() {
    //        let tabBarVC = ProfileTabBarViewController()
    //        tabBarVC.tabDelegate = self // Delegate 설정
    //        addChild(tabBarVC)
    //        view.addSubview(tabBarVC.view)
    //        tabBarVC.didMove(toParent: self)
    //
    //        // tabBarVC.view의 레이아웃 설정
    //        tabBarVC.view.snp.makeConstraints { make in
    //            // 팔로우, 메시지, 더보기 버튼을 포함하는 스택뷰 바로 아래에 위치
    //            make.top.equalTo(moreButton.snp.bottom).offset(20)
    //            make.left.right.equalToSuperview()
    //            make.height.equalTo(50) // 탭바의 높이 설정, 필요에 따라 조정
    //        }
    //
    //        // collectionView 레이아웃 설정을 탭바 뷰 아래로 조정
    //        collectionView.snp.remakeConstraints { make in
    //            make.top.equalTo(tabBarVC.view.snp.bottom).offset(10) // 탭바 뷰 아래로 10pt 떨어진 위치에 설정
    //            make.left.right.bottom.equalToSuperview()
    //        }
    //    }
}

// MARK: - ImageCollectionViewCell
class ImageCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//// SwiftUI 뷰로 UIKit 뷰 컨트롤러를 래핑
//struct ProfileDesignViewControllerPreview: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> ProfileDesignViewController {
//        return ProfileDesignViewController()
//    }
//    
//    func updateUIViewController(_ uiViewController: ProfileDesignViewController, context: Context) {
//        // 뷰 컨트롤러 업데이트가 필요할 때 사용
//    }
//}
//
//// SwiftUI Preview
//@available(iOS 13.0, *)
//struct ProfileDesignViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        ProfileDesignViewControllerPreview()
//            .edgesIgnoringSafeArea(.all) // Safe Area를 무시하고 전체 화면으로 표시하고 싶은 경우
//    }
//}
//#endif
