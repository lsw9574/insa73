<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        .fas {
            background-color: rgba(255, 255, 255, 0.0);
            border: 0px;
            float: right;
            color: white;
            cursor: pointer;
        }
    </style>
    <%
        session.invalidate();
        Cookie[] array = request.getCookies();
        String name = "";
        if (array != null) {
            for (Cookie coo : array) {
                if (coo.getName().equals("name")) {
                    name = coo.getValue();
                }
            }
        }

    %>
    <script>
        $(document).ready(function () {
            $("#loginB").click(login);

            /* 사업장코드 클릭,불러오기 */
            $("#workplaceList").click(function () {
                getCode('CO-26', "workplaceCode");
            });
            $(document).keydown(
                function (event) {
                    if (event.keyCode == 13) {
                        login()
                    }
                });

            $("#application").click(NewempApplication);
        });


        function getCode(code, inputCode) {
            option = "width=220; height=200px; left=650px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
            window.open("${pageContext.request.contextPath}/comm/codeWindow/view?code="
                + code +"&inputText=" + null + "&inputCode=" + inputCode, "newwins", option);
        }

        function login() {
            $.ajax({
                url: "${pageContext.request.contextPath}/systemmgmt/login",
                data: {
                    "workplaceCode":$("#workplaceCode").val(), //사업장코드를 보냄!!
                    "empName": $("#empName").val(),   // 이름을 보냄
                    "empCode": $("#empCode").val(), // 코드를 보냄
                    "box": $("#customCheck").val() // 쿠키를 서버에 남길건지 안 남길건지 체크
                },
                dataType: "json",
                success: function (data) {
                    if (data.me == "enter") {
                        location.href = "/main/view"
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: data.errorMsg,
                            confirmButtonText: '확인'
                        })
                    }
                    console.log("===x====" + data + "====x==="); //로그인실패 시 [object object]가 뜬다
                    console.log("===x====" + data.id + "====x==="); //로그인실패 시 undefined가 뜬다
                }
            });
        }

        function NewempApplication() {
            const option = "width=600px; height=1000px; left=100px; top=50px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";

            window.open
            (
                "${pageContext.request.contextPath}/comm/insertIntoNewApplication/view"
                , "newwins", option
            );
        }

        new WOW().init();
    </script>


</head>

<body>
<div class="container">
    <!--Grid row-->
    <div class="row mt-5">
        <!--Grid column-->
        <div class="col-md-6 mb-5 mt-md-0 mt-5 white-text text-center text-md-left">
            <h1 class="h1-responsive font-weight-bold wow fadeInLeft" data-wow-delay="0.3s">Human Resource Project </h1>
            <hr class="hr-light wow fadeInLeft" data-wow-delay="0.3s">
            <h6 class="mb-3 wow fadeInLeft" data-wow-delay="0.3s">
                Let's get started now!
            </h6>
            <button class="btn btn-outline-white wow fadeInLeft" data-wow-delay="0.3s" id="application">New
                application
            </button>
        </div>
        <div class="col-md-6 col-xl-5 mb-4">
            <div class="card wow fadeInRight" data-wow-delay="0.3s">
                <div class="card-body">
                    <div class="text-center">
                        <h3 class="white-text">
                            <i class="fas fa-user white-text"></i>&nbsp Login</h3> <%--상단 아이콘+Login--%>
                        <hr class="hr-light">
                    </div>

                    <%--사업장코드--%>
                    <div class="md-form">
                        <input type="text" id="workplaceCode" class="white-text form-control" name="workplaceCode" autocomplete="off" value="COM000">
                        <label for="workplaceCode" class="active" style="width : 400px;">select Workplace Code
                            <i class="fas fa-search" id="workplaceList" ></i>
                        </label>
                    </div>

                    <%--로그인텍스트박스--%>
                    <div class="md-form">
                        <input type="text" id="empName" class="white-text form-control" value="이송욱">
                        <label for="empName" class="active">enter Your name...</label>
                    </div>

                    <%--패스워드텍스트박스--%>
                    <div class="md-form">
                        <input type="password" id="empCode" class="white-text form-control" value="A490091">
                        <label for="empCode">enter Your password...</label>
                    </div>

                    <div class="custom-control custom-checkbox white-text text-center text-md-left">
                        <input type="checkbox" class="white-text custom-control-input " id="customCheck" name="box">
                        <label class="custom-control-label" for="customCheck">Remember Me</label>
                    </div>
                    <div class="text-center mt-4">
                        <button class="btn btn-outline-white wow fadeInLeft" id="loginB">Login</button>
                        <hr class="hr-light mb-3 mt-4">
                        <div class="inline-ul text-center">
                            <a class="p-2 m-3 tw-ic">
                                <i class="fab fa-twitter white-text"></i>
                            </a>
                            <a class="p-2 m-3 li-ic">
                                <i class="fab fa-google white-text"> </i>
                            </a>
                            <a class="p-2 m-3 ins-ic">
                                <i class="fab fa-instagram white-text"> </i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>