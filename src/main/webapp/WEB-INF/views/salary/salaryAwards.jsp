<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>jQuery UI Tabs - Default functionality</title>


<script>
var empList = [];
var salBonusList = [];
var salAwardsList = []; //empDetailList

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

		/* 검색 함수 */
	function makeEmpList(grid, value) {
		
		console.log(grid+"    "+value);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/empinfomgmt/emplist",
			data : {
				"value" : value,				//전체부서/회계팀/인사팀/전산팀
				"workplaceCode":"${sessionScope.workplaceCode}"
			},
			dataType : "json",
			success : function(data) {
				if (data.errorCode < 0) { //erroe code는 컨트롤러에서 날려보냄
					var str = "내부 서버 오류가 발생했습니다\n";
					str += "관리자에게 문의하세요\n";
					str += "에러 위치 : " + $(this).attr("id");
					str += "에러 메시지 : " + data.errorMsg;
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
		{ headerName : "사원코드", field : "empCode", hide : true },
		{ headerName : "사원명", field : "empName" },
		{ headerName : "부서", field : "deptName" }, 
		{ headerName : "직급", field : "position" }, 
		{ headerName : "성별", field : "gender", hide : true }, 
		{ headerName : "전화번호", field : "mobileNumber", hide : true }, 
		{ headerName : "이메일", field : "email" }, 
		{ headerName : "거주지", field : "address", hide : true }, 
		{ headerName : "최종학력", field : "lastSchool", hide : true }, 
		{ headerName : "사진", field : "imgExtend", hide : true }, 
		{ headerName : "생년월일", field : "birthdate", hide : true } 
	];
	gridOptions = {
		//console.log(node.data.imgExtend);
		
		columnDefs : columnDefs,
		rowData : empList,
		onRowClicked : function(node) {
			console.log(node);
			var empCode = node.data.empCode;
			
			$.ajax({
				url : "${pageContext.request.contextPath}/salaryinfomgmt/awards",
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
					
					salAwardsList = data.List;
					if (salAwardsList[0].GRADE == 'A'){
						salAwardsList[0].AWARDS_SALARY = salAwardsList[0].BASE_SALARY*2; 
					}
					else if (salAwardsList[0].GRADE == 'B'){
						salAwardsList[0].AWARDS_SALARY = salAwardsList[0].BASE_SALARY*1.5;
					}
					else if (salAwardsList[0].GRADE == 'D'){
						salAwardsList[0].AWARDS_SALARY = salAwardsList[0].BASE_SALARY*0.75;
					}
					
					
					showAwardsListGrid();	
					showBonusListGrid();
				}
			});
		}
	}
	$('#deptfindgrid').children().remove();
	var eGridDiv = document.querySelector('#deptfindgrid');
	new agGrid.Grid(eGridDiv, gridOptions);
	gridOptions.api.sizeColumnsToFit();
}

/* 이름으로 검색결과 그리드에 뿌리는 함수 */
function showEmpListNameGrid() {
	var columnDefs = [ 
		{ headerName : "사원코드", field : "empCode", hide : true }, 
		{ headerName : "사원명", field : "empName"  }, 
		{ headerName : "부서", field : "deptName" }, 
		{ headerName : "직급", field : "position" }, 
		{ headerName : "성별", field : "gender", hide : true }, 
		{ headerName : "전화번호", field : "mobileNumber", hide : true }, 
		{ headerName : "이메일", field : "email" }, 
		{ headerName : "거주지", field : "address", hide : true }, 
		{ headerName : "최종학력", field : "lastSchool", hide : true }, 
		{ headerName : "사진", field : "imgExtend", hide : true }, 
		{ headerName : "생년월일", field : "birthdate", hide : true } 
	];
	gridOptions = {
		columnDefs : columnDefs,
		rowData : empList,
		onCellClicked : function(node) {
			var empCode = node.data.empCode;
			console.log(empCode);
			$.ajax({
				url : "${pageContext.request.contextPath}/salaryinfomgmt/awards",
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
					salAwardsList = data.List;
					if (salAwardsList[0].GRADE == 'A'){
						salAwardsList[0].AWARDS_SALARY = salAwardsList[0].BASE_SALARY*2; 
					}
					else if (salAwardsList[0].GRADE == 'B'){
						salAwardsList[0].AWARDS_SALARY = salAwardsList[0].BASE_SALARY*1.5;
					}
					else if (salAwardsList[0].GRADE == 'D'){
						salAwardsList[0].AWARDS_SALARY = salAwardsList[0].BASE_SALARY*0.75;
					}
					showAwardsListGrid();
					showBonusListGrid();
				}
			});
		}
	
	}
	$('#namefindgrid').children().remove();
	var eGridDiv = document.querySelector('#namefindgrid');
	new agGrid.Grid(eGridDiv, gridOptions);
	gridOptions.api.sizeColumnsToFit();
}
//성과급 정보
function showAwardsListGrid() {
	var columnDefs = [ 
		{ headerName : "사원코드", field : "empCode" ,width:90}, 
		{ headerName : "사원명", field : "empName" ,width:80}, 
		{ headerName : "부서", field : "deptCode" ,width:80}, 
		{ headerName : "직급", field : "position" ,width:80}, 
		{ headerName : "성과급", field : "awardsSalary" ,width:80},
		{ headerName : "등급", field : "grade" ,width:85}
	];
	gridOptions = {
		columnDefs : columnDefs,
		rowData : salAwardsList,
		onSelectionChanged : function(node) {
			
			var empCode = node.data.empCode;
			console.log(empCode);
			$.ajax({
				url : "${pageContext.request.contextPath}/salaryinfomgmt/awards",
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
					//salAwardsList = data.List;
				}
			});
		}
	}
	$('#AwardsListGrid').children().remove();
	var eGridDiv = document.querySelector('#AwardsListGrid');
	new agGrid.Grid(eGridDiv, gridOptions);
	gridOptions.api.sizeColumnsToFit();

} 

//상여금 정보
function showBonusListGrid() {
	var columnDefs = [ 
		{ headerName : "사원코드", field : "empCode" }, 
		{ headerName : "사원명", field : "empName" }, 
		{ headerName : "부서", field : "deptCode" }, 
		{ headerName : "직급", field : "position" }, 
		{ headerName : "상여금", field : "baseSalary" },
		{ headerName : "등급", field : "grade", hide:true }
	];
	gridOptions = {
		columnDefs : columnDefs,
		rowData : salAwardsList,
		onSelectionChanged : function(node) {
			
			var empCode = node.data.empCode;
			console.log(empCode);
			$.ajax({
				url : "${pageContext.request.contextPath}/salaryinfomgmt/awards",
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
					//salAwardsList = data.List;
		
				}
			});
		}
	}
	$('#BonusListGrid').children().remove();
	var eGridDiv = document.querySelector('#BonusListGrid');
	new agGrid.Grid(eGridDiv, gridOptions);
	gridOptions.api.sizeColumnsToFit();

}



});
					

</script>

</head>
<body>
	<!-- 왼쪽창 -->
	<div id="tabs" class="twobox wow fadeInDown">
		<ul>
			<li><a href="#tabs-1">부서명 검색</a></li>
			<li><a href="#tabs-2">사원명 검색</a></li>
		</ul>
		<!-- 부서명검색 탭 -->
		<div id="tabs-1">
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
		<div id="tabs-2">
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
			<li><a href="#tabs-0">상여금 정보</a></li>
			<li><a href="#tabs-2">성과급 정보</a></li>
		</ul>
		<!-- 상여금 정보 -->
		<div id="tabs-0"   >
			<br />
			<div id="BonusListGrid" style="height: 500px; width: 500px"
				class="ag-grid-div ag-theme-balham ag-basic" :defaultColDef="defaultColDef"></div>
		</div>
		<!-- 성과급 정보 -->
		<div class="grid-wrapper" id="tabs-2">
			<br />
			<div id="AwardsListGrid" style="height: 500px; width: 500px"
				class="ag-grid-div ag-theme-balham ag-basic" :defaultColDef="defaultColDef"></div>
		</div>
	</div>
</body>
</html>