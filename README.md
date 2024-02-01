# Todo_CodeBase

## 구성 요소
- ViewController: 사용자 인터페이스와 사용자 인터랙션을 관리
- ProfileViewController: 사용자 프로필 정보 표시
- Model: 앱의 데이터와 비즈니스 로직을 관리
- UserProfile: 사용자 프로필 데이터 모델
- Persistence: 데이터 영구 저장을 담당
- CoreData: 복잡한 데이터 구조나 대량의 데이터 저장 및 관리
- UserDefaults: 간단한 사용자 설정값 저장

## UserDefaults와 CoreData의 차이점
#### UserDefaults
- 간단한 사용자 설정이나 소량의 데이터 저장에 적합
키-값 쌍으로 데이터를 저장
대량의 데이터나 복잡한 데이터 구조 관리에는 부적합
#### CoreData
- 대량의 구조화된 데이터 관리에 적합
관계형 데이터베이스 모델을 사용하여 복잡한 쿼리, 데이터 관계 및 마이그레이션 지원
데이터 모델링 도구를 통한 데이터 구조 시각화
