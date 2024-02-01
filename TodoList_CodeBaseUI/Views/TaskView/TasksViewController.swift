//
//  TasksViewController.swift
//  TodoList_CodeBaseUI
//
//  Created by mirae on 2/1/24.
//

import UIKit
import SnapKit
import CoreData

class TasksViewController: UIViewController {
    // UI 구성요소 선언
    let topBarView = UIView()
    let backButton = UIButton()
    let titleLabel = UILabel()
    let addButton = UIButton()
    var collectionView: UICollectionView!
    var selectedIndexPath: IndexPath? // 현재 선택된 셀의 인덱스
    var previouslySelectedIndexPath: IndexPath? // 이전에 선택된 셀의 인덱스
    
    // Core Data로부터 로드된 Task 객체 배열
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // 배경색 설정
        setupTopBarView() // 상단 바 구성
        setupCollectionView() // 컬렉션 뷰 구성
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TaskCollectionViewCell.self, forCellWithReuseIdentifier: "TaskCell") // 셀 등록
        
        fetchTasks() // Task 데이터 로드
        fetchAllTasks() // 모든 Task 데이터 로드 (디버깅용)
    }
    
    // Task 데이터 로드 메소드
    func fetchTasks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext // Managed Context 가져오기
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest() // Fetch Request 생성
        
        do {
            tasks = try managedContext.fetch(fetchRequest) // Fetch 실행
            collectionView.reloadData() // 컬렉션 뷰 리로드
        } catch let error as NSError {
            print("Fetch 실패: \(error), \(error.userInfo)")
        }
    }
    
    // 상단 바 구성 메소드
    private func setupTopBarView() {
        view.addSubview(topBarView)
        topBarView.backgroundColor = .lightGray
        topBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(view)
            make.height.equalTo(50)
        }
        
        // Back 버튼 구성
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.blue, for: .normal)
        backButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        topBarView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalTo(topBarView).offset(10)
            make.centerY.equalTo(topBarView)
        }
        
        // Title 레이블 구성
        titleLabel.text = "Tasks"
        titleLabel.textAlignment = .center
        topBarView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(topBarView)
        }
        
        // Add 버튼 구성
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(.blue, for: .normal)
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        topBarView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.right.equalTo(topBarView).offset(-10)
            make.centerY.equalTo(topBarView)
        }
    }
    
    // 컬렉션 뷰 구성 메소드
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 50)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topBarView.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    // 모달 닫기 메소드
    @objc private func closeModal() {
        dismiss(animated: true, completion: nil)
    }
    
    // Task 추가 메소드
    @objc private func addTask() {
        let alertController = UIAlertController(title: "New Task", message: "Enter task title", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Task title"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let textField = alertController.textFields?.first, let title = textField.text, !title.isEmpty else { return }
            self?.saveTask(title: title)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    // Task 저장 메소드
    private func saveTask(title: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)!
        let task = NSManagedObject(entity: entity, insertInto: managedContext)
        
        task.setValue(UUID(), forKeyPath: "id")
        task.setValue(title, forKeyPath: "title")
        task.setValue(Date(), forKeyPath: "createDate")
        
        do {
            try managedContext.save()
            fetchTasks() // 저장 후 Task 데이터 리로드
        } catch let error as NSError {
            print("Save 실패: \(error), \(error.userInfo)")
        }
    }
    
    // 모든 Task 데이터 로드 메소드 (디버깅용)
    func fetchAllTasks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            for task in tasks {
                if let task = task as? Task {
                    print("ID: \(task.id ?? UUID()), Title: \(task.title ?? "No Title"), Create Date: \(task.createDate ?? Date())")
                }
            }
        } catch let error as NSError {
            print("Fetch 실패: \(error), \(error.userInfo)")
        }
    }
}

// UICollectionViewDelegate 프로토콜 구현
extension TasksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 이전에 선택된 셀의 버튼 숨김 처리
        if let selectedIndexPath = selectedIndexPath, let cell = collectionView.cellForItem(at: selectedIndexPath) as? TaskCollectionViewCell {
            cell.hideButtons()
        }
        
        // 현재 선택된 셀의 버튼 표시
        if let cell = collectionView.cellForItem(at: indexPath) as? TaskCollectionViewCell {
            cell.showButtons()
        }
        
        // 현재 선택된 셀의 인덱스 저장
        selectedIndexPath = indexPath
    }
}

// UICollectionViewDelegateFlowLayout 프로토콜 구현
extension TasksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 선택된 셀의 경우 높이를 늘림
        if indexPath == selectedIndexPath {
            return CGSize(width: collectionView.frame.width - 20, height: 100)
        } else {
            // 기본 셀 크기 설정
            return CGSize(width: collectionView.frame.width - 20, height: 50)
        }
    }
}

// UICollectionViewDataSource 프로토콜 구현
extension TasksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Task 배열의 길이 반환
        return tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskCell", for: indexPath) as? TaskCollectionViewCell else {
            fatalError("TaskCollectionViewCell dequeue 실패")
        }

        let task = tasks[indexPath.row]
        let isEditing = indexPath == selectedIndexPath
        cell.configure(with: task, isEditing: isEditing)

        cell.editButtonAction = { [weak self] in
            self?.promptForTaskUpdate(at: indexPath)
        }

        cell.deleteButtonAction = { [weak self] in
            if let taskToDelete = self?.tasks[indexPath.row] {
                self?.deleteTask(taskToDelete)
            }
        }

        return cell
    }
    
    // Task 수정을 위한 메서드
    func promptForTaskUpdate(at indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        let alertController = UIAlertController(title: "Edit Task", message: "Edit your task title", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.text = task.title // 기존 타이틀을 텍스트 필드에 설정
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self, weak alertController] _ in
            guard let textField = alertController?.textFields?.first, let newTitle = textField.text, !newTitle.isEmpty else { return }
            self?.saveUpdatedTask(task, withNewTitle: newTitle)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    // Task 업데이트 메서드
    private func saveUpdatedTask(_ task: Task, withNewTitle newTitle: String) {
        task.title = newTitle
        task.modifyDate = Date() // 수정 날짜 업데이트
        
        do {
            try task.managedObjectContext?.save() // 변경사항 저장
            collectionView.reloadData() // 컬렉션 뷰 리로드
        } catch let error as NSError {
            print("업데이트 실패: \(error), \(error.userInfo)")
        }
    }
    
    // Task 삭제 메서드
    private func deleteTask(_ task: Task) {
        guard let managedContext = task.managedObjectContext else { return }
        managedContext.delete(task) // Task 삭제
        
        do {
            try managedContext.save() // 변경사항 저장
            if let index = tasks.firstIndex(of: task) {
                tasks.remove(at: index) // 내부 배열에서도 삭제
            }
            collectionView.reloadData() // 컬렉션 뷰 리로드
        } catch let error as NSError {
            print("삭제 실패: \(error), \(error.userInfo)")
        }
    }
}
