<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>success_applicant</title>
<script type="text/javascript">
let bean = {};
$(document).ready(function(){
	$("#applicantbtn").click(applicant);
});
function yearhalfInfo()
{
	bean.sendyear = $("#year").val();
	bean.half = $("#half").val();
	bean.workplaceCode = "${sessionScope.workplaceCode}";
}
function applicant(){
	$("#grid").html("");
	yearhalfInfo();
	const sendData = JSON.stringify(bean);
	$.ajax({
		type : "GET" ,
		url:'${pageContext.request.contextPath}/newempinfomgmt/applicant',
		dataType:"json",
		data : bean,
		success : function(data){
			console.log(data);
			if(data.errorCode < 0){
				let str = "내부 서버 오류가 발생했습니다\n";
				str += "관리자에게 문의하세요\n";
				str += "에러 위치 : " + $(this).attr("id");
				str += "에러 메시지 : " + data.errorMsg;
				alert(str);
				return;
			}
			let Infolist = data.applilist;
			showListGrid(Infolist);
		}
	});
}
function showListGrid(Infolist) {
	const columnDef =
	[
		{ headerName : "임시코드", field : "code"},
		{ headerName : "면접평균", field : "interview_avg"},
		{ headerName : "인성평균", field : "personality_avg"},
		{ headerName : "이름", field : "name" },
		{ headerName : "나이", field : "age" },
		{ headerName : "성별", field : "gender" },
		{ headerName : "주소", field : "address" },
		{ headerName : "전화번호", field : "tel" },
		{ headerName : "이메일", field : "email" },
		{ headerName : "부서", field : "dept" },
		{ headerName : "학력", field : "last_school" },
		{ headerName : "경력", field : "career" }
	];
	ListGridOptions = {
		columnDefs : columnDef, //  정의된 칼럼 정보를 넣어준다. 
		rowData : Infolist, // 그리드 데이터, json data를 넣어준다. 
		enableColResize : true, // 칼럼 리사이즈 허용 여부
		enableSorting : true, // 정렬 옵션 허용 여부
		enableFilter : true, // 필터 옵션 허용 여부
		enableRangeSelection : true, // 정렬 기능 강제여부, true인 경우 정렬이 고정이 된다.  
		localeText : { noRowsToShow : '조회 결과가 없습니다.' }, // 데이터가 없는 경우 보여 주는 사용자 메시지
		
		getRowStyle : function(param) { // row 스타일 지정 e.g. {"textAlign":"center", "backgroundColor":"#f4f4f4"}
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
		getRowHeight : function(param) { // // 높이 지정
			if (param.node.rowPinned) {
				return 30;
			}
			return 24;
		},
		onGridReady : function(event) { // GRID READY 이벤트, 사이즈 자동조정 
			event.api.sizeColumnsToFit();
		},
		
		onGridSizeChanged : function(event) { // 창 크기 변경 되었을 때 이벤트 
			event.api.sizeColumnsToFit();
		}
		
	};
	let eGridDiv = document.querySelector('#grid');
	console.log(columnDef);
	console.log(Infolist);
	new agGrid.Grid(eGridDiv, ListGridOptions); // 그리드 생성, 가져온 자료 그리드에 뿌리기
}
</script>
<style>
	.container2{
		background: #333333;
		background-color: rgba( 0, 0, 0, 0.3 );
	    color: #eee;
	    height:auto;
	}
</style>
</head>
<body>
	<div class="container2 wow fadeInDown" style="height:700px;" >
		<div class="container">
			<h6 class="section-title h3">합격자 조회</h6>
			<hr style="background-color:white; height: 1px;">
			<label for="year" /></label>
			 	 <select id = "year">
					<option value="2020">2020</option>
					<option value="2021">2021</option>
					<option value="2022">2022</option>
				 </select>년도
			<label for="half" ></label>
				 <select id = "half">
				   <option value="상반기" >상반기(1~6월)</option>
				   <option value="하반기" >하반기(7~12월)</option>
				 </select>
			<input type = "button" id = "applicantbtn" value="전송" class='jbtn'/>
			<div id="grid" class="ag-theme-balham" style="width:80%; height:500px;"></div>
		</div>
	</div>
</body>
</html>