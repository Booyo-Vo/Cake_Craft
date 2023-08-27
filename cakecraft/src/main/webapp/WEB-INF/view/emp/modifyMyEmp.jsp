<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cake Craft</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
$(document).ready(function() {
    // 비밀번호 변경 모달 띄우기
    $('#changePasswordBtn').click(function() {
        $('#changePasswordModal').modal('show');
    });

    // 비밀번호 변경 폼 제출
    $('#confirmPasswordBtn').click(function() {
        let currentPassword = $('#currentPassword').val();
        let newPassword = $('#newPassword').val();
        let confirmPassword = $('#confirmPassword').val();

        // 입력값 유효성 검사
        if (currentPassword.trim() === '' || newPassword.trim() === '' || confirmPassword.trim() === '') {
            alert('필수 입력 항목을 모두 입력해주세요.');
            return;
        }

        if (newPassword !== confirmPassword) {
            alert('새 비밀번호가 일치하지 않습니다.');
            return;
        }

        // 폼 데이터 생성
        var formData = {
            currentPassword: currentPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword
        };

        // 비밀번호 변경 폼 제출
        $.post('/cakecraft/emp/changePw', formData)
            .done(function(response) {
                // 성공적으로 처리된 경우의 동작
                alert('비밀번호 변경 성공');
                console.log("비밀번호 변경 성공");
            	 // 모달 닫기
                $('#changePasswordModal').modal('hide');
            })
            .fail(function(error) {
                // 오류 발생 시의 동작
                alert('비밀번호 변경 실패');
                console.error("비밀번호 변경 오류");
            });
    });
});
</script>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
 <form action="/cakecraft/emp/modifyMyEmp" method="post" enctype="multipart/form-data">
  <table>
            <tr>
                <th>사번</th>
                <td>${empBase.id}</td>
            </tr>
            <tr>
                <th>이름</th>
                <td><input type="text" name="empName" value="${empBase.empName}" /></td>
            </tr>
            <tr>
                <th>서명</th>
                <td>
                    <!-- 기존 사인 이미지 출력 -->
                    <c:if test="${not empty empBase.signFilename}">
                        <img src="${pageContext.request.contextPath}/signImg/${empBase.signFilename}" alt="사인 이미지" style="width: 100px; height: 100px;">
                    </c:if>
                </td>
            </tr>
            <tr>
                <th>프로필 이미지</th>
                <td>
                    <c:if test="${not empty empBase.profileFilename}">
						<img src="${pageContext.request.contextPath}/profileImg/${empBase.profileFilename}" alt="employee image" style="width: 200px; height: 200px;">
					</c:if>
					<c:if test="${empty empBase.profileFilename}">
						<img src="${pageContext.request.contextPath}/profileImg/profile.png" alt="default profile image" style="width: 100px; height: 100px;">
					</c:if>
                    <!-- 프로필 이미지 변경을 위한 업로드 필드 -->
                    <input type="file" name="profileImage" />
                </td>
            </tr>
            <tr>
            	<th>
            		입사일
            	</th>
	            <td>
					${empBase.hireDate}
				</td>
			</tr>
            <tr>
                <th>부서</th>
                <td><input type="hidden" name=deptCd value="${empBase.deptCd}" readonly="readonly" />${empBase.deptNm}</td>
            </tr>
            <tr>
                <th>팀</th>
                <td><input type="hidden" name=teamCd value="${empBase.teamCd}" readonly="readonly"/>${empBase.teamNm}</td>
            </tr>
            <tr>
                <th>직급</th>
                <td><input type="hidden" name=positionCd value="${empBase.positionCd}" readonly="readonly"/>${empBase.positionNm}</td>
            </tr>
            
            <tr>
                <th>이메일</th>
                <td><input type="text" name="email" value="${empBase.email}" /></td>
            </tr>
            
            <tr>
                <th>주소</th>
                <td><input type="text" name="address" value="${empBase.address}" /></td>
            </tr>
            <tr>
                <th>핸드폰번호</th>
                <td><input type="text" name="empPhone" value="${empBase.empPhone}" /></td>
            </tr>
            
            
        </table>
<!-- redirect 할때 id 값이 필요해서 hidden으로 전달함-->
	<input type ="hidden" name="id" value="${empbase.id}">
	<button type="submit">수정</button>
</form>

<form action="/cakecraft/emp/changePw" method="post" id="changePasswordForm">
    <button type="button" id="changePasswordBtn">비밀번호 변경</button>
</form>

<!-- 비밀번호 변경 모달 -->
<div class="modal fade" id="changePasswordModal" tabindex="-1" role="dialog" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="changePasswordModalLabel">비밀번호 변경</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <input type="password" name="currentPassword" id="currentPassword" placeholder="현재 비밀번호">
                <input type="password" name="newPassword" id="newPassword" placeholder="새 비밀번호">
                <input type="password" name="confirmPassword" id="confirmPassword" placeholder="새 비밀번호 확인">
                <button type="button" id="confirmPasswordBtn">확인</button>
                <div id="passwordError" style="color: red;"></div>
            </div>
        </div>
    </div>
</div>


</div>
<jsp:include page="/layout/footer.jsp"></jsp:include>
</body>
</html>