<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:import url="/layout/cdn.jsp"></c:import>
</head>
<body>
<c:import url="/layout/header.jsp"></c:import>
<div class="main-container">
	<div class="col-6">
		<label><b>채팅방</b></label>
	</div>
	<div>
		<ul>
			<c:forEach var="r" items="#{chatList}">
				<li><a href="${pageContext.request.contextPath}/chat/room?roomId=${r.roomId}">${r.roomName}</a></li>
			</c:forEach>
		</ul>
		
		<form action="${pageContext.request.contextPath}/chat/room" method="post">
			<input type="hidden" name="regId" value="${loginEmpBase.id}">
			<input type="hidden" name="member" value="${loginEmpBase.id}">
			<input id="roomName" type="text" name="roomName">
			<c:forEach var="e" items="${empList}">
			<div>
				<ul>
					<c:if test="${e.empStatus.equals('재직자')}">
						<li><input type="checkbox" id="${e.id}" name="member" value="${e.id}"><label for="${e.id}">${e.empName}</label></li>
					</c:if>
				</ul>
			</div>	
			</c:forEach>
			<button class="btn btn-secondary">개설하기</button>
		</form>
	</div>
</div>
<script>
	let newRoomName = '${newRoomName}';
	if(newRoomName != ''){
		swal('채팅방알림', roomName+'방이 개설되었습니다.', 'info');
	}
	$('.btn-create').click(function(){
		let name = $('#roomName').val();
		if(name == ''){
			swal('이름입력필요', '채팅방 이름을 입력해주세요', 'warning');
		}else{
			$('form').submit();
		}
	})
</script>
</body>
</html>