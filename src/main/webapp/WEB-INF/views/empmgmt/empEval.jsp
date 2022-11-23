<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery UI Tabs - Default functionality</title>


<script>
var empevalRequestList = [];
var empList = [];
var empDList = []; //empDetailList
var selectedEmpBean, updatedEmpBean = {}; // 사원의 상세정보를 저장하는 객체들 

empName = "";
emptyWorkInfoBean = {}; // 그리드에 새 행을 추가하기 위한 비어있는 객체들
var lastId = 0; // 마지막으로 선택한 그리드의 행 id (다른 행을 더블클릭 하였을 때, 해당 행을 닫기 상태로 만들기 위해 저장함) 
var addrowData;
var today;

$(document).ready(function() {
	/* 부서명 검색/사원명 검색 탭 이동 */
	$("#tabs").tabs();

	$("#sel_dept").selectmenu(); //부서 검색하면 menu 나옴
	$("#tabs1").tabs();
		
	/* 부서명 검색, 이름 검색 이벤트 등록 */
	$("#btn_name_search").click(function() {
		makeEmpList("name", $("#txt_name").val()); //이름
	})
	$("#btn_dept_search").click(function() {
		makeEmpList("dept", $("#sel_dept").val()); //부서명
	})
	
	$("#del_empval_btn").click(function() {
		var flag = confirm("선택한 사원의 인사고과를 정말 삭제하시겠습니까?");
		if (flag) removeEmpEval();
	})
		/* 검색 함수 */
	function makeEmpList(grid, value) {
		$.ajax({
			url : "${pageContext.request.contextPath}/empinfomgmt/emplist",
			data : {
				"value" : value,"workplaceCode":"${sessionScope.workplaceCode}"			//전체부서/회계팀/인사팀/전산팀
			},
			dataType : "json",
			success : function(data) {
				if (data.errorCode < 0) { //erroe code는 컨트롤러에서 날려보냄
					var str = "오류가 발생했습니다\n";
					str += "에러 메시지 : " + "이름을 입력하세요.";
					alert(str);
					return; //function 빠져나감
				}
				
				empList = data.list; //만들어놓은 빈 배열에 list담음
				
				if (grid == "dept")
					showEmpListDeptGrid();
				else {
					showEmpListNameGrid();
				}
			},
			error : function(a, b, c) {
				alert(b);
			}
		});
	}

/* 부서별 사원 정보 그리드에 뿌리는 함수 */
function showEmpListDeptGrid() {
	var columnDefs = [ 
		{ headerName : "사원코드", field : "empCode" , checkboxSelection : true },
		{ headerName : "사원명", field : "empName" },
		{ headerName : "부서", field : "deptName"},
		{ headerName : "직급", field : "position" } 
	];
	gridOptions = {
		columnDefs : columnDefs,
		rowData : empList,
		onRowClicked : function(node) {
			console.log(node.data.imgExtend);
			var empCode = node.data.empCode;
			var profile = node.data.imgExtend;
			document.getElementById('profileImg').setAttribute("src","${pageContext.request.contextPath}/profile/" + empCode + "." + profile);
			$.ajax({
				url : "${pageContext.request.contextPath}/empinfomgmt/empdetail/all",
				data : {
					"empCode" : empCode
				},
				dataType : "json",
				success : function(data) {
					if (data.errorCode < 0) {
						var str = "내부 서버 오류가 발생했습니다\n";
						str += "관리자에게 문의하세요\n";
						str += "에러 위치 : "+ $(this).attr("id");
						str += "에러 메시지 : " + data.errorMsg;
						alert(str);
						return;
					}
					
					empDList = data.empBean;
						
				
					clearEmpInfo(); // 상세정보, 재직정보 칸 초기화
					selectedEmpBean = $.extend(true, {}, data.empBean); // 취소버튼을 위한 임시 저장공간에 딥카피
					updatedEmpBean = $.extend(true, {}, data.empBean); // 변경된 내용이 들어갈 공간에 딥카피
	
					/* 회원정보를 불러와야 기타정보들의 객체에 제대로 값이 들어가기 때문에 이곳에서 부름 */
					showDetailInfo();
				}
			});
		}
	}
	$('#deptfindgrid').children().remove();
	var eGridDiv = document.querySelector('#deptfindgrid');
	new agGrid.Grid(eGridDiv, gridOptions);
	gridOptions.api.sizeColumnsToFit();
	
	showEmpEvalListGrid();
}

/* 이름으로 검색결과 그리드에 뿌리는 함수 */
function showEmpListNameGrid() {
	var columnDefs = [ 
		{ headerName : "사원코드", field : "empCode" }, 
		{ headerName : "사원명", field : "empName" }, 
		{ headerName : "부서", field : "deptName" }, 
		{ headerName : "직급", field : "position" }
	];
	gridOptions = {
		columnDefs : columnDefs,
		rowData : empList,
		onCellClicked : function(node) {
			var empCode = node.data.empCode;
			var profile = node.data.imgExtend;
			document.getElementById('profileImg').setAttribute("src", "${pageContext.request.contextPath}/profile/" + empCode + "." + profile);
			$.ajax({
				url : "${pageContext.request.contextPath}/empinfomgmt/empdetail/all",
				data : {
					"empCode" : empCode
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
					empDList = data.empBean;
					clearEmpInfo(); // 상세정보, 재직정보 칸 초기화
					selectedEmpBean = $.extend(true, {}, data.empBean); // 취소버튼을 위한 임시 저장공간에 딥카피
					updatedEmpBean = $.extend(true, {}, data.empBean); // 변경된 내용이 들어갈 공간에 딥카피

					/* 회원정보를 불러와야 기타정보들의 객체에 제대로 값이 들어가기 때문에 이곳에서 부름 */
					showDetailInfo();
				}
			});
		}
	}
	$('#namefindgrid').children().remove();
	var eGridDiv = document.querySelector('#namefindgrid');
	new agGrid.Grid(eGridDiv, gridOptions);
	gridOptions.api.sizeColumnsToFit();
	
	showEmpEvalListGrid();
}

$("#address").postcodifyPopUp();

/* 사진찾기*/
$("#findPhoto").button().click(function() {
	$("#emp_img_file").click(); //사진찾기 버튼을 누르면 숨겨진 file 태그를 클릭
});

// 사진 등록 form의 ajax 부분
$("#emp_img_form").ajaxForm({
	dataType : "json",
	success : function(responseText,statusText, xhr, $form) {
		alert(responseText.errorMsg);
		location.reload();
	}
});

/* 전역변수 초기화 함수 */
function initField() {
	selectedEmpBean, updatedEmpBean = {};
	lastId = 0;
}						

/* 현재 표시된 모든 정보를 비우는 함수 */
function clearEmpInfo() {
	// 찾았던 사진을 기본 사진으로 되돌린다
	$("#profileImg").attr("src","${pageContext.request.contextPath }/profile/profile.png");
	$("input:text").each(function() {
		$(this).val("") //모든 input text타입의 value값을 비운다
	})
}						

/* 상세정보 탭의 저장 버튼 */
$("#registEmp_Btn").click(function() {
	var achievement = $("#achievement").val();
	var ability = $("#ability").val();
	var attitude = $("#attitude").val();
	
	if ( achievement==null) {
		alert("업적점수가 없습니다.");
	} else if(ability==null){
		alert("능력점수가 없습니다.");			
	}else if(attitude==null){
		alert("태도점수가 없습니다.");			
	}else{
		var flag = confirm("인사고과를 등록하시겠습니까?");
		if(flag){ registEmp(); }
	}
});						

//인사고과 조회하기
$("#sel_empval_btn").click(function() {
	$.ajax({
		url : "${pageContext.request.contextPath}/empinfomgmt/evaluation",
		dataType : "json",
		success : function(data) {
			empevalRequestList = data.empevalList;
			showEmpEvalListGrid();
		}
	});
});

//인사고과 삭제하기
function removeEmpEval() {
	var selectedRowIds = gridOptions.api.getSelectedRows();	
	var emp_code = selectedRowIds[0].empCode;
	var apply_day = selectedRowIds[0].apply_day;
	
	$.ajax({
		type : "DELETE",
		url : "${pageContext.request.contextPath}/empinfomgmt/evaluation",
		data : {
			"emp_code" : emp_code,
			"apply_day" : apply_day
		},
		dataType : "json",
		success : function(data) {
			if (data.errorCode < 0) {
				alert("정상적으로 삭제되지 않았습니다");
			} else {
				alert("삭제되었습니다");
			}
			location.reload();
		}
	});
}
	
/* 저장 */
function registEmp() {
	saveEmpInfo();
	var sendData = JSON.stringify(updatedEmpBean);

	$.ajax({
		type : "POST",
		url : "${pageContext.request.contextPath}/empinfomgmt/evaluation",
		data : sendData,
		contentType:"application/json",
		dataType : "json",
		success : function(data) {
			if (data.errorCode < 0) {
				alert("해당 사원은 이미 인사고과 등록이 되었습니다.");
			} else {
				/* 선택한 사진이 있다면 저장 버튼을 눌렀을때에 사진 저장도 같이 되게함 */
				if ($("#emp_img_file").val() != "") {
					$("#emp_img_form").submit();
				}
				alert("인사고과가 등록되었습니다");
			}
			location.reload();
		}
	});
}
						
/* 변경된 정보들을 저장하는 함수 */
function saveEmpInfo() {
	updatedEmpBean.status = "update";
	updatedEmpBean.empCode = $("#empCode").val();
	updatedEmpBean.empName = $("#empName").val();
	updatedEmpBean.deptName = $("#deptName").val();
	updatedEmpBean.position = $("#position").val();
	updatedEmpBean.achievement = $("#achievement ").val();
	updatedEmpBean.ability = $("#ability").val();
	updatedEmpBean.attitude = $("#attitude").val();
	updatedEmpBean.approval_Status="승인대기";
}
						
						
/* 상세정보 탭의 취소 버튼 */
$("#can_work_btn").click(function() {
	var flag = confirm("취소하시겠습니까?");
	if (flag)
		rollBackEmpInfo();
});
						
function rollBackEmpInfo() {
	clearEmpInfo(); // 모든 정보를 지운 후

	// 서버에서 불러온 미리 저장한 EmpBean의 정보를 수정하던 정보에 엎어씌움
	updatedEmpBean = $
			.extend(true, {}, selectedEmpBean);
	// 딥카피하는 이유는 주소타입의 변수가 제대로 카피되지 않기 때문임

	//상제정보와 사진을 다시 띄운다
	showDetailInfo();
	showEmpImg();
}

/* 저장된 사진 불러오는 함수 */
function showEmpImg() {
	var path = "${pageContext.request.contextPath }/profile/profile.png";

	if (selectedEmpBean.imgExtend != null) {
		if (selectedEmpBean.detailInfo.imgExtend != null) {
			path = "${pageContext.request.contextPath}/profile/";
			path += selectedEmpBean.empCode;
			path += "." + selectedEmpBean.imgExtend;
		}
	}
	$("#emp_img").attr("src", path);
}
						
/*세부상세정보 그리드 띄우기*/
function showDetailInfo() {
	$("#empCode").val(selectedEmpBean.empCode);
	$("#empName").val(selectedEmpBean.empName);
	$("#deptName").val(selectedEmpBean.deptName);
	$("#position").val(selectedEmpBean.position);
	$("#achievement").val(selectedEmpBean.achievement);
	$("#ability").val(selectedEmpBean.ability);
	$("#attitude").val(selectedEmpBean.attitude);
	$("#profileImg").attr("src","${pageContext.request.contextPath}/profile/"+ selectedEmpBean.empCode + "."+ selectedEmpBean.imgExtend);
}
							
/* 날짜 자리수 맞춰주는 함수 */
function addZeros(num, digit) { 			 
	var zero = '';
    num = num.toString();
    if (num.length < digit) {
    	for (i = 0; i < digit - num.length; i++) {
        zero += '0';
    	}
    }
    return zero + num;
}
});

//인사고과조회 그리드 호출
function showEmpEvalListGrid() {
		var columnDefs = [
			{headerName : "사원번호", field : "empCode" ,width:130,checkboxSelection : true},
			{headerName : "사원이름", field : "empName",width:80},
			{headerName : "적용일", field : "apply_day" ,width:65},
			{headerName : "부서", field : "deptName" , hide : true},
			{headerName : "직급", field : "position" , hide : true},
			{headerName : "업적점수", field : "achievement" ,width:70},
			{headerName : "능력점수", field : "ability",width:70},
			{headerName : "태도점수",field : "attitude",width:70},
			{headerName : "상태",field : "approval_Status"} ];
		
		gridOptions = {
			columnDefs : columnDefs,
			rowData : empevalRequestList,
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
			localeText : {
				noRowsToShow : '조회 결과가 없습니다.'
			},
			getRowStyle : function(param) {
				if (param.node.rowPinned) {
					return {
						'font-weight' : 'bold',
						background : '#dddddd'
					};
				}
				return {
					'text-align' : 'left'
				};
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
		
		$('#empEvalList_Grid').children().remove();
		var eGridDiv = document.querySelector('#empEvalList_Grid');
		new agGrid.Grid(eGridDiv, gridOptions);
	}
</script>

</head>
<body>
	<!-- 왼쪽창 -->
	<div id="tabs" class="twobox wow fadeInDown">
		<ul>
			<li><a href="#tabs-11">부서명 검색</a></li>
			<li><a href="#tabs-1">사원명 검색</a></li>
		</ul>
		<!-- 부서명검색 탭 -->
		<div id="tabs-11">
			<select id="sel_dept">
				<option value="전체부서">전체부서</option>
				<option value="회계팀">회계팀</option>
				<option value="인사팀">인사팀</option>
				<option value="전산팀">전산팀</option>
				<option value="보안팀">보안팀</option>
			</select>
			<button id="btn_dept_search"
				class="ui-button ui-widget ui-corner-all">검색</button>
			<br /> <br />
			<div id="deptfindgrid" style="height: 250px;" class="ag-theme-balham"></div>

		</div>
		<!-- 사원명 검색탭 -->
		<div id="tabs-1">
			<input type="text" id="txt_name"
				class="ui-button ui-widget ui-corner-all">
			<button id="btn_name_search"
				class="ui-button ui-widget ui-corner-all">검색</button>
			<br /> <br />
			<div id="namefindgrid" style="height: 250px;" class="ag-theme-balham"></div>
		</div>

	</div>

	<!-- 오른쪽 창 -->
	<div id="tabs1" class="twobox wow fadeInDown">
		<ul>
			<li><a href="#tabs-0">인사고과등록</a></li>
			<li><a href="#tabs-3">인사고과조회</a></li>
		</ul>
		<!-- 기본정보 -->
		<div id="tabs-0" align="left">
			<!-- 사진박스 -->
			<div id="divImg">
				<img id="profileImg" src="${pageContext.request.contextPath}/profile/profile.png" width="180px" height="200px"><br>
				<form id="emp_img_form" action="${pageContext.request.contextPath }/foudinfomgmt/empImg.do" enctype="multipart/form-data" method="post">
					<input type="hidden" name="empCode" id="emp_img_empCode">
					<input type="file" name="empImgFile" style="display: none;" id="emp_img_file" onChange="readURL(this)">
					<br />
				</form>
				<br />
			</div>
			<!-- 상세정보박스1 -->
			<div id="divEmpInfo">
				<br />
				<table>
				<colgroup>
					<col width="30%">
					<col width="70%">
				</colgroup>
					<tr>
						<td><font>사원코드</font></td>
						<td><input class="ui-button ui-widget ui-corner-all"
							id="empCode" readonly></td>
					</tr>
					<tr>
						<td><font>이름</font></td>
						<td><input class="ui-button ui-widget ui-corner-all"
							id="empName" readonly></td>
					</tr>
					<tr>
						<td><font>부서</font></td>
						<td><input class="ui-button ui-widget ui-corner-all"
							id="deptName" readonly></td>
					</tr>
					<tr>
						<td><font>직급</font></td>
						<td><input class="ui-button ui-widget ui-corner-all"
							id="position" readonly></td>
					</tr>
				</table>
				<br />
				<!-- IMG_EXTEND -->
			</div>
			<hr>
			<!-- 상제정보박스2 -->
			<div id="divEmpDinfo">
				<table>
				<colgroup>
					<col width="30%">
					<col width="70%">
				</colgroup>
					<tr>
						<td><font>업적<br/>(업무달성도, 업무개선)</font></td>
						<td>
							<select class="ui-button ui-widget ui-corner-all"
							id="achievement">
								<script>
									for(let i=60; i<=100; i=i+10){
										document.write("<option>"+i+"</option>");	
									}
								</script>
							</select>
						</td>
					</tr>
					<tr>
						<td><font>능력<br/>(업무지식, 기획창의력)</font></td>
						<td>
							<select class="ui-button ui-widget ui-corner-all"
							id="ability">
								<script>
									for(let i=60; i<=100; i=i+10){
										document.write("<option>"+i+"</option>");	
									}
								</script>
							</select>
						</td>
					</tr>
					<tr>
						<td><font>태도<br/>(근무태도, 협동심)</font></td>
						<td>
							<select class="ui-button ui-widget ui-corner-all"
							id="attitude">
								<script>
									for(let i=60; i<=100; i=i+10){
										document.write("<option>"+i+"</option>");	
									}
								</script>
							</select>
						</td>
					</tr>
				</table>
				<input type="hidden" id="imgExtend">
			</div>
		</div>
		<!-- 인사고과조회 -->
		<div class="grid-wrapper" id="tabs-3">
			<input
				type="button" id="sel_empval_btn"
				class="ui-button ui-widget ui-corner-all" value="조회하기"/>
			<input
				type="button" id="del_empval_btn"
				class="ui-button ui-widget ui-corner-all" value="삭제하기"/>
			<br/>
			<br/>
			<div id="empEvalList_Grid" style="height: 500px; width: 505px"
				class="ag-grid-div ag-theme-balham ag-basic" :defaultColDef="defaultColDef"></div>
		</div>
		<!-- 저장/취소버튼 -->
		<div class="btn_align">
			<input type="button" id="registEmp_Btn" class="ui-button ui-widget ui-corner-all" value="등록"> 
			<input type="button" id="can_work_btn" class="ui-button ui-widget ui-corner-all" value="취소">
		</div>
	</div>
</body>
</html>