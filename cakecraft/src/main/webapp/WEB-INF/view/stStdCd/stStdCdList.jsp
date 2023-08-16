<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>stStdCdList</title>
</head>
<body>
<h1>팀 부서 관리</h1>
<c:forEach items="${deptList}" var="d">
    <br>
    부서 : ${d.cdNm}
    <br>
    <c:forEach items="${teamListMap[d.cd]}" var="t">
        팀 : ${t.cdNm}
    </c:forEach>
</c:forEach>
</body>
</html>