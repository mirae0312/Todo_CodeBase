//
//  ViewController.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 1/30/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    // 메인 화면에 표시될 이미지 뷰
    let imageView = UIImageView()
    // 할 일 목록 페이지로 이동하는 버튼
    let taskButton = UIButton()
    // 프로필 페이지로 이동하는 버튼
    let profileButton = UIButton()
    // 프로필 디자인 페이지로 이동하는 버튼
    let profileDesignButton = UIButton()
    // 랜덤 비디오 재생 페이지로 이동하는 버튼
    let randomVideoButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // 화면 배경을 흰색으로 설정
        
        setupViews() // UI 컴포넌트 초기 설정 실행
    }
    
    private func setupViews() {
        // imageView, taskButton, profileDesignButton, profileButton, randomVideoButton을 포함하는 스택 뷰 생성
        let stackView = UIStackView(arrangedSubviews: [imageView, taskButton, profileDesignButton, profileButton, randomVideoButton])
        stackView.axis = .vertical // 스택 뷰의 축을 수직으로 설정
        stackView.spacing = 10 // 스택 뷰 내 요소 간 간격 설정
        stackView.alignment = .center // 스택 뷰 내 요소를 중앙 정렬
        stackView.distribution = .equalSpacing // 스택 뷰 내 요소의 간격을 동일하게 분배
        
        view.addSubview(stackView) // 스택 뷰를 메인 뷰에 추가
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview() // 스택 뷰를 화면 세로 중앙에 위치
            make.centerX.equalToSuperview() // 스택 뷰를 화면 가로 중앙에 위치
        }
        
        // 각 UI 컴포넌트 별 세부 설정 메소드 호출
        setupImageView()
        setupTodoButton()
        setupProfileDesignButton()
        setupProfileButton()
        setupRandomVideoButton()
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: "Cat") // 이미지 뷰에 표시될 이미지 설정
        imageView.contentMode = .scaleAspectFit // 이미지의 비율을 유지하며 뷰에 맞게 조정
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(300) // 이미지 뷰의 너비와 높이 설정
        }
    }
    
    private func setupTodoButton() {
        taskButton.setTitle("💖 Task List 💖", for: .normal) // 버튼의 텍스트 설정
        taskButton.setTitleColor(.blue, for: .normal) // 버튼 텍스트 색상 설정
        taskButton.addTarget(self, action: #selector(goTaskViewController), for: .touchUpInside) // 버튼 액션 설정
        taskButton.snp.makeConstraints { make in
            make.width.equalTo(300) // 버튼 너비 설정
            make.height.equalTo(50) // 버튼 높이 설정
        }
    }
    
    private func setupProfileButton() {
        profileButton.setTitle("⭐️ ProfileViewController ⭐️", for: .normal) // 버튼의 텍스트 설정
        profileButton.setTitleColor(.blue, for: .normal) // 버튼 텍스트 색상 설정
        profileButton.addTarget(self, action: #selector(goToProfileViewController), for: .touchUpInside) // 버튼 액션 설정
        profileButton.snp.makeConstraints { make in
            make.width.equalTo(300) // 버튼 너비 설정
            make.height.equalTo(50) // 버튼 높이 설정
        }
    }
    
    private func setupProfileDesignButton() {
        profileDesignButton.setTitle("🌟 ProfileDesignViewController 🌟", for: .normal) // 버튼의 텍스트 설정
        profileDesignButton.setTitleColor(.blue, for: .normal) // 버튼 텍스트 색상 설정
        profileDesignButton.addTarget(self, action: #selector(goToProfileDesignViewController), for: .touchUpInside) // 버튼 액션 설정
        profileDesignButton.snp.makeConstraints { make in
            make.width.equalTo(300) // 버튼 너비 설정
            make.height.equalTo(50) // 버튼 높이 설정
        }
    }
    
    private func setupRandomVideoButton() {
        randomVideoButton.setTitle("🌸 Random Video 🌸", for: .normal) // 버튼의 텍스트 설정
        randomVideoButton.setTitleColor(.blue, for: .normal) // 버튼 텍스트 색상 설정
        randomVideoButton.addTarget(self, action: #selector(goToRandomVideoViewController), for: .touchUpInside) // 버튼 액션 설정
        randomVideoButton.snp.makeConstraints { make in
            make.width.equalTo(300) // 버튼 너비 설정
            make.height.equalTo(50) // 버튼 높이 설정
        }
    }
    
    // 각 버튼의 액션 메소드 구현
    @objc func goTaskViewController() {
        let taskVC = TasksViewController() // 할 일 목록 페이지로 이동
        present(taskVC, animated: true, completion: nil)
    }
    
    @objc func goToProfileDesignViewController() {
        let profileDesignVC = ProfileDesignViewController() // 프로필 디자인 페이지로 이동
        present(profileDesignVC, animated: true, completion: nil)
    }
    
    @objc func goToProfileViewController() {
        let profileVC = ProfileViewController() // 프로필 페이지로 이동
        present(profileVC, animated: true, completion: nil)
    }
    
    @objc func goToRandomVideoViewController() {
        let randomVideoVC = RandomVideoViewController() // 랜덤 비디오 재생 페이지로 이동
        present(randomVideoVC, animated: true, completion: nil)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
// SwiftUI 뷰로 UIKit 뷰 컨트롤러를 래핑
struct ViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // 뷰 컨트롤러 업데이트가 필요할 때 사용
    }
}

// SwiftUI Preview
@available(iOS 13.0, *)
struct ViewControllerPreview_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview()
            .edgesIgnoringSafeArea(.all) // Safe Area를 무시하고 전체 화면으로 표시하고 싶은 경우
    }
}
#endif
