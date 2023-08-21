<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cake Craft</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
<a href="/cakecraft/emp/empList" class="btn">사원조회</a>
<button type="button">출근이력</button>
 <h3>마이페이지</h3>
	<div>
	    <!-- EmpBase 객체의 id 필드 값 출력 -->
	   사번 ${loginId}
	</div>
	<div>
	   서명 ${empBase.signFilename}
	   <button type="button">서명 추가</button>
	</div>
	<div>
	   사진
		<p>Profile Filename: ${empBase.profileFilename}</p>
		<c:choose>
		<!--empty empBase.profileFilename가 존재할 경우 띄우고  -->
        <c:when test="${not empty empBase.profileFilename}">
            <img src="${pageContext.request.contextPath}/profileImg/${empBase.profileFilename}" alt="employee image" style="width: 200px; height: 200px;">
        </c:when>
        <!--empty empBase.profileFilename가 없을 경우 아래 기본이미지를 띄운다  -->
        <c:otherwise>
            <img src="${pageContext.request.contextPath}/profileImg/profile.jpg" alt="default profile image" style="width: 200px; height: 200px;">
        </c:otherwise>
    </c:choose>
	
	</div>
	<div>
	    입사일 ${empBase.hireDate}
	</div>
	<div>
	    부서 ${empBase.deptNm}
	</div>
	<div>
	    팀 ${empBase.teamNm}
	</div>
	<div>
	    직급 ${empBase.positionNm}
	</div>
	<div>
	    주민등록번호 ${empBase.socialNo}
	</div>
	<div>
	    이름 ${empBase.empName}
	</div>
	<div>
	    핸드폰번호 ${empBase.empPhone}
	</div>
	<div>
	    email ${empBase.email}
	</div>
	<div>
	    address ${empBase.address}
	</div>
	<div>
	    dayoffCnt ${empBase.dayoffCnt}
	</div>
	<a href="/cakecraft/emp/modifyMyEmp" class="btn">정보수정</a>
	</div>
</body>
</html>