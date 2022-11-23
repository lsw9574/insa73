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
        var proofList = [];
        var requestDate = getDay();

        $(document).ready(
            function () {
                /* 사진찾기*/

                $("#findfile").button().click(function () {
                    console.log("Dwadasd?dd?")
                    $("#proofAttd_receipt").click(); //사진찾기 버튼을 누르면 숨겨진 file 태그를 클릭
                });
                $("#proof_img_form").ajaxForm({
                    dataType: "json",
                    success: function (responseText, statusText, xhr, $form) {
                        alert(responseText.errorMsg);
                        location.reload();
                    }
                });
                $("#proofAttd_tabs").tabs();
                showRestAttdListGrid();
                $("#selectproofAttd").click(
                    function () {
                        getCodeRest("ROF001", "ROF002", "ROF003",
                            "selectproofAttd", "selectProofAttdCode");
                    })

                $("#selectProofAttdType").click(
                    function () {
                        getCodeRest("ROF001", "ROF002", "ROF003",
                            "selectProofAttdType",
                            "selectProofAttdTypeCode");
                    })

                $("#search_startD").click(getDatePicker($("#search_startD")));
                $("#search_endD").click(getDatePicker($("#search_endD")));

                $("#search_proofAttdList_Btn").click(findrestAttdList); // 조회버튼

                $("#delete_proofAttd_Btn").click(function () { //
                    var flag = confirm("선택한 증빙신청을 정말 삭제하시겠습니까?");
                    if (flag)
                        removeRestAttdList();
                });

                $("#proofAttd_startD").click(
                    getDatePicker($("#proofAttd_startD")));

                $("#btn_regist").click(registrestAttd);

                /* 사용자 기본 정보 넣기 */
                $("#proofAttd_emp").val("${sessionScope.id}");
                $("#proofAttd_dept").val("${sessionScope.dept}");
                $("#proofAttd_position").val("${sessionScope.position}");
                $("#proofAttd_cash").bind('keyup keydown', function () {
                    inputNumberFormat(this);
                });
            })

        function inputNumberFormat(obj) {
            obj.value = comma(uncomma(obj.value));
        }

        //콤마찍기
        function comma(str) {
            str = String(str);
            return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
        }

        //콤마풀기
        function uncomma(str) {
            str = String(str);
            return str.replace(/[^\d]+/g, '');
        }

        //숫자만 리턴(저장할때)
        //alert(cf_getNumberOnly('1,2./3g')); -> 123 return
        function cf_getNumberOnly(str) {
            var len = str.length;
            var sReturn = "";

            for (var i = 0; i < len; i++) {
                if ((str.charAt(i) >= "0") && (str.charAt(i) <= "9")) {
                    sReturn += str.charAt(i);
                }
            }
            return sReturn;
        }

        /* timePicker시간을 변경하는 함수 */
        function convertTimePicker() {
            startTime = $("#restAttd_startT").val().replace(":", "");
            endTime = $("#restAttd_endT").val().replace(":", "");

            if (startTime.indexOf("00") == 0) {
                startTime = startTime.replace("00", "24");
            }
            if (endTime.indexOf("00") == 0) {
                endTime = endTime.replace("00", "24");
            }
        }

        /* 오늘 날자를 RRRR-MM-DD 형식으로 리턴하는 함수 */
        function getDay() {
            var today = new Date();
            var rrrr = today.getFullYear();
            var mm = today.getMonth() + 1;
            var dd = today.getDate();
            var searchDay = rrrr + "-" + mm + "-" + dd;
            return searchDay;
        }

        /* 증빙서류 조회버튼  */
        function findrestAttdList() {
            var startVar = $("#search_startD").val();
            var endVar = $("#search_endD").val();
            var code = $("#selectProofAttdTypeCode").val();

            $.ajax({
                url: "${pageContext.request.contextPath}/documentmgmt/receipt-proof",
                data: {
                    "empCode": empCode,
                    "startDate": startVar,
                    "endDate": endVar,
                    "code": code,
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

                    proofList = data.proofList;
                    console.log(data.proofList)

                    showRestAttdListGrid();
                }
            });
        }


        /* 근태외신청 그리드 띄우는 함수 */
        function showRestAttdListGrid() {
            var columnDefs = [{
                headerName: "사원명",
                field: "empName",
                checkboxSelection: true
            }, {
                headerName: "증빙구분명",
                field: "proofTypeName",
            }, {
                headerName: "사원직급",
                field: "position",
            }, {
                headerName: "사원부서",
                field: "dept"
            }, {
                headerName: "금액",
                field: "cash"
            }, {
                headerName: "신청일",
                field: "startDate"
            }, {
                headerName: "사유",
                field: "cause"
            }, {
                headerName: "영수증",
                field: "receipt"
            }, {
                headerName: "승인여부",
                field: "applovalStatus"
            },];
            gridOptions = {
                columnDefs: columnDefs,
                rowData: proofList,
                defaultColDef: {
                    editable: false,
                    width: 100
                },
                rowSelection: 'multiple', /* 'single' or 'multiple',*/
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
            $('#restAttdList_grid').children().remove();
            var eGridDiv = document.querySelector('#restAttdList_grid');
            new agGrid.Grid(eGridDiv, gridOptions);
        }


        /* 숫자로 되있는 시간을 시간형태로  */
        function getRealTime(time) {
            var hour = Math.floor(time / 100);
            if (hour == 25)
                hour = 1;
            var min = time - (Math.floor(time / 100) * 100);
            if (min.toString().length == 1)
                min = "0" + min; //분이 1자리라면 앞에0을 붙임
            if (min == 0)
                min = "00";
            return hour + ":" + min;
        }

        function comma(num) {
            var len, point, str;

            num = num + "";
            point = num.length % 3;
            len = num.length;

            str = num.substring(0, point);
            while (point < len) {
                if (str != "")
                    str += ",";
                str += num.substring(point, point + 3);
                point += 3;
            }

            return str;

        }

        function numberFormat(inputNumber) {
            return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        // 사진 등록 form의 ajax 부분


        function readURL(input) {

            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    // 이미지 Tag의 SRC속성에 읽어들인 File내용을 지정 (아래 코드에서 읽어들인 dataURL형식)
                    $("#profileImg").attr("src", e.target.result);
                }
                reader.readAsDataURL(input.files[0]); //File내용을 읽어 dataURL형식의 문자열로 저장
            }
        }

        /* 삭제버튼 눌렀을 때 실행되는 함수 */
        function removeRestAttdList() {
            var selectedRowData = gridOptions.api.getSelectedRows();

            /* 		$.each(selectedRowIds, function(index, id){ //클릭한 회원들을 each로 풀어서 id를 얻음
             var data = $("#restAttdList_grid").getRowData(id); //얻은 아이디로 조회목록 해당아이디 직원의 모든데이터를 가져옴
             if(selectedRowData[0].applovalStatus!='승인')	//가져온 데이터의 승인여부가 '승인'이 아닐경우에 배열에 담음
             selectedRowData.push(data);
             });

             if(selectedRowData.length == 0){ //배열에 담긴 데이터가 없을때에 발생하는 alert
             alert("승인되지 않은 삭제할 근태외정보가 없습니다\n삭제할 근태외정보를 선택해 주세요");
             return;
             }
             */
            var sendData = JSON.stringify(selectedRowData); //삭제할 목록들이 담긴 배열

            $.ajax({
                type: "DELETE",
                url: "${pageContext.request.contextPath}/documentmgmt/receipt-proof",
                data : sendData,
                contentType:"application/json",
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


        /* 코드선택 창 띄우기 */
        function getCodeRest(code1, code2, code3, inputText, inputCode) {
            option = "width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
            window
                .open(
                    "${pageContext.request.contextPath}/comm/codeWindow/view?code1="
                    + code1 + "&code2=" + code2 + "&code3=" + code3
                    + "&inputText=" + inputText + "&inputCode="
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

        /* 신청 버튼  */
        function registrestAttd() {
            if ($("#selectproofAttd").val().trim() == "") {
                alert("증빙구분을 입력해주세요.");
                return;
            }
            if ($("#proofAttd_startD").val().trim() == "") {
                alert("신청일을 입력해주세요.");
                return;
            }
            if ($("#proofAttd_cash").val().trim() == "") {
                alert("금액을 입력해주세요.");
                return;
            }
            if ($("#proofAttd_cause").val().trim() == "") {
                alert("사유를 입력해주세요.");
                return;
            }
            if ($("#proofAttd_receipt").val().trim() == "") {
                alert("영수증을 첨부해 주세요.");
                return;
            }

            var proofList = {
                "empCode": empCode,
                "proofTypeCode": $("#selectProofAttdCode").val(),
                "proofTypeName": $("#selectproofAttd").val(),
                "startDate": $("#proofAttd_startD").val(),
                "position": $("#proofAttd_position").val(),
                "dept": $("#proofAttd_dept").val(),
                "cash": $("#proofAttd_cash").val(),
                "cause": $("#proofAttd_cause").val(),
                "receipt": $("#proofAttd_receipt").val(),
                "applovalStatus": '승인대기'
            };

            var sendData = JSON.stringify(proofList);

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/documentmgmt/receipt-proof",
                data: sendData,
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        alert("신청을 실패했습니다");
                    } else {
                        console.log("여기???")
                        if ($("#proofAttd_receipt").val() != "") {
                            console.log($("#proofAttd_receipt").val());
                            console.log("ㅁㅁㅁㅇㅇㄴㅇㅁㄴㅇ?")

                            $("#proof_img_cashCode").val(proofList.cash);
                            $("#proof_img_form").submit();
                        }

                        alert("신청되었습니다");
                    }
                    location.reload();
                }
            });
        }
    </script>
</head>

<body>
<section id="tabs" class="wow fadeInDown" style="height:700px; text-align: center; margin-left:0px;">

    <div class="container">
        <nav>
            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <a class="nav-item nav-link active" data-toggle="tab" href="#employmentRequest_tab" role="tab"
                   aria-controls="nav-home" aria-selected="true"> 증빙서류 신청</a>
                <a class="nav-item nav-link" data-toggle="tab" href="#employmentList_tab" role="tab"
                   aria-controls="nav-profile" aria-selected="false">증빙서류 조회</a>
            </div>
        </nav>
    </div>

    <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
        <div class="tab-pane fade show active" id="employmentRequest_tab" role="tabpanel"
             aria-labelledby="nav-home-tab">
            <font>증빙구분 </font> <input id="selectproofAttd"
                                      class="ui-button ui-widget ui-corner-all" readonly> <input
                type="hidden" id="selectProofAttdCode" name="restAttdCode">
            <hr>
            <table style="margin : auto;">
                <tr>
                    <td><font>신청자 </font></td>
                    <td><input id="proofAttd_emp"
                               class="ui-button ui-widget ui-corner-all" readonly></td>
                    <td><font>직급</font></td>
                    <td><input id="proofAttd_position"
                               class="ui-button ui-widget ui-corner-all" readonly></td>
                </tr>
                <tr>
                    <td><h3></h3></td>
                </tr>
                <tr>
                    <td><font>부서 </font></td>
                    <td><input id="proofAttd_dept"
                               class="ui-button ui-widget ui-corner-all" readonly></td>
                    <td><font>금액</font></td>
                    <td><input id="proofAttd_cash"
                               class="ui-button ui-widget ui-corner-all"></td>
                </tr>

                <tr>
                    <td><h3></h3></td>
                </tr>

                <tr>
                    <td><font>신청일</font></td>
                    <td colspan="3"><input id="proofAttd_startD"
                                           class="ui-button ui-widget ui-corner-all" readonly
                                           style="width: 605px"></td>
                </tr>

                <tr>
                    <td><h3></h3></td>
                </tr>
                <tr>
                    <td><font>사유</font></td>
                    <td colspan="3"><input id="proofAttd_cause"
                                           style="width: 605px" class="ui-button ui-widget ui-corner-all"></td>
                </tr>
                <tr>
                    <td><h3></h3></td>
                </tr>
                <tr>


                    <div id="divImg">
                        <img id="profileImg" src="" width="180px" height="200px"><br>
                        <form id="proof_img_form" action="${pageContext.request.contextPath}/systemmgmt/proofImg.do"
                              enctype="multipart/form-data" method="post">
                            <input type="hidden" name="cashCode" id="proof_img_cashCode">
                            <input type="file" name="proofImgFile"
                                   id="proofAttd_receipt" style="display: none;" onChange="readURL(this)"/>
                            <button type="button" style="width: 150px" class="ui-button ui-idget ui-corner-all"
                                    id="findfile">영수증
                            </button>

                            <br>
                        </form>

                    </div>


                </tr>

                <tr>
                    <td><h3></h3></td>
                </tr>
            </table>
            <hr>
            <input type="button" class="ui-button ui-widget ui-corner-all"
                   id="btn_regist" value="신청"> <input type="reset"
                                                      class="ui-button ui-widget ui-corner-all" value="취소">
        </div>


        <div class="tab-pane fade" id="employmentList_tab" role="tabpanel" aria-labelledby="nav-profile-tab">
            <table>
                <tr>
                    <td colspan="2">
                        <center>
                            <h3>조회범위 선택</h3>
                        </center>
                    </td>
                </tr>
                <tr>
                    <td><h3>구분</h3></td>
                    <td><input id="selectProofAttdType"
                               class="ui-button ui-widget ui-corner-all" readonly> <input
                            type="hidden" id="selectProofAttdTypeCode"></td>
                </tr>
                <tr>
                    <td><input type=text class="ui-button ui-widget ui-corner-all"
                               id="search_startD" readonly></td>
                    <td><input type=text class="ui-button ui-widget ui-corner-all"
                               id="search_endD" readonly></td>
                </tr>
                <tr>
                    <td><h3></h3></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <center>
                            <button class="ui-button ui-widget ui-corner-all" id="search_proofAttdList_Btn">조회하기
                            </button>
                            <button class="ui-button ui-widget ui-corner-all" id="delete_proofAttd_Btn">삭제하기</button>
                        </center>
                    </td>
                </tr>
            </table>
            <hr>
            <br>
            <br>
            <br>
            <div id="restAttdList_grid" style="height: 230px" class="ag-theme-balham"></div>
            <div id="restAttdList_pager"></div>
        </div>
    </div>

</section>
</body>
</html>