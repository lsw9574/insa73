<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
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
		var beforeAppointment = [];
		var afterAppointment = [];
		var selectedEmpBean, updatedEmpBean = {}; // 사원의 상세정보를 저장하는 객체들

		$(document).ready(function () {
			emptyWorkInfoBean = {}; // 그리드에 새 행을 추가하기 위한 비어있는 객체들

			/* 부서명 검색/사원명 검색 탭 이동 */
			$("#tabs").tabs();

			$("#sel_dept").selectmenu(); //부서 검색하면 menu 나옴
			$("#tabs1").tabs();

			/* 부서명 검색, 이름 검색 이벤트 등록 */
			$("#btn_name_search").click(function () {
				makeEmpList("name", $("#txt_name").val()); //이름
			})
			$("#btn_dept_search").click(function () {
				makeEmpList("dept", $("#sel_dept").val()); //부서명
			})

			$("#del_empval_btn").click(function () {
				var flag = confirm("선택한 인사발령을 정말 삭제하시겠습니까?");
				if (flag) removeEmpEval();
			})

			//인사발령 조회하기
			$("#sel_empval_btn").click(function () {
				$.ajax({
					url: "${pageContext.request.contextPath}/empinfomgmt/findAppointment",
					dataType: "json",
					success: function (data) {
						empevalRequestList = data.empevalList;
						showAppointmentList();
					}
				});
			});

			$("#createHosu").click(function () {
				getHosu();
			});

			/* 인사발령 등록 버튼 */
			$("#registAppointment_Btn").click(function () {
				console.log(afterAppointment)
				registAppointment()
			});
		});

		//호수생성 함수
		function getHosu() {
			$.ajax({
				type: "GET",
				url: '${pageContext.request.contextPath}/empinfomgmt/gethosu',
				success: function (data) {
					if (data.errorCode < 0) {
						let str = "내부 서버 오류가 발생했습니다\n";
						str += "관리자에게 문의하세요\n";
						str += "에러 위치 : " + $(this).attr("id");
						str += "에러 메시지 : " + data.errorMsg;
						alert(str);
						return;
					}
					$("#docNumber").val(data.infoTO.hosu);
					if (!afterAppointment.includes($("#docNumber").val()))
						afterAppointment.push($("#docNumber").val())
					console.log($("#docNumber").val());
					console.log(afterAppointment);
				}
			});
		}

		/* 검색 함수 */
		function makeEmpList(grid, value) {
			$.ajax({
				url: "${pageContext.request.contextPath}/empinfomgmt/emplist",
				data: {"value": value,"workplaceCode":"${sessionScope.workplaceCode}"},         //전체부서/회계팀/인사팀/전산팀
				dataType: "json",
				success: function (data) {
					if (data.errorCode < 0) { //erroe code는 컨트롤러에서 날려보냄
						var str = "오류가 발생했습니다\n";
						str += "에러 메시지 : " + "이름을 입력하세요.";
						alert(str);
						return; //function 빠져나감
					}

					empList = data.list; //만들어놓은 빈 배열에 list담음
					console.log(empList);
					if (grid == "dept")
						showEmpListDeptGrid();
					else {
						showEmpListNameGrid();
					}
				}
			});
		}

		/* 부서별 사원 정보 그리드에 뿌리는 함수 */
		function showEmpListDeptGrid() {
			var columnDefs = [
				{headerName: "사원코드", field: "empCode", checkboxSelection: true},
				{headerName: "사원명", field: "empName"},
				{headerName: "부서", field: "deptName"},
				{headerName: "직급", field: "position"}
			];
			gridOptions = {
				columnDefs: columnDefs,
				rowData: empList,
				onRowClicked: function (node) {
					console.log(node.data);
					var empCode = node.data.empCode;
					$.ajax({
						url: "${pageContext.request.contextPath}/empinfomgmt/empdetail/all",
						data: {
							"empCode": empCode
						},
						dataType: "json",
						success: function (data) {
							if (data.errorCode < 0) {
								var str = "내부 서버 오류가 발생했습니다\n";
								str += "관리자에게 문의하세요\n";
								str += "에러 위치 : " + $(this).attr("id");
								str += "에러 메시지 : " + data.errorMsg;
								alert(str);
								return;
							}
							workInfo = data.emptyWorkInfoBean[0];
							console.log(workInfo);
							registAppointmentGrid(workInfo);
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
				{headerName: "사원코드", field: "empCode"},
				{headerName: "사원명", field: "empName"},
				{headerName: "부서", field: "deptName"},
				{headerName: "직급", field: "position"}
			];
			gridOptions = {
				columnDefs: columnDefs,
				rowData: empList,
				onCellClicked: function (node) {
					var empCode = node.data.empCode;
					$.ajax({
						url: "${pageContext.request.contextPath}/empinfomgmt/empdetail/all",
						data: {"empCode": empCode},
						dataType: "json",
						success: function (data) {
							if (data.errorCode < 0) {
								var str = "내부 서버 오류가 발생했습니다\n";
								str += "관리자에게 문의하세요\n";
								str += "에러 위치 : " + $(this).attr("id");
								str += "에러 메시지 : " + data.errorMsg;
								alert(str);
								return;
							}
							workInfo = data.emptyWorkInfoBean[0];
							console.log(data.emptyWorkInfoBean[0]);

							registAppointmentGrid(workInfo);
						}
					});
				}
			}
			$('#namefindgrid').children().remove();
			var eGridDiv = document.querySelector('#namefindgrid');
			new agGrid.Grid(eGridDiv, gridOptions);
			gridOptions.api.sizeColumnsToFit();
		}

		//인사발령 등록 그리드 호출
		function registAppointmentGrid(workInfo) {
			var columnDefs1 = [
				{headerName: "발령구분", field: "type"},
				{headerName: "발령전", field: "beforeChange"},
				{headerName: "발령후", field: "afterChange", editable: true},
				{headerName: "적용일", field: "startDate", editable: true, cellEditor: 'datePicker'}
			];
			var columnDefs2 = [
				{headerName: "발령구분", field: "type"},
				{headerName: "시작일", field: "startDate", editable: true, cellEditor: 'datePicker'},
				{headerName: "종료일", field: "endDate", editable: true, cellEditor: 'datePicker'}
			];
			var columnDefs3 = [
				{headerName: "발령구분", field: "type"},
				{headerName: "시작일", field: "startDate", editable: true, cellEditor: 'datePicker'},
				{headerName: "종료일", field: "endDate", editable: true, cellEditor: 'datePicker'},
				{headerName: "파견부서", field: "dispatchDept", editable: true}
			]
			gridOptions1 = {
				columnDefs: columnDefs1,
				rowData: [
					{type: "부서이동", beforeChange: workInfo.deptName, afterChange: "", startDate:""},
					{type: "호봉승급", beforeChange: workInfo.hobong, afterChange: "", startDate:""},
					{type: "승진", beforeChange: workInfo.position, afterChange: "", startDate:""}
				],
				rowSelection: 'single', /* 'single' or 'multiple',*/
				localeText: {
					noRowsToShow: '조회 결과가 없습니다.'
				},
				components: {datePicker: getDatePicker()},
				getRowStyle: function () {
					return {
						'text-align': 'left'
					};
				},
				// GRID READY 이벤트, 사이즈 자동조정
				onGridReady: function (event) {
					event.api.sizeColumnsToFit();
				},
				// 창 크기 변경 되었을 때 이벤트
				onGridSizeChanged: function (event) {
					event.api.sizeColumnsToFit();
				}
			}
			gridOptions2 = {
				columnDefs: columnDefs2,
				rowData: [
					{type: "퇴직", startDate: "", endDate: "-"},
					{type: "휴직", startDate: "", endDate: ""}
				],
				rowSelection: 'single', /* 'single' or 'multiple',*/
				localeText: {
					noRowsToShow: '조회 결과가 없습니다.'
				},
				components: {datePicker: getDatePicker()},
				getRowStyle: function () {
					return {
						'text-align': 'left'
					};
				},
				// GRID READY 이벤트, 사이즈 자동조정
				onGridReady: function (event) {
					event.api.sizeColumnsToFit();
				},
				// 창 크기 변경 되었을 때 이벤트
				onGridSizeChanged: function (event) {
					event.api.sizeColumnsToFit();
				}
			}
			gridOptions3 = {
				columnDefs: columnDefs3,
				rowData: [
					{type: "파견", startDate: "", endDate: "", dispatchDept: ""},
				],
				rowSelection: 'single', /* 'single' or 'multiple',*/
				localeText: {
					noRowsToShow: '조회 결과가 없습니다.'
				},
				components: {datePicker: getDatePicker()},
				getRowStyle: function () {
					return {
						'text-align': 'left'
					};
				},
				// GRID READY 이벤트, 사이즈 자동조정
				onGridReady: function (event) {
					event.api.sizeColumnsToFit();
				},
				// 창 크기 변경 되었을 때 이벤트
				onGridSizeChanged: function (event) {
					event.api.sizeColumnsToFit();
				}
			}
			$('#registApnt1').children().remove();
			var eGridDiv = document.querySelector('#registApnt1');
			new agGrid.Grid(eGridDiv, gridOptions1);
			gridOptions1.api.sizeColumnsToFit();

			$('#registApnt2').children().remove();
			var eGridDiv = document.querySelector('#registApnt2');
			new agGrid.Grid(eGridDiv, gridOptions2);
			gridOptions2.api.sizeColumnsToFit();

			$('#registApnt3').children().remove();
			var eGridDiv = document.querySelector('#registApnt3');
			new agGrid.Grid(eGridDiv, gridOptions3);
			gridOptions3.api.sizeColumnsToFit();

			afterAppointment = [gridOptions1.rowData, gridOptions2.rowData, gridOptions3.rowData, workInfo];
		}

		// 그리드에 달력뜨게하는 함수
		function getDatePicker() {
			// function to act as a class
			function Datepicker() {
			}

			// gets called once before the renderer is used
			Datepicker.prototype.init = function (params) {
				// create the cell
				this.eInput = document.createElement('input');
				this.eInput.value = params.value;

				$(this.eInput).datepicker({
					dateFormat: 'yy-mm-dd',
					changeMonth: true,
					changeYear: true,
					showMonthAfterYear: true,
					dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
					monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
					yearRange: "2000:2050",
				});
			};
			// gets called once when grid ready to insert the element
			Datepicker.prototype.getGui = function () {
				return this.eInput;
			};
			// focus and select can be done after the gui is attached
			Datepicker.prototype.afterGuiAttached = function () {
				this.eInput.focus();
				this.eInput.select();
			};
			// returns the new value after editing
			Datepicker.prototype.getValue = function () {
				return this.eInput.value;
			};

			return Datepicker;
		}

		//인사발령등록 함수
		function registAppointment() {
			var after1 = JSON.stringify(afterAppointment[0])
			var after2 = JSON.stringify(afterAppointment[1])
			var after3 = JSON.stringify(afterAppointment[2])
			console.log(afterAppointment)
			$.ajax({
				type: "POST",
				url: "${pageContext.request.contextPath}/empinfomgmt/registAppoint",
				data: {
					"after1": after1,
					"after2": after2,
					"after3": after3,
					"empCode": afterAppointment[3].empCode,
					"hosu": afterAppointment[4]
				},
				dataType: "json",
				success: function (data) {
					if (data.errorCode < 0) {
						let str = "내부 서버 오류가 발생했습니다\n";
						str += "관리자에게 문의하세요\n";
						str += "에러 위치 : " + $(this).attr("id");
						str += "에러 메시지 : " + data.errorMsg;
						alert(str);
						return;
					}
					location.reload();
				}
			})
		}
	</script>
</head>
<body>
<br/>
<h4 style=color:white;>인사발령등록</h4>
<br/>
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
		<button id="btn_dept_search" class="ui-button ui-widget ui-corner-all">검색</button>
		<br/> <br/>
		<div id="deptfindgrid" style="height: 338px;" class="ag-theme-balham"></div>
	</div>
	<!-- 사원명 검색탭 -->
	<div id="tabs-1">
		<input type="text" id="txt_name" class="ui-button ui-widget ui-corner-all">
		<button id="btn_name_search" class="ui-button ui-widget ui-corner-all">검색</button>
		<br/> <br/>
		<div id="namefindgrid" style="height: 285px;" class="ag-theme-balham"></div>
	</div>
</div>

<!-- 오른쪽 창 -->
<div id="tabs1" class="twobox wow fadeInDown">
	<ul>
		<li><a href="#tabs-0">인사발령등록</a></li>
	</ul>
	<!-- 기본정보 -->
	<div id="tabs-0" align="left">
		<div id="registApnt1" style="height: 121px;" class="ag-theme-balham"></div>
		<br/>
		<div id="registApnt2" style="height: 93px;" class="ag-theme-balham"></div>
		<br/>
		<div id="registApnt3" style="height: 65px;" class="ag-theme-balham"></div>
	</div>
	<!-- 저장/취소버튼 -->
	<div class="btn_align">
		<input type="text" id="docNumber">
		<br/>
		<input type="button" id="createHosu" class="ui-button ui-widget ui-corner-all" value="호수생성">
		<input type="button" id="registAppointment_Btn" class="ui-button ui-widget ui-corner-all" value="등록">
	</div>
</div>
</body>
</html>