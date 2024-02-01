//
//  ProfileTabBarViewController.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 1/31/24.
//

import UIKit
import Tabman
import Pageboy

protocol ProfileTabBarDelegate: AnyObject {
    func tabDidChange(to index: Int)
}

class ProfileTabBarViewController: TabmanViewController, TMBarDataSource {
    private var viewControllers: [UIViewController] = []
    weak var tabDelegate: ProfileTabBarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 뷰 컨트롤러 인스턴스 생성 및 추가
        let collectionViewVC1 = ProfileDesignViewController()
        let collectionViewVC2 = ProfileDesignViewController() // 예시로 동일한 VC를 사용, 필요에 따라 다른 VC 지정 가능
        let collectionViewVC3 = ProfileDesignViewController()
        viewControllers.append(contentsOf: [collectionViewVC1, collectionViewVC2, collectionViewVC3])

        self.dataSource = self
        self.delegate = self // 여기서 TabmanViewController의 delegate 속성을 이용해 자신을 델리게이트로 설정

        // 탭바 설정
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // 탭 전환 스타일 설정
        bar.buttons.customize { (button) in
            button.selectedTintColor = .black // 선택된 탭의 색상
            button.tintColor = .gray // 선택되지 않은 탭의 색상
        }
        addBar(bar, dataSource: self, at: .top)
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        // 각 탭에 해당하는 이미지 설정
        let item = TMBarItem(title: "")
        item.image = UIImage(named: "Grid") // 탭에 사용할 이미지
        return item
    }

    // PageboyViewControllerDelegate 메서드 구현
    // 이 메서드는 TabmanViewController가 이미 PageboyViewControllerDelegate를 채택하고 있기 때문에
    // 별도의 채택 없이 오버라이드 가능
    override func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: Int, direction: PageboyViewController.NavigationDirection, animated: Bool) {
        tabDelegate?.tabDidChange(to: index)
    }
}

extension ProfileTabBarViewController: PageboyViewControllerDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .first
    }
}
