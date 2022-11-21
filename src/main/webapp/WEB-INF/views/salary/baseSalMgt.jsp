<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-fresh.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-material.css">

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>급여기준관리</title>
    <style type="text/css">
        section .section-title {
            text-align: center;
            color: #007b5e;
            text-transform: uppercase;
        }

        #tabs {
            background: #333333;
            color: #eee;
            background-color: rgba(051, 051, 051, 0.7);
        }

        #tabs h6.section-title {
            color: #eee;
        }
    </style>
    <script>
        var updatedSalaryBean = []; // 전역변수 선언
        var gridOptions;

        $(document).ready(function () {
            getBaseSalaryListFunc();
            $("#submit_Btn").click(modifyBaseSalaryList);
        });


        function getBaseSalaryListFunc() {
            $.ajax({
                url: "${pageContext.request.contextPath}/salarystdinfomgmt/base-salary",
                data: {},
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

                    updatedSalaryBean = $.extend(true, [], data.baseSalaryList); // 변경된 내용이 들어갈 공간에 딥카피
                    console.log(updatedSalaryBean);

                    showBaseSalaryListGrid();
                }
            });

        }


        /* 급여기준목록 그리드 띄우는 함수 aggrid*/
        function showBaseSalaryListGrid() {
            var columnDefs = [
                {headerName: "직급코드", field: "positionCode", hide: true},
                {headerName: "직급", field: "position", cellClass: 'rag-amber'},
                {headerName: "기본급", field: "baseSalary"},
                {headerName: "호봉인상율", field: "hobongRatio"},
                {headerName: "상태", field: "status"}
            ];

            gridOptions = {
                columnDefs: columnDefs,
                rowData: updatedSalaryBean,
                defaultColDef: {editable: true},
                onCellEditingStopped: function (event) {
                    if (event.data.status == "normal") {
                        event.data.status = "update"
                    }
                    gridOptions.api.updateRowData({update: [event.data]});
                }
            };
            var eGridDiv = document.querySelector('#baseSalaryList_grid');
            new agGrid.Grid(eGridDiv, gridOptions);
            gridOptions.api.sizeColumnsToFit();
        }


        /*수정 버튼 눌렀을때 */
        function modifyBaseSalaryList() {
            var sendData = JSON.stringify(updatedSalaryBean);

            $('#baseSalaryList_grid').children().remove();

            $.ajax({
                type: "PUT",
                url: "${pageContext.request.contextPath}/salarystdinfomgmt/base-salary",
                data: sendData,
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        alert("저장에 실패했습니다");
                    } else {
                        alert("저장되었습니다");
                    }
                    location.reload();
                }
            });
        }


    </script>


</head>
<body>
<section id="tabs" style="width:60%;height:800px;" class="wow fadeInDown">
    <div class="container">
        <h6 class="section-title h3">급여기준관리</h6>
        <hr style="background-color:white; height: 1px;">
        <input type="button" class="btn btn-light" value="변경확정" id="submit_Btn">
        <div class="row" style="display:block">
            <div class="col-md-6" style="max-width:unset">
                <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                        <div id="baseSalaryList_grid" style="height: 600px; width: 100%" class="ag-theme-balham"></div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>
</body>
</html>