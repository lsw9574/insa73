<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>

	<script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
	<link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
	<link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
	<style>
		/* Tabs*/
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
		var addrowData;

		$(document).ready(function() {
			codeList = [];
			detailCodeList = [];
			findCodeList(); // code List
			showDetailCodeListGrid(); // detail Code list

			$("#add_Btn").click(addGridRow);       // 추가버튼
			$("#remove_Btn").click(removeGirdRow); // 삭제버튼
			$("#save_Btn").click(saveGridRow);     // 저장버튼
		});

		//코드관리정보 불러오기
		function findCodeList() {
			$.ajax({
				url : "${pageContext.request.contextPath}/systemmgmt/codelist/all",
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

					codeList = data.codeList;

					showCodeGrid();
				}
			});
		}

		/* 코드목록 그리드 띄우는 함수 */
		function showCodeGrid() {
			var columnDefs = [ { headerName : "코드번호", field : "codeNumber" },
				{ headerName : "코드이름", field : "codeName" },
				{ headerName : "수정여부", field : "modifiable" },
				{ headerName : "상태", field : "status" }
			];
			gridOptions = {
				columnDefs : columnDefs,
				rowData : codeList,
				defaultColDef : {
					editable : false,
					width : 100
				},
				rowSelection : 'single', /* 'single' or 'multiple',*/ //하나만 선택가능
				enableColResize : true,
				enableSorting : true,
				enableFilter : true,
				enableRangeSelection : true,
				suppressRowClickSelection : false,
				animateRows : true,
				suppressHorizontalScroll : true,
				localeText : { noRowsToShow : '조회 결과가 없습니다.' },

				getRowStyle : function(param) {
					if (param.node.rowPinned) {
						return {
							'font-weight' : 'bold',
							background : '#dddddd'
						};
					}
					return {
						'text-align' : 'center'
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

				onCellClicked : function(node) {
					console.log(node); // 클릭한 json 객체가 넘어온다
					var codeNumber = node.data.codeNumber;

					$.ajax({
						url : "${pageContext.request.contextPath}/systemmgmt/codelist",
						data : {
							"code" : codeNumber },
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

							detailCodeList = data.detailCodeList; // 할당 후 그리드 로드
							showDetailCodeListGrid();
						}
					});
				}

			};

			var eGridDiv = document.querySelector('#codeList_grid');
			new agGrid.Grid(eGridDiv, gridOptions);
		}

		//상세 코드 그리드 띄우기
		function showDetailCodeListGrid() {
			var columnDefs = [ {
				headerName : "상세코드번호",
				field : "detailCodeNumber"
			}, {
				headerName : "코드번호",
				field : "codeNumber"
			}, {
				headerName : "상세코드이름",
				field : "detailCodeName"
			}, {
				headerName : "사용가능여부",
				field : "detailCodeNameusing"
			}, {
				headerName : "상태",
				field : "status"
			} ];
			detailGridOptions = {
				columnDefs : columnDefs,
				rowData : detailCodeList,
				defaultColDef : {
					editable : true,
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
				localeText : { noRowsToShow : '코드를 선택해주세요 .' },
				getRowStyle : function(param) {
					if (param.node.rowPinned) {
						return { 'font-weight' : 'bold', background : '#dddddd' };
					}

					return { 'text-align' : 'center' };
				},
				getRowHeight : function(param) {
					if (param.node.rowPinned) {
						return 30;
					}
					return 24;
				},

				// GRID READY 이벤트, 사이즈 자동조정
				onGridReady : function(event) { event.api.sizeColumnsToFit(); },
				// 창 크기 변경 되었을 때 이벤트
				onGridSizeChanged : function(event) { event.api.sizeColumnsToFit(); },
				onCellEditingStopped: function (event) {    //event에는 변경된 객체가 들어간다
					console.log(event);
					console.log(event.data.status);
					console.log(event.data);
					if (event.data.status == "normal") {
						event.data.status = "update"
					}
					detailGridOptions.api.updateRowData({update: [event.data]});    //현재 그리드 수정(event에 들어와있는 객체를 수정한다.)
				}
			}
			$('#detailCodeList_grid').children().remove();

			var eGridDiv = document.querySelector('#detailCodeList_grid');
			new agGrid.Grid(eGridDiv, detailGridOptions);
		}
		// 그리드에 행 추가하는 함수
		function createNewRowData() {
			var newData = {
				detailCodeNumber: "",
				codeNumber: "",
				detailCodeName: "",
				detailCodeNameusing: "",
				status: "insert"
			};
			return newData;

		}


		function addGridRow() { // 비어있는 열 하나를 추가함
			var newItem = createNewRowData();
			detailGridOptions.api.updateRowData({add: [newItem]});
		}

		function saveGridRow() { //추가된 열에 데이터를 집어넣음
			let addrowData = [];
			detailGridOptions.api.forEachNode(function (node) {
				addrowData.push(node.data);
			});
			let sendData = JSON.stringify(addrowData);

			$.ajax({
				type: "PUT",
				url: "${pageContext.request.contextPath}/systemmgmt/codelist",
				data: sendData,
				contentType: "application/json",
				dataType: "json",
				success: function (sendData) {
					if (sendData.errorCode < 0) {
						alert("저장에 실패했습니다");
					} else {
						alert("저장되었습니다");
					}
					location.reload();
				}
			});
		}
		function removeGirdRow(){
			let selectedData = detailGridOptions.api.getSelectedRows()[0];
			if (selectedData.status == "normal") {
				selectedData.status = 'delete';
			}

			detailGridOptions.api.updateRowData({update: [selectedData]});

		}

	</script>
</head>

<body>
<section id="tabs" style="width:550px; height:740px; display: inline-block;" class="wow fadeInDown">
	<div class="container">
		<h6 class="section-title h3" style="text-align:left;">코드조회</h6>
		<hr style="background-color:white; height: 1px;">
		<div class="row">
			<div class="col-md-6">
				<div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
					<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
						<div id="codeList_grid" style="height: 600px; width: 500px" class="ag-theme-balham"></div>
					</div>
				</div>

			</div>
		</div>
	</div>
</section>

<section id="tabs" style="width:550px; height:740px; display: inline-block;" class="wow fadeInDown">
	<div class="container">
		<h6 class="section-title h3" style="text-align:left;">세부코드조회</h6>
		<hr style="background-color:white; height: 1px;">
		<input type="button" class="btn btn-light btn-sm" value="추가" id="add_Btn">
		<input type="button" class="btn btn-light btn-sm" value="삭제" id="remove_Btn">
		<input type="button" class="btn btn-light btn-sm" value="저장" id="save_Btn">
		<div class="row">
			<div class="col-md-6">
				<div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
					<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
						<div id="detailCodeList_grid" style="height: 600px; width: 500px" class="ag-theme-balham"></div>
					</div>
				</div>

			</div>
		</div>
	</div>
</section>
</body>
</html>