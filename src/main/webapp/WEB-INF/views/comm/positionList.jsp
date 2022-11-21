<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>

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
	var selectedPositionBean, updatedPositionBean = []; // 직급정보를 담기 위한 테이블
	var emptyPositionBean = []; // 그리드에 새 행을 추가하기 위한 비어있는 객체들
	var addrowData;

	$(document).ready(function() {
		positionListAjax();

		// 그리드의 행 추가, 삭제 버튼들
		$("#add_position_Btn").click(addListGridRow);
		$("#del_position_Btn").click(delListGridRow);

		/* 상세정보 탭의 저장 버튼 */
		$("#modifyPosition_Btn").click(function() {
			if (updatedPositionBean == null) {
				alert("저장할 내용이 없습니다");
			} else {
				var flag = confirm("변경한 내용을 서버에 저장하시겠습니까?");
				if (flag) modifyPosition();
			}
		});
	});

	function positionListAjax() {
		$.ajax({
			url : "${pageContext.request.contextPath}/foudinfomgmt/positionlist",
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
				selectedPositionBean = $.extend(true, [], data.positionList); // 취소버튼을 위한 임시 저장공간에 딥카피 ? 얘 안 씀 이유는 뭐지 
				updatedPositionBean = $.extend(true, [], data.positionList); // 변경된 내용이 들어갈 공간에 딥카피

				showPositionListGrid();
			}
		});

	}

	/* 직급목록 그리드 띄우는 함수 aggrid*/
	function showPositionListGrid() {
		var columnDefs = [ { headerName : "직급코드", field : "positionCode" }, 
						   { headerName : "직급명", field : "position" }, 
						   { headerName : "기본급", field : "basesalary" }, 
						   { headerName : "호봉인상률", field : "hobongratio" }, 
						   { headerName : "상태", field : "status" } 
						 ];
		gridOptions = {
			columnDefs : columnDefs,
			rowData : updatedPositionBean,
			defaultColDef : { editable : true , width : 100 },
			rowSelection : 'multiple', 
			//rowMultiSelectWithClick : true,
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
			onCellEditingStopped : function(event) {
				console.log(event.data.status);
				if (event.data.status == "normal") { event.data.status = "update" }
				
				gridOptions.api.updateRowData({ update : [ event.data ] });
			},
		};

		var eGridDiv = document.querySelector('#positionList_grid');
		new agGrid.Grid(eGridDiv, gridOptions);
	}

	// 그리드에 행 추가하는 함수
	function createNewRowData() {
		var newData = {
			positionCode : "POS",
			position : "PosName",
			baseSalary : "0",
			hobongRatio : "0",
			status : "insert"
		};
		return newData;
	}

	function addListGridRow() {
		var newItem = createNewRowData();
		gridOptions.api.updateRowData({ add : [ newItem ] });
		getRowData();
	}

	function getRowData() {
		addrowData = [];
		
		gridOptions.api.forEachNode(function(node) { addrowData.push(node.data); });
		console.log('Row Data:');
		console.log(addrowData);
	}

	/* 그리드에 행 삭제 (주석은 행 추가하는거 참조)*/
	function delListGridRow() {
		var selectedData = gridOptions.api.getSelectedRows();
		console.log(selectedData);
		var selectedData0 = selectedData[0];
		
		if (selectedData0.status == "normal") { selectedData0.status = 'delete' }
		gridOptions.api.updateRowData({ update : selectedData });
		console.log('delete Data:');
		console.log(selectedData);
		getRowData();
	}

	/* 저장 버튼을 눌렀을 때 실행되는 함수 */
	function modifyPosition() {
		if (addrowData != null) {
			var sendData = JSON.stringify(addrowData);
			alert(sendData);
		} else {
			var sendData = JSON.stringify(updatedPositionBean);
			alert(sendData);
		}

		$('#positionList_grid').children().remove();
		
		$.ajax({
			type : "PUT",
			url : "${pageContext.request.contextPath}/foudinfomgmt/positionlist",
			data : sendData,
			contentType:"application/json",
			dataType : "json",
			success : function(sendData) {
				console.log(sendData);
				if (sendData.errorCode < 0) {
					alert("저장에 실패했습니다");
				} else {
					alert("저장되었습니다");
				}
				
				var eGridDiv = document.querySelector('#positionList_grid');
				new agGrid.Grid(eGridDiv, gridOptions);
				location.reload();
			}
		});
	}
</script>
<section id="tabs" style="width:60%; height:800px;" class="wow fadeInDown">
	<div class="container">
		<h6 class="section-title h3" style="text-align:left;">직급관리목록</h6>
		<hr style="background-color:white; height: 1px;">
		<input type="button" class="btn btn-light btn-sm" value="추가" id= "add_position_Btn">
		<input type="button" class="btn btn-light btn-sm" value="삭제" id="del_position_Btn">
		<input type="button" class="btn btn-light btn-sm" value="저장" id="modifyPosition_Btn">
		<div class="row">
			<div class="col-md-6">
				<div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
					<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
						<div id="positionList_grid" style="height: 600px; width: 500px" class="ag-theme-balham"></div>
					</div>
				</div>
			
			</div>
		</div>
	</div>
</section>