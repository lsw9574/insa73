<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <style>
        #tabs {
            color: #eee;
            background-color: rgba(051, 051, 051, 0.8);
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
        var ReceiptRequestList = [];

        $(document).ready(function () {

            showReceiptListGrid();

            var today = $.datepicker.formatDate($.datepicker.ATOM, new Date());
            $("#retirementDate").val(today);


            /* 신청탭 */

            /* 신청, 사용 날짜 */
            getDatePicker($("#retirementDate"));

            /* 퇴사 신청 버튼  */
            $("#retirement_Btn").click(function () {
                var flag = confirm("퇴사를 신청하시겠습니까?");
                if (flag)
                    // requireReceipt();
                    modifyRetireDate();
            });

            /*퇴직금 영수증 신청 버튼*/
            $("#retirement_Receipt_Btn").click(function () {
                var flag = confirm("퇴직금영수증을 신청하시겠습니까?");
                if (flag)
                    // requireReceipt();
                    registRetirementReceipt();
            });


            /* 조회탭 */
            /* 조회 날짜 */
            getDatePicker($("#search_startDate"));
            $("#search_startDate").change(function () {
                $("#search_endDate").datepicker("option", "minDate", $(this).val());
            });

            getDatePicker($("#search_endDate"));
            $("#search_endDate").change(function () {
                $("#search_startDate").datepicker("option", "maxDate", $(this).val());
            });

            /* 영수증 조회 버튼 */
            $("#search_receiptList_Btn").click(findReceiptList);

            /* 영수증 발급 버튼 */
            $("#print_receipt").click(printReceipt);

        });

        /*퇴직금 영수증 신청 버튼누르면 실행*/
        function registRetirementReceipt() {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/retirementmgmt/registerRetirementReceipt",
                data: { "empCode": empCode },
                dataType: 'json',
                success: function (data) {
                    if (data.errorCode < 0) {
                        alert(data.errorMsg);
                        return;
                    } else {
                        alert("퇴직금영수증을 신청하였습니다.");
                    }
                    location.reload();
                }
            });
        }


        /* 퇴사 신청 */
        function modifyRetireDate() {

            var sendData = {
                "empCode": empCode,
                "retirementDate": $("#retirementDate").val()
            };
            $.ajax({
                type: "PUT",
                url: "${pageContext.request.contextPath}/retirementmgmt/modifyRetirementApply",
                data: JSON.stringify(sendData),
                contentType: "application/json",
                dataType: 'json',
                success: function (data) {
                    if (data.errorCode < 0) {
                        alert(data.errorMsg);
                        return;
                    } else if (data.errorCode < -1) {
                        let str = "내부 서버 오류가 발생했습니다\n";
                        str += "관리자에게 문의하세요\n";
                        str += "에러 위치 : " + $(this).attr("id");
                        str += "에러 메시지 : " + data.errorMsg;
                        alert(str);
                        return;
                    } else {
                        alert("퇴사를 신청하였습니다.");
                    }
                    location.reload();
                }
            });
        }


        function findReceiptList() { // 영수증신청조회버튼
            var startVar = $("#search_startDate").val(); //시작날짜
            var endVar = $("#search_endDate").val(); //종료날짜

            $.ajax({
                url: "${pageContext.request.contextPath}/retirementmgmt/findRetirementReceiptlist",
                data: {
                    "empCode": empCode,
                    "startDate": startVar,
                    "endDate": endVar,
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
                    ReceiptRequestList = data.retirementPersonList;
                    console.log(ReceiptRequestList);
                    showReceiptListGrid();

                }
            });
        }

        /* 영수증 조회 그리드 */

        function showReceiptListGrid() {
            var columnDefs = [
                {headerName: "사원코드", field: "empCode", hide: true}, //hide:true = 숨김
                {headerName: "사원명", field: "empName", checkboxSelection: true}, //체크박스옵션
                {headerName: "신청일", field: "retirementDate"},
                {headerName: "부서", field: "deptName"},
                {headerName: "사업장", field: "workplaceName"}
            ];
            gridOptions = {
                columnDefs: columnDefs,
                rowData: ReceiptRequestList,
                defaultColDef: {editable: false, width: 100}, //수정불가
                rowSelection: 'single', /* 'single' or 'multiple',*/
                enableColResize: true, //칼럼크기
                enableSorting: true, //정렬
                enableFilter: true, //필터
                enableRangeSelection: true, //정렬고정
                suppressRowClickSelection: false, //선택허용
                animateRows: true,
                suppressHorizontalScroll: true, //가로스크롤허용
                localeText: {noRowsToShow: '조회 결과가 없습니다.'}, //데이터가없을경우보여질메세지
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
            $('#receiptList_grid').children().remove();
            var eGridDiv = document.querySelector('#receiptList_grid');
            new agGrid.Grid(eGridDiv, gridOptions);
        }


        /* DatePicker 함수 */
        function getDatePicker($CellId) {
            $CellId.datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "yy-mm-dd",
                showAnim: "slide",
                dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
                monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
                yearRange: "2000:2050",
            });
        }


        /* 승인된 영수증 발급 */
        function printReceipt() {
            var selectedRowData = gridOptions.api.getSelectedRows();
            var data = selectedRowData[0];
            console.log(data.empCode);

            empCode = data.empCode;

            window.open(
                "${pageContext.request.contextPath}/retirementmgmt/report?method=retirementReceiptReport&empCode="
                + empCode, "퇴직금영수증", "width=1280, height=1024");

        }


    </script>
</head>
<body>
<section id="tabs" class="wow fadeInDown"
         style="height:550px; text-align: center;">

    <div class="container">
        <nav>
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <a class="nav-item nav-link active" data-toggle="tab"
                   href="#employmentRequest_tab" role="tab" aria-controls="nav-home"
                   aria-selected="true"> 퇴직금영수증 신청</a> <a class="nav-item nav-link"
                                                          data-toggle="tab" href="#employmentList_tab" role="tab"
                                                          aria-controls="nav-profile" aria-selected="false">퇴직금영수증
                조회</a>
            </div>
        </nav>
    </div>

    <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
        <div class="tab-pane fade show active" id="employmentRequest_tab"
             role="tabpanel" aria-labelledby="nav-home-tab">
            <br> <br> <br>
            <h4>퇴직금영수증 신청</h4>
            <br> <br>
            <table style="margin: auto;">
                <tr>
                    <td>사원명</td>
                    <td><input type="text"
                               class="ui-button ui-widget ui-corner-all"
                               value="${sessionScope.id}" readonly> <input type="hidden"
                                                                           id="employmentEmpCode"
                                                                           value="${sessionScope.code}"></td>
                    <td>부서</td>
                    <td><input type="text" id="deptName"
                               class="ui-button ui-widget ui-corner-all" value="${sessionScope.dept}"
                               readonly></td>
                </tr>

                <tr>
                    <td>신청일</td>
                    <td><input type="text"
                               class="ui-button ui-widget ui-corner-all" id="retirementDate" readonly></td>
                    <td>사업장</td>
                    <td><input class="ui-button ui-widget ui-corner-all"
                               type="text" id="business" value="${sessionScope.workplaceCode}" readonly>
                        <%--<input type="hidden" id="businessCode">--%>
                    </td>

                </tr>

            </table>
            <hr>
            <div>
                <br>
                <input type="button"
                       class="ui-button ui-widget ui-corner-all"
                       id="retirement_Btn" value="퇴사 신청">

                <input type="button"
                       class="ui-button ui-widget ui-corner-all"
                       id="retirement_Receipt_Btn" value="퇴직금영수증 신청">
            </div>
        </div>

        <div class="tab-pane fade" id="employmentList_tab" role="tabpanel"
             aria-labelledby="nav-profile-tab">
            <br/>
            <input type=text class="ui-button ui-widget ui-corner-all"
                   id="search_startDate" readonly> 부터 <input type=text
                                                             class="ui-button ui-widget ui-corner-all"
                                                             id="search_endDate"
                                                             readonly> 까지<br/>
            <br/> <input type="button" class="ui-button ui-widget ui-corner-all"
                         id="search_receiptList_Btn" value="신청 조회"><input type="button"
                                                                          class="ui-button ui-widget ui-corner-all"
                                                                          id="print_receipt"
                                                                          value="퇴직영수증 발급">
            <br/>
            <br/> <br/>
            <div id="receiptList_grid"
                 style="height: 230px; width: 800px; margin: auto;"
                 class="ag-theme-balham"></div>
        </div>
    </div>

</section>
</body>
</html>