<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layout/cdn.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
</head>
<body>
<jsp:include page="/layout/header.jsp"></jsp:include>
<!-- 제목 -->
<div class="main-container">
	<div class="pd-ltr-20 xs-pd-20-10">
		<div class="min-height-200px">
			<div class="page-header">
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="title">
							<h4>차트</h4>
						</div>
						<nav aria-label="breadcrumb" role="navigation">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="index.html">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">차트</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<div class="row clearfix">
				<div class="col-md-6 col-sm-12 mb-30">
					<div class="pd-20 card-box height-100-p">
					<!-- 해당년 입사자 퇴사자 -->
					<canvas id="YearCntChart" style="width:100%;max-width:600px"></canvas>
					<script> 
					const YearCntxValues = ["입사자", "퇴사자"];
					const YearCntyValues = [${hireYearCnt}, ${retireYearCnt}];
					const barColors = ["blue", "black"];
					
					new Chart("YearCntChart", {
					  type: "bar",
					  data: {
					    labels: YearCntxValues,
					    datasets: [{
					      backgroundColor: barColors,
					      data: YearCntyValues
					    }]
					  },
					  options: {
						responsive: false, 
					    legend: {display: false},
					    title: {
					      display: true,
					      text: "${year}년 입사자 퇴사자"
					    }
					  }
					});
					</script>
					<!-- 해당년 입사자 퇴사자 끝 -->
			</div>
		</div>	
			<div class="col-md-6 col-sm-12 mb-30">
				<div class="pd-20 card-box height-100-p">
				<canvas id="genderCntChart" style="width:100%;max-width:600px"></canvas>
				<!--  재직자 성별 비율 -->
				<script>
				const genderxValues = ["남자", "여자"];
				const genderyValues = [${maleCnt}, ${femaleCnt}];
				const genderColors = ["blue", "red"];
				
				new Chart("genderCntChart", {
				  type: "pie",
				  data: {
				    labels: genderxValues,
				    datasets: [{
				      backgroundColor: genderColors,
				      data: genderyValues
				    }]
				  },
				  options: {
					responsive: false, 
				    title: {
				      display: true,
				      text: "재직자 성별비율"
				    }
				  }
				});
				</script>
				<!--  재직자 성별 비율 끝-->
				</div>
			</div>
			<div class="col-md-6 col-sm-12 mb-30">
				<div class="pd-20 card-box height-100-p">
		        <!-- 부서별 인원수 차트 -->
		        <canvas id="deptCntChart" style="width:100%;max-width:600px"></canvas>
		        
		        <script>
		        // 부서별 데이터를 저장할 배열들
		        const deptCntxValues = [];
		        const deptCntyValues = [];
		        const deptColors = ["red", "orange", "yellow", "green"];
		        
		        // 부서별 데이터 반복문
		        <c:forEach items="${deptCnt}" var="dept">
		            deptCntxValues.push("${dept.deptName}");
		            deptCntyValues.push(${dept.deptCnt});
		        </c:forEach>
		        // 차트생성
		        new Chart("deptCntChart", {
		            type: "bar",
		            data: {
		                labels: deptCntxValues,
		                datasets: [{
		                    backgroundColor: deptColors,
		                    data: deptCntyValues
		                }]
		            },
		            options: {
		                responsive: false, 
		                legend: { display: false },
		                title: {
		                    display: true,
		                    text: "부서별 재직자 수"
		                },
		                scales: {
		                    yAxes: [{
		                        ticks: {
		                            beginAtZero: true // Y축 시작값을 0으로 지정
		                        }
		                    }]
		                }
		            }
		        });
		        </script>
		        </div>
		    </div>
			<div class="col-md-6 col-sm-12 mb-30">
				<div class="pd-20 card-box height-100-p">
		        <!-- 팀별 인원수 차트 -->
		        <canvas id="teamCntChart" style="width:100%;max-width:600px"></canvas>
		        
		        <script>
		        // 팀별 데이터를 저장할 배열들
		        const teamCntxValues = [];
		        const teamCntyValues = [];
		        const teamColors = ["red","red","red","red", "orange","orange","yellow","yellow","yellow", "green"];
		        
		        // 팀별 데이터 반복문
		        <c:forEach items="${teamCnt}" var="team">
		            teamCntxValues.push("${team.teamName}");
		            teamCntyValues.push(${team.teamCnt});
		        </c:forEach>
		        
		        // 차트 생성
		        new Chart("teamCntChart", {
		            type: "horizontalBar", // 수평 막대 바 차트로 설정
		            data: {
		                labels: teamCntxValues,
		                datasets: [{
		                    backgroundColor: teamColors,
		                    data: teamCntyValues
		                }]
		            },
		            options: {
		                indexAxis: 'y', // Y축을 인덱스로 설정하여 오른쪽 방향으로 커지도록 설정
		                responsive: false, 
		                legend: { display: false },
		                title: {
		                    display: true,
		                    text: "팀별 재직자 수"
		                },
		                scales: {
		                    x: {
		                        beginAtZero: true // X축 시작값을 0으로 지정
		                    }
		                }
		            }
		        });
		        </script>
		    </div>
		</div>
			<div class="col-md-6 col-sm-12 mb-30">
				<div class="pd-20 card-box height-100-p">
		        <!-- 월별 입사자 퇴사자 -->
		        <canvas id="monthCntChart" style="width:100%;max-width:600px"></canvas>
		
		        <script>
			    const monthCntxValues = [1,2,3,4,5,6,7,8,9,10,11,12];
			    const hireData = [];
			    const retireData = [];
			
			    // MonthCntMap를 JSP 코드로 순회하며 데이터 채우기
			    <c:forEach items="${MonthCntMap}" var="m">
			        if ("${m.key}".endsWith("_hire")) {
			            const monthIndex = parseInt("${m.key}".replace("_hire", "")) - 1;
			            hireData[monthIndex] = ${m.value[0]};
			        } else if ("${m.key}".endsWith("_retire")) {
			            const monthIndex = parseInt("${m.key}".replace("_retire", "")) - 1;
			            retireData[monthIndex] = ${m.value[0]};
			        }
			    </c:forEach>
			    
			    new Chart("monthCntChart", {
			        type: "line",
			        data: {
			            labels: monthCntxValues,
			            datasets: [
			                { 
			                    data: hireData,
			                    borderColor: "blue",
			                    fill: false
			                }, 
			                { 
			                    data: retireData,
			                    borderColor: "red",
			                    fill: false
			                }
			            ]
			        },
			        options: {
			            legend: {display: false},
			        title: {
	                    display: true,
	                    text: "${year}년 월별 입사자 퇴사자" }
			        }
			    });
				</script>
		        <!--  월별 입사자 퇴사자 끝-->
		    	</div>
		    </div>
			<div class="col-md-6 col-sm-12 mb-30">
				<div class="pd-20 card-box height-100-p">
		        <!-- 직급별 인원수 바 차트 -->
		        <canvas id="positionCntChart" style="width:100%;max-width:600px"></canvas>
		        
		        <script>
		        const positionCntxValues = [];
		        const positionCntyValues = [];
		    
		        <c:forEach items="${positionCnt}" var="position">
		            positionCntxValues.push("${position.positionName}");
		            positionCntyValues.push(${position.positionCnt});
		        </c:forEach>
		    
		        new Chart("positionCntChart", {
		            type: "bar", // 바 차트로 변경
		            data: {
		                labels: positionCntxValues,
		                datasets: [{
		                    backgroundColor:  ["black","purple","blue","green", "yellow","orange","red"], // 적절한 색상으로 변경
		                    data: positionCntyValues
		                }]
		            },
		            options: {
		                responsive: false, 
		                legend: {display: false},
		                title: {
		                    display: true,
		                    text: "직급별 인원 수"
		                },
		                scales: {
		                    yAxes: [{
		                        ticks: {
		                            beginAtZero: true // y축을 0부터 시작하도록 설정
		                        }
		                    }]
		                }
		            }
		        });
		        </script>
			</div>
		</div>
	</div>
</div>
</div>	
</div>
</body>
</html>