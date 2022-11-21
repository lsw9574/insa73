<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>상용직급여계산</title>
    <style>

        /* 상단 우측 버튼 */
        .upperbuttons {
            background-color: #615265;
            border: none;
            color: white;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }

        /* 레이아웃 css */
        .container2 {
            display: grid;
            grid-template-columns: 33% 33% 33%;
            grid-template-rows: 80px 60px 401px 150px;
            gap: 0px 0px;
            grid-auto-flow: row;
            grid-template-areas:
    "Name buttons buttons"
    "date payday payday"
    "grid_div money_div tax_div"
    "textarea textarea textarea";
            width: 100%;
            height: 100%;
            color: white;
            background-color: #000000;
            background-color: rgba(30, 30, 30, 0.5);
            text-align: center;
        }

        .Name {
            grid-area: Name;
            padding: 10px;
        }

        .buttons {
            grid-area: buttons;
            padding: 15px;
        }

        .date {
            grid-area: date;
            padding: 15px;
        }

        .payday {
            grid-area: payday;
            padding: 15px;
        }

        .grid_div {
            display: grid;
            grid-template-columns: 1fr 1.3fr 0.7fr;
            grid-template-rows: 1fr 1fr 1fr;
            gap: 0px 0px;
            grid-auto-flow: row;
            grid-template-areas:
    "grid grid ."
    "grid grid ."
    "inwon inwon .";
            grid-area: grid_div;
        }

        .grid {
            grid-area: grid;
        }

        .inwon {
            grid-area: inwon;
        }

        .money_div {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            grid-template-rows: 1fr 1fr 1fr;
            gap: 0px 0px;
            grid-auto-flow: row;
            grid-area: money_div;
        }

        .grid2 {
            grid-area: grid2;
        }

        .tax_div {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            grid-template-rows: 1.5fr 0.5fr 1fr;
            gap: 0px 0px;
            grid-template-areas:
    "grid3 grid3 grid3"
    "grid3 grid3 grid3"
    "company company company";
            grid-area: tax_div;
        }

        .grid3 {
            grid-area: grid3;
        }

        .company {
            grid-area: company;
        }

        .textarea {
            grid-area: textarea;
        }

        /* 테이블 스타일 */
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            color: black;
            width: 100%;
        }

        .tg td {
            border-color: black;
            border-style: solid;
            border-width: 1px;
            font-family: Arial, sans-serif;
            font-size: 14px;
            overflow: hidden;
            padding: 2px 5px;
            word-break: normal;
        }

        .tg th {
            border-color: black;
            border-style: solid;
            border-width: 1px;
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            overflow: hidden;
            padding: 2px 5px;
            word-break: normal;
        }

        .tg .tg-el46 {
            background-color: #6665cd;
            border-color: #c0c0c0;
            color: #ffffff;
            text-align: center;
            vertical-align: top
        }

        .tg .tg-855q {
            background-color: #ffffff;
            border-color: #c0c0c0;
            text-align: left;
            vertical-align: top
        }

        .tg {
            border-collapse: collapse;
            border-spacing: 0;
        }

        .tg .tg-0inc {
            background-color: #6665cd;
            border-color: #c0c0c0;
            color: #ffffff;
            text-align: center;
            vertical-align: top
        }

        .tg .tg-855q {
            background-color: #ffffff;
            border-color: #c0c0c0;
            text-align: left;
            vertical-align: top
        }

        /* 하단 메뉴탭 스타일 */
        body {
            margin-top: 100px;
            font-family: 'Trebuchet MS', serif;
            line-height: 1.6
        }

        .container3 {
            color: #000000;
            width: 100%;
            margin: 0 auto;
        }

        ul.tabs {
            margin: 0px;
            padding: 0px;
            list-style: none;
        }

        ul.tabs li {
            background: #2c3135;
            color: #ffffff;
            display: inline-block;
            padding: 10px 15px;
            cursor: pointer;
        }

        ul.tabs li.current {
            background: #ededed;
            color: #222;
        }

        .tab-content {
            display: none;
            background: #ededed;
            padding: 15px;
        }

        .tab-content.current {
            display: inherit;
        }

        /* 하단 텍스트박스들의 스타일 */
        .css-input {
            padding: 2px;
            font-size: 15px;
            text-align: right;
            border-width: 1px;
            border-color: #147e80;
            background-color: #e7feff;
            color: #000000;
            border-style: solid;
            border-radius: 0px;
        }

        .css-input:focus {
            outline: none;
        }
    </style>

    <script>
        var FullTimeSalaryList = [];
        var yearSalary = [];
        var monthSalaryGridData = [];
        var EmpListGridOptions = {};
        var EmpList;
        var year;
        var month;

        $(document).ready(function () {
            findEmpInfo();

            //input:text에 버튼 형식의 css 씌움
            $("input:text").button().css({width: "150px", height: "30px"});

            var year = 2020;
            for (var y = 2020; y <= 2022; y++)
                $("#searchYear1").append($("<option />").val(y).text(y + " "));

            // 귀속연월 셀렉터
            for (var i = 1; i <= 12; i++)
                $("#searchYearMonth").append($("<option />").val(i).text(i + " "));


            // 월급여 조회하기 버튼
            $("#Search_Btn").click(plusAllmoney);
            $("#Search_Btn").click(searchTotalData);

            // 마감 버튼
            $("#finalize_Btn").click(finalizeFullTimeSalary);

            // 마감취소 버튼
            $("#cancel_Btn").click(cancelFullTimeSalary);

            $('ul.tabs li').click(function () {
                var tab_id = $(this).attr('data-tab');

                $('ul.tabs li').removeClass('current');
                $('.tab-content').removeClass('current');

                $(this).addClass('current');
                $("#" + tab_id).addClass('current');
            })

            $("#payment_date").click(function () { //휴가조회 - 구분
                getCode();
            })

        });

        /* 숫자 3자리마다 콤마를 찍는 정규표현식 */
        function numberWithCommas(won) {
            return won.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        function findEmpInfo() { //실행하자마자 사원들의 데이터를 가져옴
            $.ajax({
                url: '${pageContext.request.contextPath}/empinfomgmt/emplist',
                data: {
                    "value": "전체부서"
                    //전체부서/회계팀/인사팀/전산팀
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
                    empInfoList = data.list;
                    console.log(empInfoList);
                    showEmpListGrid();

                    /* 사람숫자 구하기 */
                    humanSu.innerHTML = empInfoList.length;
                    /* 텍스트박스안에 변수값을 지정하기 */
                    document.getElementById("t2Inwon").value = empInfoList.length + "명";
                }
            });
        }

        function showEmpListGrid() { // 가져온 사원들의 데이터를 그리드에 출력함
            var columnDefs = [{headerName: "사원코드", field: "empCode", checkboxSelection: true},
                {headerName: "사원명", field: "empName"},
                /*
                        headerName : 그리드 헤더에 보여주는 타이틀
                        field : json data에 선언이 되어 있는 field와 바인딩된다.
                        checkboxSelection : 체크박스 기능 추가
                    */
            ];
            EmpListGridOptions = {
                columnDefs: columnDefs, //  정의된 칼럼 정보를 넣어준다.
                rowData: empInfoList, // 그리드 데이터, json data를 넣어준다.
                defaultColDef: {editable: false, width: 100}, // 공통 기본 정의
                rowSelection: 'single', //  'single' or 'multiple', row data를 선택하는 경우의 옵션으로 하나만 선택하거나 복수개를 선택할 수 있다.
                enableColResize: true, // 칼럼 리사이즈 허용 여부
                enableSorting: true, // 정렬 옵션 허용 여부
                enableFilter: true, // 필터 옵션 허용 여부
                enableRangeSelection: true, // 정렬 기능 강제여부, true인 경우 정렬이 고정이 된다.
                suppressRowClickSelection: false, // 선택 허용 여부
                animateRows: true, //
                suppressHorizontalScroll: true, // 가로 스크롤 허용 여부, 자동 조정으로 되어 있으면 불필요.
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
            var eGridDiv = document.querySelector('#empSelect_grid');
            new agGrid.Grid(eGridDiv, EmpListGridOptions); // 그리드 생성, 가져온 자료 그리드에 뿌리기
        }

        /* 총액 더하는 함수. */
        function plusAllmoney() {
            year = $("#searchYear1").val();
            month = $("#searchYearMonth").val();
            var apply_year_month = year + "-" + month
            console.log("plusAllmoney 실행함???");
            console.log(apply_year_month);

            $.ajax({
                url: '${pageContext.request.contextPath}/salaryinfomgmt/salary',
                data: {
                    "applyYearMonth": apply_year_month
                },
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        var str = "내부 서버 오류가 발생했습니다\n";
                        str += "관리자에게 문의하세요\n";
                        str += "에러 위치 : " + $(this).attr("id");
                        str += "에러 메시지 : " + data.errorMsg;
                        alert(str);
                        return;
                    } else {
                        AllMoneyList = data.AllMoneyList;
                        console.log("올머니리스트");
                        console.log(AllMoneyList);

                        /* 두번째 탭의 텍스트박스 내용들 */
                        /* 과세 구하기 */
                        var moneyTotalList = new Array();
                        for (var i = 0; i < AllMoneyList.length; i++) {
                            moneyTotalList[i] =
                                Number(AllMoneyList[i].basicSalary) +
                                Number(AllMoneyList[i].positionSalary) +
                                Number(AllMoneyList[i].familySalary) +
                                Number(AllMoneyList[i].foodSalary) +
                                Number(AllMoneyList[i].overWorkSalary);
                            moneyTotalList.push(moneyTotalList[i]);
                        }
                        moneyTotalList.pop();
                        var TotalamountofTax = 0;
                        moneyTotalList.forEach(function (el) {
                            TotalamountofTax += el;
                        });

                        /* 국민연금총액 */
                        var nationalPensionTotal = 0;
                        for (var i = 0; i < AllMoneyList.length; i++) {
                            nationalPensionTotal += Number(AllMoneyList[i].nationalPension);
                        }
                        nationalPensionTotal = numberWithCommas(nationalPensionTotal) + "원";
                        document.getElementById('tab2np').value = nationalPensionTotal;

                        /* 소득세총액 */
                        var incomeTaxTotal = 0;
                        for (var i = 0; i < AllMoneyList.length; i++) {
                            incomeTaxTotal += Number(AllMoneyList[i].incomeTax);
                        }
                        incomeTaxTotal = numberWithCommas(incomeTaxTotal) + "원";
                        document.getElementById('tab2it').value = incomeTaxTotal;

                        /* 과세 */
                        TotalamountofTax = numberWithCommas(TotalamountofTax) + "원";
                        document.getElementById('tab2tax').value = TotalamountofTax;

                        /* 지정기부금 */
                        var religionDonationTotal = 0;
                        for (var i = 0; i < AllMoneyList.length; i++) {
                            religionDonationTotal += Number(AllMoneyList[i].religionDonation);
                        }
                        religionDonationTotal = numberWithCommas(religionDonationTotal) + "원";
                        document.getElementById('tab2rd').value = religionDonationTotal;

                        /* 고용보험총액 */
                        var employmentInsuranceTotal = 0;
                        for (var i = 0; i < AllMoneyList.length; i++) {
                            employmentInsuranceTotal += Number(AllMoneyList[i].employmentInsurance);
                        }
                        var beforeEmploymentInsuranceTotal = employmentInsuranceTotal;
                        employmentInsuranceTotal = numberWithCommas(employmentInsuranceTotal) + "원";
                        document.getElementById('tab2ei').value = employmentInsuranceTotal;

                        /* 지방소득세총액 */
                        beforeEmploymentInsuranceTotal = beforeEmploymentInsuranceTotal / 10;
                        beforeEmploymentInsuranceTotal = numberWithCommas(beforeEmploymentInsuranceTotal) + "원";
                        document.getElementById('tab2it2').value = beforeEmploymentInsuranceTotal;

                        /* 회사부담금 계산 */
                        var moneyTotalList2 = new Array();
                        for (var i = 0; i < AllMoneyList.length; i++) {
                            moneyTotalList2[i] =
                                Number(AllMoneyList[i].healthInsurance) +
                                Number(AllMoneyList[i].longTermInsurance) +
                                Number(AllMoneyList[i].employmentInsurance);
                            moneyTotalList2.push(moneyTotalList2[i]);
                        }
                        moneyTotalList2.pop();
                        var TotalamountofBC = 0;
                        moneyTotalList2.forEach(function (el) {
                            TotalamountofBC += el;
                        });

                        TotalamountofBC = numberWithCommas(TotalamountofBC) + "원";
                        document.getElementById('tab2bc').value = TotalamountofBC;


                        /* 건강보험총액 */
                        var healthInsuranceTotal = 0;
                        for (var i = 0; i < AllMoneyList.length; i++) {
                            healthInsuranceTotal += Number(AllMoneyList[i].healthInsurance);
                        }
                        var health10 = numberWithCommas(Math.floor(healthInsuranceTotal / 9.73)) + "원";
                        healthInsuranceTotal = numberWithCommas(healthInsuranceTotal) + "원";
                        document.getElementById('tab2hi').value = healthInsuranceTotal;
                        document.getElementById('tab2hi2').value = health10;
                    }
                }
            });

        }


        /* 조회하기 버튼 누르면 실행할것 */
        function searchTotalData() {
            EmpList = EmpListGridOptions.api.getSelectedRows(); //선택한 그리드 열의 데이터

            console.log("어떤 사원을 선택했나요?");
            console.log(EmpList);
            year = $("#searchYear1").val();
            month = $("#searchYearMonth").val();

            var apply_year_month = year + "-" + month
            console.log(apply_year_month);

            if (EmpList.length == 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'ㄴ(ʘᗩʘ’)ㄱ',
                    text: '조회할 사원을 선택해주세요'
                });
                return;
            }
            empCode = EmpList[0].empCode;

            console.log("우리가 cstmt까지 갈거야!!");
            console.log(apply_year_month);
            console.log(empCode);
            $.ajax({
                url: '${pageContext.request.contextPath}/salaryinfomgmt/salary/empcode',
                data: {
                    "empCode": empCode,
                    "applyYearMonth": apply_year_month
                },
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        var str = "내부 서버 오류가 발생했습니다\n";
                        str += "관리자에게 문의하세요\n";
                        str += "에러 위치 : " + $(this).attr("id");
                        str += "에러 메시지 : " + data.errorMsg;
                        alert(str);
                        return;
                    } else if (data.FullTimeSalaryList == null) {
                        alert("해당 조회년월에 해당하는 사원의 급여정보가 존재하지 않습니다!");
                    } else {
                        FullTimeSalaryList = data.FullTimeSalaryList;

                        /* 사원의 마감상태 확인창. 회원별로 마감을 체크할 수 있음!*/
                        document.getElementById('finalize').innerHTML = FullTimeSalaryList[0].finalizeStatus;

                        var moneytotal =
                            Number(FullTimeSalaryList[0].basicSalary) +
                            Number(FullTimeSalaryList[0].positionSalary) +
                            Number(FullTimeSalaryList[0].familySalary) +
                            Number(FullTimeSalaryList[0].foodSalary) +
                            Number(FullTimeSalaryList[0].overWorkSalary);

                        var taxtotal =
                            Number(FullTimeSalaryList[0].nationalPension) +
                            Number(FullTimeSalaryList[0].healthInsurance) +
                            Number(FullTimeSalaryList[0].longTermInsurance) +
                            Number(FullTimeSalaryList[0].employmentInsurance) +
                            Number(FullTimeSalaryList[0].incomeTax) +
                            Number(FullTimeSalaryList[0].residentTax);

                        var businessChargetotal =
                            Number(FullTimeSalaryList[0].healthInsurance) +
                            Number(FullTimeSalaryList[0].longTermInsurance) +
                            Number(FullTimeSalaryList[0].employmentInsurance);


                        /* 첫번째 탭의 텍스트박스 내용들 */
                        /* 급여형태 구하기 */
                        console.log(FullTimeSalaryList);
                        var TotalamountofyearMoney = FullTimeSalaryList[0].basicSalBefore;
                        console.log(TotalamountofyearMoney);
                        /* 액수 3자리마다 콤마를 찍는 정규표현식을 실행시킴 */
                        document.getElementById('t1st').value = "월급"; //"[연봉]" + numberWithCommas(TotalamountofyearMoney * 12) + "원";

                        /* 과세총액 */
                        document.getElementById('t1tt').value = numberWithCommas(moneytotal) + "원";

                        /* 부서 */
                        document.getElementById('t1dept').value = EmpList[0].deptName;

                        /* 입사일자 */
                        document.getElementById('t1hd').value = EmpList[0].hiredate/* .replaceAll("-","/").substring(0,10) */;

                        /* 회사부담금 */
                        document.getElementById('t1bc').value = numberWithCommas(businessChargetotal) + "원";

                        /* 직종 */
                        document.getElementById('t1job').value = EmpList[0].occupation;

                        /* 차인지급액 */
                        document.getElementById('t1as').value = numberWithCommas(Math.floor((moneytotal - taxtotal) / 10) * 10) + "원";

                        /* 액수 3자리마다 콤마를 찍는 정규표현식을 실행시킴 */
                        money_total.innerHTML = numberWithCommas(moneytotal) + "원";
                        tax_total.innerHTML = numberWithCommas(taxtotal) + "원";
                        $('#plus_total').val(numberWithCommas(moneytotal - taxtotal) + "원");

                        /* 액수 3자리마다 콤마를 찍는 정규표현식을 실행시킴 */
                        $.each(FullTimeSalaryList, function (i, elt) {
                            FullTimeSalaryList[i].basicSalary = numberWithCommas(FullTimeSalaryList[i].basicSalary) + "원";
                            FullTimeSalaryList[i].basicSalBefore = numberWithCommas(FullTimeSalaryList[i].basicSalBefore) + "원";
                            FullTimeSalaryList[i].positionSalary = numberWithCommas(FullTimeSalaryList[i].positionSalary) + "원";
                            FullTimeSalaryList[i].familySalary = numberWithCommas(FullTimeSalaryList[i].familySalary) + "원";
                            FullTimeSalaryList[i].foodSalary = numberWithCommas(FullTimeSalaryList[i].foodSalary) + "원";
                            FullTimeSalaryList[i].overWorkSalary = numberWithCommas(FullTimeSalaryList[i].overWorkSalary) + "원";
                            FullTimeSalaryList[i].nationalPension = numberWithCommas(FullTimeSalaryList[i].nationalPension) + "원";
                            FullTimeSalaryList[i].healthInsurance = numberWithCommas(FullTimeSalaryList[i].healthInsurance) + "원";
                            FullTimeSalaryList[i].longTermInsurance = numberWithCommas(FullTimeSalaryList[i].longTermInsurance) + "원";
                            FullTimeSalaryList[i].employmentInsurance = numberWithCommas(FullTimeSalaryList[i].employmentInsurance) + "원";
                            FullTimeSalaryList[i].religionDonation = numberWithCommas(FullTimeSalaryList[i].religionDonation) + "원";
                            FullTimeSalaryList[i].incomeTax = numberWithCommas(FullTimeSalaryList[i].incomeTax) + "원";
                            FullTimeSalaryList[i].residentTax = numberWithCommas(FullTimeSalaryList[i].residentTax) + "원";
                            businessChargetotal = numberWithCommas(businessChargetotal) + "원";
                        });


                        function showMoneyData() {
                            money1.innerHTML = FullTimeSalaryList[0].basicSalary;
                            money2.innerHTML = FullTimeSalaryList[0].positionSalary;
                            money3.innerHTML = FullTimeSalaryList[0].familySalary;
                            money4.innerHTML = FullTimeSalaryList[0].foodSalary;
                            money5.innerHTML = FullTimeSalaryList[0].overWorkSalary;
                        }

                        function showTaxData() {
                            tax1.innerHTML = FullTimeSalaryList[0].nationalPension;
                            tax2.innerHTML = FullTimeSalaryList[0].healthInsurance;
                            tax3.innerHTML = FullTimeSalaryList[0].longTermInsurance;
                            tax4.innerHTML = FullTimeSalaryList[0].employmentInsurance;
                            tax5.innerHTML = FullTimeSalaryList[0].religionDonation;
                            tax6.innerHTML = FullTimeSalaryList[0].incomeTax;
                            tax7.innerHTML = FullTimeSalaryList[0].residentTax;
                            bc.innerHTML = businessChargetotal;
                            companybudam_total.innerHTML = businessChargetotal;
                        }

                        if (finalize.innerHTML == "Y") {
                            alert("마감처리를 완료하면 수정된 급여정보를 조회하지 않습니다!");
                        }

                        showMoneyData();
                        showTaxData();

                    }
                }
            });
        }


        /* 마감처리 함수 */
        function finalizeFullTimeSalary() {

            console.log("그리드가 선택한 사원의 정보");
            console.log(EmpList);
            if (FullTimeSalaryList.length == 0) {
                alert("마감정보를 확인하기 위해서는 사원정보를 먼저 조회하셔야 합니다");
            }

            FullTimeSalaryList[0].finalizeStatus = "Y";
            FullTimeSalaryList[0].empCode = empCode;
            FullTimeSalaryList[0].applyYearMonth = $("#searchYear1").val() + "-" + $("#searchYearMonth").val();
            var sendData = JSON.stringify(FullTimeSalaryList);
            console.log(sendData);

            $.ajax({
                type: "PUT",
                url: "${pageContext.request.contextPath}/salaryinfomgmt/salary",
                data : sendData,
                contentType:"application/json",
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: '마감이 실패하였습니다',
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
                            text: '마감이 성공적으로 처리 되었습니다 !',
                            confirmButtonText: '확인'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                location.reload();
                            }
                        })
                    }
                }
            });
        }

        /* 마감취소 처리 함수 */
        function cancelFullTimeSalary() {
            console.log("그리드가 선택한 사원의 정보");
            console.log(EmpList);
            if (FullTimeSalaryList.length == 0) {
                alert("마감정보를 확인하기 위해서는 사원정보를 먼저 조회하셔야 합니다");
            }

            FullTimeSalaryList[0].finalizeStatus = "N";
            FullTimeSalaryList[0].empCode = empCode;
            FullTimeSalaryList[0].applyYearMonth = $("#searchYear1").val() + "-" + $("#searchYearMonth").val();
            var sendData = JSON.stringify(FullTimeSalaryList);
            console.log(sendData);

            $.ajax({
                type: "PUT",
                url: "${pageContext.request.contextPath}/salaryinfomgmt/salary",
                data : sendData,
                contentType:"application/json",
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: '마감 취소가 실패하였습니다',
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
                            text: '마감이 성공적으로 취소 되었습니다',
                            confirmButtonText: '확인'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                location.reload();
                            }
                        })
                    }
                }
            });
        }

        /* 코드선택 창 띄우기 */
        function getCode() {
            PopW = window.open("${pageContext.request.contextPath}/comm/agWindow/view", "payment_date", "width=400,height=400,top=10,left=20,resizable=no,scrollbars=yes,menubar=yes,toolbar=no,status=yes,location=yes")
        }

        // style="margin: auto"
    </script>
</head>
<body>
<div class="container2 wow fadeInDown">

    <div class="Name" style="border: 1px solid grey;">
        <span style="font-weight:700; font-size:35px; font-style: normal;">&#9745;</span>
        <span style=" font-weight: bold; font-size: 2.0em; line-height: 1.0em; color: white ;font-family: arial;">직원급여 계산</span>
    </div>

    <div class="buttons" style="border: 1px solid grey; position: relative;">
        <input type="button" class="upperbuttons" id="Search_Btn" value="조회하기"/>&emsp;
        <input type="button" class="upperbuttons" id="finalize_Btn" value="마감"/>&emsp;
        <input type="button" class="upperbuttons" id="cancel_Btn" value="마감취소"/>
        <div style="border:1px solid grey; padding:10px; position: absolute; right:0px; bottom:0px;">마감상태 : <span
                id="finalize">&nbsp;-&nbsp;</span></div>
    </div>

    <div class="date" style="border: 1px solid grey;">
        귀속연월 <select id="searchYear1"></select> 년 <select id="searchYearMonth"></select> 월
    </div>
    <div class="payday" style="border: 1px solid grey;">
        지급일 <input type="text" id="payment_ord" readonly/> <input type="button" value=&#128270 id="payment_date"> <input
            type="text" value="" id="payment_value" readonly/>
    </div>


    <div class="grid_div" style="border: 1px solid grey; ">

        <div class="grid">
            <div id="empSelect_grid" class="ag-theme-balham" style="width:100%; height:100%;"></div>
        </div>

        <div class="inwon" style="position: relative;">
            <div style="border:1px solid grey; padding:10px; position: absolute; bottom:0px;">총 인원 : <span id="humanSu">0</span>
                명
            </div>
        </div>


    </div>
    <div class="money_div" style="border: 1px solid grey; position: relative;">
        <table class="tg" style="position: absolute;">
            <thead>
            <tr>
                <th class="tg-el46">지급항목</th>
                <th class="tg-el46">금액</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="tg-855q">기본급</td>
                <td class="tg-855q"><span id="money1"></span></td>
            </tr>
            <tr>
                <td class="tg-855q">직책수당</td>
                <td class="tg-855q"><span id="money2"></span></td>
            </tr>
            <tr>
                <td class="tg-855q">가족수당</td>
                <td class="tg-855q"><span id="money3"></span></td>
            </tr>
            <tr>
                <td class="tg-855q">식대</td>
                <td class="tg-855q"><span id="money4"></span></td>
            </tr>
            <tr>
                <td class="tg-855q">초과근무수당</td>
                <td class="tg-855q"><span id="money5"></span></td>
            </tr>
            </tbody>
        </table>
        <div style="border:1px solid grey; padding:10px; position: absolute; bottom:0px;">
            지급총액 : <span id="money_total">0</span>
        </div>
    </div>
    <div class="tax_div" style="border: 1px solid grey;">
        <div class="grid3" style="border: 1px solid grey; position: relative;">
            <table class="tg" style="position: absolute;">
                <thead>
                <tr>
                    <th class="tg-0inc">공제항목</th>
                    <th class="tg-0inc">금액</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="tg-855q">국민연금</td>
                    <td class="tg-855q"><span id="tax1"></span></td>
                </tr>
                <tr>
                    <td class="tg-855q">건강보험</td>
                    <td class="tg-855q"><span id="tax2"></span></td>
                </tr>
                <tr>
                    <td class="tg-855q">장기요양보험료</td>
                    <td class="tg-855q"><span id="tax3"></span></td>
                </tr>
                <tr>
                    <td class="tg-855q">고용보험</td>
                    <td class="tg-855q"><span id="tax4"></span></td>
                </tr>
                <tr>
                    <td class="tg-855q">기부금</td>
                    <td class="tg-855q"><span id="tax5"></span></td>
                </tr>
                <tr>
                    <td class="tg-855q">소득세</td>
                    <td class="tg-855q"><span id="tax6"></span></td>
                </tr>
                <tr>
                    <td class="tg-855q">주민세</td>
                    <td class="tg-855q"><span id="tax7"></span></td>
                </tr>
                </tbody>
            </table>
            <div style="border:1px solid grey; padding:10px; position: absolute; bottom:0px;">공제총액 : <span
                    id="tax_total">0</span></div>
        </div>
        <div class="company" style="border: 1px solid grey; position: relative;">
            <table class="tg" style="position: absolute;">
                <thead>
                <tr>
                    <th class="tg-0inc">회사부담금 항목</th>
                    <th class="tg-0inc">금액</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="tg-855q">사회보험 사업자 부담금</td>
                    <td class="tg-855q"><span id="bc"></span></td>
                </tr>
                </tbody>
            </table>
            <div style="border:1px solid grey; padding:10px; position: absolute; bottom:0px;">회사부담금 총액 : <span
                    id="companybudam_total"></span></div>
        </div>
    </div>
    <div class="textarea" style="border: 1px solid grey;">

        <div class="container3">
            <ul class="tabs">
                <li class="tab-link current" data-tab="tab-1">개인정보</li>
                <li class="tab-link" data-tab="tab-2">과세총액</li>
            </ul>

            <div id="tab-1" class="tab-content current">
                사업장 &nbsp;&nbsp;<input type="text" class="css-input"/>&emsp;&emsp; 급여형태 &nbsp;&nbsp;<input type="text"
                                                                                                           class="css-input"
                                                                                                           id="t1st"
                                                                                                           readonly/>&emsp;&emsp;
                과세총액 &nbsp;&nbsp;<input type="text" class="css-input" id="t1tt"/>&emsp;&emsp; 소득제외 &nbsp;&nbsp;<input
                    type="text" class="css-input"/> <br/><br/>
                &emsp; 부서 &nbsp;&nbsp;<input type="text" class="css-input" id="t1dept"/>&emsp;&emsp; 입사일자
                &nbsp;&nbsp;<input type="text" class="css-input" id="t1hd"/>&emsp;&emsp; 비과세신고분 &nbsp;&nbsp;<input
                    type="text" class="css-input" value="0"/>&emsp;&emsp; 회사부담금 &nbsp;&nbsp;<input type="text"
                                                                                                   class="css-input"
                                                                                                   id="t1bc"/>
                <br/><br/>
                &emsp;&emsp;&emsp; 직종 &nbsp;&nbsp;<input type="text" class="css-input" id="t1job"/>&emsp;&emsp; 퇴사일자
                &nbsp;&nbsp;<input type="text" class="css-input"/>&emsp;&emsp; 비과세신고제외분 &nbsp;&nbsp;<input type="text"
                                                                                                           class="css-input"
                                                                                                           value="0"/>&emsp;&emsp;
                차인지급액 &nbsp;&nbsp;<input type="text" class="css-input" id="t1as"/>

            </div>
            <div id="tab-2" class="tab-content">
                총인원 &nbsp;&nbsp;<input type="text" class="css-input" id="t2Inwon" readonly/>&emsp;&emsp; 사학연금 &nbsp;&nbsp;<input
                    type="text" class="css-input" readonly/>&emsp;&emsp; 국민연금 &nbsp;&nbsp;<input type="text"
                                                                                                 class="css-input"
                                                                                                 id="tab2np" readonly/>&emsp;&emsp;
                소득세 &nbsp;&nbsp;<input type="text" class="css-input" id="tab2it" readonly/> / &nbsp;&nbsp;<input
                    type="text" class="css-input" readonly/><br/><br/>
                &emsp; 과세 &nbsp;&nbsp;<input type="text" class="css-input" id="tab2tax" readonly/>&emsp;&emsp; 지정기부금
                &nbsp;&nbsp;<input type="text" class="css-input" id="tab2rd" readonly/>&emsp;&emsp; 고용보험
                &nbsp;&nbsp;<input type="text" class="css-input" id="tab2ei" readonly/>&emsp;&emsp; 지방소득세
                &nbsp;&nbsp;<input type="text" class="css-input" id="tab2it2" readonly/> / &nbsp;&nbsp;<input
                    type="text" class="css-input" readonly/><br/><br/>
                비과세 &nbsp;&nbsp;<input type="text" class="css-input" value="0" readonly/>&emsp;&emsp; 회사부담금 &nbsp;&nbsp;<input
                    type="text" class="css-input" id="tab2bc" readonly/>&emsp;&emsp; 농특세 &nbsp;&nbsp;<input type="text"
                                                                                                            class="css-input"
                                                                                                            readonly/>&emsp;&emsp;
                건강보험 &nbsp;&nbsp;<input type="text" class="css-input" id="tab2hi" readonly/> / &nbsp;&nbsp;<input
                    type="text" id="tab2hi2" class="css-input" readonly/>
            </div>
        </div>
    </div>

</div>
</body>
</html>