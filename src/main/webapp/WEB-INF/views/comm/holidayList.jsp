<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>휴일목록</title>
    <style>

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

        #tabs .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
            color: #f3f3f3;
            background-color: transparent;
            border-color: transparent transparent #f3f3f3;
            border-bottom: 4px solid !important;
            font-size: 20px;
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
        // 휴일목록을 담을 배열
        var holidayList = [];
        var emptyInfo = {};
        var addrowData;

        $(document).ready(function () {
            $("#add_Btn").click(addGridRow); 	   // 추가버튼
            $("#remove_Btn").click(removeGirdRow); // 삭제버튼
            $("#save_Btn").click(saveGridRow); 	   // 저장버튼

            $.ajax({
                url: "${pageContext.request.contextPath}/foudinfomgmt/holiday",
                dataType: "json",
                success: function (data) {
                    holidayList = data.holidayList;
                    console.log(holidayList);

                    var columnDefs = [{headerName: "일자", field: "applyDay"},
                        {headerName: "휴일명", field: "holidayName"},
                        {headerName: "비고", field: "note"},
                        {headerName: "상태", field: "status"}];
                    gridOptions = {
                        columnDefs: columnDefs, // def 속성
                        rowData: holidayList,//데이터
                        defaultColDef: {editable: true, /*width: 100,*/ resizable: true, sortable: true, filter: true}, //편집가능,가로길이,가로길이변경,정렬,필터
                        rowSelection: 'single', // 하나만 선택가능 (반대는 multiple)
                        //enableRangeSelection: true,//유료 ㅠㅠㅠㅠㅠ 마우스 클릭한 상태에서 드래그시 드래그 한 곳을 선택할 수 있다
                        suppressRowClickSelection: false,// 줄 클릭시 선택되는거 기본값이 false, true로 바꾸면 선택안됨
                        animateRows: true,   // 정렬을 바꾸거나 필터를 사용할 때 애니매이션이 추가됨
                        suppressHorizontalScroll: false,//수평스크롤 있는데 안보여요 ㅠㅠ
                        localeText: {noRowsToShow: '조회 결과가 없습니다.'},//데이터가 없을 경우 찍히는 텍스트
                        // pinnedTopRowData: [{applyDay: "YYYY-MM-DD", holidayName: "휴일명", note: "비고", status: "상태"}],//상단 핀고정(하단에 고정하고싶으면 Bottom으로 바꾸면 된다(중복가능))
                        //pinnedBottomRowData: [{applyDay: "YYYY-MM-DD", holidayName: "휴일명", note: "비고", status: "상태"}],//상단 핀고정(하단에 고정하고싶으면 Bottom으로 바꾸면 된다(중복가능))
                        getRowStyle: function (param) {     //css변경
                            if (param.node.rowPinned) {     //핀일 경우 top또는 bottom
                                return {
                                    'font-weight': 'bold',
                                    background: '#dddddd'
                                };
                            }
                            return {    //핀이 아닌 일반 데이터들
                                'text-align': 'center'
                            };
                        },
                        getRowHeight: function (param) {    //높이 변경
                            if (param.node.rowPinned) {     //핀일 경우
                                return 30;
                            }
                            return 24;  //핀이 아닐경우
                        },
                        // GRID READY 이벤트, 사이즈 자동조정 그리드를 모두 만들고 난 후 실행됩니다 $().ready()와 비슷합니다
                        onGridReady: function (event) {     //event에 gridOption이 들어온다
                            event.api.sizeColumnsToFit();   //가로 넓이 자동조절
                        },
                        // 창 크기 변경 되었을 때 이벤트
                        onGridSizeChanged: function (event) {
                            event.api.sizeColumnsToFit();   //가로넓이 자동조정
                        },
                        //셀 데이터 변경시 실행
                        onCellEditingStopped: function (event) {    //event에는 변경된 객체가 들어간다
                            console.log(event);
                            console.log(event.data.status);
                            console.log(event.data);
                            if (event.data.status == "normal") {
                                event.data.status = "update"
                            }
                            gridOptions.api.updateRowData({update: [event.data]});    //현재 그리드 수정(event에 들어와있는 객체를 수정한다.)
                        }
                    };

                    var eGridDiv = document.querySelector('#holidayListGrid');
                    new agGrid.Grid(eGridDiv, gridOptions);
                }
            });
        });

        // 그리드에 행 추가하는 함수
        function createNewRowData() {
            var newData = {
                applyDay: "",
                holidayName: "",
                note: "",
                status: "insert"
            };
            return newData;

        }

        function addGridRow() { // 비어있는 열 하나를 추가함
            var newItem = createNewRowData();
            gridOptions.api.updateRowData({add: [newItem]});
            getRowData();
        }

        function getRowData() { //추가된 열에 데이터를 집어넣음
            addrowData = [];
            gridOptions.api.forEachNode(function (node) {
                addrowData.push(node.data);
            });
            console.log('Row Data:');
            console.log(addrowData);
        }


        /* 그리드에 행 삭제 (주석은 행 추가하는거 참조)*/
        function removeGirdRow() {
            var selectedData = gridOptions.api.getSelectedRows();
            console.log(selectedData);
            var selectedData0 = selectedData[0];
            if (selectedData0.status == "normal") {
                selectedData0.status = 'delete';
            }

            gridOptions.api.updateRowData({update: selectedData});

            console.log('delete Data:');
            console.log(selectedData);
            getRowData();
        }


        /* 저장 버튼을 눌렀을 때 실행되는 함수 */
        function saveGridRow() {
            if (addrowData != null) {
                var sendData = JSON.stringify(addrowData); //addrowData가 추가한 데이터만 의미할거같지만 추가한거포함해서 행 전체를 의미함.
                alert(sendData);
            } else {
                var sendData = JSON.stringify(holidayList); //저장된 휴일 전체 리스트
                alert(sendData);
            }

            $('#holidayListGrid').children().remove(); // 그리드 내용을 지움 . 굳이 지워야 하는 이유는 잘 모르겠다 어차피 페이지는 다시로드 되는데 ?

            $.ajax({
                type: "PUT",
                url: "${pageContext.request.contextPath}/foudinfomgmt/holiday",
                data: sendData,
                contentType: "application/json",
                dataType: "json",
                success: function (sendData) {
                    let keys = Object.keys(sendData);
                    for(let key of keys){
                        console.log(sendData[key]);
                    }
                    console.log("체크" + sendData.errorMsg);

                    if (sendData.errorCode < 0) {
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
<section id="tabs" style="width:550px; height:800px; text-align: center; margin-left:100px;" class="wow fadeInDown">
    <div class="container">
        <h6 class="section-title h3" style="text-align:left;">휴일조회</h6>
        <hr style="background-color:white; height: 1px;">
        <input type="button" class="btn btn-light btn-sm" value="추가" id="add_Btn">
        <input type="button" class="btn btn-light btn-sm" value="삭제" id="remove_Btn">
        <input type="button" class="btn btn-light btn-sm" value="저장" id="save_Btn">
        <div class="row">
            <div class="col-md-6">
                <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                        <div id="holidayListGrid" style="height: 600px; width: 500px" class="ag-theme-balham"></div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>
</body>
</html>