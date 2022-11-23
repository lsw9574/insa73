<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>

    <!-- Load D3.js -->
    <script src="https://d3js.org/d3.v4.min.js"></script>
    <!-- Load billboard.js with style -->
    <%-- <script src="${pageContext.request.contextPath}/js/billboard.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/billboard.css"> --%>

    <style>
        section .section-title {
            text-align: center;
            color: #007b5e;
            text-transform: uppercase;
        }

        #tabs {
            background: #333333;
            color: #eee;
            background-color: rgba(051, 051, 051, 0.8);
        }

        #tabs h6.section-title {
            color: #eee;
        }

        #container {
            margin: auto 0;
            padding-left: 5px;
            padding-right: 5px;
        }
    </style>
    <script>
        flag = true;
        var annualVacationData = []; //연차데이터
        var annualVacationMgtList = []; //연차리스트
        var empCode = "${sessionScope.code}"; //A490071

        $(document).ready(function () {
            showAnnualVacationGrid(); //일단 뭐안뜸
            $("#searchYear").change(function () {
                document.getElementById("searchButton").disabled = false;
            }); //searchYear 셀렉터에 변화가 감지되면 searchButton의 disable상태를 해제합니다
            $("#searchMonth").change(function () {
                document.getElementById("searchButton").disabled = false;
            }); //searchMonth 셀렉터에 변화가 감지되면 searchButton의 disable상태를 해제합니다

            /* 적용년 셀렉터 */
            nowDate = new Date();

            for (var y = 2020; y <= nowDate.getFullYear(); y++) {
                $("#searchYear").append($("<option />").val(y).text(y + "년 "));
            }

            /* 적용월 셀렉터 */
            //$("#searchMonth").selectmenu();
            for (var i = 1; i <= 12; i++) {
                $("#searchMonth").append($("<option />").val(i).text(i + "월"));
            }

            /* 현황조회, 마감처리, 마감취소 버튼 */
            $("#searchButton").click(findAnnualVacationMgtList);
            $("#finalizeButton").click(finalizeAnnualVacationMgt);
            $("#cancelButton").click(cancelAnnualVacationMgt);

        });

        /* 연차현황 조회버튼 함수 */
        function findAnnualVacationMgtList() {

            if ($("#searchMonth").val() == "") {
                alert("적용연월을 선택해 주세요");
                return;
            }

            document.getElementById("searchButton").disabled = true;

            var year = $("#searchYear").val();
            var month = addZeros($("#searchMonth").val(), 2); // $("#searchMonth").val()은 2이지만 addZeros 펑션을 거치면 02로 표시됨.
            var date = year + month;
            console.log("Request Date : " + date);

            $
                .ajax({
                    url: "${pageContext.request.contextPath}/attdappvl/annual-leaveMgt",
                    data: {
                        "applyYearMonth": date,
                        "workplaceCode":"${sessionScope.workplaceCode}"
                    },
                    dataType: "json",
                    success: function (data) {
                        flag = false;
                        if (data.errorCode < 0) {
                            var str = "내부 서버 오류가 발생했습니다\n";
                            str += "관리자에게 문의하세요\n";
                            str += "에러 위치 : " + $(this).attr("id") + "\n";
                            str += "에러 메시지 : " + data.errorMsg;
                            alert(str);
                            return;
                        }

                        annualVacationMgtList = data.annualVacationMgtList;
                        console.log(annualVacationMgtList);
                        showAnnualVacationGrid();
                    }
                });
        }

        /* 연차현황 조회 그리드 */
        function showAnnualVacationGrid() {
            var columnDefs = [{
                headerName: "사원코드",
                field: "empCode"
            }, {
                headerName: "직원이름",
                field: "empName"
            }, {
                headerName: "적용년월",
                field: "applyYearMonth"
            }, {
                headerName: "반차사용개수",
                field: "afternoonOff"
            }, {
                headerName: "연차사용개수",
                field: "monthlyLeave"
            }, {
                headerName: "남은연차",
                field: "remainingHoliday"
            }, {
                headerName: "마감여부",
                field: "finalizeStatus"
            }];
            gridOptions = {
                columnDefs: columnDefs,
                rowData: annualVacationMgtList,
                defaultColDef: {
                    editable: false,
                    width: 100
                },
                rowSelection: 'single', /* 'single' or 'multiple',*/
                enableColResize: true,
                enableSorting: true,
                enableFilter: true,
                enableRangeSelection: true,
                suppressRowClickSelection: false,
                animateRows: true,
                suppressHorizontalScroll: true,
                localeText: {
                    noRowsToShow: '조회 결과가 없습니다.'
                },
                getRowStyle: function (param) {
                    if (param.node.rowPinned) {
                        return {
                            'font-weight': 'bold',
                            background: '#dddddd'
                        };
                    }
                    return {
                        'text-align': 'center'
                    };
                },
                getRowHeight: function (param) {
                    if (param.node.rowPinned) {
                        return 30;
                    }
                    return 24;
                },
                // GRID READY 이벤트, 사이즈 자동조정
                onGridReady: function (event) {
                    event.api.sizeColumnsToFit();
                },
                // 창 크기 변경 되었을 때 이벤트
                onGridSizeChanged: function (event) {
                    event.api.sizeColumnsToFit();
                },
                onCellEditingStarted: function (event) {
                    console.log('cellEditingStarted');
                },
            };
            $('#annualVacation_grid').children().remove();
            var eGridDiv = document.querySelector('#annualVacation_grid');
            new agGrid.Grid(eGridDiv, gridOptions);
        }

        /* 날짜 자리수 맞춰주는 함수 */
        function addZeros(num, digit) {
            var zero = '';
            num = num.toString();
            if (num.length < digit) {
                for (i = 0; i < digit - num.length; i++) {
                    zero += '0';
                }
            }
            return zero + num;
        }

        /* 마감처리 함수 */
        function finalizeAnnualVacationMgt() {
            for (var index in annualVacationMgtList) {
                annualVacationMgtList[index].finalizeStatus = "Y";
                annualVacationMgtList[index].status = "update";
            }

            var sendData = JSON.stringify(annualVacationMgtList);

            alert(sendData);

            $
                .ajax({
                    type: "PUT",
                    url: "${pageContext.request.contextPath}/attdappvl/annual-leaveMgt",
                    data:  sendData,
                    contentType:"application/json",
                    dataType: "json",
                    success: function (data) {
                        flag = true;
                        if (data.errorCode < 0) {
                            alert("마감을 실패했습니다");
                        } else {
                            alert("마감처리 되었습니다");
                        }
                        location.reload();
                    }
                });
        }

        /* 마감취소 함수 */
        function cancelAnnualVacationMgt() {
            for (var index in annualVacationMgtList) {
                annualVacationMgtList[index].finalizeStatus = "N";
                annualVacationMgtList[index].status = "update";
            }

            var sendData = JSON.stringify(annualVacationMgtList);

            $
                .ajax({
                    type: "PUT",
                    url: "${pageContext.request.contextPath}/attdappvl/annual-leaveMgt-cancel",
                    data: sendData,
                    contentType: "application/json",
                    dataType: "json",
                    success: function (data) {
                        if (data.errorCode < 0) {
                            alert("마감취소를 실패했습니다");
                        } else {
                            alert("마감취소처리 되었습니다");
                        }
                        location.reload();
                    }
                });
        }
    </script>
</head>

<body class="hm-gradient">
<section id="tabs"
         style="width: 950px; height: 530px; text-align: center; padding: 6px;"
         class="wow fadeInDown">
    <h6 class="section-title h3">연차관리</h6>
    <div class="container">
        <hr style="background-color: white; height: 1px;">
    </div>
    조회 년/월
    <div class="col col-md-4" style="display: inline-block; width: 150px;">
        <select class="form-control" id="searchYear"></select>
    </div>
    <div class="col col-md-4" style="display: inline-block; width: 150px;">
        <select class="form-control" id="searchMonth"></select>
    </div>
    <input type="button" value="조회하기" class="btn btn-light btn-sm"
           id="searchButton"> <br/> <br/> <input type="button"
                                                 value="마감처리" class="btn btn-light btn-sm" id="finalizeButton">
    <input type="button" value="마감취소" class="btn btn-light btn-sm"
           id="cancelButton">
    <div id="annualVacation_grid"
         style="height: 300px; width: 900px; margin: auto;"
         class="ag-theme-balham"></div>
</section>
</body>
</html>