<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>증빙 승인 관리</title>
<style>
	/* Tabs*/
section {
    padding: 30px 0;
}

section .section-title {
    text-align: center;
    color: #007b5e;
    text-transform: uppercase;
}
#tabs{
	background: #333333;
    color: #eee;
    background-color: rgba( 051,051, 051, 0.8 );
}
#tabs h6.section-title{
    color: #eee;
}
</style>
<script>
	var proofAttdList = [];
	var lastId = 0;

	$(document).ready(
			
			function() {
				$("input:text").button();
				$(".small_Btn").button();

				getDatePicker($("#search_startDate"));
				getDatePicker($("#search_endDate"));

				showCertificateListGrid();

				findCertificateRequestList('모든부서'); // 초기실행일 경우 , 해당일자만 조회함 .

				$("#search_certificate_deptName").click(
						function() {
							getCode("CO-19", "search_certificate_deptName","search_certificate_deptCode");
						}); // 부서선택

				$("#search_startDate").change(
						function() {
							$("#search_endDate").datepicker("option","minDate", $(this).val());
						}); // 시작일

				$("#search_endDate").change(
						function() {
							$("#search_startDate").datepicker("option","maxDate", $(this).val());
						}); // 종료일

				$("#search_certificateList_Btn").click(findCertificateRequestList); // 조회버튼
				$("#apploval_certificate_Btn").click(applovalCertificateRequest); // 승인버튼
				$("#cancel_certificate_Btn").click(cancelCertificateReqeust); // 승인취소버튼
				$("#reject_certificate_Btn").click(rejectCertificateRequest); // 반려버튼
				$("#update_certificate_Btn").click(modifyCertificateRequest); // 확정버튼
			});

	

	/* 증빙승인 조회버튼 함수 */
	function findCertificateRequestList(allDept) {
		var deptName = $("#search_certificate_deptName").val();
		var startDate = $("#search_startDate").val();
		var endDate = $("#search_endDate").val();
		console.log(allDept);
		
		if (allDept == "모든부서") {  //넘어온값이 '모든부서'와 같다면 
			deptName = allDept; 

			var today = new Date();
			var rrrr = today.getFullYear();
			var mm = today.getMonth() + 1;
			var dd = today.getDate();
			startDate = rrrr + "-" + mm + "-" + dd; //시작일을 오늘날짜로 넘긴다
		}		
				$.ajax({
					url : "${pageContext.request.contextPath}/documentmgmt/proof-approval",
					data : {
						"deptName" : deptName,
						"startDate" : startDate,
						"endDate" : endDate,
					},
					dataType : "json",
					success : function(data) {
						if (data.errorCode < 0) {
							var str = "내부 서버 오류가 발생했습니다\n";
							str += "관리자에게 문의하세요\n";
							str += "에러 위치 : " + $(this).attr("id");
							str += "에러 메시지 : " + data.errorMsg;
							alert(str);
							return;
						}
						console.log(data.proofAttdList);
						proofAttdList = data.proofAttdList;
						showCertificateListGrid();
					}
				});
	}

	
	
	/*그리드 띄우는 함수 */
	function showCertificateListGrid() {
		var columnDefs = [ {
			headerName : "부서",
			field : "dept",
			checkboxSelection : true
		}, {
			headerName : "사원번호",
			field : "empCode"
		}, {
			headerName : "사원이름",
			field : "empName"
		}, {
			headerName : "증빙용도",
			field : "proofTypeName"
		}, {
			headerName : "신청일",
			field : "startDate"
		}, {
			headerName : "승인여부",
			field : "applovalStatus"
		}, {
			headerName : "금액",
			field : "cash"
		}, {
			headerName : "사유",
			field : "cause",
			editable : true
		}, {
			headerName : "영수증",
			field : "receipt"
		},
		{headerName: "상태", field: "status",hide:true}
		];
		gridOptions = {
			columnDefs : columnDefs,
			rowData : proofAttdList,
			onCellClicked : function(node) {			// 클릭하면 옆에 div에 뿌려줌
					console.log(node);
					$("#fC").html(node.data.empCode);	
					$("#fN").html(node.data.empName);		// 밑에꺼 제이쿼리로 바꿈 
					$("#fD").html(node.data.dept);
					$("#fP").html(node.data.proofTypeName);
					$("#fE").html(node.data.startDate);
					$("#fM").html(node.data.applovalStatus);
					$("#fB").html(node.data.cash);
					$("#fA").html(node.data.cause);
						
		
			var cash = node.data.cash;
			var profile = node.data.receipt;
			console.log(cash+profile);
		document.getElementById('profileImg').setAttribute("src","${pageContext.request.contextPath}/profile/"+cash+"."+profile);},
		defaultColDef : {
				editable : false,
				width : 100
			},
			rowSelection : 'single', /* 'single' or 'multiple',*/
			enableColResize : true,
			enableSorting : true,
			enableFilter : true,
			enableRangeSelection : true,
			suppressRowClickSelection : false,
			animateRows : true,
			suppressHorizontalScroll : true,
			localeText : { noRowsToShow : '조회 결과가 없습니다.'},
			getRowStyle : function(param) {
				if (param.node.rowPinned) {
					return { 'font-weight' : 'bold', background : '#dddddd' };
				}
				return {'text-align' : 'center'};
			},
			getRowHeight : function(param) {
				if (param.node.rowPinned) {
					return 30;
				}
				return 24;
			},
			// GRID READY 이벤트, 사이즈 자동조정 
			onGridReady : function(event) {
				event.api.sizeColumnsToFit();
			},
			// 창 크기 변경 되었을 때 이벤트 
			onGridSizeChanged : function(event) {
				event.api.sizeColumnsToFit();
			},
			onCellEditingStarted : function(event) {
				console.log('cellEditingStarted');
			},
		}; 
		$('#certificateList_grid').children().remove();
		
		var eGridDiv = document.querySelector('#certificateList_grid');
		new agGrid.Grid(eGridDiv, gridOptions);
	}
	
	
	
	/*  확정버튼 눌렀을 때 실행되는 함수 */
	function modifyCertificateRequest() {
		var sendData = JSON.stringify(proofAttdList);

		$.ajax({
			type : "PUT",
			url : "${pageContext.request.contextPath}/documentmgmt/proof-approval",
			data : sendData,
			contentType:"application/json",
			dataType : "json",
			success : function(data) {
				if (data.errorCode < 0) {
					var str = "내부 서버 오류가 발생했습니다\n";
					str += "관리자에게 문의하세요\n";
					str += "에러 위치 : " + $(this).attr("id");
					str += "에러 메시지 : " + data.errorMsg;
					alert(str);
					} else {
						alert("확정되었습니다");
					}
					
					findCertificateRequestList('모든부서');
					}
				});
	}

	/* 승인버튼 함수 */
	function applovalCertificateRequest() {
		var rowNode = gridOptions.api.getSelectedNodes();
		console.log(typeof rowNode);
		if (rowNode == null) {
			alert("승인할 증빙 항목을 선택해 주세요");
			return;
		}
		
		console.log(rowNode[0].data);
		rowNode[0].setDataValue('applovalStatus', "승인");
		//rowNode[0].setDataValue('rejectCause', "");
		rowNode[0].setDataValue('status', "update");
		console.log(rowNode[0].data);
	}
	/* 승인취소버튼 함수 */
	function cancelCertificateReqeust() {
		var rowNode = gridOptions.api.getSelectedNodes();
		if (rowNode == null) {
			alert("취소할 증빙 항목을 선택해 주세요");
			return;
		}
		rowNode[0].setDataValue('applovalStatus', "승인취소");
		rowNode[0].setDataValue('status', "update");
	}
	
	/* 근태외 반려버튼 함수 */
	function rejectCertificateRequest() {
		var rowNode = gridOptions.api.getSelectedNodes();
		if (rowNode == null) {
			alert("반려할 증빙  항목을 선택해 주세요");
			return;
		}
		rowNode[0].setDataValue('applovalStatus', "반려");
		rowNode[0].setDataValue('status', "update");
	}

	/* 날짜 조회창 함수 */
	function getDatePicker($Obj, maxDate) {
		$Obj.datepicker({
			defaultDate : "d",
			changeMonth : true,
			changeYear : true,
			dateFormat : "yy-mm-dd",
			dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
			monthNamesShort : [ "1", "2", "3", "4", "5", "6", "7", "8", "9","10", "11", "12" ],
			yearRange : "2000:2050",
			showOptions : "up",
			maxDate : (maxDate == null ? "+100Y" : maxDate)
		});
	}

	/* 코드 선택창 띄우는 함수 */
	function getCode(code, inputText, inputCode) {
		option = "width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
		window.open("${pageContext.request.contextPath}/comm/codeWindow/view?code=" + code + 
				"&inputText=" + inputText + "&inputCode="+ inputCode, "newwins", option);
	}
</script>
</head>
<body>
		<section id="tabs" style="height:700px; text-align: center; margin-left:0px;" class="wow fadeInDown">
		
			<h6 class="section-title h3">증빙승인관리</h6>
			<div class="container">
			<hr style="background-color:white; height: 1px;">
			</div>
			
			조회부서 <input type=text id="search_certificate_deptName" readonly>
			<input type=hidden id="search_certificate_deptCode"> 
			신청일자 <input type=text id="search_startDate" readonly> ~ <input type=text id="search_endDate" readonly>
			<button class="btn btn-light btn-sm" id="search_certificateList_Btn">조회하기</button>
			<br /> <br /> <br />
			<button class="btn btn-light btn-sm" id="apploval_certificate_Btn">승인</button>
			<button class="btn btn-light btn-sm" id="cancel_certificate_Btn">승인취소</button>
			<button class="btn btn-light btn-sm" id="reject_certificate_Btn">반려</button>
			<button class="btn btn-light btn-sm" id="update_certificate_Btn">확정</button>
			<br />
			<br />
			<br />
			<div id="certificateList_grid" style="height: 400px; margin : auto; "
				class="ag-theme-balham"></div>
			<div id="certificateList_pager"></div>
	</section>
	<td>
		<section id="tabs" style=" margin-top: 30px;height:400px; text-align: center"class="wow fadeInDown">
		<div class="container">
			<h6 class="section-title h3">증빙내역</h6>
			<hr style="background-color:white; height: 1px;">
				<div style="display: inline-block;">
					 <img id="profileImg" src="" width="200px" height="250px">
				</div>
				<div style=" display: inline-block; position:absolute; margin-left: 50px;" >
					<font>사원코드 : </font> <font id="fC"></font><br/><br/>
					<font>이름 : </font> <font id="fN"></font><br/><br/>
					<font>부서 : </font> <font id="fD"></font><br/>
					<font>증빙종류 : </font> <font id="fP"></font><br/><br/> 
					<font>신청일 : </font> <font id="fE"></font><br/>
					<font>승인여부: </font> <font id="fM"></font><br/>
					<font>금액 : </font> <font id="fB"></font><br/>
					<font>사유 : </font> <font id="fA"></font><br/>
				</div>
			</div>
	</section>
	</td>
</body>
</html>