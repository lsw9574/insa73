<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>채용조건</title>
	<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyC8UHAVjK073bToMSOZg0eTE9HRRB4SuB8" ></script>
	<script>
		let nempBean={};
		let findTermsBean={};
		$(document).ready(function() {
			Map();
		    $("#condition_form").click(condition_Form);
		    findTerms();
		    $("#resetvalue").click(resetBtn);
		});
		
		function Map()
		{
		    var Y_point = 35.159755;        // Y 좌표
		    var X_point = 128.1062387;        // X 좌표
		    var zoomLevel = 18;                // 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼
		    var markerTitle = "서울IT교육센터";        // 현재 위치 마커에 마우스를 오버을때 나타나는 정보
		    var markerMaxWidth = 300;                // 마커를 클릭했을때 나타나는 말풍선의 최대 크기
		    var contentString    = '<div style="color:black;">' +		// 말풍선 내용
		    '<h2>오시는 길</h2>'+
		    '<p>주소 : 경상남도 진주시 가좌동 가좌길74번길 8 KR 혜람빌딩 5층</p>' +
			'<p>영업 시간 : 평일 오전 9:00 ~ 오후 10:00, 토요일 오전 9:00 ~ 오후 1:00</p>'+
			'<p>보건 및 안전 : 예약 필수 · 마스크 필수 · 체온 확인 필수 · 직원 마스크 착용함 · 직원 체온 확인함 </p>' +
			'<p>연락처 : 055-753-3677</p>'
		    '</div>';
		    var myLatlng = new google.maps.LatLng(Y_point, X_point);
		    var mapOptions =
		    {
				zoom: zoomLevel,
				center: myLatlng,
				mapTypeId: google.maps.MapTypeId.ROADMAP
			}
		    var map = new google.maps.Map(document.getElementById('map_ma'), mapOptions);
		    var marker = new google.maps.Marker
		    ({
				position: myLatlng,
				map: map,
				title: markerTitle
		    });
		    var infowindow = new google.maps.InfoWindow
		    ({
		           content: contentString,
		           maxWizzzdth: markerMaxWidth
		    });
		    google.maps.event.addListener(marker, 'click', function()
		    {
		        infowindow.open(map, marker);
		    });
		}
		function saveInfo()
		{//각 데이터들을 컨트롤러에게 보내기 위해 nempBean에 저장
			console.log(nempBean);
			nempBean.min_age=$("#min_age").val(); 
			nempBean.max_age=$("#max_age").val();
			nempBean.dept=$("#dept").val();
			nempBean.last_school=$("#last_school").val();
			nempBean.career=$("#career").val();
			nempBean.year=$("#year").val();
			nempBean.half=$("#half").val();
			nempBean.hwp_file=$("#hwp_file").val();
			nempBean.workplaceCode=${sessionScope.workplaceCode};
		}
		function condition_Form()
		{//JSON형태로 nempBean데이터를 전송
			saveInfo();
			const sendData = JSON.stringify(nempBean);
			$.ajax
			({
				type : "POST" ,
				url : "${pageContext.request.contextPath}/documentmgmt/condition",
				dataType : "json",
				data : sendData,
				contentType:"application/json",
				success : function(data)
				{
					if(data.errorCode<0){
		                 var error=/unique constraint/;
		                 if(error.test(data.errorMsg)){
		                    alert("에러 : "+data.errorMsg);
		                    return false;
		                 }              
		              }
					else
		              alert(nempBean.year + "년도 의 "+nempBean.half + "의 신입사원 채용 정보를 저장하였습니다.");
					location.reload(); 
				}
			});
			
	        var form = new FormData();
	        form.append( "hwp_file", $("#hwp_file")[0].files[0] );
			$.ajax
			({
				type : "POST" ,
				url : "${pageContext.request.contextPath}/documentmgmt/conditionFile",
				dataType : "json",
				processData : false,
		        contentType : false,
				data: form,
				success : function(data)
				{
					if(data.errorCode<0){
		                 var error=/unique constraint/;
		                 if(error.test(data.errorMsg)){
		                    alert("에러 : "+data.errorMsg);
		                    return false;
		                 }              
		              }
					else
		              alert(nempBean.year + "년도 의 "+nempBean.half + "의 신입사원 채용 정보를 저장하였습니다.");
					location.reload(); 
				}
			});
		}
		
		function findTerms()
		{ //실행하자마자 지원서 양식들의 데이터를 가져옴
			$.ajax
			({
				url:'${pageContext.request.contextPath}/documentmgmt/termslist',
				data : {"workplaceCode":"${sessionScope.workplaceCode}"},
				dataType:"json",
				success : function(data)
				{
					if(data.errorCode < 0)
					{
						var str = "내부 서버 오류가 발생했습니다\n";
						str += "관리자에게 문의하세요\n";
						str += "에러 위치 : " + $(this).attr("id");
						str += "에러 메시지 : " + data.errorMsg;
						alert(str);
						return;
					}
					findTermsBean = data.termlist;
					showTermsListGrid();
				}
			});
		}
		function showTermsListGrid()
		{
			let TermsListGridOptions={};
			const columnDef =
			[
					{ headerName : "채용년도", field : "year"},
					{ headerName : "반기", field : "half" },
					{ headerName : "최소나이", field : "min_age" },
					{ headerName : "최대나이", field : "max_age" },
					{ headerName : "모집부문", field : "dept" },
					{ headerName : "경력", field : "career" },
					{ headerName : "학력", field : "last_school" },
					{ headerName : "채용양식", field : "hwp_file" }
			];
			let hiperlink = [];
 		 	
			TermsListGridOptions = 
			{
					columnDefs : columnDef, //  정의된 칼럼 정보를 넣어준다. 
					rowData : findTermsBean, // 그리드 데이터, json data를 넣어준다. 
					enableColResize : true, // 칼럼 리사이즈 허용 여부
					enableRangeSelection : true, // 정렬 기능 강제여부, true인 경우 정렬이 고정이 된다.  
					localeText : { noRowsToShow : '조회 결과가 없습니다.' }, // 데이터가 없는 경우 보여 주는 사용자 메시지
					
					getRowStyle : function(param)
					{ // row 스타일 지정 e.g. {"textAlign":"center", "backgroundColor":"#f4f4f4"}
						if (param.node.rowPinned)
						{
							return {
								'font-weight' : 'bold',
								background : '#dddddd'
							};
						}
						return {
							'text-align' : 'center'
						};
					},
					getRowHeight : function(param)
					{ // // 높이 지정
						if (param.node.rowPinned)
						{
							return 30;
						}
						return 24;
					},
					onGridReady : function(event)
					{ // GRID READY 이벤트, 사이즈 자동조정 
						event.api.sizeColumnsToFit();
					},
					
					onGridSizeChanged : function(event)
					{ // 창 크기 변경 되었을 때 이벤트 
						event.api.sizeColumnsToFit();
					},
					onCellClicked : function(event)
					{
						if( event.data.hwp_file == "채용공고_무관.hwp")
							event.data.hwp_file = "채용공고_전체.hwp"
						location.href ="${pageContext.request.contextPath}/termfile/"+event.data.hwp_file;
					}
				};
			
				let eGridDiv = document.querySelector('#grid');
				new agGrid.Grid(eGridDiv, TermsListGridOptions); // 그리드 생성, 가져온 자료 그리드에 뿌리기
		}
		function resetBtn()
		{
			$("#min_age").val("20"); 
			$("#max_age").val("30");
			$("#dept").val("무관");
			$("#last_school").val("고졸");
			$("#career").val("");
			$("#year").val("2022");
			$("#half").val("상반기");
			$("#hwp_file").val("");
		}
	</script>
	<style type="text/css">
		.dv{background-color:white;margin-top:10px;}
		#map_ma {width:100%; height:400px; clear:both;}
		.th{background-color : rgba(0, 0, 0, 0.22); color:black; border:solid 1px white; text-align: center}
		#th_top{border-top:solid 1px rgba(0, 0, 0, 0.22);}
 		#th_bottom{border-bottom:solid 1px rgba(0, 0, 0, 0.22);}
 		#hwp_file{color:black;}
		.tb{border: 1px solid rgba(0, 0, 0, 0.22); height:auto; height : 50px;}
		input[type="text"],input[type="number"],select{border:none; border-bottom:solid 1px rgba(0, 0, 0, 0.22);}
		input[type="text"]:focus,input[type="number"]:focus,select:focus{outline:2px solid #d50000;}
		#tabs{
			background: #333333;
			background-color: rgba( 0, 0, 0, 0.3 );
		    color: #eee;
		    height:auto;
		}
	</style>
</head>
<body>
	<section id="tabs" style="width:100%;height:1100px;" class="wow fadeInDown">
	<div class="container">
		<div id = "dv_body">
			<h6 class="section-title h3">오시는 길</h6>
			<hr style="background-color:white; height: 1px;">
			<div>
				<div id = "map_ma" class="solid-red-one" ></div>
			</div>
			<br/>
			<h6 class="section-title h3">기초 조건 양식</h6>
			<hr style="background-color:white; height: 1px;">
			<div class="dv" style="width:80%">
				
				<table class = "tb" >
					<tr>
						<td class ="th" id="th_top">
							최소 나이
						</td>
						<td>
							<input type ="number" placeholder="min_age" name = "min_age" id="min_age" maxlength='3' value=20 />
						</td>
						<td class ="th" id="th_top">
							최대 나이
						</td>
						<td>
							<input type ="number" placeholder="max_age" name = "max_age" id="max_age" maxlength='3' value=30 />
						</td>
					</tr>
					<tr>
						<td class ="th">
							채용 년도
						</td>
						<td>
							<input type ="number" placeholder="year" name = "year" id="year" value=2022 />
						</td>
						<td class ="th">
					 		반기
						</td>
						<td>
							<label for="half" ></label>
							  <select id = "half">
							    <option value="상반기" >상반기(1~6월)</option>
							    <option value="하반기" >하반기(7~12월)</option>
							  </select>
							 
						</td>
					</tr>
					<tr>
						<td class ="th">
							경력
						</td>
						<td>
							<input type ="text" placeholder="career" name = "career" id="career" />
						</td>
						<td class ="th">
							모집 부문
						</td>
						<td>
							<label for='dept' ></label>
							  <select id = "dept">
							    <option value="인사팀" >인사팀</option>
							    <option value="회계팀" >회계팀</option>
							    <option value="전산팀" >전산팀</option>
							    <option value="보안팀" >보안팀</option>
							    <option value="개발팀" >개발팀</option>
							    <option value="무관" selected >무관</option>
							  </select>
						</td>
					</tr>
					<tr>
						<td class ="th" id="th_bottom">
							학력
						</td>
						<td>
							<label for='last_school' ></label>
							  <select id = "last_school">
							    <option value="초졸" >초졸</option>
							    <option value="중졸" >중졸</option>
							    <option value="고졸" selected >고졸</option>
							    <option value="2년제대학" >2년제대학</option>
							    <option value="4년제대학" >4년제대학</option>
							  </select>
						</td>
						<td class ="th" id="th_bottom">
							채용 양식
						</td>
						<td>
							<input type="file" name="hwp_file" accept=".hwp" id="hwp_file" />
						</td>
					</tr>
				</table>
			</div>
			<input type = "button" value="전송" id = "condition_form" class="jbtn" />
			<input type = "reset" value="취소" id="resetvalue" class="jbtn" />
			<br/>
			<br/>
			<h6 class="section-title h3">년도별 인적 사항 조건</h6>
			<hr style="background-color:white; height: 1px;">
			<div>
				<div id = "grid" class="ag-theme-balham" style="width:100%; height:200px;" ></div>
			</div>
		</div>
	</div>
	</section>
</body>
</html>