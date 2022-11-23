<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style type="text/css">
        #tabs {
            background: #333333;
            background-color: rgba(0, 0, 0, 0.3);
            color: #eee;
            height: auto;
        }

        .center-desc {
            text-align: center;
        }

        .approval {
            position: relative;
            width: 50px;
            height: 50px;
            margin-left: 10px;
        }
    </style>
    <script type="text/javascript">
        let bean = {};
        let Infolist = [];
        $(document).ready(function () {

            $("#btn").click(function () {
                findInfo();
            })
            $("#approval_Btn").click(approvalrecruitment);
            $("#cancel_Btn").click(cancelrecruitment);
            $("#confirm_Btn").click(sendDataF);
        });

        function saveInfo() {
            bean.year = $("#year").val();
            bean.half = $("#half").val();
            bean.workplaceCode = "${sessionScope.workplaceCode}";
            console.log(bean);
        }

        function findInfo() {

            $("#grid").html("");
            saveInfo();
            const sendData = JSON.stringify(bean);
            let gridOptions = {};
            $.ajax({
                type: "GET",
                url: '${pageContext.request.contextPath}/documentmgmt/newemprecruit',
                dataType: "json",
                data:
                    {
                        "sendyear": $("#year").val(),
                        "half": $("#half").val(),
                        "workplaceCode": "${sessionScope.workplaceCode}"
                    },
                success: function (data) {
                    if (data.errorCode < 0) {
                        let str = "내부 서버 오류가 발생했습니다\n";
                        str += "관리자에게 문의하세요\n";
                        str += "에러 위치 : " + $(this).attr("id");
                        str += "에러 메시지 : " + data.errorMsg;
                        alert(str);
                        return;
                    }
                    Infolist = data.Infolist;
                    showListGrid(Infolist);
                }
            });
        }

        function showListGrid(Infolist) {
            const columnDef =
                [
                    {headerName: "", field: "approval", checkboxSelection: true, width: 100},
                    {headerName: "이름", field: "pname"},
                    {headerName: "임시코드", field: "pcode"},
                    {headerName: "면접평균", field: "i_avg"},
                    {headerName: "인성평균", field: "p_avg"},
                    {headerName: "나이", field: "age"},
                    {headerName: "성별", field: "gender"},
                    {headerName: "주소", field: "address"},
                    {headerName: "전화번호", field: "tel"},
                    {headerName: "이메일", field: "email"},
                    {headerName: "부서", field: "dept"},
                    {headerName: "학력", field: "lastschool"},
                    {headerName: "승인여부", field: "approvalStatus"},
                    {headerName: "상태", field: "status", hide: true}
                ];
            console.log(Infolist, "Infolist");
            gridOptions = {
                columnDefs: columnDef, //  정의된 칼럼 정보를 넣어준다.
                rowData: Infolist, // 그리드 데이터, json data를 넣어준다.
                enableColResize: true, // 칼럼 리사이즈 허용 여부
                enableSorting: true, // 정렬 옵션 허용 여부
                enableFilter: true, // 필터 옵션 허용 여부
                enableRangeSelection: true, // 정렬 기능 강제여부, true인 경우 정렬이 고정이 된다.
                localeText: {noRowsToShow: '조회 결과가 없습니다.'}, // 데이터가 없는 경우 보여 주는 사용자 메시지

                getRowStyle: function (param) { // row 스타일 지정 e.g. {"textAlign":"center", "backgroundColor":"#f4f4f4"}
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
                getRowHeight: function (param) { // // 높이 지정
                    if (param.node.rowPinned) {
                        return 30;
                    }
                    return 24;
                },
                onGridReady: function (event) { // GRID READY 이벤트, 사이즈 자동조정
                    event.api.sizeColumnsToFit();
                },

                onGridSizeChanged: function (event) { // 창 크기 변경 되었을 때 이벤트
                    event.api.sizeColumnsToFit();
                }

            };
            let eGridDiv = document.querySelector('#grid');
            console.log(columnDef);
            console.log(Infolist);
            new agGrid.Grid(eGridDiv, gridOptions); // 그리드 생성, 가져온 자료 그리드에 뿌리기
        }

        /* 승인버튼 함수 */
        function approvalrecruitment() {
            var rowNode = gridOptions.api.getSelectedNodes();
            console.log(rowNode[0]);
            if (rowNode[0] == null) {
                alert("승인할 항목을 선택해 주세요");
                return;
            }
            rowNode[0].setDataValue('approvalStatus', "승인");
            rowNode[0].setDataValue('status', "update");
            console.log(rowNode[0].data);
        }

        /* 승인취소버튼 함수 */
        function cancelrecruitment() {
            var rowNode = gridOptions.api.getSelectedNodes();
            if (rowNode[0] == null) {
                alert("대기할 항목을 선택해 주세요");
                return;
            }
            rowNode[0].setDataValue('approvalStatus', "승인취소");
            rowNode[0].setDataValue('status', "update");
            console.log(rowNode[0].data);
        }

        function sendDataF() {
            var sendData = JSON.stringify(Infolist);
            $.ajax({
                type: "PUT",
                url: "${pageContext.request.contextPath}/documentmgmt/newemprecruit",
                data: sendData,
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        alert("변경에 실패했습니다");
                    } else {
                        alert("확정되었습니다");
                    }
                    location.reload();
                }
            });
        }
    </script>
</head>
<body>
<section id="tabs" style="width:100%;height:800px;" class="wow fadeInDown">
    <div class='container'>
        <h6 class="section-title h3">신입채용 승인 관리</h6>
        <hr style="background-color:white; height: 1px;">
        <label for="year"/></label>
        <select id="year">
            <option value="2020">2020</option>
            <option value="2021">2021</option>
            <option value="2022">2022</option>
        </select>년도
        <label for="half"></label>
        <select id="half">
            <option value="상반기">상반기(1~6월)</option>
            <option value="하반기">하반기(7~12월)</option>
        </select>
        <input type="button" id="btn" value="조회" class="jbtn"/>
        <br/><br/><br/>
        <div class='center-desc'>
            <button class='btn btn-light btn-sm' id='approval_Btn'>승인</button>
            <button class='btn btn-light btn-sm' id='cancel_Btn'>승인취소</button>
            <button class='btn btn-light btn-sm' id='confirm_Btn'>확정</button>
        </div>
        <br/><br/>
        <div id="grid" class="ag-theme-balham" style="width:100%; height:400px;"></div>
    </div>
</section>
</body>
</html>