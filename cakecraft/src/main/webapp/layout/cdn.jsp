<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!------------- title ------------->
<title>Cake Craft</title>

<!------------- bootstrap5 ------------->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>


<!------------- 템플릿 ------------->
<!-- Site favicon -->
<link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/layout/vendors/images/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/layout/vendors/images/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="${pageContext.request.contextPath}/layout/vendors/images/favicon-16x16.png">
<!-- Mobile Specific Metas -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<!-- Google Font -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap">
<!-- CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layout/vendors/styles/core.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layout/vendors/styles/icon-font.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layout/vendors/styles/style.css">
<!-- js -->
<script src="${pageContext.request.contextPath}/layout/vendors/scripts/core.js"></script>
<script src="${pageContext.request.contextPath}/layout/vendors/scripts/script.min.js"></script>
<script src="${pageContext.request.contextPath}/layout/vendors/scripts/process.js"></script>
<script src="${pageContext.request.contextPath}/layout/vendors/scripts/layout-settings.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-119386393-1"></script>


<!------------- jqGrid ------------->
<!-- The actual JQuery code -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js" /></script>
<!-- The JQuery UI code -->
<script type="text/javascript" src="https://code.jquery.com/ui/1.10.3/jquery-ui.min.js" /></script>
<!-- The jqGrid language file code -->
<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/i18n/grid.locale-kr.js" /></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/redmond/jquery-ui.css" type="text/css" />
<!-- jqGrid CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/jqgrid/4.6.0/css/ui.jqgrid.css" type="text/css" />
<!-- The atual jqGrid code -->
<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/jquery.jqGrid.src.js" /></script>

<!------------- jqGrid 행높이 조절 ------------->
<style>
	.ui-jqgrid tr.jqgrow { outline-style: none; height: 43px; font-size: 13px; } 
</style>

<!------------- 사인용 캔버스 ------------->
<script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>

<!------------- sweet alert ------------->
<script src="${pageContext.request.contextPath}/layout/src/plugins/sweetalert2/sweetalert2.all.js"></script>
<script src="${pageContext.request.contextPath}/layout/src/plugins/sweetalert2/sweet-alert.init.js"></script>