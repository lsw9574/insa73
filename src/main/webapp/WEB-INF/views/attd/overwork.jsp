<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <style>
        #tabs {
            background: #333333;
            color: #eee;
            background-color: rgba(051, 051, 051, 0.8);
        }

        #tabs h6.section-title {
            color: #eee;
        }

        #tabs .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
            color: #f3f3f3;
            background-color: transparent;
            border-color: transparent transparent #f3f3f3;
            border-bottom: 4px solid !important;
            font-size: 10px;
            font-weight: bold;
        }

        #tabs .nav-tabs .nav-link {
            border: 1px solid transparent;
            border-top-left-radius: .25rem;
            border-top-right-radius: .25rem;
            color: #eee;
            font-size: 20px;
        }
    </style>
    <script>
        var empCode = "${sessionScope.code}";
        var startTime = 0;
        var endTime = 0;
        var endTimeHour = 0;
        var overworkList = [];
        var requestDate = getDay();
        $(document).ready(function () {
            $("#overwork_tabs").tabs();
            showOverworkListGrid();
            $("#selectOverwork").click(function () {
                getCode("CO-15", "selectOverwork", "selectOverworkCode");
            })

            $("#selectOverworkType").click(function () {
                getCode("CO-15", "selectOverworkType", "selectOverworkTypeCode");
            })

            $("#overwork_startT").timepicker({
                step: 5,
                timeFormat: "H:i",
                minTime: "00:00",
                maxTime: "23:55"
            });

            $("#overwork_endT").timepicker({
                step: 5,
                timeFormat: "H:i",
                minTime: "00:00",
                maxTime: "23:55"
            });


            $("#search_startD").click(getDatePicker($("#search_startD")));
            $("#search_endD").click(getDatePicker($("#search_endD")));

            $("#search_overworkList_Btn").click(findoverworkList); // 조회버튼


            $("#delete_overwork_Btn").click(function () { // 초과근무 삭제버튼
                var flag = confirm("선택한 초과근무신청을 정말 삭제하시겠습니까?");
                if (flag)
                    removeOverworkList();
            });


            $("#overwork_startD").click(getDatePicker($("#overwork_startD")));

            $("#overwork_startD").change(function () { // 근태외신청 시작일
                $("#overwork_endD").datepicker("option", "minDate", $(this).val());
                if ($("#overwork_endD").val() != "")
                    calculateNumberOfDays();
            });


            $("#overwork_endD").click(getDatePicker($("#overwork_endD")));
            $("#overwork_endD").change(function () { // 근태외신청 종료일
                $("#overwork_startD").datepicker("option", "maxDate", $(this).val());
                if ($("#overwork_startD").val() != "")
                    calculateNumberOfDays();
            });

            $("#btn_regist").click(registoverwork);

            /* 사용자 기본 정보 넣기 */
            $("#overwork_emp").val("${sessionScope.id}");
            $("#overwork_dept").val("${sessionScope.dept}");
            $("#overwork_position").val("${sessionScope.position}");
        })

        /* 오늘 날자를 RRRR-MM-DD 형식으로 리턴하는 함수 */
        function getDay() {
            var today = new Date();
            var rrrr = today.getFullYear();
            var mm = today.getMonth() + 1;
            var dd = today.getDate();
            var searchDay = rrrr + "-" + mm + "-" + dd;
            console.log(searchDay);
            return searchDay;
        }


        /* 초과근무목록 조회버튼  */
        function findoverworkList() {
            var startVar = $("#search_startD").val(); // 조회 시작일
            var endVar = $("#search_endD").val(); // 조회 종료일
            var code = $("#selectOverworkTypeCode").val(); // 그 뭐고 근태코드

            $.ajax({
                url: "${pageContext.request.contextPath}/attdmgmt/excused-attnd",
                data: {
                    "empCode": empCode,
                    "startDate": startVar,
                    "endDate": endVar,
                    "code": code
                },
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        var str = "내부 서버 오류가 발생했습니다\n";
                        str += "관리자에게 문의하세요\n";
                        str += "에러 위치 : " + $(this).attr("id");
                        str += "에러 메시지 : " + data.errorMsg;
                        alert(str);
                        return;
                    }

                    overworkList = data.restAttdList;

                    /* 시간형태변경포문부분 */
                    for (var index in overworkList) {
                        console.log(overworkList[index].startTime);
                        console.log(overworkList[index].endTime);
                        overworkList[index].startTime = getRealTime(overworkList[index].startTime);
                        overworkList[index].endTime = getRealTime(overworkList[index].endTime);
                    }

                    showOverworkListGrid();
                }
            });
        }


        /* 초과근무목록 그리드 띄우는 함수 */
        function showOverworkListGrid() {
            var columnDefs = [
                {headerName: "사원코드", field: "empCode", hide: true},
                {headerName: "일련번호", field: "restAttdCode", hide: true},
                {headerName: "근태구분코드", field: "restTypeCode", hide: true},
                {headerName: "근태구분명", field: "restTypeName", checkboxSelection: true},
                {headerName: "신청일자", field: "requestDate"},
                {headerName: "시작일", field: "startDate"},
                {headerName: "종료일", field: "endDate"},
                {headerName: "일수", field: "numberOfDays"},
                {headerName: "시작시간", field: "startTime"},
                {headerName: "종료시간", field: "endTime"},
                {headerName: "사유", field: "cause"},
                {headerName: "승인여부", field: "applovalStatus"},
                {headerName: "반려사유", field: "rejectCause"}
            ];
            gridOptions = {
                columnDefs: columnDefs,
                rowData: overworkList,
                defaultColDef: {editable: false, width: 250},
                rowSelection: 'multiple', /* 'single' or 'multiple',*/
                enableColResize: true,
                enableSorting: true,
                enableFilter: true,
                enableRangeSelection: true,
                suppressRowClickSelection: false,
                animateRows: true,
                suppressHorizontalScroll: true,
                localeText: {noRowsToShow: '조회 결과가 없습니다.'},
                getRowStyle: function (param) {
                    if (param.node.rowPinned) {
                        return {'font-weight': 'bold', background: '#dddddd'};
                    }
                    return {'text-align': 'center'};
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
            $('#overworkList_grid').children().remove();
            var eGridDiv = document.querySelector('#overworkList_grid');
            new agGrid.Grid(eGridDiv, gridOptions);
        }


        /* 숫자로 되있는 시간을 시간형태로  */
        function getRealTime(time) {
            var hour = Math.floor(time / 100);
            if (hour > 24) hour += 24; // 보여지기 위한 부분인데 만약 25시면 새벽 한 시라는 말 인데 왜 시발 24시간을 더 해주냐고 이 미친새끼야
            var min = time - (Math.floor(time / 100) * 100);
            if (min.toString().length == 1) min = "0" + min; //분이 1자리라면 앞에0을 붙임
            if (min == 0) min = "00";
            return hour + ":" + min;
        }

        /* 삭제버튼 눌렀을 때 실행되는 함수 */
        function removeOverworkList() {
            var selectedRowData = gridOptions.api.getSelectedRows();
            var sendData = JSON.stringify(selectedRowData); //삭제할 목록들이 담긴 배열

            $.ajax({
                type: "DELETE",
                url: "${pageContext.request.contextPath}/attdmgmt/excused-attnd",
                data: sendData,
                contentType : "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        alert("정상적으로 삭제되지 않았습니다");
                    } else {
                        alert("삭제되었습니다");
                    }
                    location.reload();
                }
            });
        }


        /* 일수 계산 함수  */
        function calculateNumberOfDays() {
            startStr = $("#overwork_startD").val();
            endStr = $("#overwork_endD").val();
            if ($("#selectOverworkCode").val().trim() == "ASC006" || $("#selectOverworkCode").val().trim() == "ASC007") {
                $("#overwork_day").val(0.5); //반차라면 무조건 0.5일
            } else if ($("#selectOverworkCode").val().trim() == "ASC001" || $("#selectOverworkCode").val().trim() == "ASC004" || $("#selectOverworkCode").val().trim() == "ASC005") {

                $.ajax({ //경조사 및 연차라면 주말, 공휴일을 제외한 계산일수를 반환하는 함수 사용
                    url: "${pageContext.request.contextPath}/foudinfomgmt/holidayweek",
                    data: {
                        "startDate": startStr,
                        "endDate": endStr
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.errorCode < 0) {
                            var str = "내부 서버 오류가 발생했습니다\n";
                            str += "관리자에게 문의하세요\n";
                            str += "에러 위치 : " + $(this).attr("id");
                            str += "에러 메시지 : " + data.errorMsg;
                            alert(str);
                            return;
                        }
                        $("#overwork_day").val(data.weekdayCount);
                    }
                });

            } else { // 그 외에는 주말 및 공휴일을 포함한 일자를 가져온다
                var startMs = (new Date(startStr)).getTime();
                var endMs = (new Date(endStr)).getTime();
                var numberOfDays = (endMs - startMs) / (1000 * 60 * 60 * 24) + 1;
                $("#overwork_day").val(numberOfDays);
            }
        }


        /* 코드선택 창 띄우기 */
        function getCode(code, inputText, inputCode) {
            option = "width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
            window.open(
                "${pageContext.request.contextPath}/comm/codeWindow/view?code="
                + code + "&inputText=" + inputText + "&inputCode="
                + inputCode, "newwins", option);
        }

        /* 달력띄우기 */
        function getDatePicker($Obj) {
            $Obj.datepicker({
                defaultDate: "d",
                changeMonth: true,
                changeYear: true,
                dateFormat: "yy/mm/dd",
                dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
                monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9",
                    "10", "11", "12"],
                yearRange: "2000:2050"
            });
        }


        /* timePicker시간을 변경하는 함수 */
        function convertTimePicker() {
            startTime = $("#overwork_startT").val().replace(":", "");
            endTime = $("#overwork_endT").val().replace(":", "");
            endTimeHour = $("#overwork_endT").val().substring(0, 2);

            if (Number($("#overwork_endT").val().substring(0, 2)) < 9) {
                endTime = Number(endTime) + 2400;
            }

            console.log(endTime);

        }

        /* 신청 버튼  */
        function registoverwork() {
            convertTimePicker();
            var overworkList = {
                "empCode": empCode,
                "restTypeCode": $("#selectOverworkCode").val(),
                "restTypeName": $("#selectOverwork").val(),
                "requestDate": requestDate,
                "startDate": $("#overwork_startD").val(),
                "endDate": $("#overwork_endD").val(),
                "numberOfDays": $("#overwork_day").val(),
                "cause": $("#overwork_cause").val(),
                "applovalStatus": '승인대기',
                "startTime": startTime,
                "endTime": endTime
            };


            var sendData = JSON.stringify(overworkList);

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/attdmgmt/excused-attnd",
                data: sendData,
                contentType : "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        alert("신청을 실패했습니다");
                    } else {
                        alert("신청되었습니다");
                    }
                    location.reload();
                }
            });
        }

    </script>
</head>
<body>
<section id="tabs" class="wow fadeInDown" style="width:90%; text-align: center;">
    <div class="container">
        <nav>
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <a class="nav-item nav-link active" data-toggle="tab" href="#overworkAttd_tab" role="tab"
                   aria-controls="nav-home" aria-selected="true">초과근무 신청</a>
                <a class="nav-item nav-link" data-toggle="tab" href="#overworkSerach_tab" role="tab"
                   aria-controls="nav-profile" aria-selected="false">초과근무 조회</a>
            </div>
        </nav>
    </div>

    <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
        <div class="tab-pane fade show active" id="overworkAttd_tab" role="tabpanel" aria-labelledby="nav-home-tab">
            <font>초과근무 구분 </font><input id="selectOverwork" class="ui-button ui-widget ui-corner-all" value="초과근무"
                                        readonly>
            <input type="hidden" id="selectOverworkCode" name="overworkCode" value="ASC008">
            <hr>
            <table style="margin : auto;">
                <tr>
                    <td><font>신청자 </font></td>
                    <td><input id="overwork_emp" class="ui-button ui-widget ui-corner-all" readonly></td>
                </tr>
                <tr>
                    <td><h3></h3></td>
                </tr>
                <tr>
                    <td><font>부서 </font></td>
                    <td><input id="overwork_dept" class="ui-button ui-widget ui-corner-all" readonly></td>

                    <td><font>직급</font></td>
                    <td><input id="overwork_position" class="ui-button ui-widget ui-corner-all" readonly></td>
                </tr>
                <tr>
                    <td><h3></h3></td>
                </tr>
                <form>
                    <tr>
                        <td><font>시작일</font></td>
                        <td><input id="overwork_startD" class="ui-button ui-widget ui-corner-all" readonly></td>

                        <td><font>종료일</font></td>
                        <td><input id="overwork_endD" class="ui-button ui-widget ui-corner-all" readonly></td>
                    </tr>
                    <tr>
                        <td><h3></h3></td>
                    </tr>
                    <tr>
                        <td><font>시작시간</font></td>
                        <td><input id="overwork_startT" class="ui-button ui-widget ui-corner-all" name="timePicker1"
                                   value="19:00" readonly></td>

                        <td><font>종료시간</font></td>
                        <td><input id="overwork_endT" class="ui-button ui-widget ui-corner-all" name="timePicker2"
                                   placeholder="시간선택"></td>
                    </tr>
                    <tr>
                        <td><h3></h3></td>
                    </tr>
                    <tr>
                        <td><font>일수</font></td>
                        <td><input id="overwork_day" class="ui-button ui-widget ui-corner-all" readonly></td>
                        <td><font>증명서</font></td>
                        <td><input id="overwork_certi" class="ui-button ui-widget ui-corner-all" readonly></td>
                    </tr>
                    <tr>
                        <td><h3></h3></td>
                    </tr>
                    <tr>
                        <td><font>사유</font></td>
                        <td colspan="3"><input id="overwork_cause" style="width:490px"
                                               class="ui-button ui-widget ui-corner-all"></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <hr>
                            <input type="button" class="ui-button ui-widget ui-corner-all" id="btn_regist" value="신청">
                            <input type="reset" class="ui-button ui-widget ui-corner-all" value="취소"></td>
                    </tr>

                </form>
            </table>


        </div>

        <div class="tab-pane fade" id="overworkSerach_tab" role="tabpanel" aria-labelledby="nav-profile-tab"
             style="width:1050px;">
            <table style="margin : auto;">
                <tr>
                    <td colspan="2">
                        <center><h3>조회범위 선택</h3></center>
                    </td>
                </tr>
                <tr>
                    <td><h3>구분</h3></td>
                    <td><input id="selectOverworkType" class="ui-button ui-widget ui-corner-all" readonly>
                        <input type="hidden" id="selectOverworkTypeCode">
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type=text class="ui-button ui-widget ui-corner-all" id="search_startD" readonly>~
                    </td>
                    <td>
                        <input type=text class="ui-button ui-widget ui-corner-all" id="search_endD" readonly>
                    </td>
                </tr>
                <tr>
                    <td><h3></h3></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <center>
                            <button class="ui-button ui-widget ui-corner-all" id="search_overworkList_Btn">조회하기</button>
                            <button class="ui-button ui-widget ui-corner-all" id="delete_overwork_Btn">삭제하기</button>
                        </center>
                    </td>
                </tr>
            </table>
            <hr>
            <div id="overworkList_grid" style="height: 230px; width:100%; margin : auto;" class="ag-theme-balham"></div>
            <div id="overworkList_pager"></div>

        </div>
    </div>
</section>
</body>
</html>