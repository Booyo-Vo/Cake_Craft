<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>schedule.jsp</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<h1>${targetYear}년 ${targetMonth+1}월 </h1>
<a href="/schedule?targetYear=${targetYear}&targetMonth=${targetMonth-1}">이전</a>
<a href="/schedule?targetYear=${targetYear}&targetMonth=${targetMonth+1}">다음</a>
<div class="container">
	<div class="row">
		<!-- calendar -->
		<div class="col-8">
			<table class="table">
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
									<c:if test="${fn:substring(c.startDtime, 8, 10) == d}">
										<div>
											<c:if test="${c.categoryCd == '1'}">
												<span style="color:blue">●</span><span> ${c.scheduleContent}</span>
											</c:if>
											<c:if test="${c.categoryCd == '2'}">
												<span style="color:red">●</span><span> ${c.scheduleContent}</span>
											</c:if>
											<c:if test="${c.categoryCd == '3'}">
												<span style="color:black">●</span><span> ${c.scheduleContent}</span>
											</c:if>
										</div>
									</c:if>
								</c:forEach>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</table>
		</div>
		<!-- today schedule -->
		<div class="col-4">
			<div class="mb-5">
				<span style="color:blue">●</span> 전사일정
				<c:forEach var="c" items="${scheduleListByDate}">
					<c:if test="${c.categoryCd == '1'}">
						<div>
							<span> ${c.scheduleContent}</span>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="mb-5">
				<span style="color:red">●</span> 팀일정
				<c:forEach var="c" items="${scheduleListByDate}">
					<c:if test="${c.categoryCd == '2'}">
						<div>
							<span> ${c.scheduleContent}</span>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div>
				<span style="color:black">●</span> 개인일정
				<c:forEach var="c" items="${scheduleListByDate}">
					<c:if test="${c.categoryCd == '3'}">
						<div>
							<span>${c.scheduleContent}</span>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
</body>
</html>