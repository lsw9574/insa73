<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css"/>
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
          type="text/css">
    <link href="${pageContext.request.contextPath}/css/sb-admin-2.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/js/sb-admin-2.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/chart.js/Chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="https://unpkg.com/@ag-grid-enterprise/all-modules@24.1.0/dist/ag-grid-enterprise.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.23.0/moment.min.js"></script>
    <script src="https://unpkg.com/ag-grid/dist/ag-grid.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

    <!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"> -->
    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script> -->


    <jsp:include page="head.jsp"/>
    <title>INSATesting</title>
    <sitemesh:write property='head'/>

    <c:if test="${requestScope.errorMsg != null}">
        <script>
            alert("${requestScope.errorMsg }");
        </script>
    </c:if>
    <style>
        .rgba-gradient {
            background: -webkit-linear-gradient(45deg, rgba(72, 15, 144, 0.2), rgba(0, 0, 0, 0.9) 100%) !important;
        }

        /* footer 하단에 고정하기(Sticky CSS Footer): https://blog.naver.com/eggtory/220744380205*/
        /* To fix footer Start */
        html, body {
            height: 100%;
            margin: 0;
        }

        .content {
            min-height: 100%;
        }

        .content-inside {
            padding: 20px;
            padding-bottom: 50px;
        }

        .footer {
            height: 50px;
            margin-top: -50px;
            color: white;
        }

        /*https://blog.naver.com/eggtory/220744380205*/
        /* To fix footer End */
    </style>
</head>

<body>
<!-- navbar Start -->
<div id="navbar">
    <jsp:include page="navbar.jsp"/>
</div>
<!-- navbar End -->

<!-- Content Start -->
<div
        class="content container-fluid align-items-stretch mask rgba-gradient">
    <div class=" row py-5" style="padding-top: 12vh !important">
        <!-- Sidebar Start -->
        <div class="col-md-4 ">
            <jsp:include page="menu.jsp"/>
        </div>
        <!-- Sidebar End -->

        <!-- Decorator-body Start -->
        <div class="col-md-8">
            <sitemesh:write property='body'/>
        </div>
        <!-- Decorator-body End -->
    </div>
</div>
<!-- Content End -->

<footer class="footer text-center">
    <jsp:include page="footer.jsp"/>
</footer>

</body>
</html>