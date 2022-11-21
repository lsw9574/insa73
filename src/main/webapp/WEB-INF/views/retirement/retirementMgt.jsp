<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
    <style>
        #tabs {
            color: #eee;
            background-color: rgba(051, 051, 051, 0.8);
        }
    </style>

    <script>
        let updateContents = [];

        $(document).ready(function () {
            $.ajax({
                url: "${pageContext.request.contextPath}/retirementmgmt/retirementmgmt",
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        alert(data.errorMsg);
                        return;
                    }

                    console.log(data);
                    let retirementMgmt = data.retirementMgmt[0];
                    $("#moel_check").val(retirementMgmt.moelCheck);
                    $("#moel_check_code").val(retirementMgmt.moelCheckCode);
                    $("#retirement_range").val(retirementMgmt.retirementRange);
                    $("#retirement_range_code").val(retirementMgmt.retirementRangeCode);
                    $("#month_or_day").val(retirementMgmt.monthOrDay);
                    $("#month_or_day_code").val(retirementMgmt.monthOrDayCode);
                    $("#retireday_check").val(retirementMgmt.retiredayCheck);
                    $("#retireday_check_code").val(retirementMgmt.retiredayCheckCode);
                }
            });
            $("#moel_check").click(
                function () {
                    getCode("CO-23", "moel_check", "moel_check_code");
                });
            $("#retirement_range").click(
                function () {
                    getCode("CO-24", "retirement_range", "retirement_range_code");
                });
            $("#month_or_day").click(
                function () {
                    getCode("CO-25", "month_or_day", "month_or_day_code");
                });
            $("#retireday_check").click(
                function () {
                    getCode("CO-23", "retireday_check", "retireday_check_code");
                });


            $("#retirement_mgmt_save_btn").click(severancepay);
        });

        function getCode(code, inputText, inputCode) {
            let option = "width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
            window.open(
                "${pageContext.request.contextPath}/comm/codeWindow/view?code="
                + code + "&inputText=" + inputText + "&inputCode="
                + inputCode, "newwins", option);
        }

        function severancepay() {

            let moel_check_code=$("#moel_check_code").val();
            let retirement_range_code = $("#retirement_range_code").val();
            let month_or_day_code = $("#month_or_day_code").val();
            let retireday_check_code = $("#retireday_check_code").val();
            if (moel_check_code == 'CHK000') {
                retirement_range_code = 'RAG001';
                month_or_day_code = 'MDC000';
                retireday_check_code = 'CHK001';
            }
            let sendData = {
                "moelCheckCode": moel_check_code,
                "retirementRangeCode": retirement_range_code,
                "monthOrDayCode": month_or_day_code,
                "retiredayCheckCode": retireday_check_code
            };
            $.ajax({
                type: "PUT",
                url: "${pageContext.request.contextPath}/retirementmgmt/retirementmgmt",
                data: JSON.stringify(sendData),
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.errorCode < 0) {
                        alert(data.errorMsg);
                        return;
                    }
                    location.reload();
                }
            });

        }

    </script>
</head>
<body>
<section id="tabs" class="wow fadeInDown"
         style="height:550px; text-align: center;">

    <br> <br> <br>
    <h4>퇴직금 설정</h4>
    <br> <br>
    <table style="margin: auto;width:500px;">
        <tr>
            <td>고용노동부기준</td>
            <td><input type="text" class="ui-button ui-widget ui-corner-all" id="moel_check" readonly>
                <input type="hidden" id="moel_check_code">
            </td>
        </tr>
        <tr>
            <td>퇴직범위설정</td>
            <td><input type="text" id="retirement_range" class="ui-button ui-widget ui-corner-all" readonly>
                <input type="hidden" id="retirement_range_code">
            </td>
        </tr>

        <tr>
            <td>급여계산방식</td>
            <td><input type="text" class="ui-button ui-widget ui-corner-all" id="month_or_day" readonly>
                <input type="hidden" id="month_or_day_code">
            </td>
        </tr>
        <tr>
            <td>퇴사일포함여부</td>
            <td><input class="ui-button ui-widget ui-corner-all" type="text" id="retireday_check" readonly>
                <input type="hidden" id="retireday_check_code">
            </td>

        </tr>

    </table>
    <hr>
    <div>
        <br> <input type="button" class="ui-button ui-widget ui-corner-all" id="retirement_mgmt_save_btn"
                    value="퇴직금 설정 저장">
    </div>

</section>
</body>
</html>