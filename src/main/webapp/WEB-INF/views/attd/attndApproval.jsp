<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>근태외승인</title>
<style type="text/css">

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
var restAttdList = [];

	$(document).ready(function(){

		$("input:text").button(); //text 박스를 버튼 화 시키는 것 
		$(".small_Btn").button(); // 얘도 버튼 

		$(".comment_div").css({fontSize : "0.7em"});
		$("#attdList_tabs").tabs().css({margin:"10px"});

		getDatePicker($("#search_restAttd_startDate"));
		getDatePicker($("#search_restAttd_endDate"));
		
		showRestAttdListGrid(); // 근태외신청목록 그리드 처음엔 검색목록이 안 뜨기 때문 ~ 

		findRestAttdList("모든부서"); //신청일자가 오늘인 근태외신청을 바로 보여준다
		
		$("#search_restAttd_deptName").click(function(){
			getCode("CO-07","search_restAttd_deptName","search_restAttd_deptCode");
		}); // 부서선택
		
		$("#search_restAttd_startDate").change(function(){
			$("#search_restAttd_endDate").datepicker("option","minDate",$(this).val());
		}); // 시작일
		
		$("#search_restAttd_endDate").change(function(){
			$("#search_restAttd_startDate").datepicker("option","maxDate",$(this).val());
		}); // 종료일
		
		$("#search_restAttdList_Btn").click(findRestAttdList); // 조회버튼
		$("#apploval_restAttd_Btn").click(applovalRestAttd); // 승인버튼
		$("#cancel_restAttd_Btn").click(cancelRestAttd); // 승인취소버튼
		$("#reject_restAttd_Btn").click(rejectRestAttd); // 반려버튼
		$("#update_restAttd_Btn").click(modifyRestAttd); // 확정버튼
	});

   

	/* 근태외목록 조회버튼 함수 */
	function findRestAttdList(allDept){
	    var deptName = $("#search_restAttd_deptCode").val();
	    var startDate = $("#search_restAttd_startDate").val();
	  
		if(allDept=="모든부서"){ //넘어온값이 '모든부서'와 같다면 
		    deptName = allDept; //deptName를 모든부서로 바꾸고
		  
		    var today = new Date();
		    var rrrr = today.getFullYear();
		    var mm = today.getMonth()+1;
		    var dd = today.getDate();
		    startDate= rrrr+"-"+mm+"-"+dd; //시작일을 오늘날짜로 넘긴다
		    
		}
		$.ajax({
			url:"${pageContext.request.contextPath}/attdappvl/attnd-approval",
			data:{
				"deptName" : deptName,
				"startDate" : startDate,
				"endDate" : $("#search_restAttd_endDate").val(),
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

				restAttdList = data.restAttdList;
				console.log(restAttdList);
				console.log(restAttdList[0].endTime);
				console.log(restAttdList[0].startTime);
				
				for(var index in restAttdList){
					restAttdList[index].startTime = getRealTime(restAttdList[index].startTime);
					restAttdList[index].endTime = getRealTime(restAttdList[index].endTime);
				}

				showRestAttdListGrid();
			}
		});
	}
	
	
	
	 /* 근태외목록 조회 그리드 띄우는 함수 */
    function showRestAttdListGrid(){
    		var columnDefs = [
    			  {headerName: "사원코드", field: "empCode",hide:true },
    		      {headerName: "사원명", field: "empName",checkboxSelection: true , width: 130},
    		      {headerName: "일련번호", field: "restAttdCode",hide:true },
    		      {headerName: "근태구분코드", field: "restTypeCode",hide:true},
    		      {headerName: "근태구분명", field: "restTypeName" , width: 100},
    		      {headerName: "신청일자", field: "requestDate" , width: 130},
    		      {headerName: "시작일", field: "startDate" , width: 130},
    		      {headerName: "종료일", field: "endDate" , width: 130},
    		      {headerName: "시작시간", field: "startTime", width: 80},
    		      {headerName: "종료시간", field: "endTime", width: 80},
    		      {headerName: "일수", field: "numberOfDays" , width: 80},
    		      {headerName: "경비", field: "cost" , width: 80},
    		      {headerName: "사유", field: "cause" , width: 80},
    		      {headerName: "승인여부", field: "applovalStatus",editable:true , width: 110},
    		      {headerName: "반려사유", field: "rejectCause",editable:true , width: 80},
    		      {headerName: "상태", field: "status",hide:true}
    		];      
      		gridOptions = {
      			columnDefs: columnDefs,
      			rowData: restAttdList,
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
      			defaultColDef : {resizable : true},
      			getRowStyle: function (param) {
      				console.log(param.node);
      		        if (param.node.rowPinned) {
      		            return {'font-weight': 'bold', background: '#FF5E00'};
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
      		    },
      		    onCellEditingStarted: function (event) {
      		        console.log('cellEditingStarted');
      		    }, 
      	};   
      	$('#restAttdList_grid').children().remove();	 
      	var eGridDiv = document.querySelector('#restAttdList_grid');
      	new agGrid.Grid(eGridDiv, gridOptions);	
       }
	
	
	
	/* 확정버튼 눌렀을 때 실행되는 함수 */
	function modifyRestAttd(){
		var sendData = JSON.stringify(restAttdList);

		$.ajax({
			type : "PUT",
			url : "${pageContext.request.contextPath}/attdappvl/attnd-approval",
			data :  sendData,
			contentType:"application/json",
			dataType : "json",
			success : function(data) {
				if(data.errorCode < 0){
					alert("변경에 실패했습니다");
				} else {
					alert("확정되었습니다");
				}
				location.reload();
			}
		});
	}

	
	/* 근태외 승인버튼 함수 */
	function applovalRestAttd(){
		var rowNode = gridOptions.api.getSelectedNodes();
		console.log(rowNode[0]);
		if(rowNode[0] == null){
			alert("승인할 근태외 항목을 선택해 주세요");
			return;
		}
		rowNode[0].setDataValue('rejectCause', "");
		rowNode[0].setDataValue('applovalStatus',"승인");
		rowNode[0].setDataValue('status', "update");
		console.log(rowNode[0].data);
	}
	
	/* 근태외 승인취소버튼 함수 */
	function cancelRestAttd(){
		var rowNode = gridOptions.api.getSelectedNodes();
		if(rowNode[0] == null){
			alert("취소할 근태외 항목을 선택해 주세요");
			return;
		}
		rowNode[0].setDataValue('applovalStatus', "승인취소");
		rowNode[0].setDataValue('status', "update");
		console.log(rowNode[0].data);
	};	
	/* 근태외 반려버튼 함수 */
	function rejectRestAttd(){
		var rowNode = gridOptions.api.getSelectedNodes();
		if(rowNode[0] == null){
			alert("반려할 근태외 항목을 선택해 주세요");
			return;
		}
		rowNode[0].setDataValue('applovalStatus', "반려");
		rowNode[0].setDataValue('status', "update");
		console.log(rowNode[0].data);
	}

	
	/* 0000단위인 시간을 00:00(실제시간)으로 변환하는 함수 */
	function getRealTime(time){
		var hour = Math.floor(time/100);
		if(hour==25) hour=1; //데이터 베이스에 넘길때는 25시로 받고나서 grid에 표시하는건 1시로
		var min = time-(Math.floor(time/100)*100);
		if(min.toString().length==1) min="0"+min; //분이 1자리라면 앞에0을 붙임
		if(min==0) min="00";
		return hour + ":" + min;
	}

	/* 날짜 조회창 함수 */
	function getDatePicker($Obj, maxDate) {
			$Obj.datepicker({
				defaultDate : "d",
				changeMonth : true,
				changeYear : true,
				dateFormat : "yy-mm-dd",
				dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
				monthNamesShort : [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" ],
				yearRange: "2000:2050",
				showOptions: "up",
				maxDate : (maxDate==null? "+100Y" : maxDate)
			});
	}

	/* 코드 선택창 띄우는 함수 */
	  function getCode(code,inputText,inputCode){
		option="width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
		window.open("${pageContext.request.contextPath}/comm/codeWindow/view?code="
						+code+"&inputText="+inputText+"&inputCode="+inputCode,"newwins",option);
}
</script>
</head>
<body>
	<section id="tabs" style="height:530px; text-align: center;" class="wow fadeInDown">
		<h6 class="section-title h3">근태외 승인관리</h6>
		<div class="container">
		<hr style="background-color:white; height: 1px;">
		</div>
		<h6 style="display:inline-block;">조회부서</h6> 
              	<input type=text id="search_restAttd_deptName" style="width:100px;" readonly>
              	<input type=hidden id="search_restAttd_deptCode">
              	
       <h6 style="display:inline-block;">  조회일자</h6>  
       		<input type=text id="search_restAttd_startDate" style="width:100px;" readonly> ~ <input type=text id="search_restAttd_endDate" style="width:100px;" readonly>
       
		<input type= "button" value="조회하기" class="btn btn-light btn-sm" id="search_restAttdList_Btn">
		<br/> 
		<br/>
		<input type= "button" value="승인" class="btn btn-light btn-sm" id="apploval_restAttd_Btn">
		<input type= "button" value="승인취소" class="btn btn-light btn-sm" id="cancel_restAttd_Btn">
		<input type= "button" value="반려" class="btn btn-light btn-sm" id="reject_restAttd_Btn">
		<input type= "button" value="확정" class="btn btn-light btn-sm" id="update_restAttd_Btn">
		<div id="restAttdList_grid" style="height: 300px; width: 100%" class="ag-theme-balham"></div>
</section>
</body>
</html>