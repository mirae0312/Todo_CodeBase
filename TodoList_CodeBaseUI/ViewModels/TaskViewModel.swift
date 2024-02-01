//
//  TaskViewModel.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 2/1/24.
//

import Foundation

// `TasksViewModel`은 `TasksViewController`에 데이터를 제공하고, 사용자의 입력에 대한 응답으로 모델을 업데이트
class TasksViewModel {
    
    // Task 객체 배열
    private(set) var tasks: [Task] = []
    
    // CoreData에서 모든 Task를 가져와서 `tasks` 배열에 저장
    func fetchTasks() {
        tasks = DataManager.shared.fetchTasks()
    }
    
    // 새로운 Task를 생성하고 저장
    // - Parameter title: 새로운 Task의 제목
    func createTask(title: String) {
        DataManager.shared.createTask(title: title)
        fetchTasks() // 새로운 데이터로 배열을 업데이트
    }
    
    // 특정 Task의 제목을 업데이트
    // - Parameters:
    //   - task: 수정할 Task 객체
    //   - newTitle: Task의 새로운 제목
    func updateTask(task: Task, newTitle: String) {
        DataManager.shared.updateTask(task: task, newTitle: newTitle)
        fetchTasks() // 변경사항을 반영하기 위해 데이터를 새로고침
    }
    
    // 특정 Task를 삭제
    // - Parameter task: 삭제할 Task 객체
    func deleteTask(task: Task) {
        DataManager.shared.deleteTask(task: task)
        fetchTasks() // 삭제 후의 데이터로 배열을 업데이트
    }
    
    // 특정 인덱스의 Task를 반환. 컬렉션 뷰에서 사용
    // - Parameter index: 가져올 Task의 인덱스
    // - Returns: 해당 인덱스의 `Task` 객체
    func task(at index: Int) -> Task {
        return tasks[index]
    }
}
