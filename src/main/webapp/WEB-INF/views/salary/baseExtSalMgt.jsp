<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.noStyle.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-grid.css">
    <link rel="stylesheet" href="https://unpkg.com/ag-grid-community/dist/styles/ag-theme-balham.css">

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>초과수당관리</title>
    <style type="text/css">
        section .section-title {
            text-align: center;
            color: #007b5e;
            text-transform: uppercase;
        }

        #tabs {
            color: #eee;
            background-color: rgba(051, 051, 051, 0.8);
        }

        #tabs h6.section-title {
            color: #eee;
        }
    </style>
    <script>
        // 전역변수 선언
        var baseExtSalList = [];
        var gridOptions;

        $(document).ready(function () {
            $("#submit_Btn").click(modifyBaseExtSalList); // 확정버튼

            $.ajax({
                url: "${pageContext.request.contextPath}/salarystdinfomgmt/over-sal",
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

                    baseExtSalList = data.baseExtSalList;
                    showBaseExtSalListGrid();
                }
            });
        });


        function showBaseExtSalListGrid() {
            var result = [];
            var columnDefs = [
                {headerName: "초과수당코드", field: "extSalCode"},
                {headerName: "초과수당명", field: "extSalName", cellClass: 'rag-amber'},
                {headerName: "배율", field: "ratio"},
                {headerName: "상태", field: "status"}
            ];

            gridOptions = {
                columnDefs: columnDefs,
                rowData: baseExtSalList,
                defaultColDef: {editable: true},
                rowSelection: 'single', /* 'single' or 'multiple',*/
                onCellEditingStopped: function (event) {
                    console.log(event.data.status);
                    console.log(event.data);
                    if (event.data.status == "normal") {
                        event.data.status = "update"
                    }
                    gridOptions.api.updateRowData({update: [event.data]});
                }

            };

            var eGridDiv = document.querySelector('#baseExtSalList_grid');
            new agGrid.Grid(eGridDiv, gridOptions);
            gridOptions.api.sizeColumnsToFit();
        }


        /* do submit */
        function modifyBaseExtSalList() {
            var sendData = JSON.stringify(baseExtSalList);

            $('#baseSalaryList_grid').children().remove();

            $.ajax({
                type: "PUT",
                url: "${pageContext.request.contextPath}/salarystdinfomgmt/over-sal",
                data : sendData,
                contentType:"application/json",
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
<section id="tabs" style="width:60%;height:450px; " class="wow fadeInDown">
    <div class="container">
        <h6 class="section-title h3">초과수당관리</h6>
        <hr style="background-color:white; height: 1px;">
        <input type="button" class="btn btn-light" value="변경확정" id="submit_Btn">
        <div class="row">
            <div class="col-md-6">
                <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                        <div id="baseExtSalList_grid" style="height: 250px; width: 500px" class="ag-theme-balham"></div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>
</body>
</html>