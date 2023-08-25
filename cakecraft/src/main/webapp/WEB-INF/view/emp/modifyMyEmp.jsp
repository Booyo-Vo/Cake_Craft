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
    $('form').submit(function(event) {
        // 입력 필드 값 가져오기
        var empName = $('input[name="empName"]').val();
        var address = $('input[name="address"]').val();
        var empPhone = $('input[name="empPhone"]').val();

        // 공백 체크
        if (empName.trim() === '' || address.trim() === '' || empPhone.trim() === '') {
            alert('필수 입력 항목을 모두 입력해주세요.');
            event.preventDefault(); // 폼 제출 중지
        }
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
                        <img src="${pageContext.request.contextPath}/signImg/${empBase.signFilename}" alt="사인 이미지" style="width: 200px; height: 200px;">
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
</div>
</body>
</html>