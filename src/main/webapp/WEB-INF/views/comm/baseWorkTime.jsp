<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
</style>
<script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
<link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
<style>

section .section-title {
    text-align: center;
    color: #007b5e;
    text-transform: uppercase;
}
#tabs{
	background: #333333;
    color: #eee;
    background-color: rgba( 051,051, 051, 0.5 );
}
#tabs h6.section-title{
    color: #eee;
}
</style>
<script>
	var selectedTimeBean, updatedTimeBean = []; // 기준근무시간 상세정보를 저장하는 객체들
	var addrowData; 							// 수정내역 저장하는 그리드 (데이터 추가될 시에만 사용 됨)
	var emptyBean = []; 						// 그리드에 새 행을 추가하기 위한 비어있는 객체들

	var gridOptions;

	$(document).ready(function() {
		baseWorkTimeAjax(); 						// 기준근무시간 가지고 오는 함수 실행 

		$("#add_time_Btn").click(addGridRow); // 추가버튼 
		$("#del_time_Btn").click(delGridRow); // 삭제버튼

		/* 상세정보 탭의 저장 버튼 (그리드에 데이터가 존재하지 않을 때 실행)*/
		$("#mod_time_Btn").click(function() {
			if (updatedTimeBean == null){
				alert("저장할 내용이 없습니다");
			} else {
				var flag = confirm("변경한 내용을 서버에 저장하시겠습니까?");
				if (flag) modifyTime();
				showBaseWorkTimeListGrid();
			}
		});

	});
	

	
	
  //기준근무시간 가지고 오는 함수
	function baseWorkTimeAjax() {		
		$.ajax({
			url : "${pageContext.request.contextPath}/foudinfomgmt/basetime",
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
				
				selectedTimeBean = $.extend(true, [], data.list); // 취소버튼을 위한 임시 저장공간에 딥카피
				updatedTimeBean = $.extend(true, [], data.list);  // 변경된 내용이 들어갈 공간에 딥카피
				showBaseWorkTimeListGrid();

			}
		});

	}

  
	/* 기준근무시간목록 그리드 띄우는 함수 aggrid*/
	function showBaseWorkTimeListGrid() {
		var columnDefs = [ 
		  { headerName : "기준연도", field : "applyYear" }, 
			{ headerName : "통상근무시작", field : "attendTime" }, 
			{ headerName : "통상근무종료", field : "quitTime" }, 
			{ headerName : "점심시간시작", field : "lunchStartTime" }, 
			{ headerName : "점심시간종료", field : "lunchEndTime" }, 
			{ headerName : "저녁시간시작", field : "dinnerStartTime" }, 
			{ headerName : "저녁시간종료", field : "dinnerEndTime" }, 
			{ headerName : "저녁근무종료", field : "overEndTime" }, 
			{ headerName : "심야근무종료", field : "nightEndTime" }, 
			{ headerName : "상태", field : "status" }
		];
		
		gridOptions = {
			columnDefs : columnDefs,
			rowData : updatedTimeBean, 
			defaultColDef : { 
			  editable : true, 
			  width : 100, 
			  resizable: true,
			  sortable: true,
			  filter:true,
			  },
			rowSelection : 'single',
			//enableColResize : true,
			enableRangeSelection : true,
			suppressRowClickSelection : false,
			animateRows : true,
			suppressHorizontalScroll : true,
			localeText : { noRowsToShow : '조회 결과가 없습니다.' },
			getRowStyle : function(param) {
				if (param.node.rowPinned) {
					return { 'font-weight' : 'bold', background : '#dddddd' };
				}
				return  { 'text-align' : 'center' };
			},
			getRowHeight : function(param) {
				if (param.node.rowPinned) {
					return 30;
				}
				return 28;
			},
			
			// GRID READY 이벤트, 사이즈 자동조정 
			onGridReady : function(event) {
				event.api.sizeColumnsToFit();
			},
			// 창 크기 변경 되었을 때 이벤트 
			onGridSizeChanged : function(event) {
				event.api.sizeColumnsToFit();
			},
			
			onCellEditingStopped : function(event) { // 하나의 cell 이 수정이 끝났을때 status를 update로 바꿈
				if (event.data.status === "normal") {
					event.data.status = "update" }
					
				console.log("선택된 Row 데이터 : "+event.data);
				console.log("선택된 Row Status : "+event.data.status);
				
				gridOptions.api.updateRowData({ update : [event.data] });
			},
		};

		var eGridDiv = document.querySelector('#baseWorkTime_grid');
		new agGrid.Grid(eGridDiv, gridOptions);
	}

	
	
	// 그리드에 행 추가하는 함수
	function createNewRowData() {
		var newData = {
		    applyYear : "20xx",
		    attendTime : "0900",
		    quitTime : "1800",
		    lunchStartTime:"1300",
		    lunchEndTime: "1400",
	      dinnerStartTime :"1800",
	      dinnerEndTime :"1900",
	      overEndTime:"2200",
	      nightEndTime:"2500",
				status : "insert"
		};
		
		return newData;
	}

	function addGridRow() {
		var newItem = createNewRowData();
		console.log(newItem);
		gridOptions.api.updateRowData({ add : [ newItem ] }); // 그리드 정보 업데이트 
		getRowData(); // 추가된 정보를 배열에 다시 넣는 작업을 함 
	}

	function getRowData() {
		addrowData = []; // 수정된 정보를 담을 배열 , 호출 될 때 마다 초기화 됨 
		
		gridOptions.api.forEachNode(function(node) {
			addrowData.push(node.data);
		});
		console.log('Reload Row Data:');
		console.log(addrowData);
	}

	/* 그리드에 행 삭제 (주석은 행 추가하는거 참조)*/
	function delGridRow(){
		var selectedData = gridOptions.api.getSelectedRows(); //선택된 row를 가지고 옴  [] 에 담아서 
		var selectedData0 = selectedData[0];
		
		if (selectedData0.status == "normal") {
			selectedData0.status = 'delete'
			gridOptions.api.updateRowData({ update : selectedData });
		}
		
		console.log('delete Data:');
		console.log(selectedData);

		getRowData(); // 굳이 필요없는 듯 
	}

	/* 저장 버튼을 눌렀을 때 실행되는 함수 */
	function modifyTime() {
		if (addrowData != null) {
			console.log("추가 된 Row 가 있습니다");
			var sendData = JSON.stringify(addrowData);
			alert(sendData);
		} else {
			console.log("추가 된 Row가 존재하지 않습니다");
			var sendData = JSON.stringify(updatedTimeBean);
			alert(sendData);
		}

		$('#baseWorkTime_grid').children().remove(); // 필수적으로 필요함 , ajax 이기 때문에 
		
		$.ajax({
			type : "PUT",
			url : "${pageContext.request.contextPath}/foudinfomgmt/basetime",
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
				location.reload();
			}
		});
	}
	
</script>
<section id="tabs" style="width:auto; height:auto; text-align: center;" class="wow fadeInDown">
	<div class="container">
		<h6 class="section-title h3" style="text-align:left;">기준근무시간관리</h6>
		<hr style="background-color:white; height: 1px;">
		<input type="button" class="btn btn-light btn-sm" value="추가" id= "add_time_Btn">
		<input type="button" class="btn btn-light btn-sm" value="삭제" id="del_time_Btn">
		<input type="button" class="btn btn-light btn-sm" value="저장" id="mod_time_Btn">
		<div class="row">
			<div class="col-12">
				<div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
					<div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
						<div id="baseWorkTime_grid" style="width: 100%; height: 500px;" class="ag-theme-balham"></div>
					</div>
				</div>
			
			</div>
		</div>
	</div>
</section>