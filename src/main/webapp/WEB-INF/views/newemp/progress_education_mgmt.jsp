<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="http://export.dhtmlx.com/gantt/api.js"></script> <!-- 간트차트 파일화 작업 -->
    <script src="${pageContext.request.contextPath}/js/dhtmlxgantt.js?v=7.1.12"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dhtmlxgantt.css?v=7.1.12"/>
    <style type="text/css">
        .container2 {
            /*background: #333333;*/
            background-color: rgba(0, 0, 0, 0.3);
            color: #eee;
            height: auto;
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
            font-weight: bold;
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

        .area {
            width: 100%;
            height: 500px;
            outline: none;
        }

        input[type='text'] {
            outline: none;
        }

        .gantt_task_cell.week_end {
            background-color: #EFF5FD;
        }

        .gantt_task_row.gantt_selected .gantt_task_cell.week_end {
            background-color: #F8EC9C;
        }

    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('ul.tabs li').click(function () {
                var tab_id = $(this).attr('data-tab');

                $('ul.tabs li').removeClass('current');
                $('.tab-content').removeClass('current');

                $(this).addClass('current');
                $("#" + tab_id).addClass('current');


            });
            var gantt = Gantt.getGanttInstance();
            var gantt1 = Gantt.getGanttInstance();

            gantt.init("gantt_here");
            $("#data_btn").click(sendData);

            function sendData() {
                let jsonData = gantt.serialize('json');
                $.ajax({
                    type: "POST",
                    url: '${pageContext.request.contextPath}/documentmgmt/educationmgmt',
                    dataType: "json",
                    data: {"jsonData": JSON.stringify(jsonData)},
                    success: function (data) {
                        console.log(data);
                        if (data.errorCode < 0) {
                            let str = "내부 서버 오류가 발생했습니다\n";
                            str += "관리자에게 문의하세요\n";
                            str += "에러 위치 : " + $(this).attr("id");
                            str += "에러 메시지 : " + data.errorMsg;
                            alert(str);
                            return;
                        }
                    }
                });
                location.reload();
            }


            gantt1.init("gantt_info");
            getData();

            function getData() {
                $.ajax({
                    type: "GET",
                    url: '${pageContext.request.contextPath}/documentmgmt/ganttchartdata',
                    dataType: "json",
                    success: function (data) {
                        if (data.errorCode < 0) {
                            let str = "내부 서버 오류가 발생했습니다\n";
                            str += "관리자에게 문의하세요\n";
                            str += "에러 위치 : " + $(this).attr("id");
                            str += "에러 메시지 : " + data.errorMsg;
                            alert(str);
                            return;
                        }
                        console.log(data.datalinks);
                        gantt1.parse(data.datalinks);
                        gantt1.config.readonly = true;//읽기전용모드
                    }
                });
            }
        });

    </script>

</head>
<body>
<div class="container2 wow fadeInDown">
    <div class="textarea">
        <div class="container3">
            <ul class="tabs">
                <li class="tab-link current" data-tab="tab-1">교육훈련 진행관리</li>
                <li class="tab-link" data-tab="tab-2">교육훈련 진행정보</li>
            </ul>
            <div id="tab-1" class="tab-content current" style='width:100%; height:700px;'>
                <div id="gantt_here" style='width:100%; height:95%;'></div>
                <button id="data_btn" class='jbtn'>기록</button>
            </div>
            <div id="tab-2" class="tab-content" style='width:100%; height:700px;'>
                <div id="gantt_info" style='width:100%; height:100%;'></div>
            </div>
        </div>
    </div>
</div>
</body>
</html>