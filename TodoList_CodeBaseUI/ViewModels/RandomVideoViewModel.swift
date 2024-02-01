//
//  RandomVideoViewModel.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 2/1/24.
//

import Foundation

// 동영상 목록을 관리하고 API로부터 동영상 데이터를 가져오는 ViewModel
class RandomVideoViewModel {
    // 동영상 객체 배열
    var videos: [Video] = []
    // 동영상 데이터 로드 완료 시 호출될 클로저. 에러가 있을 경우 에러를 전달
    var onVideoFetchCompleted: ((Error?) -> Void)?
    
    // 동영상 데이터를 가져오는 메소드
    func fetchVideos() {
        // 동영상 데이터를 가져올 URL. URL이 유효하지 않으면 메소드 종료
        guard let url = URL(string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json") else { return }
        
        // URLSession을 사용해 비동기적으로 데이터 로드
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            // 데이터 로드 실패 시 에러 처리 후 종료
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.onVideoFetchCompleted?(error) // 메인 스레드에서 에러 클로저 호출
                }
                return
            }
            
            // 데이터 로드 성공 시 JSON 디코딩을 시도
            do {
                // JSONDecoder를 사용해 데이터를 [Video] 배열로 디코딩
                self?.videos = try JSONDecoder().decode([Video].self, from: data)
                DispatchQueue.main.async {
                    self?.onVideoFetchCompleted?(nil) // 메인 스레드에서 성공 클로저 호출
                }
            } catch {
                // 디코딩 실패 시 에러 처리
                DispatchQueue.main.async {
                    self?.onVideoFetchCompleted?(error) // 메인 스레드에서 에러 클로저 호출
                }
            }
        }.resume() // URLSessionDataTask 시작
    }
}
