<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width: 1579px; ">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>월근태관리</title>
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
	padding-top:20px;
    color: #eee;
}
#container{
	margin:auto 0;
	padding-left:5px;
	padding-right:5px;
}
select{
	font-size:small;
}
</style>


<script>
var monthAttdMgtList = [];

	$(document).ready(function(){

	    showMonthAttdMgtListGrid();
	    
		$("input:text").button();
		$(".small_Btn").button();

		$("#search_monthAttdMgtList_Btn").click(findMonthAttdMgtList); 	// 조회버튼 
		$("#finalize_monthAttdMgt_Btn").click(finalizeMonthAttdMgt); 	// 마감버튼 
		$("#cancel_monthAttdMgt_Btn").click(cancelMonthAttdMgt); 		// 마감취소버튼 
		
		
		var year = (new Date()).getFullYear();
		
		for(var i=1; i<=12; i++){
			$("#searchYearMonth").append($("<option />").val(year+"-"+i).text(year+"년 "+i+"월"));	
		}
		
		});

	
	
	/* 월근태관리 목록 조회버튼 함수 */
	function findMonthAttdMgtList(){
		if($("#searchYearMonth").val()==""){
			alert("조회연월을 선택해 주세요");
			return;
		}

		$.ajax({
			url:"${pageContext.request.contextPath}/attdappvl/month-attnd",
			data:{
				"applyYearMonth" : $("#searchYearMonth").val(),
				"workplaceCode":"${sessionScope.workplaceCode}"
			},
			dataType:"json",
			success : function(data){
				
				if(data.errorCode < 0){
					var str = "내부 서버 오류가 발생했습니다\n";
					str += "관리자에게 문의하세요\n";
					str += "에러 위치 : " + $(this).attr("id");
					str += "에러 메시지 : " + data.errorMsg;
					alert(str);
					return;
				}

				monthAttdMgtList = data.monthAttdMgtList;
				console.log(monthAttdMgtList);
				
 				for(var index in monthAttdMgtList){
 					monthAttdMgtList[index].workHour = getRealTime(monthAttdMgtList[index].workHour); //1600을 16:00으로
 					monthAttdMgtList[index].overWorkHour = getRealTime(monthAttdMgtList[index].overWorkHour);
 					monthAttdMgtList[index].nightWorkHour = getRealTime(monthAttdMgtList[index].nightWorkHour);
 					monthAttdMgtList[index].holidayWorkHour = getRealTime(monthAttdMgtList[index].holidayWorkHour);
 					monthAttdMgtList[index].holidayOverWorkHour = getRealTime(monthAttdMgtList[index].holidayOverWorkHour);
 					monthAttdMgtList[index].holidayNightWorkHour = getRealTime(monthAttdMgtList[index].holidayNightWorkHour);
				}
				
				showMonthAttdMgtListGrid();
			}
		});
	}

    /* 월근태관리 목록 그리드 띄우는 함수 */
    function showMonthAttdMgtListGrid(){
		var columnDefs = [
		      {headerName: "사원코드", field: "empCode" },
		      {headerName: "사원명", field: "empName"},
		      {headerName: "적용연월", field: "applyYearMonth" },
		      {headerName: "기준근무일수", field: "basicWorkDays"},
		      {headerName: "평일근무일수", field: "weekdayWorkDays"},
		      {headerName: "기준근무시간", field: "basicWorkHour"},
		      {headerName: "실제근무시간", field: "workHour"},
		      {headerName: "연장근무시간", field: "overWorkHour"},
		      {headerName: "심야근무시간", field: "nightWorkHour"},
		      {headerName: "휴일근무일수", field: "holidayWorkDays"},
		      {headerName: "휴일근무시간", field: "holidayWorkHour"},
		      {headerName: "지각일수", field: "lateDays"},
		      {headerName: "결근일수", field: "absentDays"},
		      {headerName: "반차일수", field: "halfHolidays"},
		      {headerName: "휴가일수", field: "holidays"},
		      {headerName: "마감여부", field: "finalizeStatus"},
		      {headerName: "상태", field: "status",hide:true}
		];      
	gridOptions = {
			columnDefs: columnDefs,
			rowData: monthAttdMgtList,
			defaultColDef: { editable: false, width: 100 },
			rowSelection: 'single', /* 'single' or 'multiple',*/
			enableColResize: true,
			enableSorting: true,
			enableFilter: true,
			enableRangeSelection: true,
			suppressRowClickSelection: false,
			animateRows: true,
			suppressHorizontalScroll: true,
			localeText: {noRowsToShow: '조회 결과가 없습니다.'},
			getRowStyle: function (param) {
		        if (param.node.rowPinned) {
		            return {'font-weight': 'bold', background: '#dddddd'};
		        }
		        return {'text-align': 'center'};
		    },
		    getRowHeight: function(param) {
		        if (param.node.rowPinned) {
		            return 30;
		        }
		        return 24;
		    },
		    // GRID READY 이벤트, 사이즈 자동조정 
		    onGridReady: function (event) {
		        event.api.sizeColumnsToFit();
		    },
		    // 창 크기 변경 되었을 때 이벤트 
		    onGridSizeChanged: function(event) {
		        event.api.sizeColumnsToFit();
		    }
	};   
	
 	$('#monthAttdMgtList_grid').children().remove(); /* 자식노드를 지워서 중복생성 방지 */
	var eGridDiv = document.querySelector('#monthAttdMgtList_grid');
	new agGrid.Grid(eGridDiv, gridOptions); /* 새로 생성 */
}

    
    
    /* 마감처리 함수 */
    function finalizeMonthAttdMgt(){
		for(var index in monthAttdMgtList){
			monthAttdMgtList[index].finalizeStatus = "Y";
			monthAttdMgtList[index].status = "update";
		}

		var sendData = JSON.stringify(monthAttdMgtList);

		$.ajax({
			type : "PUT",
			url : "${pageContext.request.contextPath}/attdappvl/month-attnd",
			data : sendData,
			contentType:"application/json",
			dataType : "json",
			success : function(data) {
				if(data.errorCode < 0){
					alert("마감을 실패했습니다");
				} else {
					alert("마감처리 되었습니다");
				}
				location.reload();
			}
		});
	}

    /* 마감취소 함수 */
    function cancelMonthAttdMgt(){
		for(var index in monthAttdMgtList){
			monthAttdMgtList[index].finalizeStatus = "N";
			monthAttdMgtList[index].status = "update";
		}

		var sendData = JSON.stringify(monthAttdMgtList);

		$.ajax({
			type : "PUT",
			url : "${pageContext.request.contextPath}/attdappvl/month-attnd",
			data : sendData,
			contentType:"application/json",
			dataType : "json",
			success : function(data) {
				if(data.errorCode < 0){
					alert("마감취소를 실패했습니다");
				} else {
					alert("마감취소처리 되었습니다");
				}
				location.reload();
			}
		});
	}
    

	/* 0000단위인 시간을 (00시간00분) 형식으로 변환하는 함수 */
	function getRealTime(time){
		var hour = Math.floor(time/100); 
		if(hour==25) hour=1; //데이터 베이스에 넘길때는 25시로 받고나서 grid에 표시하는건 1시로
		var min = time-(Math.floor(time/100)*100);
		if(min.toString().length==1) min="0"+min; //분이 1자리라면 앞에0을 붙임
		if(min==0) min="00";
		return hour + ":" + min;
	}
</script>
</head>
<body>
<section id="tabs" style="width:100%;height:530px; text-align: center;" class="wow fadeInDown">
		<h6 class="section-title h3">월근태관리</h6>
		<div class="container">
		<hr style="background-color:white; height: 1px;">
		</div>
		<div style="text-align:center">
			조회월<div class="col col-md-4" style="float:unset;display:inline-block;width:170px;">
	                         <select class="form-control" id="searchYearMonth"></select> </div>
	       <input type= "button" value="조회하기" class="btn btn-light btn-sm" id="search_monthAttdMgtList_Btn">
       
		</div>
		<br/> 
		<br/>
		<div style="text-align:right">
			<input type= "button" value="전체마감하기" class="btn btn-light btn-sm" id="finalize_monthAttdMgt_Btn">
			<input type= "button" value="전체마감취소" class="btn btn-light btn-sm" id="cancel_monthAttdMgt_Btn">
		</div>
		<div id="monthAttdMgtList_grid" style="height: 300px; width: 100%;" class="ag-theme-balham"></div>
</section>
</body>

</html>