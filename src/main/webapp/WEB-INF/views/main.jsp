<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<%-- <c:set var="dept" value="" />

<c:if test="${ not empty sessionScope.id}">               
	<c:set var="dept" value="${sessionScope.dept}" />   
</c:if>

<c:set var="position" value="" />

<c:if test="${ not empty sessionScope.id}">
	<c:set var="position" value="${sessionScope.position}" />
</c:if> --%>

<c:set var="name" value="Guest"/> <!-- 기본아이디는 Guest -->

<c:if test="${ not empty sessionScope.id}"> <!-- sessionScope.id가 있는 경우 -->
    <c:set var="name" value="${sessionScope.id}"/> <!-- 아이디는 세션에 있는 아이디 -->
</c:if>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
</head>

<body>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

<div id="dTagStyle1" class="wow fadeInDown" style="margin-left:20px">
    <font color="white" id="font1">${name} ${position}님</font>
</div>

<div id="dTagStyle2" class="wow fadeInUp" style="margin-left:20px">
    <font color="white" id="font2">환영합니다</font>
</div>

<script>
    document.getElementById("dTagStyle1").style.font = "bold 45px Do Hyeon";
    document.getElementById("dTagStyle2").style.font = "bold 45px Do Hyeon";
</script>
</body>
</html>