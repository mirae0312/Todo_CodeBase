//
//  RandomVideoViewController.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 2/1/24.
//
import UIKit
import AVKit

// 동영상을 랜덤하게 재생하는 뷰 컨트롤러 정의
class RandomVideoViewController: UIViewController {
    // ViewModel 인스턴스화, 동영상 데이터 관리 담당
    var viewModel = RandomVideoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 동영상 데이터 로드 완료 시 실행될 클로저 설정
        viewModel.onVideoFetchCompleted = { [weak self] error in
            // 에러 발생 시 콘솔에 에러 로그 출력
            if let error = error {
                print("동영상 로딩 중 에러 발생: \(error)")
                return
            }
            // 에러 없을 경우 첫 번째 동영상 재생 시작
            self?.playFirstVideo()
        }
        
        // ViewModel을 통해 동영상 데이터 로드 시작
        viewModel.fetchVideos()
    }
    
    // 첫 번째 동영상 재생 메서드
    func playFirstVideo() {
        // ViewModel에서 첫 번째 동영상 URL 가져옴. 유효하지 않으면 종료
        guard let firstVideoUrl = URL(string: viewModel.videos.first?.videoUrl ?? "") else { return }
        
        // URL을 사용해 AVPlayer 인스턴스 생성
        let player = AVPlayer(url: firstVideoUrl)
        
        // AVPlayerViewController 인스턴스 생성 후 player 할당
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        // 생성한 AVPlayerViewController를 모달 형태로 표시, 재생 시작
        present(playerViewController, animated: true) {
            player.play()
        }
    }
}


