<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:set var="dept" value=""/>
<c:if test="${ not empty sessionScope.id}">            <%--값이 null이 아닐경우 --%>
    <c:set var="dept" value="${sessionScope.dept}"/>
</c:if>

<c:set var="position" value=""/>
<c:if test="${ not empty sessionScope.id}">
    <c:set var="position" value="${sessionScope.position}"/>
</c:if>

<c:set var="name" value="Guest"/>
<c:if test="${ not empty sessionScope.id}">
    <c:set var="name" value="${sessionScope.id}"/>
</c:if>

<script>
  $(document).ready(
      function () {
        const emp = {
          id: "${sessionScope.id}",
          position: "${sessionScope.position}",
          dept: "${sessionScope.dept}",
          authority: "${sessionScope.authority}",
        }

        console.log("권한 레벨 : " + emp.authority);
        //authoritySeparator(authority);
        $('nav li').hover(function () {
          $('ul', this).stop().toggle();
        });

 		if (emp.id === "") {
          $("#accordionSidebar").hide();
        } 

        //ClickEvent();
        findMenuList();
        historyBack();
      });
  function historyBack()
  {
	  $("#sidebarToggle").click(function(){
		  history.back()
	  })
  }
  function findMenuList() {
    $.ajax({
      url: "${pageContext.request.contextPath}/systemmgmt/menulist",
      data: {"method": "findMenuList"},
      dataType: "json",
      success: function (data) {

        if (data.errorCode < 0) {
          let str = "내부 서버 오류가 발생했습니다\n";
          str += "관리자에게 문의하세요\n";
          str += "에러 위치 : " + $(this).attr("id");
          str += "에러 메시지 : " + data.errorMsg;
          alert(str);
          return;
        }

        const menuList = data.menuList;
        console.log(menuList);
        let num = 0;
        $.each(menuList, function (index, menuOption) {
          if (menuOption.is_collapse === "Y") {
            num++;
           let headMenu = '<li class="nav-item active">'
                + '<a class="nav-link dropdown-toggle" href="#" data-toggle="collapse" data-target="#collapseUtilities' 
                + num + '" aria-expanded="true" aria-controls="collapseTwo">'
                + '<i class="fas fa-fw fa-wrench"></i>'
                + '<span> ' + menuOption.menu_name + '</span>'
                + '</a>'
                + '<div id="collapseUtilities' + num
                + '" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">'
                + '<div class="bg-white py-2 collapse-inner rounded" id="subTarget' + num + '">'
                + '<h6 class="collapse-header">Custom Utilities:</h6>'
                + '</div>'
                + '</div>'
                + '</li>';

            $("#target").append(headMenu);
          } else {
            let subMenu = '<a class="collapse-item" href="${pageContext.request.contextPath}'
                + menuOption.menu_url + '">' + menuOption.menu_name + '</a>';
            $("#target .collapse #subTarget" + num + "").append(subMenu);
          }

        });

      }
    });
  }

  function ClickEvent() {
    $(document).on('click', '#target .nav-item .nav-link', function (event) {
      alert("Check");
      $(this).off();
    });
  }
  

</script>

<body>
<section class="wow bounceInLeft">
    <!--  메뉴  Body -->
    <ul class="navbar-nav bg-gradient-jhscription sidebar sidebar-dark accordion" id="accordionSidebar">

        <!--  메뉴 Head -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center"
           href="${pageContext.request.contextPath}/main/view">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-chalkboard-teacher"></i>
            </div>
            <div class="sidebar-brand-text mx-3">HELLO<sup>Inc.</sup></div>
        </a>


        <hr class="sidebar-divider my-0">


        <li class="nav-item">
            <a class="nav-link" href="#"> <!-- index.html -->
                <i class="fas fa-fw fa-tachometer-alt"></i>
                <span>Dashboard</span></a>
        </li>


        <hr class="sidebar-divider">
        <div class="sidebar-heading">
            Interface
        </div>

        <!--  DB 연동하는 데이터 들어가는 Content 부분 -->
        <div id="target"></div>


        <hr class="sidebar-divider">


        <div class="sidebar-heading"></div>


        <li class="nav-item">
            <a class="nav-link"
               href="${pageContext.request.contextPath}/comm/rprtHospService/view">

                <i class="fas fa-fw fa-chart-area"></i>
                <span>신속항원검사의료기관</span></a>
        </li>

        

        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/comm/listBoard/view">
                <i class="fas fa-fw fa-chart-area"></i>
                <span>게시판(page)</span></a>
        </li>

        <hr class="sidebar-divider d-none d-md-block">


        <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>

    </ul>

</section>
</body>
</html>

