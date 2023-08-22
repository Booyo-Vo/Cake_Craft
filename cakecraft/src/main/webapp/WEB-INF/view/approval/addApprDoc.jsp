<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<head>
<meta charset="UTF-8">
<script>
function submitForm() {
    var tableContent = $("#testid table").prop('outerHTML');  // 테이블 내용을 가져옴

    var approvalDocumentCd = $("#approvalDocumentCd").val();
    var id = $("#id").val();
    var documentTitle = $("#documentTitle").val();
    var tempSave = $("#tempSave").val();

    var form = $("<form>").attr({
        "method": "post",
        "action": "/cakecraft/approval/addApprDoc"
    });

    $("<input>").attr({
        "type": "hidden",
        "name": "documentContent",
        "value": tableContent
    }).appendTo(form);

    $("<input>").attr({
        "type": "hidden",
        "name": "approvalDocumentCd",
        "value": approvalDocumentCd
    }).appendTo(form);

    $("<input>").attr({
        "type": "hidden",
        "name": "id",
        "value": id
    }).appendTo(form);

    $("<input>").attr({
        "type": "hidden",
        "name": "documentTitle",
        "value": documentTitle
    }).appendTo(form);

    $("<input>").attr({
        "type": "hidden",
        "name": "tempSave",
        "value": tempSave
    }).appendTo(form);

    form.appendTo("body").submit();
}
</script>
</head>
<body>  
    <h1>기안서</h1>
    <form action="/cakecraft/approval/addApprDoc" method="post">
       <div>
          <div id="testid">
           <table border="1">
               <tr>
                   <th>문서번호</th>
                   <td></td>
                   <th rowspan="3">결<br>재</th>
                   <th>담당자</th>
                   <th>결재자1</th>
                   <th>결재자2</th>
               </tr>
               <tr>
                   <th>문서형식</th>
                   <td><input type="text" name="approvalDocumentCd" value="품의"></td>
                   <td rowspan="2"><input type="text" name="id" value="${loginId}" readonly="readonly"></td>
                   <td rowspan="2"><input type="text" name="approvalIdLv2" value="232211558"></td>
                   <td rowspan="2"><input type="text" name="approvalIdLv3" value="232227088"></td>
               </tr>
               <tr>
                   <th>기안일자</th>
                   <td></td>
               </tr>
               <tr>
                   <th>기 안 자</th>
                   <td><input type="text" name="id" value="${loginId}" readonly="readonly"></td>
                   <th>참<br>조</th>
                   <td colspan="3"></td>
               </tr>
               <tr>
                   <th>제 &nbsp; &nbsp; 목</th>
                   <td colspan="5"><input type="text" name="documentTitle"></td>
               </tr>
               <tr>
                   <th>내 &nbsp; &nbsp; 용</th>
                   <td colspan="5"><input type="text" name="content" size="50"></td>
               </tr>
               <tr>
                   <th>파 &nbsp; &nbsp; 일</th>
                   <td colspan="5"></td>
               </tr>
           </table>
          </div>
        </div>
    <input type="text" id="approvalDocumentCd" value="품의">
    <input type="text" id="id" value="${loginId}" readonly="readonly">
        <input type="hidden" name="tempSave" id="tempSaveField" value="N">
        <button type="button" onclick="tempSave()">임시저장</button>
        
      <button type="button" onclick="submitForm()">제출하기</button>
    </form>
</body>
</html>