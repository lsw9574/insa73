<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>jQuery UI Tabs - Default functionality</title>


    <script>
        var empList = [];
        var empDList = []; //empDetailList
        var selectedEmpBean, selectEmpLicenBean, updatedEmpBean = {}; // 사원의 상세정보를 저장하는 객체들

        empName = "";
        emptyWorkInfoBean = {}; // 그리드에 새 행을 추가하기 위한 비어있는 객체들
        emptyLicenseInfoBean = {};
        emptyFamilyInfoBean = {};
        var lastId = 0; // 마지막으로 선택한 그리드의 행 id (다른 행을 더블클릭 하였을 때, 해당 행을 닫기 상태로 만들기 위해 저장함)
        var workgridOptions = {};
        var familygridOptions = {};
        var licensegridOptions = {};
        var addrowData;
        var today;

        $(document)
            .ready(
                function () {
                    /* 부서명 검색/사원명 검색 탭 이동 */
                    $("#tabs").tabs();

                    $("#sel_dept").selectmenu(); //부서 검색하면 menu 나옴
                    $("#tabs1").tabs();

                    /* 부서명 검색, 이름 검색 이벤트 등록 */
                    $("#btn_name_search").click(function () {
                        makeEmpList("name", $("#txt_name").val()); //이름
                    })
                    $("#btn_dept_search").click(function () {
                        makeEmpList("dept", $("#sel_dept").val()); //부서명
                    })

                    /* 검색 함수 */
                    function makeEmpList(grid, value) {

                        console.log(grid + "    " + value);

                        $
                            .ajax({
                                url: "${pageContext.request.contextPath}/empinfomgmt/emplist",
                                data: {
                                    "value": value, "workplaceCode":"${sessionScope.workplaceCode}"
                                    //전체부서/회계팀/인사팀/전산팀
                                },
                                dataType: "json",
                                success: function (data) {
                                    if (data.errorCode < 0) { //erroe code는 컨트롤러에서 날려보냄
                                        var str = "내부 서버 오류가 발생했습니다\n";
                                        str += "관리자에게 문의하세요\n";
                                        str += "에러 위치 : "
                                            + $(this).attr("id");
                                        str += "에러 메시지 : "
                                            + data.errorMsg;
                                        alert(str);
                                        return; //function 빠져나감
                                    }

                                    empList = data.list; //만들어놓은 빈 배열에 list담음

                                    if (grid == "dept")
                                        showEmpListDeptGrid();
                                    else {
                                        showEmpListNameGrid();
                                    }
                                },
                                error: function (a, b, c) {
                                    alert(b);
                                }
                            });
                    }

                    /* 부서별 사원 정보 그리드에 뿌리는 함수 */
                    function showEmpListDeptGrid() {
                        var columnDefs = [{
                            headerName: "사원코드",
                            field: "empCode",
                            checkboxSelection: true
                        }, {
                            headerName: "사원명",
                            field: "empName"
                        }, {
                            headerName: "부서",
                            field: "deptName"
                        }, {
                            headerName: "직급",
                            field: "position"
                        }, {
                            headerName: "성별",
                            field: "gender",
                            hide: true
                        }, {
                            headerName: "전화번호",
                            field: "mobileNumber",
                            hide: true
                        }, {
                            headerName: "이메일",
                            field: "email",
                            width: 100,
                            hide: true
                        }, {
                            headerName: "거주지",
                            field: "address",
                            hide: true
                        }, {
                            headerName: "최종학력",
                            field: "lastSchool",
                            hide: true
                        }, {
                            headerName: "사진",
                            field: "imgExtend",
                            hide: true
                        }, {
                            headerName: "생년월일",
                            field: "birthdate",
                            hide: true
                        }];
                        gridOptions = {
                            columnDefs: columnDefs,
                            rowData: empList,
                            onRowClicked: function (node) {
                                console.log("노드입니다");
                                console.log(node);
                                var empCode = node.data.empCode;
                                var profile = node.data.imgExtend;
                                document.getElementById('profileImg')
                                    .setAttribute(
                                        "src",
                                        "${pageContext.request.contextPath}/profile/"
                                        + empCode + "."
                                        + profile);
                                $
                                    .ajax({
                                        url: "${pageContext.request.contextPath}/empinfomgmt/empdetail/all",
                                        data: {
                                            "empCode": empCode
                                        },
                                        dataType: "json",
                                        success: function (data) {
                                            console.log(data)
                                            if (data.errorCode < 0) {
                                                var str = "내부 서버 오류가 발생했습니다\n";
                                                str += "관리자에게 문의하세요\n";
                                                str += "에러 위치 : "
                                                    + $(this).attr(
                                                        "id");
                                                str += "에러 메시지 : "
                                                    + data.errorMsg;
                                                alert(str);
                                                return;
                                            }

                                            empDList = data.empBean;
                                            //initField(); // 전역변수 초기화
                                            clearEmpInfo(); // 상세정보, 재직정보 칸 초기화
                                            setAllEmptyBean(data);
                                            selectedEmpBean = $.extend(
                                                true, {},
                                                data.empBean); // 취소버튼을 위한 임시 저장공간에 딥카피
                                            updatedEmpBean = $
                                                .extend(
                                                    true,
                                                    {},
                                                    data.emptyLicenseInfoBean); // 변경된 내용이 들어갈 공간에 딥카피

                                            showDetailInfo();
                                            showWorkInfoListGrid();
                                            showLicenseInfoListGrid();
                                            showFamilyInfoListGrid();
                                        }
                                    });
                            }
                        }
                        $('#deptfindgrid').children().remove();
                        var eGridDiv = document
                            .querySelector('#deptfindgrid');
                        new agGrid.Grid(eGridDiv, gridOptions);
                        gridOptions.api.sizeColumnsToFit();
                    }

                    /* 이름으로 검색결과 그리드에 뿌리는 함수 */
                    function showEmpListNameGrid() {
                        var columnDefs = [{
                            headerName: "사원코드",
                            field: "empCode",
                            width: 130,
                            checkboxSelection: true
                        }, {
                            headerName: "사원명",
                            field: "empName",
                            width: 120
                        }, {
                            headerName: "부서",
                            field: "deptName",
                            width: 120
                        }, {
                            headerName: "직급",
                            field: "position",
                            width: 130
                        }, {
                            headerName: "성별",
                            field: "gender",
                            hide: true
                        }, {
                            headerName: "전화번호",
                            field: "mobileNumber",
                            hide: true
                        }, {
                            headerName: "이메일",
                            field: "email",
                            width: 100,
                            hide: true
                        }, {
                            headerName: "거주지",
                            field: "address",
                            hide: true
                        }, {
                            headerName: "최종학력",
                            field: "lastSchool",
                            hide: true
                        }, {
                            headerName: "사진",
                            field: "imgExtend",
                            hide: true
                        }, {
                            headerName: "생년월일",
                            field: "birthdate",
                            hide: true
                        }];
                        gridOptions = {
                            columnDefs: columnDefs,
                            rowData: empList,
                            onCellClicked: function (node) {
                                var empCode = node.data.empCode;
                                var profile = node.data.imgExtend;
                                document.getElementById('profileImg')
                                    .setAttribute(
                                        "src",
                                        "${pageContext.request.contextPath}/profile/"
                                        + empCode + "."
                                        + profile);
                                $
                                    .ajax({
                                        url: "${pageContext.request.contextPath}/empinfomgmt/empdetail/all",
                                        data: {
                                            "empCode": empCode
                                        },
                                        dataType: "json",
                                        success: function (data) {
                                            if (data.errorCode < 0) {
                                                var str = "내부 서버 오류가 발생했습니다\n";
                                                str += "관리자에게 문의하세요\n";
                                                str += "에러 위치 : "
                                                    + $(this).attr(
                                                        "id");
                                                str += "에러 메시지 : "
                                                    + data.errorMsg;
                                                alert(str);
                                                return;
                                            }
                                            empDList = data.empBean;
                                            //initField(); // 전역변수 초기화
                                            clearEmpInfo(); // 상세정보, 재직정보 칸 초기화
                                            setAllEmptyBean(data);
                                            selectedEmpBean = $.extend(
                                                true, {},
                                                data.empBean); // 취소버튼을 위한 임시 저장공간에 딥카피
                                            updatedEmpBean = $.extend(
                                                true, {},
                                                data.empBean); // 변경된 내용이 들어갈 공간에 딥카피
                                            // 객체를 딥카피 하는 이유는 객체 내에 저장된 주소타입의 변수들이 제대로 복사되지 않기 때문임
                                            /* 회원정보를 불러와야 기타정보들의 객체에 제대로 값이 들어가기 때문에 이곳에서 부름 */
                                            showDetailInfo();
                                            showWorkInfoListGrid();
                                            showCareerInfoListGrid();
                                            showEducationInfoListGrid();
                                            showLicenseInfoListGrid();
                                            showFamilyInfoListGrid();
                                        }
                                    });
                            }
                        }
                        $('#namefindgrid').children().remove();
                        var eGridDiv = document
                            .querySelector('#namefindgrid');
                        new agGrid.Grid(eGridDiv, gridOptions);
                        gridOptions.api.sizeColumnsToFit();
                    }

                    $("#address").postcodifyPopUp();

                    /* 사진찾기*/
                    $("#findPhoto").button().click(function () {
                        $("#emp_img_file").click(); //사진찾기 버튼을 누르면 숨겨진 file 태그를 클릭
                    });

                    // 사진 등록 form의 ajax 부분
                    $("#emp_img_form").ajaxForm(
                        {
                            dataType: "json",
                            success: function (responseText,
                                               statusText, xhr, $form) {
                                alert(responseText.errorMsg);
                                location.reload();
                            }
                        });

                    /* 코드 선택창 띄우기 */
                    function getCode(code, inputText, inputCode) {
                        option = "width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
                        window.open(
                            "${pageContext.request.contextPath}/comm/codeWindow/view?code="
                            + code + "&inputText=" + inputText
                            + "&inputCode=" + inputCode,
                            "newwins", option);
                    }

                    /* 전역변수 초기화 함수 */
                    function initField() {
                        selectedEmpBean, updatedEmpBean = {};
                        emptyFamilyInfoBean = {};
                        emptyCareerInfoBean = {};
                        emptyWorkInfoBean = {};
                        emptyEducationInfoBean = {};
                        emptyLicenseInfoBean = {};
                        lastId = 0;
                    }

                    /* 현재 표시된 모든 정보를 비우는 함수 */
                    function clearEmpInfo() {
                        // 찾았던 사진을 기본 사진으로 되돌린다
                        $("#profileImg")
                            .attr("src",
                                "${pageContext.request.contextPath }/profile/profile.png");
                        $("input:text").each(function () {
                            $(this).val("") //모든 input text타입의 value값을 비운다
                        })
                    }

                    /* 새로운 정보들을 추가하기 위한 빈 객체 세팅 */
                    function setAllEmptyBean(data) {
                        var todayTime = new Date();
                        var rrrr = todayTime.getFullYear();
                        var mm = todayTime.getMonth() + 1;
                        var dd = todayTime.getDate();
                        today = rrrr + "-" + addZeros(mm, 2) + "-"
                            + addZeros(dd, 2);
                        console.log(today);
                        realTime = parseInt(today.replace(/\-/g, '')) - 20000000;
                        emptyFamilyInfoListBean = data.emptyFamilyInfoBean;
                        emptyWorkInfoListBean = data.emptyWorkInfoBean;
                        emptyLicenseInfoListBean = data.emptyLicenseInfoBean;
                        emptyFamilyInfoListBean.status = "insert";
                        emptyFamilyInfoListBean.empCode = data.empBean.empCode;
                        emptyWorkInfoListBean.status = "insert";
                        emptyWorkInfoListBean.empCode = data.empBean.empCode;
                        emptyWorkInfoListBean.deptName = data.empBean.deptName;
                        emptyWorkInfoListBean.position = data.empBean.position;
                        emptyWorkInfoListBean.empName = data.empBean.empName;
                        emptyWorkInfoListBean.workInfoDays = realTime;
                        emptyLicenseInfoListBean.status = "insert";
                        emptyLicenseInfoListBean.empCode = data.empBean.empCode;
                    }

                    /* DatePicker 달력함수 */
                    function getDatePicker() {
                        // function to act as a class
                        function Datepicker() {
                        }

                        // gets called once before the renderer is used
                        Datepicker.prototype.init = function (params) {
                            // create the cell
                            this.eInput = document.createElement('input');
                            this.eInput.value = params.value;

                            // https://jqueryui.com/datepicker/
                            $(this.eInput).datepicker({
                                dateFormat: 'dd/mm/yy'
                            });
                        };

                        // gets called once when grid ready to insert the element
                        Datepicker.prototype.getGui = function () {
                            return this.eInput;
                        };

                        // focus and select can be done after the gui is attached
                        Datepicker.prototype.afterGuiAttached = function () {
                            this.eInput.focus();
                            this.eInput.select();
                        };

                        // returns the new value after editing
                        Datepicker.prototype.getValue = function () {
                            return this.eInput.value;
                        };

                        // any cleanup we need to be done here
                        Datepicker.prototype.destroy = function () {
                            // but this example is simple, no cleanup, we could
                            // even leave this method out as it's optional
                        };

                        // if true, then this editor will appear in a popup
                        Datepicker.prototype.isPopup = function () {
                            // and we could leave this method out also, false is the default
                            return false;
                        };
                        return Datepicker;
                    }

                    function getDatePickerNumber($CellId) {
                        // function to act as a class
                        function Datepicker() {
                        }

                        // gets called once before the renderer is used
                        Datepicker.prototype.init = function (params) {
                            // create the cell
                            this.eInput = document.createElement('input');
                            this.eInput.value = params.value;

                            // https://jqueryui.com/datepicker/
                            $(this.eInput).datepicker({
                                dateFormat: 'dd/mm/yy'
                            });
                        };

                        // gets called once when grid ready to insert the element
                        Datepicker.prototype.getGui = function () {
                            return this.eInput;
                        };

                        // focus and select can be done after the gui is attached
                        Datepicker.prototype.afterGuiAttached = function () {
                            this.eInput.focus();
                            this.eInput.select();
                        };

                        // returns the new value after editing
                        Datepicker.prototype.getValue = function () {
                            return this.eInput.value;
                        };

                        // any cleanup we need to be done here
                        Datepicker.prototype.destroy = function () {
                            // but this example is simple, no cleanup, we could
                            // even leave this method out as it's optional
                        };

                        // if true, then this editor will appear in a popup
                        Datepicker.prototype.isPopup = function () {
                            // and we could leave this method out also, false is the default
                            return false;
                        };
                        return Datepicker;
                    }

                    ////////////////////////////////////////////////////그리드이벤트////////////////////////////////////////////////////////
                    /* 그리드에 행 추가하는 함수 */
                    function addListGridRow() {
                        var key = $(this).attr("id").split("_")[1]; // add_work_btn -> work

                        var emptyBean = {
                            "family": emptyFamilyInfoListBean,
                            "work": emptyWorkInfoListBean,
                            "license": emptyLicenseInfoListBean
                        }
                        /*
                         * addRowData가 아닌 addRow로 cell을 추가하면 굉장히 편하지만 이 방법을 사용하는 이유는
                         * addRow로 cell을 추가하면 editable에 따라 textbox가 자동으로 생성된 상태로 cell이 추가됨
                         * 이걸 일일이 처리하는것보다 빈 객체를 가져와 처리하는게 편하기 때문에 addRowData를 사용
                         */

                        var newData = emptyBean[key];
                        console.log(newData);

                        if (key == "work") {
                            workgridOptions.api.updateRowData({
                                add: [newData]
                            });
                        } else if (key == "family") {
                            familygridOptions.api.updateRowData({
                                add: [newData]
                            });
                        } else if (key == "career") {
                            careergridOptions.api.updateRowData({
                                add: [newData]
                            });
                        } else if (key == "education") {
                            educationgridOptions.api.updateRowData({
                                add: [newData]
                            });
                        } else if (key == "license") {
                            licensegridOptions.api.updateRowData({
                                add: [newData]
                            });
                        }
                    }

                    /* 그리드에 행 삭제 */
                    function delListGridRow() {
                        var key = $(this).attr("id").split("_")[1];
                        var selectedRowId = $("#" + key + "InfoListGrid")
                            .getGridParam("selrow");
                        if (selectedRowId != null) {
                            var data = $("#" + key + "InfoListGrid")
                                .getRowData(selectedRowId);
                            if (data.status == "select"
                                || data.status == "update")
                                $("#" + key + "InfoListGrid").setCell(
                                    selectedRowId, "status", "delete");
                            else if (data.status == "delete")
                                $("#" + key + "InfoListGrid").setCell(
                                    selectedRowId, "status", "update");
                            else
                                $("#" + key + "InfoListGrid").delRowData(
                                    selectedRowId);
                        } else {
                            alert("삭제할 행을 선택해 주세요!");
                        }
                    }

                    /* 상세정보 탭의 저장 버튼 */
                    $("#modifyEmp_Btn").click(function () {
                        if (updatedEmpBean == null) {
                            alert("저장할 내용이 없습니다");
                        } else {
                            var flag = confirm("변경한 내용을 서버에 저장하시겠습니까?");

                            if (flag) {
                                modifyEmp();
                            }
                        }
                    });

                    /* 저장 */
                    function modifyEmp() {
                        saveEmpInfo();
                        var sendData = JSON.stringify(updatedEmpBean);

                        $
                            .ajax({
                                type: "PUT",
                                url: "${pageContext.request.contextPath}/empinfomgmt/empdetail/empcode",
                                data: sendData,
                                contentType: "application/json",
                                dataType: "json",
                                success: function (data) {
                                    if (data.errorCode < 0) {
                                        alert("저장에 실패했습니다");
                                    } else {
                                        /* 선택한 사진이 있다면 저장 버튼을 눌렀을때에 사진 저장도 같이 되게함 */
                                        if ($("#emp_img_file").val() != "") {
                                            $("#emp_img_form").submit();
                                        }
                                        alert("저장되었습니다");
                                    }

                                    location.reload();
                                }
                            });
                    }

                    /* 변경된 정보들을 저장하는 함수 */
                    function saveEmpInfo() {
                        addrowData = [];
                        workgridOptions.api.forEachNode(function (node) {
                            addrowData.push(node.data);
                        });
                        updatedEmpBean.status = "update";
                        updatedEmpBean.empCode = $("#empCode").val();
                        updatedEmpBean.empName = $("#empName").val();
                        updatedEmpBean.birthdate = $("#birthdate").val();
                        updatedEmpBean.deptName = $("#deptName").val();
                        updatedEmpBean.position = $("#position").val();
                        updatedEmpBean.email = $("#email").val();
                        updatedEmpBean.gender = $("#gender").val();
                        updatedEmpBean.mobileNumber = $("#mobileNumber")
                            .val();
                        updatedEmpBean.lastSchool = $("#lastSchool").val();
                        updatedEmpBean.address = $("#address").val();
                        updatedEmpBean.detailAddress = $("#detailAddress")
                            .val();
                        updatedEmpBean.postNumber = $("#postNumber").val();
                        updatedEmpBean.workInfoList = addrowData;
                        console.log(updatedEmpBean);
                        /* 사진, 생년월일  추가해줘야함*/
                    }

                    /* 상세정보 탭의 취소 버튼 */
                    $("#can_work_btn").click(function () {
                        var flag = confirm("취소하시겠습니까?");
                        if (flag)
                            rollBackEmpInfo();
                    });

                    function rollBackEmpInfo() {
                        clearEmpInfo(); // 모든 정보를 지운 후

                        // 서버에서 불러온 미리 저장한 EmpBean의 정보를 수정하던 정보에 엎어씌움
                        updatedEmpBean = $
                            .extend(true, {}, selectedEmpBean);
                        // 딥카피하는 이유는 주소타입의 변수가 제대로 카피되지 않기 때문임

                        //상제정보와 사진을 다시 띄운다
                        showDetailInfo();
                        showEmpImg();
                    }

                    /* 사진 찾기 버튼 */
                    $("#findImg_btn").click(function () {
                        if (updatedEmpBean == null) {
                            alert("저장할 내용이 없습니다");
                        } else {
                            var flag = confirm("변경한 내용을 서버에 저장하시겠습니까?");
                            if (flag)
                                modifyEmp();
                        }
                    });

                    /* 저장된 사진 불러오는 함수 */
                    function showEmpImg() {
                        var path = "${pageContext.request.contextPath }/profile/profile.png";

                        if (selectedEmpBean.imgExtend != null) {
                            if (selectedEmpBean.detailInfo.imgExtend != null) {
                                path = "${pageContext.request.contextPath}/profile/";
                                path += selectedEmpBean.empCode;
                                path += "." + selectedEmpBean.imgExtend;
                            }
                        }
                        $("#emp_img").attr("src", path);
                    }

                    /* 사원 삭제 버튼 눌렀을 때 실행되는 함수 */
                    function removeEmpListD() {
                        var selectedRowIds = gridOptions.api
                            .getSelectedRows();
                        var sendData = JSON.stringify(selectedRowIds);
                        $
                            .ajax({
                                type: "DELETE",
                                url: "${pageContext.request.contextPath}/empinfomgmt/empdetail/empcode",
                                data: sendData,
                                contentType: "application/json",
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

                    function removeEmpListN() {
                        var selectedRowIds = gridOptions.api
                            .getSelectedRows();
                        var sendData = JSON.stringify(selectedRowIds);
                        if (selectedRowIds.length == 0) {
                            alert("삭제할 사원을 선택해 주세요");
                            return;
                        }
                        var sendData = JSON.stringify(selectedRowIds);
                        $
                            .ajax({
                                type: "DELETE",
                                url: "${pageContext.request.contextPath}/empinfomgmt/empdetail/empcode",
                                data: sendData,
                                contentType: "application/json",
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

                    function showDetailInfo() {
                        $("#empCode").val(selectedEmpBean.empCode);
                        $("#empName").val(selectedEmpBean.empName);
                        $("#deptName").val(selectedEmpBean.deptName);
                        $("#position").val(selectedEmpBean.position);
                        $("#birthdate").val(selectedEmpBean.birthdate);
                        $("#gender").val(selectedEmpBean.gender);
                        $("#mobileNumber")
                            .val(selectedEmpBean.mobileNumber);
                        $("#address").val(selectedEmpBean.address);
                        $("#detailAddress").val(
                            selectedEmpBean.detailAddress);
                        $("#postNumber").val(selectedEmpBean.postNumber);
                        $("#email").val(selectedEmpBean.email);
                        $("#lastSchool").val(selectedEmpBean.lastSchool);
                        $("#profileImg").attr(
                            "src",
                            "${pageContext.request.contextPath}/profile/"
                            + selectedEmpBean.empCode + "."
                            + selectedEmpBean.imgExtend);
                    }

                    function showWorkInfoListGrid() {
                        var columnDefs = [
                            {
                                headerName: "사원코드",
                                field: "empCode",
                            },
                            {
                                headerName: "적용일",
                                field: "workInfoDays",
                                editable: true,
                                cellRenderer: function (params) {
                                    return '<i class="fa fa-calendar-o" aria-hidden="true"></i>'
                                        + params.value;
                                },
                                //cellEditor: DateEditor
                            },
                            {
                                headerName: "입사일",
                                field: "hiredate",
                                editable: true,
                                cellRenderer: function (params) {
                                    return '<i class="fa fa-calendar-o" aria-hidden="true"></i>'
                                        + params.value;
                                },
                                //cellEditor: DateEditor
                            },
                            {
                                headerName: "퇴사일",
                                field: "retireDate",
                                editable: true,
                                cellRenderer: function (params) {
                                    return '<i class="fa fa-calendar-o" aria-hidden="true"></i>'
                                        + params.value;
                                },
                                //cellEditor: DateEditor
                            },
                            {
                                headerName: "직종",
                                field: "occupation",
                                editable: true,
                                cellEditor: 'agSelectCellEditor',
                                cellEditorParams: {
                                    values: ['생산직', '사무직']
                                },
                            },
                            {
                                headerName: "고용형태",
                                field: "employmentType",
                                editable: true,
                                cellEditor: 'agSelectCellEditor',
                                cellEditorParams: {
                                    values: ['정규직', '계약직', '일용직',
                                        '파겨직', '재택근로자', '단시간근로자']
                                },
                            },
                            {
                                headerName: "호봉",
                                field: "hobong",
                                editable: true,
                                cellEditor: 'agSelectCellEditor',
                                cellEditorParams: {
                                    values: ['1호봉', '2호봉', '3호봉',
                                        '4호봉', '5호봉', '6호봉', '7호봉',
                                        '8호봉', '9호봉', '10호봉',
                                        '11호봉', '12호봉', '13호봉',
                                        '14호봉', '15호봉', '16호봉',
                                        '17호봉', '18호봉', '19호봉',
                                        '20호봉', '21호봉', '22호봉',
                                        '23호봉', '24호봉', '25호봉']
                                },
                            }, {
                                headerName: "직급",
                                field: "position"
                            }, {
                                headerName: "부서",
                                field: "deptName"
                            }, {
                                headerName: "상태",
                                field: "status"
                            }];

                        workgridOptions = {
                            columnDefs: columnDefs,
                            rowData: updatedEmpBean.workInfoList,
                            defaultColDef: {
                                editable: false,
                                width: 100
                            },
                            components: {
                                datePicker: getDatePicker(),
                                datePicker1: getDatePickerNumber(),

                            },
                            rowSelection: 'single', /* 'single' or 'multiple',*/
                            enableColResize: true,
                            enableSorting: true,
                            enableFilter: true,
                            enableRangeSelection: true,
                            suppressRowClickSelection: false,
                            animateRows: true,
                            suppressHorizontalScroll: true,
                            defaultColDef: {
                                resizable: true
                            },
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
                            onCellEditingStopped: function (event) {
                                console.log('cellEditingStopped');
                                console.log(event.data.status);
                                console.log(event.data);
                                if (event.data.status == "normal") {
                                    event.data.status = "update"
                                }
                                console.log(event.data.status);
                            },
                        };
                        $('#workInfoListGrid').children().remove();
                        var eGridDiv = document
                            .querySelector('#workInfoListGrid');
                        new agGrid.Grid(eGridDiv, workgridOptions);
                    }

                    function showWorkInfoListGrid() {
                        var columnDefs = [
                            {
                                headerName: "사원코드",
                                field: "empCode",
                            },
                            {
                                headerName: "적용일",
                                field: "workInfoDays",
                                editable: true,
                                cellRenderer: function (params) {
                                    return '<i class="fa fa-calendar-o" aria-hidden="true"></i>'
                                        + params.value;
                                },
                                //cellEditor: DateEditor
                            },
                            {
                                headerName: "입사일",
                                field: "hiredate",
                                editable: true,
                                cellRenderer: function (params) {
                                    return '<i class="fa fa-calendar-o" aria-hidden="true"></i>'
                                        + params.value;
                                },
                                //cellEditor: DateEditor
                            },
                            {
                                headerName: "퇴사일",
                                field: "retireDate",
                                editable: true,
                                cellRenderer: function (params) {
                                    return '<i class="fa fa-calendar-o" aria-hidden="true"></i>'
                                        + params.value;
                                },
                                //cellEditor: DateEditor
                            },
                            {
                                headerName: "직종",
                                field: "occupation",
                                editable: true,
                                cellEditor: 'agSelectCellEditor',
                                cellEditorParams: {
                                    values: ['생산직', '사무직']
                                }
                            },
                            {
                                headerName: "고용형태",
                                field: "employmentType",
                                editable: true,
                                cellEditor: 'agSelectCellEditor',
                                cellEditorParams: {
                                    values: ['정규직', '계약직', '일용직',
                                        '파겨직', '재택근로자', '단시간근로자']
                                }
                            },
                            {
                                headerName: "호봉",
                                field: "hobong",
                                editable: true,
                                cellEditor: 'agSelectCellEditor',
                                cellEditorParams: {
                                    values: ['1호봉', '2호봉', '3호봉',
                                        '4호봉', '5호봉', '6호봉', '7호봉',
                                        '8호봉', '9호봉', '10호봉',
                                        '11호봉', '12호봉', '13호봉',
                                        '14호봉', '15호봉', '16호봉',
                                        '17호봉', '18호봉', '19호봉',
                                        '20호봉', '21호봉', '22호봉',
                                        '23호봉', '24호봉', '25호봉']
                                },
                            }, {
                                headerName: "직급",
                                field: "position"
                            }, {
                                headerName: "부서",
                                field: "deptName"
                            }, {
                                headerName: "상태",
                                field: "status"
                            }];

                        workgridOptions = {
                            columnDefs: columnDefs,
                            rowData: updatedEmpBean.workInfoList,
                            defaultColDef: {
                                editable: false,
                                width: 100
                            },
                            components: {
                                datePicker: getDatePicker(),
                                datePicker1: getDatePickerNumber(),

                            },
                            rowSelection: 'single', /* 'single' or 'multiple',*/
                            enableColResize: true,
                            enableSorting: true,
                            enableFilter: true,
                            enableRangeSelection: true,
                            suppressRowClickSelection: false,
                            animateRows: true,
                            suppressHorizontalScroll: true,
                            defaultColDef: {
                                resizable: true
                            },
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
                            onCellEditingStopped: function (event) {
                                console.log('cellEditingStopped');
                                console.log(event.data.status);
                                console.log(event.data);
                                if (event.data.status == "normal") {
                                    event.data.status = "update"
                                }
                                console.log(event.data.status);
                            },
                        };
                        $('#workInfoListGrid').children().remove();
                        var eGridDiv = document
                            .querySelector('#workInfoListGrid');
                        new agGrid.Grid(eGridDiv, workgridOptions);
                        //gridOptions.api.setRowData([{empCode:"A490070"}]);
                    }

                    //가족정보 그리드 호출
                    function showFamilyInfoListGrid() {
                        var columnDefs = [{
                            headerName: "사원코드",
                            field: "empCode",
                            editable: false
                        }, {
                            headerName: "일련번호",
                            field: "familyCode",
                            editable: true
                        }, {
                            headerName: "성명",
                            field: "familyName",
                            editable: true
                        }, {
                            headerName: "관계",
                            field: "relation",
                            editable: true
                        }, {
                            headerName: "생년월일",
                            field: "birthdate",
                            editable: true,
                            cellEditor: 'datePicker'
                        }, {
                            headerName: "동거여부",
                            field: "liveTogether"
                        }, {
                            headerName: "상태",
                            field: "status"
                        }];
                        familygridOptions = {
                            columnDefs: columnDefs,
                            rowData: updatedEmpBean.familyInfoList,
                            defaultColDef: {
                                editable: false,
                                width: 100
                            },
                            components: {
                                datePicker: getDatePicker(),
                                datePicker1: getDatePickerNumber()
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
                        $('#familyInfoListGrid').children().remove();
                        var eGridDiv = document
                            .querySelector('#familyInfoListGrid');
                        new agGrid.Grid(eGridDiv, familygridOptions);
                    }

                    //자격증정보 그리드 호출
                    function showLicenseInfoListGrid() {
                        var columnDefs = [{
                            headerName: "사원코드",
                            field: "empCode",
                            editable: false
                        }, {
                            headerName: "일련번호",
                            field: "licenseCode",
                            editable: true
                        }, {
                            headerName: "자격명",
                            field: "licenseName",
                            editable: true
                        }, {
                            headerName: "취득일",
                            field: "getDate",
                            cellEditor: 'datePicker'
                        }, {
                            headerName: "만료일",
                            field: "expireDate",
                            cellEditor: 'datePicker'
                        }, {
                            headerName: "급수",
                            field: "licenseLevel"
                        }, {
                            headerName: "발행기관",
                            field: "licenseCenter"
                        }, {
                            headerName: "발급번호",
                            field: "issueNumber"
                        }, {
                            headerName: "상태",
                            field: "status"
                        },];
                        licensegridOptions = {
                            columnDefs: columnDefs,
                            rowData: updatedEmpBean.emptyLicenseInfoBean,
                            defaultColDef: {
                                editable: false,
                                width: 100
                            },
                            components: {
                                datePicker: getDatePicker(),
                                datePicker1: getDatePickerNumber()
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
                        $('#licenseInfoListGrid').children().remove();
                        var eGridDiv = document
                            .querySelector('#licenseInfoListGrid');
                        new agGrid.Grid(eGridDiv, licensegridOptions);
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

                    $("#add_work_btn").click(addListGridRow);
                    $("#add_career_btn").click(addListGridRow);
                    $("#add_education_btn").click(addListGridRow);
                    $("#add_license_btn").click(addListGridRow);
                    $("#add_family_btn").click(addListGridRow);

                    $("#del_work_btn").click(delListGridRow);
                    $("#del_career_btn").click(delListGridRow);
                    $("#del_education_btn").click(delListGridRow);
                    $("#del_license_btn").click(delListGridRow);
                    $("#del_family_btn").click(delListGridRow);

                    /* $("#deptName").click(function(){
                     getCode("CO-07","deptName");
                     });
                     $("#position").click(function(){
                     getCode("CO-04","position");
                     }); */
                    $("#gender").click(function () {
                        getCode("CO-01", "gender");
                    });
                    $("#lastSchool").click(function () {
                        getCode("CO-02", "lastSchool");
                    });

                    $("#birthdate").click(getDatePicker($("#birthdate")));

                    $("#btn_dept_del").click(function () { // 부서검색제버튼
                        var flag = confirm("선택한 사원을 정말 삭제하시겠습니까?");
                        if (flag)
                            removeEmpListD();
                    });

                    $("#btn_name_del").click(function () { // 이름삭제버튼
                        var flag = confirm("선택한 사원을 정말 삭제하시겠습니까?");
                        if (flag)
                            removeEmpListN();
                    });

                    showEmpListDeptGrid();
                    showEmpListNameGrid();
                    showWorkInfoListGrid();
                    showFamilyInfoListGrid();
                    showLicenseInfoListGrid();

                });

        /* 사진찾기 버튼 눌렀을 때 실행되는 함수 */
        function readURL(input) {
            $("#emp_img_empCode").val(updatedEmpBean.empCode);
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    // 이미지 Tag의 SRC속성에 읽어들인 File내용을 지정 (아래 코드에서 읽어들인 dataURL형식)
                    $("#profileImg").attr("src", e.target.result);
                }
                reader.readAsDataURL(input.files[0]); //File내용을 읽어 dataURL형식의 문자열로 저장
            }
        }

        /* 달력 띄우기 */
        $(function () {
            $("#birthdate").datepicker({
                changeMonth: true,
                changeYear: true,
                showOn: "button",
                buttonImage: "${pageContext.request.contextPath}/image/cal.png",
                buttonImageOnly: true,
                dateFormat: "yy/mm/dd",
                yearRange: "1900:2030",
            })
        });
    </script>

</head>
<body>
<!-- 왼쪽창 -->
<div id="tabs" class="twobox wow fadeInDown">
    <ul>
        <li><a href="#tabs-11">부서명 검색</a></li>
        <li><a href="#tabs-1">사원명 검색</a></li>
    </ul>
    <!-- 부서명검색 탭 -->
    <div id="tabs-11">
        <select id="sel_dept">
            <option value="전체부서">전체부서</option>
            <option value="회계팀">회계팀</option>
            <option value="인사팀">인사팀</option>
            <option value="전산팀">전산팀</option>
            <option value="보안팀">보안팀</option>
        </select>
        <button id="btn_dept_search"
                class="ui-button ui-widget ui-corner-all">검색
        </button>
        <button id="btn_dept_del" class="ui-button ui-widget ui-corner-all">삭제</button>
        <br/> <br/>
        <div id="deptfindgrid" style="height: 250px;" class="ag-theme-balham"></div>
    </div>
    <!-- 사원명 검색탭 -->
    <div id="tabs-1">
        <input type="text" id="txt_name"
               class="ui-button ui-widget ui-corner-all">
        <button id="btn_name_search"
                class="ui-button ui-widget ui-corner-all">검색
        </button>
        <button id="btn_name_del" class="ui-button ui-widget ui-corner-all">삭제</button>
        <br/> <br/>
        <div id="namefindgrid" style="height: 250px;" class="ag-theme-balham"></div>
    </div>

</div>

<!-- 오른쪽 창 -->
<div id="tabs1" class="twobox wow fadeInDown">
    <ul>
        <li><a href="#tabs-0">기본 정보</a></li>
        <li><a href="#tabs-2">재직 정보</a></li>
        <li><a href="#tabs-6">가족 정보</a></li>
        <li><a href="#tabs-5">자격증 정보</a></li>
    </ul>
    <!-- 기본정보 -->
    <div id="tabs-0" align="left">
        <!-- 사진박스 -->
        <div id="divImg">
            <img id="profileImg"
                 src="${pageContext.request.contextPath}/profile/profile.png"
                 width="180px" height="200px"><br>
            <form id="emp_img_form"
                  action="${pageContext.request.contextPath }/foudinfomgmt/empImg.do"
                  enctype="multipart/form-data" method="post">
                <input type="hidden" name="empCode" id="emp_img_empCode"> <input
                    type="file" name="empImgFile" style="display: none;"
                    id="emp_img_file" onChange="readURL(this)">
                <button type="button" style="width: 150px"
                        class="ui-button ui-widget ui-corner-all" id="findPhoto">사진찾기
                </button>
                <br/>
            </form>
            <br/>
        </div>
        <!-- 상세정보박스1 -->
        <div id="divEmpInfo">
            <br/>
            <table>
                <colgroup>
                    <col width="30%">
                    <col width="70%">
                </colgroup>
                <tr>
                    <td><font>사원코드</font></td>
                    <td><input class="ui-button ui-widget ui-corner-all"
                               id="empCode" readonly></td>
                </tr>
                <tr>
                    <td><font>이름</font></td>
                    <td><input class="ui-button ui-widget ui-corner-all"
                               id="empName"></td>
                </tr>
                <tr>
                    <td><font>부서</font></td>
                    <td><input class="ui-button ui-widget ui-corner-all"
                               id="deptName"></td>
                </tr>
                <tr>
                    <td><font>직급</font></td>
                    <td><input class="ui-button ui-widget ui-corner-all"
                               id="position"></td>
                </tr>
            </table>
            <!-- <font style="font-size: 10px">전화번호 </font><br/>-->
            <br/>
            <!-- IMG_EXTEND -->
        </div>
        <hr>
        <!-- 선 -->
        <!-- 상제정보박스2 -->
        <div id="divEmpDinfo">
            <table>
                <colgroup>
                    <col width="30%">
                    <col width="70%">
                </colgroup>
                <tr>
                    <td><font>e-mail</font></td>
                    <td><input class="ui-button ui-widget ui-corner-all"
                               id="email"></td>
                </tr>
                <tr>
                    <td><font>휴대전화 </font></td>
                    <td><input class="ui-button ui-widget ui-corner-all"
                               id="mobileNumber"></td>
                </tr>
                <tr>
                    <td><font>생년월일</font></td>
                    <td><input class="ui-button ui-widget ui-corner-all"
                               id="birthdate" readonly></td>
                </tr>
                <tr>
                    <td><font>성별</font></td>
                    <td><input class="ui-button ui-widget ui-corner-all"
                               id="gender" readonly></td>
                </tr>
                <tr>
                    <td><font>최종학력</font></td>
                    <td><input class="ui-button ui-widget ui-corner-all"
                               id="lastSchool" readonly></td>
                </tr>
                <tr>
                    <td><font>주소</font></td>
                    <td><input
                            class="postcodify_address ui-button ui-widget ui-corner-all"
                            id="address" readonly></td>
                </tr>
                <tr>
                    <td><font>상세주소</font></td>
                    <td><input
                            class="postcodify_details ui-button ui-widget ui-corner-all"
                            id="detailAddress"></td>
                </tr>
                <tr>
                    <td><font>우편번호</font></td>
                    <td><input
                            class="postcodify_postcode5 ui-button ui-widget ui-corner-all"
                            id="postNumber" readonly></td>
                </tr>
            </table>
            <input type="hidden" id="imgExtend">
        </div>
    </div>
    <!-- 재직정보 -->
    <div class="grid-wrapper" id="tabs-2">
        <input type="button" id="add_work_btn"
               class="ui-button ui-widget ui-corner-all" value="추가"> <input
            type="button" id="del_work_btn"
            class="ui-button ui-widget ui-corner-all" value="수정"><br/>
        <br/>
        <div id="workInfoListGrid" style="height: 500px; width: 505px"
             class="ag-grid-div ag-theme-balham ag-basic"
             :defaultColDef="defaultColDef"></div>
    </div>

    <!-- 자격증정보 -->
    <div id="tabs-5">
        <input type="button" id="add_license_btn"
               class="ui-button ui-widget ui-corner-all" value="추가"> <input
            type="button" id="del_license_btn"
            class="ui-button ui-widget ui-corner-all" value="수정"><br/>
        <br/>
        <div id="licenseInfoListGrid" style="height: 500px; width: 505px"
             class="ag-theme-balham"></div>
    </div>

    <!-- 가족정보 -->
    <div id="tabs-6">
        <input type="button" id="add_family_btn"
               class="ui-button ui-widget ui-corner-all" value="추가"> <input
            type="button" id="del_family_btn"
            class="ui-button ui-widget ui-corner-all" value="수정"><br/>
        <br/>
        <div id="familyInfoListGrid" style="height: 500px; width: 505px"
             class="ag-theme-balham"></div>
    </div>

    <!-- 저장/취소버튼 -->
    <div class="btn_align">
        <input type="button" id="modifyEmp_Btn"
               class="ui-button ui-widget ui-corner-all" value="저장"> <input
            type="button" id="can_work_btn"
            class="ui-button ui-widget ui-corner-all" value="취소">
    </div>
</div>

</body>
</html>