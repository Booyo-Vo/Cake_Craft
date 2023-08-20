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
 <h3>마이페이지</h3>
	<div>
	    <!-- EmpBase 객체의 id 필드 값 출력 -->
	   로그인 아이디 ${loginId}
	</div>
	<div>
	   signFilename ${empSignimg.signFilename}
	   <button type="button">서명 추가</button>
	</div>
	<div>
	    hireDate ${empBase.hireDate}
	</div>
	<div>
	    deptCd ${empBase.deptCd}
	</div>
	<div>
	    teamCd ${empBase.teamCd}
	</div>
	<div>
	    positionCd ${empBase.positionCd}
	</div>
	<div>
	    socialNo ${empBase.socialNo}
	</div>
	<div>
	    empName ${empBase.empName}
	</div>
	<div>
	    empPhone ${empBase.empPhone}
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
</div>
</body>
</html>