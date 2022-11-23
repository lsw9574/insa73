<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>인사고과 승인관리</title>
    <style type="text/css">

        section .section-title {
            text-align: center;
            color: #007b5e;
            text-transform: uppercase;
            padding-top: 20px
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

        select {
            font-size: small;
        }
    </style>

    <script>
        var empEvalAppoRequestList = [];
        //var lastId = 0;

        $(document).ready(function () {

            $("input:text").button();
            $(".small_Btn").button();

            $(".comment_div").css({fontSize: "0.7em"});

            $("#certificateApproval_tabs").tabs().css({margin: "10px"});

            showEmpEvalListGrid();

            findEmpEvalRequestList('모든부서');

            $("#search_empeval_deptName").click(
                function () {
                    getCode("CO-07", "search_empeval_deptName", "search_empeval_deptCode");
                }); // 부서선택

            $("#search_EmpEvalList_Btn").click(findEmpEvalRequestList); // 조회버튼
            $("#apploval_EmpEvalAppo_Btn").click(applovalEmpEvalRequest); // 승인버튼
            $("#cancel_EmpEvalAppo_Btn").click(cancelEmpEvalReqeust); // 승인취소버튼
            $("#reject_EmpEvalAppo_Btn").click(rejectEmpEvalRequest); // 반려버튼
            $("#update_EmpEvalAppo_Btn").click(modifyEmpEvalRequest); // 확정버튼
            $("#excelPrint_EmpEvalList_Btn").click(excelEmpEvalList); // 엑셀출력 버튼
        });

        function excelEmpEvalList() {
            var excelObject = [];
            gridOptions.api.forEachNode(function (rowNode, index) {
                excelObject.push(rowNode.data);

            });

            var sendData = JSON.stringify(excelObject);
            console.log(sendData);
            $.ajax({
                url: "${pageContext.request.contextPath}/empinfomgmt/excel",
                data: {"sendData": sendData},
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: '엑셀 출력을 실패하였습니다',
                            confirmButtonText: '확인'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                location.reload();
                            }
                        })

                    } else {
                        Swal.fire({
                            icon: 'success',
                            title: 'Complete !',
                            text: '엑셀출력에 성공하셨습니다.',
                            confirmButtonText: '확인'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                location.reload();
                            }
                        }) //
                    }
                }
            });


        }


        /* 인사고과 조회버튼 함수 */
        function findEmpEvalRequestList(allDept) {

            var deptName = $("#search_empeval_deptName").val();
            var year = $("#year").val();

            if (allDept == "모든부서") { //넘어온값이 '모든부서'와 같다면
                deptName = allDept; //deptName를 모든부서로 바꾸고
            }

            $.ajax({
                url: "${pageContext.request.contextPath}/empinfomgmt/evaluation-approval",
                data: {
                    "deptName": deptName,
                    "year": year,
                    "workplaceCode":"${sessionScope.workplaceCode}"
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

                    empEvalAppoRequestList = data.empEvalList;
                    showEmpEvalListGrid();
                }
            });
        }


        /*그리드 띄우는 함수 */
        function showEmpEvalListGrid() {
            var columnDefs = [
                {headerName: "부서", field: "deptName", checkboxSelection: true},
                {headerName: "사원번호", field: "empCode"},
                {headerName: "사원이름", field: "empName"},
                {headerName: "등록일", field: "apply_day"},
                {headerName: "직급", field: "position"},
                {headerName: "업적점수", field: "achievement"},
                {headerName: "능력점수", field: "ability"},
                {headerName: "태도점수", field: "attitude"},
                {headerName: "승인여부", field: "approval_Status"},
                {headerName: "평가등급", field: "grade"}];

            gridOptions = {
                columnDefs: columnDefs,
                rowData: empEvalAppoRequestList,
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

            $('#empEvalList_grid').children().remove();
            var eGridDiv = document.querySelector('#empEvalList_grid');
            new agGrid.Grid(eGridDiv, gridOptions);
        }


        /*  확정버튼 눌렀을 때 실행되는 함수 */
        function modifyEmpEvalRequest() {
            var sendData = JSON.stringify(empEvalAppoRequestList);
            console.log(empEvalAppoRequestList);
            $.ajax({
                type: "PUT",
                url: "${pageContext.request.contextPath}/empinfomgmt/evaluation-approval",
                data : sendData,
                contentType:"application/json",
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        var str = "내부 서버 오류가 발생했습니다\n";
                        str += "관리자에게 문의하세요\n";
                        str += "에러 위치 : " + $(this).attr("id");
                        str += "에러 메시지 : " + data.errorMsg;
                        alert(str);
                    } else {
                        alert("확정되었습니다");
                    }

                    findEmpEvalRequestList('모든부서');
                }
            });
        }


        /* 승인버튼 함수 */
        function applovalEmpEvalRequest() {
            var rowNode = gridOptions.api.getSelectedNodes();
            console.log(rowNode[0].data);
            if (rowNode == null) {
                alert("승인할 재직증명서 항목을 선택해 주세요");
                return;
            }
            rowNode[0].setDataValue('approval_Status', "승인");
            console.log(rowNode[0].data);
        }


        /* 승인취소버튼 함수 */
        function cancelEmpEvalReqeust() {
            var rowNode = gridOptions.api.getSelectedNodes();
            if (rowNode == null) {
                alert("취소할 재직증명서 항목을 선택해 주세요");
                return;
            }
            rowNode[0].setDataValue('approval_Status', "승인취소");
        }


        /* 근태외 반려버튼 함수 */
        function rejectEmpEvalRequest() {
            var rowNode = gridOptions.api.getSelectedNodes();
            if (rowNode == null) {
                alert("반려할 재직증명서 항목을 선택해 주세요");
                return;
            }
            rowNode[0].setDataValue('approval_Status', "반려");
        }

        /* 코드 선택창 띄우는 함수 */
        function getCode(code, inputText, inputCode) {
            option = "width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
            window.open(
                "${pageContext.request.contextPath}/comm/codeWindow/view?code="
                + code + "&inputText=" + inputText + "&inputCode="
                + inputCode, "newwins", option);
        }
    </script>
</head>
<body>
<section id="tabs" style=" height:530px; text-align: center;" class="wow fadeInDown">
    <h6 class="section-title h3">인사고과 승인관리</h6>
    <div class="container">
        <hr style="background-color:white; height: 1px;">
    </div>
    <h6 style="display:inline-block;">조회부서</h6>
    <input type=text id="search_empeval_deptName" style="width:100px;" readonly>
    <input type=hidden id="search_empeval_deptCode">

    <h6 style="display:inline-block;"> 조회일자</h6>
    <select style="width:80px; height:33px; text-align:center;" id="year">
        <script>
            for (var i = 2020; i <= 2023; i++) document.write("<option>" + i + "</option>");
        </script>
    </select>

    <input type="button" value="조회하기" class="btn btn-light btn-sm" id="search_EmpEvalList_Btn">
    <input type="button" value="엑셀 출력하기" class="btn btn-light btn-sm" id="excelPrint_EmpEvalList_Btn">
    <br/>
    <br/>
    <input type="button" value="승인" class="btn btn-light btn-sm" id="apploval_EmpEvalAppo_Btn">
    <input type="button" value="승인취소" class="btn btn-light btn-sm" id="cancel_EmpEvalAppo_Btn">
    <input type="button" value="반려" class="btn btn-light btn-sm" id="reject_EmpEvalAppo_Btn">
    <input type="button" value="확정" class="btn btn-light btn-sm" id="update_EmpEvalAppo_Btn">
    <div id="empEvalList_grid" style="height: 305px; text-align: center;" class="ag-theme-balham"></div>
</section>
</body>
</html>