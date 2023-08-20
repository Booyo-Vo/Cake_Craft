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

<h3>사원정보</h3>
	<div>
	    <!-- EmpBase 객체의 id 필드 값 출력 -->
	   이름 ${empbase.empName}
	</div>
	<div>
	   사원번호 ${empbase.id}
	</div>
	<div>
	    부서 ${empbase.deptNm}
	</div>
	<div>
	    팀 ${empbase.teamNm}
	</div>
	<div>
	    직급 ${empbase.positionNm}
	</div>
	<div>
	    이메일 ${empbase.email}
	</div>

</div>
</body>
</html>