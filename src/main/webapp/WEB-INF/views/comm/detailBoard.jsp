<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
	td { font-colSize:0.8em; }
	table { width:400px; }	
	a { cursor:pointer;text-decoration:underline; }
	h3 { font-weight: bold; }
				
	.hStyle { 
		background-color:gray; 
		color:white; 
		width:25%;
	}
	
	.sStyle{
		font-colSize:9px;
		text-decoration:underline;
		color:red;
	}
	
	.card1 {
	  	background-color: #FFFFFF !important;
	  	border-radius: 10px;
	}
</style>
<script>
	var board=[];
	$(document).ready(function () {
		findDetailBoardList();
	});
	
	function downloadFunc(fn,tfn){
		var path='${pageContext.request.contextPath}/systemmgmt/detail-board/file';
		location.href=path+'?fileName='+fn+'&tempFileName='+tfn;
	}
	
	function reply(replyObj){
		var path='${pageContext.request.contextPath}/comm/registForm/view';
		replyObj.href=path+'?board_seq='+board.board_seq;
	}
	
	
	function back(){
		location.href="${pageContext.request.contextPath}/comm/listBoard/view"
	}
	
	function findDetailBoardList(){
		var html="";
		var boardSeq=<%=request.getParameter("board_seq")%>;
		$.ajax({
	   		url:"${pageContext.request.contextPath}/systemmgmt/detail-board",
	   		data : {"board_seq" : boardSeq},
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
				console.log(data.board);
				board=data.board;
				html += "<tr>";
				html += "<td class='hStyle'>글제목</td>";
				html += "<td>" + board.title + "<span class='sStyle'>조회수:"+board.hit+"</span></td>";
				html += "<td class='hStyle'>작성자</td>";
				html += "<td>" + board.name + "</td>";
				html += "</tr>";
				html += "<tr>";
				html += "<td class='hStyle'>내용</td>";
				html += "<td colspan='3'>" + board.content + "</td>";
				html += "</tr>";
				html += "<tr>";
				html += "<td class='hStyle'>첨부파일</td>";
				html += "<td colspan='3'>";
				for(index in board.boardFiles){
					html += "<a onclick=downloadFunc('"+board.boardFiles[index].fileName+"','"+board.boardFiles[index].tempFileName+"')>"+board.boardFiles[index].fileName+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+"</a></br>";
				}
				html += "</td>";
				html += "</tr>";
				$("#DetailTable").empty();
				$("#DetailTable").append(html);
	   		}  		
	  	});	
	}
	function deleteBoard(){
		$.ajax({
			type : "DELETE",
	   		url:"${pageContext.request.contextPath}/systemmgmt/detail-board",
	   		data : {"board_seq" : board.board_seq},
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
				alert(data.errorMsg);
				location.href="${pageContext.request.contextPath}/comm/listBoard/view"
			}
	   		
		});
	}
</script>
</head>

<body>
	<h3><small>&nbsp;</small></h3>
	<h3><small>&nbsp;</small></h3>
	<div class="container">
		<div class="card1">
			<div class="card-body">
				<h3 class="display-10 text-dark font-weight-bold" >게시글상세보기</h3>
				<h3><small>&nbsp;</small></h3>
				<table class="table text-center table-striped table-bordered table-sm" id="DetailTable">		
				</table>
				<p>
				<form id="formTag">
					<a class="btn btn-outline btn-sm dark-text font-weight-bold text-dark" role="button" onclick="reply(this)">답변</a>
					<a class="btn btn-outline btn-sm dark-text font-weight-bold text-dark" role="button" onclick="deleteBoard()">삭제</a>
					<a class="btn btn-outline btn-sm dark-text font-weight-bold text-dark" role="button" onclick="back()">뒤로가기</a>
				</form>
			</div>
		</div>
	</div>
</body>
</html>


