<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>증빙 승인 관리</title>
    <style>
        /* Tabs*/
        section {
            padding: 30px 0;
            color: #007b5e;
            text-transform: uppercase;
            color: #eee;
        }
    </style>
    <script>
        $(document)
            .ready(
                function () {
                    let empList = [];
                    $("#tabs1").tabs();
                    $("#tabs2").tabs();
                    $("#sel_dept").selectmenu();
                    $("#btn_name_search").click(clickFunction);

                    function clickFunction(name) {
                        makeEmpList("name", $("#txt_name").val()); //이름
                    }

                    $("#btn_name_search").click(function () {
                        makeEmpList("name", $("#txt_name").val()); //이름
                    });
                    $("#btn_dept_search").click(function () {
                        makeEmpList("dept", $("#sel_dept").val()); //부서명
                    });

                    function makeEmpList(grid, value) {

                        console.log(grid + "    " + value);

                        $
                            .ajax({
                                url: "${pageContext.request.contextPath}/empinfomgmt/emplist",
                                data: {
                                    "value": value
                                    //전체부서/회계팀/인사팀/전산팀
                                },
                                dataType: "json",
                                success: function (data) {//data = {"list":[{empName:"이희애","empCode":"12345"},{empName:"a",empCode:"23456"}]}
                                    if (data.errorCode < 0) { //erroe code는 컨트롤러에서 날려보냄
                                        var str = "내부 서버 오류가 발생했습니다\n";
                                        str += "관리자에게 문의하세요\n";
                                        str += "에러 위치 : "
                                            + $(this).attr("id");
                                        str += "에러 메시지 : "
                                            + data.errorMsg;
                                        alert(str);
                                        return; //function 빠져나감
                                    }

                                    empList = data.list; //만들어놓은 빈 배열에 list담음

                                    showEmpListGrid(grid);
                                },
                                error: function (a, b, c) {
                                    alert(b);
                                }
                            });
                    }

                    /* 부서별 사원 정보 그리드에 뿌리는 함수 */
                    function showEmpListGrid(grid) {
                        var columnDefs = [{
                            headerName: "사원코드",
                            field: "empCode"
                        }, {
                            headerName: "사원명",
                            field: "empName"
                        }, {
                            headerName: "부서",
                            field: "deptName"
                        }, {
                            headerName: "직급",
                            field: "position"
                        }];
                        gridOptions = {
                            columnDefs: columnDefs,
                            rowData: empList
                            ,
                            onRowClicked: function (node) {
                                // console.log("노드입니다");
                                // console.log(node);
                                var empCode = node.data.empCode;
                                $.ajax({
                                    url: "${pageContext.request.contextPath}/retirementmgmt/retirementpay",
                                    data: {
                                        "empCode": empCode
                                    },
                                    dataType: "json",
                                    success: function (data) {
                                        console.log(data);
                                        if (data.errorCode == 0) {
                                            let retirementPay = data.retirementPay[0];
                                            $("#retirement_emp").val(retirementPay.empName);
                                            $("#retirement_pay").val(retirementPay.retirementPay);
                                            $("#retirement_range").val(retirementPay.retirementRange);
                                            $("#retirement_startD").val(retirementPay.hiredate);
                                            $("#retirement_endD").val(retirementPay.retiredate);
                                            $("#retirement_bonus").val(retirementPay.retirementBonus);
                                            $("#retirement_awards").val(retirementPay.retirementAwards);

                                        } else {
                                            alert(data.errorMsg);
                                        }
                                    }
                                });
                            },
                            onGridReady: function (event) {     //event에 gridOption이 들어온다
                                event.api.sizeColumnsToFit();   //가로 넓이 자동조절
                            },
                            localeText: {noRowsToShow: '조회 결과가 없습니다.'}
                        }
                        $('#' + grid + 'findgrid').children().remove();
                        var eGridDiv = document
                            .querySelector('#' + grid + 'findgrid');
                        new agGrid.Grid(eGridDiv, gridOptions);
                        gridOptions.api.sizeColumnsToFit();
                    }

                    showEmpListGrid("dept");
                    showEmpListGrid("name");
                });
    </script>
</head>
<body>
<section id="tabs1" style="  text-align: center; margin-left:0px;" class="wow fadeInDown"> <!--위쪽 태그-->

    <ul>
        <li><a href="#tabs1-1">부서명 검색</a></li> <!--section태그의 id를 제이쿼리객체로 들고와서 .tabs()함수를 실행하면 탭으로 바뀜-->
        <li><a href="#tabs1-2">사원명 검색</a></li> <!--a태그의 href에 있는 id값을 찾아가서 아래쪽에 띄운다-->
    </ul>
    <!-- 부서명검색 탭 -->
    <div id="tabs1-1">
        <select id="sel_dept"> <!--$("#sel_dept").selectmenu(); 함수를 사용해 모양을 바꾼다-->
            <option value="전체부서">전체부서</option>
            <option value="회계팀">회계팀</option>
            <option value="인사팀">인사팀</option>
            <option value="전산팀">전산팀</option>
            <option value="보안팀">보안팀</option>
        </select>
        <button id="btn_dept_search"
                class="ui-button ui-widget ui-corner-all">검색 <!--검색버튼-->
        </button>
        <button id="btn_dept_del" class="ui-button ui-widget ui-corner-all">삭제</button> <!--삭제버튼-->
        <br/> <br/>
        <div id="deptfindgrid" style="height: 250px;" class="ag-theme-balham"></div> <!--부서검색에서 그리드가 들어가는곳-->
    </div>
    <!-- 사원명 검색탭 -->
    <div id="tabs1-2">
        <input type="text" id="txt_name"
               class="ui-button ui-widget ui-corner-all">
        <button id="btn_name_search"
                class="ui-button ui-widget ui-corner-all">검색
        </button>
        <button id="btn_name_del" class="ui-button ui-widget ui-corner-all">삭제</button>
        <br/> <br/>
        <div id="namefindgrid" style="height: 250px;" class="ag-theme-balham"></div> <!--사원명검색에서 그리드가 들어가는곳-->
    </div>

</section>
<br>
<section id="tabs2" style=" width: 80%; margin-left :0px; text-align: center" class="wow fadeInDown"> <!--아래쪽 태그-->
    <ul>
        <li><a href="#tabs2-1">퇴직금산정현황</a></li> <!--section태그의 id를 제이쿼리객체로 들고와서 .tabs()함수를 실행하면 탭으로 바뀜-->
    </ul>
    <div id="tabs2-1">
        <table style="margin : auto;"> <!--테이블-->
            <tr>
                <td><font>사원명</font></td>
                <td><input id="retirement_emp" class="ui-button ui-widget ui-corner-all" readonly></td>
            </tr>
            <tr>
                <td><h3></h3></td>
            </tr>
            <tr>
                <td><font>퇴직금</font></td>
                <td><input id="retirement_pay" class="ui-button ui-widget ui-corner-all" readonly></td>

                <td><font>산정기간</font></td>
                <td><input id="retirement_range" class="ui-button ui-widget ui-corner-all" readonly></td>
            </tr>
            <tr>
                <td><h3></h3></td>
            </tr>
            <tr>
                <td><font>입사일</font></td>
                <td><input id="retirement_startD" class="ui-button ui-widget ui-corner-all" readonly></td>

                <td><font>퇴사일</font></td>
                <td><input id="retirement_endD" class="ui-button ui-widget ui-corner-all" readonly></td>
            </tr>
            <tr>
                <td><h3></h3></td>
            </tr>
            <tr>
                <td><font>상여금</font></td>
                <td><input id="retirement_bonus" class="ui-button ui-widget ui-corner-all" readonly></td>

                <td><font>성과금</font></td>
                <td><input id="retirement_awards" class="ui-button ui-widget ui-corner-all" readonly></td>
            </tr>
        </table>
    </div>
</section>
</body>
</html>