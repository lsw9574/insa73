<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>이력서 신청</title>
    <style type="text/css">
        body {
            background-color: black;
            color: white;
            text-align: center;
        }

        .header {
            width: 100%;
            height: 50px;
            font-size: 30px;
        }

        .center_table {
            width: 100%;
            text-align: center;
        }

        .tbl {
            display: inline-block;
        }

        input[type="text"], input[type="number"] {
            height: 32px;
            width: 300px;
            border: 0;
            border-radius: 5px;
            outline: none;
            padding-left: 10px;
            background-color: rgb(233, 233, 233);
        }

        td {
            text-align: center;
        }

        .jbtn {
            width: 80px;
            height: 30px;
            background-color: white;
            border: none;
            color: black;
            text-align: center;
            text-decoration: none;
            -webkit-transition-duration: 0.4s;
            transition-duration: 0.4s;
            cursor: pointer;
            border: 1px black solid;
            border-radius: 5px;
        }

        .jbtn:hover {
            background-color: black;
            color: white;
            border-radius: 5px;
        }

        select {
            display: block;
            width: 310px;
            height: 33px;
            border: 0;
            border-radius: 5px;
            outline: none;
        }
    </style>
    <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"
    ></script>
    <script type="text/javascript">
        let bean = {};
        let yearhalf = {};
        const date = new Date();
        $(document).ready(function () {
            $("#code_produce").click(produceCode);
            $("#Reg_btn").click(RegisterBtnF);
            $("#cancel_btn").click(cancelBtnF);
            console.log(date, "date");

        })

        function saveInfo() {
			bean.workplace = $("#workplace").val();
            bean.year = $("#year").val();
            bean.half = $("#half").val();
            bean.p_code = $("#p_code").val();
            bean.p_name = $("#p_name").val();
            bean.p_age = $("#p_age").val();
            bean.p_gender = $("#p_gender").val();
            bean.p_address = $("#p_address").val();
            bean.p_tel = $("#p_tel").val();
            bean.p_email = $("#p_email").val();
            bean.p_dept = $("#p_dept").val();
            bean.p_last_school = $("#p_last_school").val();
            bean.p_career = $("#p_career").val();

            bean.p_code = $("#p_code").val();
            bean.p_challenge = $("#p_challenge").val();
            bean.p_creativity = $("#p_creativity").val();
            bean.p_passion = $("#p_passion").val();
            bean.p_cooperation = $("#p_cooperation").val();
            bean.p_globalmind = $("#p_globalmind").val();

            bean.i_attitude = $("#i_attitude").val();
            bean.i_scrupulosity = $("#i_scrupulosity").val();
            bean.i_reliability = $("#i_reliability").val();
            bean.i_creativity = $("#i_creativity").val();
            bean.i_positiveness = $("#i_positiveness").val();
        }

        function applyCodeSaveInfo() {
            const half = $("#half").val();
            if (half === '상반기')
                yearhalf.half = '1';
            else
                yearhalf.half = '2';
            yearhalf.year = $("#year").val();
            console.log(yearhalf.half, yearhalf.year);
        }

        function produceCode() {
            applyCodeSaveInfo();
            const sendData = JSON.stringify(yearhalf);
            $.ajax({
                type: "GET",
                url: '${pageContext.request.contextPath}/newempinfomgmt/newCode',
                dataType: "json",
                data:
                    {"sendData": sendData},
                success: function (data) {
                    if (data.errorCode < 0) {
                        let str = "내부 서버 오류가 발생했습니다\n";
                        str += "관리자에게 문의하세요\n";
                        str += "에러 위치 : " + $(this).attr("id");
                        str += "에러 메시지 : " + data.errorMsg;
                        alert(str);
                        return;
                    }
                    $("#p_code").val(data.newcode);
                }
            });
        }

        function RegisterBtnF() {
            saveInfo();
            var sendData = JSON.stringify(bean);
            $.ajax({
                type: "PUT",
                url: '${pageContext.request.contextPath}/newempinfomgmt/newapplicationreg',
                dataType: "json",
                data: {"sendData": sendData},
                success: function (data) {
                    if (data.errorCode < 0) {
                        let str = "내부 서버 오류가 발생했습니다\n";
                        str += "관리자에게 문의하세요\n";
                        str += "에러 위치 : " + $(this).attr("id");
                        str += "에러 메시지 : " + data.errorMsg;
                        alert(str);
                        return;
                    }
                    window.opener.location.reload();
                    window.close();
                }
            });

        }

        function cancelBtnF() {
            $("#workplace").val('COM000');
            $("#year").val(2022);
            $("#half").val('상반기');
            $("#p_code").val('');
            $("#p_name").val('');
            $("#p_age").val('');
            $("#p_gender").val('남자');
            $("#p_address").val('');
            $("#p_tel").val('');
            $("#p_email").val('');
            $("#p_dept").val('회계팀');
            $("#p_last_school").val('초졸');
            $("#p_career").val('신입');

            $("#p_challenge").val(1);
            $("#p_creativity").val(1);
            $("#p_passion").val(1);
            $("#p_cooperation").val(1);
            $("#p_globalmind").val(1);

            $("#i_attitude").val(1);
            $("#i_scrupulosity").val(1);
            $("#i_reliability").val(1);
            $("#i_creativity").val(1);
            $("#i_positiveness").val(1);
        }
    </script>
</head>
<body>
<div class="header"><p>이력서 추가</p></div>
<div class="center_table">
    <table class="tbl">
        <tr>
            <td>사업장</td>
            <td>
                <label for="workplace"></label>
                <select id="workplace">
                    <option value="COM000">(주)SEOULIT 본사</option>
                    <option value="COM001">(주)SEOULIT 정촌</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>지원 년도</td>
            <td><input type="number" id="year" value="2022"/></td>
        </tr>
        <tr>
            <td>지원 기수</td>
            <td>
                <label for="half"></label>
                <select id="half">
                    <option value="상반기">상반기(1~6월)</option>
                    <option value="하반기">하반기(7~12월)</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>임시코드</td>
            <td><input type="text" id="p_code" readonly/></td>
            <td><input type="button" id="code_produce" class="jbtn" value="코드생성"/></td>
        </tr>
        <tr>
            <td>이름</td>
            <td><input type="text" id="p_name"/></td>
        </tr>
        <tr>
            <td>나이</td>
            <td><input type="number" id="p_age"/></td>
        </tr>
        <tr>
            <td>성별</td>
            <td>
                <label for="p_gender"></label>
                <select id="p_gender">
                    <option value="남자">남자</option>
                    <option value="여자">여자</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>주소</td>
            <td><input type="text" id="p_address"/></td>
        </tr>
        <tr>
            <td>전화번호</td>
            <td><input type="text" id="p_tel"/></td>
        </tr>
        <tr>
            <td>이메일</td>
            <td><input type="text" id="p_email"/></td>
        </tr>
        <tr>
            <td>부서</td>
            <td>
                <label for="p_dept"></label>
                <select id="p_dept">
                    <option value="회계팀">회계팀</option>
                    <option value="인사팀">인사팀</option>
                    <option value="전산팀">전산팀</option>
                    <option value="보안팀">보안팀</option>
                    <option value="개발팀">개발팀</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>학력</td>
            <td>
                <label for="p_last_school"></label>
                <select id="p_last_school">
                    <option value="초졸">초졸</option>
                    <option value="중졸">중졸</option>
                    <option value="고졸">고졸</option>
                    <option value="2년제대학">2년제대학</option>
                    <option value="4년제대학">4년제대학</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>경력</td>
            <td>
                <label for="p_career"></label>
                <select id="p_career">
                    <option value="신입">신입</option>
                    <option value="1년차">1년차</option>
                    <option value="2년차">2년차</option>
                    <option value="3년차">3년차</option>
                </select>
            </td>
        </tr>

        <tr>
            <td>도전</td>
            <td><input type="number" value="1" id="p_challenge" max="5"/></td>
        </tr>
        <tr>
            <td>창의</td>
            <td><input type="number" value="1" id="p_creativity" max="5"/></td>
        </tr>
        <tr>
            <td>열정</td>
            <td><input type="number" value="1" id="p_passion" max="5"/></td>
        </tr>
        <tr>
            <td>협력</td>
            <td><input type="number" value="1" id="p_cooperation" max="5"/></td>
        </tr>
        <tr>
            <td>글로벌마인드</td>
            <td><input type="number" value="1" id="p_globalmind" max="5"/></td>
        </tr>
        <tr>
            <td>태도</td>
            <td><input type="number" value="1" id="i_attitude" max="5"/></td>
        </tr>
        <tr>
            <td>주도성</td>
            <td><input type="number" value="1" id="i_scrupulosity" max="5"/></td>
        </tr>
        <tr>
            <td>신뢰성</td>
            <td><input type="number" value="1" id="i_reliability" max="5"/></td>
        </tr>
        <tr>
            <td>창의성</td>
            <td><input type="number" value="1" id="i_creativity" max="5"/></td>
        </tr>
        <tr>
            <td>적극성</td>
            <td><input type="number" value="1" id="i_positiveness" max="5"/></td>
        </tr>
    </table>
    <input type="button" class="jbtn" id="Reg_btn" value="이력서 지원"/><input type="reset" class="jbtn" id="cancel_btn"
                                                                          value="초기화"/>
</div>
</body>
</html>