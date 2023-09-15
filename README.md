# Cake_Craft 전자결재시스템:그룹웨어

# 🖥 개요  
- 2023-08-10 ~ 2023-09-08
- Spring/MVC 방식을 사용하여 전자결재시스템 그룹웨어 구현
- 2차 팀 프로젝트

# 🛠️ 개발 환경
- Language (언어) : `HTML5` `CSS3` `Java`, `SQL`, `JavaScript`, `Ajax`
- Library (라이브러리): `Bootstrap`, `jQuery`, `JSTL`
- Database (데이터베이스) : `MariaDB`
- WAS (Web Application Server) : `Apache Tomcat9`
- OS(운영체제): `MAC`,`window10`
- TOOL : `SPRING-TOOL-SUITE4`, `sequelAce`, `HeidiSQL`

# 📌 주요 기능
**[ 구은혜 ]**
- **일정 관리**
  - Java 기본 API의 Calendar Class 사용하여 달력을 구현하여 가계부를 구성
  - 전사 일정, 팀 일정, 개인 일정을 로그인한 사원의 정보에 맞춰 날짜에 따라 캘린더에 출력
  - 특일 정보 API를 이용하여 공휴일 정보를 가져와서 출력
  - 일정 추가, 수정, 삭제 기능을 모달창을 띄어 구현
- **게시판**
  - jqGrid를 활용하여 테이블을 구현
  - 모든 게시판에서 목록을 출력하고, 정렬과 페이징 기능을 구현
  - 작성자, 제목, 내용 일부의 검색어를 통한 필터
  - javascript를 활용하여 입력폼 유효성 검사 기능을 구현
- **좋아요**
  - ajax를 활용하여 [좋아요] 버튼 클릭 시 비동기식으로 좋아요 수를 +1, [좋아요 취소] 버튼 클릭 시 좋아요 수를 -1
  - javascript를 활용하여 [좋아요]버튼 클릭시 [좋아요]버튼을 숨기고 [좋아요취소]버튼을 노출
- **댓글**
  - 게시글마다 댓글을 달 수 있으며, 댓글 작성자만 댓글을 수정, 삭제
  - 댓글 수정 버튼 클릭 시, javascript를 활용하여 댓글이 사라지고 수정폼이 노출
- **첨부파일**
  - 여러 가지 확장자의 첨부파일을 한 번에 여러 개 업로드 가능
  - 이미지를 업로드하였을 시, 게시글 상세 보기에서 이미지를 출력
  - 파일을 업로드하였을 시, 파일 다운로드 가능
- **비밀글**
  - 문의사항에서 비밀글일시 작성자와 관리자만 열람
- **문의 답변**
  - 문의사항에 답변이 없으면 입력폼이 출력되고, 답변이 있으면 답변이 출력
  - 답변 수정 버튼 클릭 시, javascript를 활용하여 답변이 사라지고 수정폼이 노출

**[ 김미선 ]**
- **로그인 / 출퇴근기능**
  - id와 기본pw 설정: 입사시 생성되는 사번을 기본 id로 설정하여 첫 로그인 시 부여 받은 id와 pw를 입력해 로그인
  - 로그인 유지: 로컬 스토리지를 사용하여 자동로그인 기능 구현
  - 지정된 위치에서 활성화되는 출퇴근 버튼을 구현하여 db로 리스트 출력
- **사원마이페이지**
  - 사원이 개인정보를 조회하는 페이지로 남은 연차 개수를 표시하도록 구현
  - 정보 변경기능: 사원이 개인정보를 변경하는 것이 가능
- **사원조회**
  - 조회 페이지의 첫 화면에서 사원이 다른 사원을 검색하고 정렬할 수 있도록 구현
  - 상세내역으로 보이는 사원정보는 인사팀이 가진 사원 테이블에서 일부만 보이도록 구현

**[ 임지예 ]**
- **사원리스트**
  - jqgrid 를 활용하여 사원리스트를 출력
  - poi.jar를 통해 전체사원·선택한 사원 리스트 다운로드를 구현
  - 재직자, 퇴사자에 따라 증명서를 나누고 프린트가 가능하도록 구현
  - 연차이력을 확인 할 수 있도록 리스트 구현
- **사원추가**
  - javascript를 활용하여 입력폼 유효성 검사를 구현
  - 다음주소 API를 활용하여 주소검색을 할 수 있도록 구현
  - poi.jar를 통해 사원 대량업로드를 구현
- **부서·팀 관리**
  - 모달창과 Ajax를 통해 추가·수정·삭제를 진행하고 성공 및 실패 알림창이 뜨도록 구현
- **차트**
  - Chart.js룰 통해 조직 내 인원 동향을 직관적으로 파악할 수 있도록 구현

 **[ 김미진 ]**
- **시설비품관리**
  - jqgrid를 이용하여 시설비품목록 출력
  - 카테고리 및 사용여부 별 검색기능 구현
  - 모달창을 이용한 시설비품 추가 및 수정 기능 구현
  - 시설비품 분류(카테고리) 관리기능(추가, 수정) 구현
  - javascript를 이용하여 각 입력값의 유효성 검사 진행
- **시설비품 예약**
  - 일별 시설비품 예약현황 출력
  - 날짜 및 분류 별 예약기능 구현
  - jqgrid를 이용하여 사원별 예약이력 목록을 출력
  - 예약시작시간에 따른 예약취소 기능 구현
- **채팅**
  - WebSocket을 이용하여 실시간 채팅기능 구현
