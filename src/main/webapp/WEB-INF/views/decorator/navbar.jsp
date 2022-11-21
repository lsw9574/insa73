<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

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

<script
        src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
<link rel="stylesheet"
      href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
<link rel="stylesheet"
      href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
<link rel="stylesheet"
      href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-fresh.css">
<link rel="stylesheet"
      href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-material.css">
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">

<!-- Material Design Bootstrap -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css"
      rel="stylesheet">
<!-- Bootstrap tooltips -->
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/wow.js"></script>


<style>
    #divTag1 {
        margin-left: 50px;
    }

    #divTag3 {
        margin-left: 800px;
    }

    font {
        font-family: '견고딕체'
    }

    html,
    body,
    header,
    .view {
        height: 100% !important;
    }

    @media (max-width: 740px) {
        html,
        body,
        header,
        .view {
            height: 1000px !important;
        }
    }

    @media (min-width: 800px) and (max-width: 850px) {
        html,
        body,
        header,
        .view {
            height: 650px !important;
        }
    }

    .top-nav-collapse {
        background-color: #000000 !important;
    }

    .navbar:not(.top-nav-collapse) {
        background: transparent !important;
    }

    @media (max-width: 991px) {
        .navbar:not(.top-nav-collapse) {
            background: #3f51b5 !important;
        }
    }

    .card {
        background-color: rgba(126, 123, 215, 0.1) !important;
    }

    .md-form label {
        color: #ffffff !important;
    }

    h6 {
        line-height: 1.7;
    }
</style>

<script>
    new WOW().init();
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
                $("#navbar").hide();
            }

            findNavbarList();
        });

    function findNavbarList() {
        $.ajax({
            url: "${pageContext.request.contextPath}/systemmgmt/menulist",
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

                const navbarList = data.navbarList;
                console.log(navbarList);

                let navbar = "";
                const navbarAlt = [];
                let num = 0;
                $.each(navbarList, function (index, menuOption) {
                    if (menuOption.navbar_name !== "") {
                        num++;
                        navbar = '<li class="nav-item">' + '<a class="nav-link m" href="${pageContext.request.contextPath}' + menuOption.menu_url
                            + '" id="'
                            + menuOption.menu_code + '">' + menuOption.navbar_name + '</a>' + '<li>'
                        console.log(navbar);
                        $("#target-navbar").append(navbar);
                    }
                });
            }
        });
    }
</script>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top scrolling-navbar" id="navbar">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/main/view">
        <strong>SeoulIt 73</strong>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <!-- navbar Menu Start -->
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ml-auto" id="target-navbar"></ul>
        <div class="dropdown">
            <a class="nav-link dropdown-toggle"
               id="navbarDropdownMenuLink-4"
               data-toggle="dropdown" aria-haspopup="true"
               aria-expanded="false">
                <i class="fas fa-user"></i> Profile </a>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">

                <c:if test="${empty sessionScope.id}">
                    <a class="dropdown-item"
                       href="${pageContext.request.contextPath}/systemmgmt/loginForm/view">
                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                        Log-in
                    </a>
                </c:if>

                <c:if test="${not empty sessionScope.id}">
                    <a class="dropdown-item"
                       href="${pageContext.request.contextPath}/logout">
                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                        Log-out
                    </a>
                </c:if>
                <!-- <div class="dropdown-divider"></div> -->
            </div>
        </div>
    </div>
</nav>

</body>
