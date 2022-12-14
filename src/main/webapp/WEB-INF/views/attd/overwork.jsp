<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <style>
        #tabs {
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

            $("#search_overworkList_Btn").click(findoverworkList); // ????????????


            $("#delete_overwork_Btn").click(function () { // ???????????? ????????????
                var flag = confirm("????????? ????????????????????? ?????? ?????????????????????????");
                if (flag)
                    removeOverworkList();
            });


            $("#overwork_startD").click(getDatePicker($("#overwork_startD")));

            $("#overwork_startD").change(function () { // ??????????????? ?????????
                $("#overwork_endD").datepicker("option", "minDate", $(this).val());
                if ($("#overwork_endD").val() != "")
                    calculateNumberOfDays();
            });


            $("#overwork_endD").click(getDatePicker($("#overwork_endD")));
            $("#overwork_endD").change(function () { // ??????????????? ?????????
                $("#overwork_startD").datepicker("option", "maxDate", $(this).val());
                if ($("#overwork_startD").val() != "")
                    calculateNumberOfDays();
            });

            $("#btn_regist").click(registoverwork);

            /* ????????? ?????? ?????? ?????? */
            $("#overwork_emp").val("${sessionScope.id}");
            $("#overwork_dept").val("${sessionScope.dept}");
            $("#overwork_position").val("${sessionScope.position}");
        })

        /* ?????? ????????? RRRR-MM-DD ???????????? ???????????? ?????? */
        function getDay() {
            var today = new Date();
            var rrrr = today.getFullYear();
            var mm = today.getMonth() + 1;
            var dd = today.getDate();
            var searchDay = rrrr + "-" + mm + "-" + dd;
            console.log(searchDay);
            return searchDay;
        }


        /* ?????????????????? ????????????  */
        function findoverworkList() {
            var startVar = $("#search_startD").val(); // ?????? ?????????
            var endVar = $("#search_endD").val(); // ?????? ?????????
            var code = $("#selectOverworkTypeCode").val(); // ??? ?????? ????????????

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
                        var str = "?????? ?????? ????????? ??????????????????\n";
                        str += "??????????????? ???????????????\n";
                        str += "?????? ?????? : " + $(this).attr("id");
                        str += "?????? ????????? : " + data.errorMsg;
                        alert(str);
                        return;
                    }

                    overworkList = data.restAttdList;

                    /* ?????????????????????????????? */
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


        /* ?????????????????? ????????? ????????? ?????? */
        function showOverworkListGrid() {
            var columnDefs = [
                {headerName: "????????????", field: "empCode", hide: true},
                {headerName: "????????????", field: "restAttdCode", hide: true},
                {headerName: "??????????????????", field: "restTypeCode", hide: true},
                {headerName: "???????????????", field: "restTypeName", checkboxSelection: true},
                {headerName: "????????????", field: "requestDate"},
                {headerName: "?????????", field: "startDate"},
                {headerName: "?????????", field: "endDate"},
                {headerName: "??????", field: "numberOfDays"},
                {headerName: "????????????", field: "startTime"},
                {headerName: "????????????", field: "endTime"},
                {headerName: "??????", field: "cause"},
                {headerName: "????????????", field: "applovalStatus"},
                {headerName: "????????????", field: "rejectCause"}
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
                localeText: {noRowsToShow: '?????? ????????? ????????????.'},
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
                // GRID READY ?????????, ????????? ????????????
                onGridReady: function (event) {
                    event.api.sizeColumnsToFit();
                },
                // ??? ?????? ?????? ????????? ??? ?????????
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


        /* ????????? ????????? ????????? ???????????????  */
        function getRealTime(time) {
            var hour = Math.floor(time / 100);
            if (hour > 24) hour += 24; // ???????????? ?????? ???????????? ?????? 25?????? ?????? ??? ????????? ??? ?????? ??? ?????? 24????????? ??? ???????????? ??? ???????????????
            var min = time - (Math.floor(time / 100) * 100);
            if (min.toString().length == 1) min = "0" + min; //?????? 1???????????? ??????0??? ??????
            if (min == 0) min = "00";
            return hour + ":" + min;
        }

        /* ???????????? ????????? ??? ???????????? ?????? */
        function removeOverworkList() {
            var selectedRowData = gridOptions.api.getSelectedRows();
            var sendData = JSON.stringify(selectedRowData); //????????? ???????????? ?????? ??????

            $.ajax({
                type: "DELETE",
                url: "${pageContext.request.contextPath}/attdmgmt/excused-attnd",
                data: sendData,
                contentType : "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        alert("??????????????? ???????????? ???????????????");
                    } else {
                        alert("?????????????????????");
                    }
                    location.reload();
                }
            });
        }


        /* ?????? ?????? ??????  */
        function calculateNumberOfDays() {
            startStr = $("#overwork_startD").val();
            endStr = $("#overwork_endD").val();
            if ($("#selectOverworkCode").val().trim() == "ASC006" || $("#selectOverworkCode").val().trim() == "ASC007") {
                $("#overwork_day").val(0.5); //???????????? ????????? 0.5???
            } else if ($("#selectOverworkCode").val().trim() == "ASC001" || $("#selectOverworkCode").val().trim() == "ASC004" || $("#selectOverworkCode").val().trim() == "ASC005") {

                $.ajax({ //????????? ??? ???????????? ??????, ???????????? ????????? ??????????????? ???????????? ?????? ??????
                    url: "${pageContext.request.contextPath}/foudinfomgmt/holidayweek",
                    data: {
                        "startDate": startStr,
                        "endDate": endStr
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.errorCode < 0) {
                            var str = "?????? ?????? ????????? ??????????????????\n";
                            str += "??????????????? ???????????????\n";
                            str += "?????? ?????? : " + $(this).attr("id");
                            str += "?????? ????????? : " + data.errorMsg;
                            alert(str);
                            return;
                        }
                        $("#overwork_day").val(data.weekdayCount);
                    }
                });

            } else { // ??? ????????? ?????? ??? ???????????? ????????? ????????? ????????????
                var startMs = (new Date(startStr)).getTime();
                var endMs = (new Date(endStr)).getTime();
                var numberOfDays = (endMs - startMs) / (1000 * 60 * 60 * 24) + 1;
                $("#overwork_day").val(numberOfDays);
            }
        }


        /* ???????????? ??? ????????? */
        function getCode(code, inputText, inputCode) {
            option = "width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
            window.open(
                "${pageContext.request.contextPath}/comm/codeWindow/view?code="
                + code + "&inputText=" + inputText + "&inputCode="
                + inputCode, "newwins", option);
        }

        /* ??????????????? */
        function getDatePicker($Obj) {
            $Obj.datepicker({
                defaultDate: "d",
                changeMonth: true,
                changeYear: true,
                dateFormat: "yy/mm/dd",
                dayNamesMin: ["???", "???", "???", "???", "???", "???", "???"],
                monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9",
                    "10", "11", "12"],
                yearRange: "2000:2050"
            });
        }


        /* timePicker????????? ???????????? ?????? */
        function convertTimePicker() {
            startTime = $("#overwork_startT").val().replace(":", "");
            endTime = $("#overwork_endT").val().replace(":", "");
            endTimeHour = $("#overwork_endT").val().substring(0, 2);

            if (Number($("#overwork_endT").val().substring(0, 2)) < 9) {
                endTime = Number(endTime) + 2400;
            }

            console.log(endTime);

        }

        /* ?????? ??????  */
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
                "applovalStatus": '????????????',
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
                        alert("????????? ??????????????????");
                    } else {
                        alert("?????????????????????");
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
                   aria-controls="nav-home" aria-selected="true">???????????? ??????</a>
                <a class="nav-item nav-link" data-toggle="tab" href="#overworkSerach_tab" role="tab"
                   aria-controls="nav-profile" aria-selected="false">???????????? ??????</a>
            </div>
        </nav>
    </div>

    <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
        <div class="tab-pane fade show active" id="overworkAttd_tab" role="tabpanel" aria-labelledby="nav-home-tab">
            <font>???????????? ?????? </font><input id="selectOverwork" class="ui-button ui-widget ui-corner-all" value="????????????"
                                        readonly>
            <input type="hidden" id="selectOverworkCode" name="overworkCode" value="ASC008">
            <hr>
            <table style="margin : auto;">
                <tr>
                    <td><font>????????? </font></td>
                    <td><input id="overwork_emp" class="ui-button ui-widget ui-corner-all" readonly></td>
                </tr>
                <tr>
                    <td><h3></h3></td>
                </tr>
                <tr>
                    <td><font>?????? </font></td>
                    <td><input id="overwork_dept" class="ui-button ui-widget ui-corner-all" readonly></td>

                    <td><font>??????</font></td>
                    <td><input id="overwork_position" class="ui-button ui-widget ui-corner-all" readonly></td>
                </tr>
                <tr>
                    <td><h3></h3></td>
                </tr>
                <form>
                    <tr>
                        <td><font>?????????</font></td>
                        <td><input id="overwork_startD" class="ui-button ui-widget ui-corner-all" readonly></td>

                        <td><font>?????????</font></td>
                        <td><input id="overwork_endD" class="ui-button ui-widget ui-corner-all" readonly></td>
                    </tr>
                    <tr>
                        <td><h3></h3></td>
                    </tr>
                    <tr>
                        <td><font>????????????</font></td>
                        <td><input id="overwork_startT" class="ui-button ui-widget ui-corner-all" name="timePicker1"
                                   value="19:00" readonly></td>

                        <td><font>????????????</font></td>
                        <td><input id="overwork_endT" class="ui-button ui-widget ui-corner-all" name="timePicker2"
                                   placeholder="????????????"></td>
                    </tr>
                    <tr>
                        <td><h3></h3></td>
                    </tr>
                    <tr>
                        <td><font>??????</font></td>
                        <td><input id="overwork_day" class="ui-button ui-widget ui-corner-all" readonly></td>
                        <td><font>?????????</font></td>
                        <td><input id="overwork_certi" class="ui-button ui-widget ui-corner-all" readonly></td>
                    </tr>
                    <tr>
                        <td><h3></h3></td>
                    </tr>
                    <tr>
                        <td><font>??????</font></td>
                        <td colspan="3"><input id="overwork_cause" style="width:490px"
                                               class="ui-button ui-widget ui-corner-all"></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <hr>
                            <input type="button" class="ui-button ui-widget ui-corner-all" id="btn_regist" value="??????">
                            <input type="reset" class="ui-button ui-widget ui-corner-all" value="??????"></td>
                    </tr>

                </form>
            </table>


        </div>

        <div class="tab-pane fade" id="overworkSerach_tab" role="tabpanel" aria-labelledby="nav-profile-tab"
             style="width:1050px;">
            <table style="margin : auto;">
                <tr>
                    <td colspan="2">
                        <center><h3>???????????? ??????</h3></center>
                    </td>
                </tr>
                <tr>
                    <td><h3>??????</h3></td>
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
                            <button class="ui-button ui-widget ui-corner-all" id="search_overworkList_Btn">????????????</button>
                            <button class="ui-button ui-widget ui-corner-all" id="delete_overwork_Btn">????????????</button>
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