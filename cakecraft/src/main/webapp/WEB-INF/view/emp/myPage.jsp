<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cake Craft</title>
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
	   <p>서명: ${empBase.signFilename}</p>
	   <c:if test="${not empty empBase.signFilename}">
	   		<img src="${pageContext.request.contextPath}/signImg/${empBase.signFilename}" alt="signImg" style="width: 200px; height: 200px;">
	   </c:if>
	   <c:if test="${empty empBase.signFilename}">
	   		(비어있음)
	   </c:if>
	   <c:choose>
        <c:when test="${empty empBase.signFilename}">
            <button id="addSignature">서명 추가</button>
        </c:when>
        <c:otherwise>
            <button id="addSignature">서명 수정</button>
        </c:otherwise>
    </c:choose>
	<!-- 서명 모달 -->
		<div class="modal fade" id="signatureModal" tabindex="-1" role="dialog" aria-labelledby="signatureModalLabel" aria-hidden="true">
		    <div class="modal-dialog modal-dialog-centered" role="document">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="signatureModalLabel">서명 추가</h5>
		                <button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close">
		                    <span aria-hidden="true">&times;</span>
		                </button>
		            </div>
		            <div class="modal-body">
		                <canvas id="modalGoal" style="border: 1px solid black"></canvas>
		                <div>
		                    <button id="modalClear" class="btn btn-default">Clear</button>
		                    <button id="modalSend" class="btn btn-default">Send</button>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
	<div>
		<!-- db에 프로필 사진이 없을 경우 기본 이미지를 띄운다 -->
		<p>프로필 사진: ${empBase.profileFilename}</p>
		<c:if test="${not empty empBase.profileFilename}">
		    <img src="${pageContext.request.contextPath}/profileImg/${empBase.profileFilename}" alt="employee image" style="width: 200px; height: 200px;">
		</c:if>
		<c:if test="${empty empBase.profileFilename}">
		    <img src="${pageContext.request.contextPath}/profileImg/profile.png" alt="default profile image" style="width: 100px; height: 100px;">
		</c:if>
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
<script>

// 모달 내부의 서명 기능과 관련된 스크립트
$(document).ready(function() {

    // 서명 추가 버튼 클릭 시 모달 열기
    $('#addSignature').click(function() {
        $('#signatureModal').modal('show'); // 모달 열기
    });
	
    // 모달 내부의 서명 기능과 관련된 스크립트
    let goal = $('#goal')[0];
    let signModal = new SignaturePad(document.getElementById('modalGoal'), {
        minWidth: 2,
        maxWidth: 2,
        penColor: 'rgb(0, 0, 0)'
    });
  	//서명 지우기
    $('#modalClear').click(function() {
        signModal.clear();
    });
	//서명 저장
    $('#modalSend').click(function() {
        if (signModal.isEmpty()) {
            alert('내용이 없습니다.');
        } else {
            $.ajax({
                url: '/cakecraft/emp/addsign',
                data: { sign: signModal.toDataURL('image/png', 1.0) },
                type: 'post',
                success: function(jsonData) {
                    alert('이미지 전송 성공! - ' + jsonData);
                    $('#signatureModal').modal('hide'); // 이미지 전송 성공 후 모달 닫기
                }
            });
        }
    });

});
</script>
</html>