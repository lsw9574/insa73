<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
	body{
		background-color : black;
		color:white;
		text-align:center;
	}
	.header{
		width:100%;
		height:50px;
		font-size:30px;
	}
	.center_table{
		width:100%;
		text-align:center;
	}
	.tbl{
		display:inline-block;
	}
	input[type="text"], input[type="number"]{
	  height: 40px;
	  width: 300px;
	  border: 0;
	  border-radius: 5px;
	  outline: none;
	  padding-left: 10px;
	  background-color: rgb(233, 233, 233);
	}
	td{
		text-align : right;
	}
	.jbtn{
		width:80px;
		height:30px;
		background-color: white;
		border: none;
		color: black;
		text-align: center;
		text-decoration: none;
		-webkit-transition-duration: 0.4s;
		transition-duration: 0.4s;
		cursor: pointer;
		border:1px black solid;
		border-radius: 5px;
	}
	.jbtn:hover
	{
		background-color: black;
		color: white;
		border-radius: 5px;
	}
</style>

<c:choose>
	<c:when test="${sessionScope.dept eq '인사팀'}">
	<head>
		<script
      src="https://code.jquery.com/jquery-3.6.0.min.js"
      integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
      crossorigin="anonymous"
    ></script>
		<script type="text/javascript">
		    let bean = {};
			$(document).ready(function(){
				$("#update_btn").click(modifyBtnF);
				$("#cancel_btn").click(cancelBtnF);
			})
			function saveInfo()
			{
				bean.p_code=$("#p_code").val();
				bean.p_name=$("#p_name").val();
				bean.p_age=$("#p_age").val();
				bean.p_gender=$("#p_gender").val();
				bean.p_address=$("#p_address").val();
				bean.p_tel=$("#p_tel").val();
				bean.p_email=$("#p_email").val();
				bean.p_dept=$("#p_dept").val();
				bean.p_last_school=$("#p_last_school").val();
				bean.p_career=$("#p_career").val();
			}
			function modifyBtnF(){
				saveInfo();
				const sendData = JSON.stringify(bean);
				$.ajax({
					type : "PUT" ,
					url:'${pageContext.request.contextPath}/newempinfomgmt/resumemgmt',
					dataType:"json",
					data : sendData,
					contentType:"application/json",
					success : function(data){
						if(data.errorCode < 0){
							let str = "내부 서버 오류가 발생했습니다\n";
							str += "관리자에게 문의하세요\n";
							str += "에러 위치 : " + $(this).attr("id");
							str += "에러 메시지 : " + data.errorMsg;
							alert(str);
							return;
						}
						window.opener.location.reload();
						window.close();
						
					}
				});
			}
			function cancelBtnF(){
				$("#p_name").val('<%=request.getParameter("p_name")%>');
				$("#p_age").val('<%=request.getParameter("p_age")%>');
				$("#p_gender").val('<%=request.getParameter("p_gender")%>');
				$("#p_address").val('<%=request.getParameter("p_address")%>');
				$("#p_tel").val('<%=request.getParameter("p_tel")%>');
				$("#p_email").val('<%=request.getParameter("p_email")%>');
				$("#p_dept").val('<%=request.getParameter("p_dept")%>');
				$("#p_last_school").val('<%=request.getParameter("p_last_school")%>');
				$("#p_career").val('<%=request.getParameter("p_career")%>');
			}
		</script>
	</head>
	<body>
		<div class="header"><p>이력서 수정</p></div>
		<div class="center_table" >
		<table class="tbl">
			<tr>
				<td>임시코드 </td>
				<td><input type="text" id="p_code" value= <%=request.getParameter("p_code")%> readonly /></td>
			</tr>
			<tr>
				<td>이름 </td>
				<td><input type="text" id="p_name" value=<%=request.getParameter("p_name")%> /></td>
			</tr>
			<tr>
				<td>나이 </td>
				<td><input type="number" id="p_age" value=<%=request.getParameter("p_age")%> /></td>
			</tr>
			<tr>
				<td>성별 </td>
				<td><input type="text" id="p_gender" value=<%=request.getParameter("p_gender")%> /></td>
			</tr>
			<tr>
				<td>주소 </td>
				<td><input type="text" id="p_address" value='<%=request.getParameter("p_address")%>' /></td>
			</tr>
			<tr>
				<td>전화번호 </td>
				<td><input type="text" id="p_tel" value=<%=request.getParameter("p_tel")%> /></td>
			</tr>
			<tr>
				<td>이메일 </td>
				<td><input type="text" id="p_email" value=<%=request.getParameter("p_email")%> /></td>
			</tr>
			<tr>
				<td>부서 </td>
				<td><input type="text" id="p_dept" value=<%=request.getParameter("p_dept")%> /></td>
			</tr>
			<tr>
				<td>학력 </td>
				<td><input type="text" id="p_last_school" value=<%=request.getParameter("p_last_school")%> /></td>
			</tr>
			<tr>
				<td>경력 </td>
				<td><input type="text" id="p_career" value='${param.p_career}' /></td>
			</tr>
		</table>
		</div>
		<button class="jbtn" id = "update_btn" >정보 수정</button><button class="jbtn" id = "cancel_btn" >초기화</button>
	</body>
	</c:when>
	<c:otherwise>
		<script>
			alert("'인사' 부서의 권한이 필요합니다.");
			window.close();
		</script>
	</c:otherwise>
</c:choose>