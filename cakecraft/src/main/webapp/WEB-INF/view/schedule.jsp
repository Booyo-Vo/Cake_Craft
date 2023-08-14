<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>schedule.jsp</title>
</head>
<body>
<h1>${targetYear}년 ${targetMonth+1}월 </h1>
<a href="/schedule?targetYear=${targetYear}&targetMonth=${targetMonth-1}">이전</a>
<a href="/schedule?targetYear=${targetYear}&targetMonth=${targetMonth+1}">다음</a>
<!-- calendar -->
<table border="1">
	<tr>
		<th>Sun</th>
		<th>Mon</th>
		<th>Tue</th>
		<th>Wed</th>
		<th>Thu</th>
		<th>Fri</th>
		<th>Sat</th>
	</tr>
	<tr>
		<c:forEach var="i" begin="0" end="${totalTd -1}" step="1">
			<c:set var="d" value="${i-beginBlank+1}"></c:set>
			<c:if test="${i!=0 && i%7==0}">
				</tr><tr>
			</c:if>
			<c:if test="${d < 1 || d > lastDate}">
				<td>&nbsp;</td>
			</c:if>
			<c:if test="${!(d < 1 || d > lastDate)}">
				<td>
					${d }
					<c:forEach var="c" items="${scheduleList}">
						<c:if test="${fn: substring(c.startDtime, 8, 10) <= d && fn:substring(c.endDtime, 8, 10) >= d}">
							<div>
								<c:if test="${c.categoryCd == '1'}">
									<span style="color:blue">${c.scheduleContent}</span>
								</c:if>
								<c:if test="${c.categoryCd == '2'}">
									<span style="color:red">${c.scheduleContent}</span>
								</c:if>
								<c:if test="${c.categoryCd == '3'}">
									<span style="color:black">${c.scheduleContent}</span>
								</c:if>
							</div>
						</c:if>
					</c:forEach>
				</td>
			</c:if>
		</c:forEach>
	</tr>
</table>
</body>
</html>