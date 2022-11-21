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
	$(document).ready(function() {
		codeList = [];
		detailCodeList = [];
		findCodeList(); // code List 
		showDetailCodeListGrid(); // detail Code list
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
			rowSelection : 'single', /* 'single' or 'multiple',*/
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
		gridOptions = {
			columnDefs : columnDefs,
			rowData : detailCodeList,
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
			onGridSizeChanged : function(event) { event.api.sizeColumnsToFit(); }
		}
		$('#detailCodeList_grid').children().remove();
		
		var eGridDiv = document.querySelector('#detailCodeList_grid');
		new agGrid.Grid(eGridDiv, gridOptions);

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