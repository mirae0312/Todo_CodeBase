//
//  DataManager.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 2/1/24.
//

import Foundation
import CoreData

// `DataManager`는 Core Data stack을 관리, Core Data와 관련된 모든 작업을 처리
class DataManager {
    
    // 싱글톤 인스턴스를 생성하여 앱 전체에서 하나의 인스턴스만 사용
    static let shared = DataManager()
    
    // NSPersistentContainer는 Core Data stack을 초기화 및 관리
    let persistentContainer: NSPersistentContainer
    
    private init() {
        // Core Data 모델 파일 이름을 사용하여 NSPersistentContainer를 초기화
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    // `Task` 객체를 생성하고 Core Data에 저장
    // - Parameter title: 생성할 Task의 제목
    func createTask(title: String) {
        let context = persistentContainer.viewContext
        let task = Task(context: context) // 새 Task 객체를 생성
        task.id = UUID() // 고유 ID 할당
        task.title = title // 제목 할당
        task.createDate = Date() // 생성 날짜 할당
        print("createTask to save task: \(task.title)")
        do {
            try context.save() // 컨텍스트를 저장하여 변경사항을 영구 저장소에 반영
        } catch {
            print("Failed to save task: \(error)")
        }
    }
    
    // 저장된 `Task` 객체들을 가져옴
    // - Returns: `Task` 객체 배열을 반환
    func fetchTasks() -> [Task] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest) // Fetch 요청을 실행
        } catch {
            print("Failed to fetch tasks: \(error)")
            return []
        }
    }
    
    // 지정된 `Task` 객체를 수정하고 Core Data에 반영
    // - Parameters:
    //   - task: 수정할 Task 객체
    //   - newTitle: 새로운 제목
    func updateTask(task: Task, newTitle: String) {
        let context = persistentContainer.viewContext
        task.title = newTitle // 새로운 제목으로 업데이트
        task.modifyDate = Date() // 수정 날짜를 현재로 업데이트
        
        do {
            try context.save() // 변경사항 저장
        } catch {
            print("Failed to update task: \(error)")
        }
    }
    
    // 지정된 `Task` 객체를 삭제하고 Core Data에 반영
    // - Parameter task: 삭제할 Task 객체
    func deleteTask(task: Task) {
        let context = persistentContainer.viewContext
        context.delete(task) // 컨텍스트에서 Task 객체를 삭제
        
        do {
            try context.save() // 변경사항을 저장
        } catch {
            print("Failed to delete task: \(error)")
        }
    }
}
