<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script>
$(document).ready(function() {
	// 문서구분 선택이 변경되었을 때 실행
	$('select[name="documentNm"]').change(function() {
		var selectedDoc = $(this).val();
		var docSubSelect = $('select[name="documentSubNm"]');

		if (selectedDoc !== '') {
			docSubSelect.prop('disabled', false);
			
			// AJAX 요청을 통해, 문서구분에 따른 하위 항목 리스트를 가져온다
			$.get('/cakecraft/stStdCd/getDocSubListByDoc?docNm=' + selectedDoc, function(docSubs) {
				docSubSelect.empty();
				$.each(docSubs, function(index, docSub) {
					docSubSelect.append($('<option>', {
						value: docSub.cdNm,
						text: docSub.cdNm
					}));
				});
			});
		} else {
			docSubSelect.prop('disabled', true);
			docSubSelect.empty();
		}
	});
	
	// 페이지 로드 시에 기본으로 선택된 문서구분에 해당하는 하위 항목 리스트 표시
	var initialSelectedDoc = $('select[name="documentNm"]').val();
	if (initialSelectedDoc !== '') {
		var initialDocSubSelect = $('select[name="documentSubNm"]');
		$.get('/cakecraft/stStdCd/getDocSubListByDoc?docNm=' + initialSelectedDoc, function(docSubs) {
			initialDocSubSelect.empty();
			$.each(docSubs, function(index, docSub) {
				initialDocSubSelect.append($('<option>', {
					value: docSub.cdNm,
					text: docSub.cdNm
				}));
			});
			initialDocSubSelect.prop('disabled', false);
		});
	}
});
</script>
<script>
	$(document).ready(function(){
		// 파일 개수 3개제한
		$('#addFile').click(function(){
			if ($('.files').length >= 3) {
				swal({
					type: 'warning',
					title: '경고',
					text: '최대 3개의 파일만 첨부할 수 있습니다.',
				});
			} else if ($('.files').last().val() == ''){
				swal({
					type: 'warning',
					title: '경고',
					text: '파일 선택란이 비어있습니다.',
				});
			} else {
				var newInput = $('<input class="files" type="file" name="multipartFiles" id="multipartFiles" ><br>');
				$('#files').append(newInput);
			}
		});

		$('#removeFile').click(function(){
			var visibleFiles = $('.files:visible');
			if (visibleFiles.length === 1) {
				if (visibleFiles.val() !== "") {
					visibleFiles.val("");
				} else {
					swal({
						type: 'warning',
						title: '경고',
						text: '더 이상 삭제할 파일이 없습니다.',
					});
				}
			} else {
				visibleFiles.last().prev().remove(); // 직전의 <input>을 제거
				visibleFiles.last().remove(); // 현재 <input>을 제거
			}
		});

		// 파일 용량 3MB 제한 / 확장자 제한
		$(document).on("change", "input[name='multipartFile']", function() {
			var maxSize = 3 * 1024 * 1024;
			var allowedExtensions = ["xlsx", "docs", "hwp", "pdf", "pptx", "ppt", "jpg", "jpeg", "png"];

			var file = this.files[0];
			var fileSize = file.size;
			var fileExtension = file.name.split('.').pop().toLowerCase();

			if (fileSize > maxSize) {
				swal({
					type: 'warning',
					title: '용량을 확인하세요',
					text: '3MB 이내로 등록 가능합니다.',
				});
				$(this).val('');
				return false;
			}

			if (allowedExtensions.indexOf(fileExtension) === -1) {
				swal({
					type: 'warning',
					title: '확장자를 확인하세요',
					text: '업로드 가능 확장자 : xlsx, docs, hwp, pdf, pptx, ppt, jpg, jpeg, png',
				});
				$(this).val('');
				return false;
			}
		});
	});
</script>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<div class="main-container">
<!-- 모달창 -->
<div class="modal fade" id="testModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title" id="exampleModalLabel">사원이름검색</h3>
			</div>
			<div class="modal-body">
				<!-- 모달 내용에 선택 값을 입력하는 입력란 -->
				<div style="display: inline-block">
					<input type="text" id="selectedValue" class="form-control" placeholder="선택한 값을 입력하세요">
				</div>
				<div style="display: inline-block">
					<button type="button" class="btn btn-primary" id="selectedValueBtn">검색</button>
				</div>
				<table id="employeeTable" border="1">
				</table>
			</div>
			<div class="modal-footer">
				<input type="hidden" id="modalValue">
					<a class="btn" id="modalY">선택</a>
					<button class="btn" type="button" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<div class="pd-ltr-20 xs-pd-20-10">
	<form action="/cakecraft/approval/addApprDoc" method="post" name="requestForm" id="requestForm" enctype="multipart/form-data">
		<div class="min-height-200px">
			<div class="invoice-wrap">
				<div class="invoice-box">
					<div class="invoice-header">
					</div>
					<h4 class="text-center mb-30 weight-600">기 안 서</h4>
					<br>
					<div class="row pb-30">
						<div class="col-md-6">
						</div>
						<div class="col-md-6">
							<div class="text-center">
								<table class="table table-bordered">
									<tr>
										<td rowspan="3">결<br>재</td>
										<td>
											<input type="text" class="form-control" name="approvalIdLv1" id="approvalIdLv1" value="${loginId}" readonly="readonly">
										</td>
										<td>
											<input type="text" class="form-control" name="approvalIdLv2" id="approvalIdLv2" value="" readonly="readonly" onClick="modalcall('approvalIdLv2')" placeholder="검색">
										</td>
										<td>
											<input type="text" class="form-control" name="approvalIdLv3" id="approvalIdLv3" value="" readonly="readonly" onClick="modalcall('approvalIdLv3')" placeholder="검색">
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<div class="invoice-desc pb-30">
						<table class="table table-bordered">
							<tr>
								<td>문서번호</td>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr>
								<td>문서구분</td>
								<td style="width: 290px;">
								<select class="form-control" name="documentNm" id="documentNm">
									<c:forEach items="${docCodeList}" var="dc">
										<option value="${dc.cdNm}">${dc.cdNm}</option>
									</c:forEach>
								</select>
								</td>
								<td>항목구분</td>
								<td>
									<select class="form-control" name="documentSubNm" id="documentSubNm">
										<c:forEach items="${docSubCodeList}" var="dsc">
											<option value="${dsc.cdNm}">${dsc.cdNm}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
								<tr>
								<td>기안자</td>
								<td>${loginId}</td>
								<td>참조자</td>
								<td>
									<input type="text" class="form-control" name="refId" id="refId" value="" readonly="readonly" onClick="modalcall('refId')" placeholder="검색">
								</td>
							</tr>
							<tr>
								<td>기안일자</td>
								<td colspan="3"><input type="text" class="form-control" name="crntDT" id="crntDT" value="${currentDate}"></td>
							</tr>
							<tr>
								<td>시행일자</td>
								<td colspan="3">
								<div style="display: inline-block;">
									<input type="datetime-local" class="form-control" name="startDay" id="startDay" value="${apprDocByNo.startDay}">
								</div>	
								&nbsp; ~ &nbsp;
								<div style="display: inline-block;">	
									<input type="datetime-local" class="form-control" name="endDay" id="endDay" value="${apprDocByNo.startDay}">
								</div>
								</td>
							</tr>
							<tr>
						</table> 
						<div class="form-group">
                           <input type="text" class="form-control" name="documentTitle" id="documentTitle" placeholder="제목을 입력하세요" value="">
                        </div>
						<div class="form-group">
                           <textarea class="textarea_editor form-control border-radius-0" name="documentContent" id="documentContent" placeholder="내용을 입력하세요"></textarea>
                        </div>
						
						<label for="files">첨부파일</label>
		                <button type="button" class="btn btn-secondary" id="addFile">추가</button>
		                <button type="button" class="btn btn-secondary" id="removeFile">삭제</button>
			            <div class="form-group" id="files">
			                <input class="files" type="file" name="multipartFiles" id="multipartFiles" multiple="multiple"><br>
			            </div>
					</div>
				</div>
			</div>
		</div>
		
		<br>
		
		<!-- 기본값을 N으로 설정 -->
		<input type="hidden" name="tempSave" id="tempSave" value="N">
		<input type="hidden" name="documentNo" id="documentNo" value="">
		<input type="hidden" name="documentCd" id="documentCd" value="">
		<input type="hidden" name="documentSubCd" id="documentSubCd" value="">
		
		
		<div>
			<h1 class="text-center pb-20">
				<button type="button" class="btn btn-secondary" onclick="tempSaveAndSubmit()">임시저장</button>
				<button type="button" class="btn btn-primary" id="submitBtn" onclick="submitForm1()">제출하기</button>
			</h1>
		</div>
	</form>
</div>
</div>
<jsp:include page="/layout/footer.jsp"></jsp:include>
<script>
	// 임시저장 버튼을 눌렀을 때 호출되는 함수
	function tempSaveAndSubmit() {
		$("#tempSave").val('Y'); // tempSave 값을 Y로 설정	
		var formdata = new FormData();
	    formdata.append("documentNm", $("#documentNm").val());
	    formdata.append("documentSubNm", $("#documentSubNm").val());

	    // 파일을 추가하지 않고 서버로 요청을 보냄
	    $.ajax({
	        url: "/cakecraft/approval/fileAddApprDoc",
	        data: formdata,
	        processData: false,    // 필수
	        contentType: false,    // 필수
	        method: "post",
	        cache: false,
	        enctype: "multipart/form-data",
	        dataType: "json",
	        success: function (data) {
	            console.log(data);
	            if (data.success === "Y") {
	                $("#documentNo").val(data.documentNo);
	                $("#documentCd").val(data.documentCd);
	                $("#documentSubCd").val(data.documentSubCd);
	                console.log(data.documentNo);
	                $("#requestForm").submit();
	            } else {
	                alert("잠시 후 다시 시도해주세요.");
	            }
	        },
	        error: function (error) {
	            console.log("Error:", error);
	        }
	    });
	}
	
	// 제출하기 버튼을 눌렀을 때 호출되는 함수
	function submitForm1() {
		var formdata = new FormData();
		var fileLength = $(".files").length;
		formdata.append("documentNm",$("#documentNm").val());
		formdata.append("documentSubNm",$("#documentSubNm").val());
		for(var i=0; i < fileLength; i++){
			if($(".files")[i].files[0] != null){
				formdata.append("fileList", $(".files")[i].files[0]);
			}
		}
		
		$.ajax({
			url : "/cakecraft/approval/fileAddApprDoc",
			data : formdata,
			processData: false,	// 필수
			contentType: false,	// 필수
			method : "post",
			cache: false,
			enctype : "multipart/form-data",
			dataType: "json",
			success : function(data){
				console.log(data);
				if(data.success === "Y"){
					$("#documentNo").val(data.documentNo);
					$("#documentCd").val(data.documentCd);
					$("#documentSubCd").val(data.documentSubCd);
					console.log(documentNo);
					$("#requestForm").submit();			
					
				} else {
					alert("잠시 후 다시 시도해주세요.");
				}
		    },
		    error: function(error) {
		        console.log("Error:", error);
		    }
		});
	}

	// 모달창 호출 	
	function modalcall(value){
		console.log(value);
		
		// 테이블 초기화 (모든 검색 결과 삭제)
		$('#employeeTable').empty();
		// 선택한 값을 입력하는 입력란 초기화
		$('#selectedValue').val("");
		//window.document.preventDefault();
		$('#modalValue').val(value);
		$('#testModal').modal("show");
	}

	// 검색 결과
	$('#selectedValueBtn').click(function() {
		// 테이블 초기화 (모든 검색 결과 삭제)
		$('#employeeTable').empty();
		let empName = $('#selectedValue').val();
		console.log('empName param : ' + empName);
		$.ajax({
			url : '${pageContext.request.contextPath}/searchEmpListByNm',
			type : 'post',
			data : {empName : empName},	// json배열{키 : 값}
			success: function(data) {
				console.log('성공');
				// 서버로부터 받은 데이터(data)를 사용하여 DOM을 조작
				for (var i = 0; i < data.length; i++) {
					var employee = data[i];
					var newRow = '<tr>' +
						'<td><input type="radio" name="selectNm" value="' + employee.id + '"></td>' +
								'<td>' + employee.id + '</td>' +
								'<td>' + employee.empName + '</td>' +
								'<td>' + employee.deptNm + '</td>' +
								'<td>' + employee.teamNm + '</td>' +
								'<td>' + employee.positionNm + '</td>' +
								'</tr>';
					$('#employeeTable').append(newRow); // 예시로 데이터를 테이블에 추가
				}
			},
			error: function(error) {
				console.log('Error:', error);
			}
		});
	});
	
	$('#modalY').click(function() {
		let modalValue = $('#modalValue').val();

		// 모달 내의 입력란에서 값 가져오기
		var selectedValue = $('input[name="selectNm"]:checked').val();

		// 부모 창의 입력란에 값 설정
		$('#'+modalValue).val(selectedValue);

		// 모달 창 닫기
		$('#testModal').modal("hide");
	});
</script>
</body>
</html>