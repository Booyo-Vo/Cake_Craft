<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
	<div class="pd-ltr-20 xs-pd-20-10">
         <div class="min-height-200px">
            <div class="invoice-wrap">
               <div class="invoice-box">
                  <div class="invoice-header">
                  </div>
                  <h4 class="text-center mb-30 weight-600">기&nbsp;안&nbsp;서</h4>
                  <br>
                  <div class="row pb-30">
                     <div class="col-md-6">
                     </div>
                     <div class="col-md-6">
                        <div class="text-center">
                           <table class="table table-bordered">
                              <tr>
                                 <td rowspan="3">결<br>재</td>
                                 <td>${apprInfoLv1.approvalId}</td><!-- empBase직급가져오기 -->
                                 <td>${apprInfoLv2.approvalId}</td>
                                 <td>${apprInfoLv3.approvalId}</td>
                              </tr>
                              <tr>
                                 <td>
	                                 <c:if test="${apprInfoLv1.approvalStatusCd == 2}">
										<div>사인</div>
										<div>날짜</div>
									 </c:if>
                                 </td>
                                 <td>
	                                 <c:if test="${apprInfoLv2.approvalStatusCd == 2}">
										<div>사인</div>
										<div>날짜</div>
									 </c:if>
                                 </td>
                                 <td>
	                                 <c:if test="${apprInfoLv3.approvalStatusCd == 2}">
										<div>사인</div>
										<div>날짜</div>
									 </c:if>
                                 </td>
                              </tr>
                           </table>
                        </div>
                     </div>
                  </div>
                  <div class="invoice-desc pb-30">
                        <table class="table table-bordered">
                           <tr>
                              <td>문서번호</td>
                              <td colspan="3">${documentNo}</td>
                           </tr>
                           <tr>
                              <td>문서구분</td>
                              <td>${apprDoc.documentNm}</td>
                              <td>항목구분</td>
                              <td>${apprDoc.documentSubNm}</td>
                           </tr>
                           <tr>
                              <td>기안자</td>
                              <td>${apprInfoLv1.approvalId}</td>
                              <td>참조자</td>
                              <td>${apprRef.refId}</td>
                           </tr>
                           <tr>
                              <td>기안일자</td>
                              <td colspan="3">${apprDoc.modDtime}</td>
                           </tr>
                           <tr>
                              <td>시행일자</td>
                              <td colspan="3">
                              ${apprDoc.startDay}
                               ~ 
                              ${apprDoc.endDay}
                              </td>
                           </tr>
                           <tr>
                              <td>문서제목</td>
                              <td colspan="3">${apprDoc.documentTitle}</td>
                           </tr>
                           <tr height="300">
                               <td colspan="4">${apprDoc.documentContent}</td>
                           </tr>
                           <tr>
                              <td>첨부파일</td>
                              <td colspan="3">파일</td>
                           </tr>
                        </table> 
                     </div>
                  </div>
               </div>
            </div>
         </div>
         
	<br>

	<!-- 참조자로 지정된 경우 : 버튼 없음 -->
	<c:if test="${apprHist.approvalLevel eq ''}"></c:if>
	
	<!-- 결재자로 지정된 경우 : 승인 / 반려 -->
	<c:if test="${(apprHist.approvalLevel == 2 && apprHist.approvalStatusCd == 1) 
				|| (apprHistPreLv.approvalStatusCd == 2	&& apprHist.approvalLevel == 3 && apprHist.approvalStatusCd == 1)}">
		<div>
			<h1 class="text-center pb-20">
				<button type="button" class="btn btn-primary" onclick="apprAccept()">승인</button>
				<button type="button" class="btn btn-secondary" onclick="apprReturn()">반려</button>
			</h1>
		</div>
	</c:if>
</div>

<script>
	// 승인버튼을 눌렀을 때 호출되는 함수
	function apprAccept() {
		var documentNo = 
	}
	
	// 반려버튼을 눌렀을 때 호출되는 함수
	function apprReturn() {
		
	}

</script>
</body>
</html>