<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ko">
<head>
   <title>인사발령관리</title>
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
      var appointmentList = [];
      var detailappointmentList = [];
      var changeDetailList = [];

      $(document).ready(function () {

         $("#tabs").tabs();

         findAppointmentInfo(); //발령정보를 발령결재텝의 그리드에 뿌리는 함수
         appointmentInfo(); //발령정보를 인사발령이력탭의 그리드에 뿌리는 함수
         approvalGrid2();
         approvalGrid3();

         $("#approval").click(function () { //승인버튼을 누르면 3번그리드의 승인여부가 '승인'으로 바뀐다
            approvalAppointmentRequest();
         })

         $("#refer").click(function () {//반려버튼을 누르면 3번그리드의 승인여부가 '반려'로 바뀐다
            referAppointmentRequest();
         })

         $("#confirm").click(function () { //확정버튼을 누르면 승인여부가 DB에 저장된다
            if ("${sessionScope.position}" === "팀장" && "${sessionScope.dept}" === "인사팀") //인사팀 팀장만 확정가능
               confirmAppointmentRequest();
            else
               alert("결재권한이 없습니다"); //권한이 없을때 나오는 문구
         })
      });

      //발령정보를 그리드에 뿌리는 함수
      function findAppointmentInfo() {
         $.ajax({
            url: "${pageContext.request.contextPath}/empinfomgmt/findAppointment",
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
               appointmentList = data.appointmentList;
               console.log(appointmentList);
               approvalGrid1();
               appointmentInfoGrid();
            }
         });
      }

      function approvalGrid1() {
         var columnDefs1 = [
            {headerName: "호수", field: "hosu"},
            {headerName: "제목", field: "title"},
            {headerName: "발령일", field: "appointmentDate"},
            {headerName: "발령근거", field: "appointmentDetail"},
            {headerName: "발령인원", field: "appointmentCount"}
         ];
         gridOptions = {
            columnDefs: columnDefs1,
            rowData: appointmentList,
            localeText: {
               noRowsToShow: '조회 결과가 없습니다.'
            }, // 데이터가 없을 때 뿌려지는 글
            getRowStyle: function (param) {
               return {
                  'text-align': 'center'
               };
            },
            // GRID READY 이벤트, 사이즈 자동조정
            onGridReady: function (event) {
               event.api.sizeColumnsToFit();
            },
            // 창 크기 변경 되었을 때 이벤트
            onGridSizeChanged: function (event) {
               event.api.sizeColumnsToFit();
            },
            /** 1번 그리드의 데이터를 누르면 2번 그리드에 발령내용과 인원수가 나옴 */
            onRowClicked: function (event) {
               var sendData = event.data.hosu;
               $.ajax({
                  url: "${pageContext.request.contextPath}/empinfomgmt/findDetailAppointment",
                  data: {"hosu": sendData},
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
                     detailappointmentList = data.detailAppointmentList;
                     approvalGrid2();
                  }
               });
            }
         }
         $('#approvalgrid1').children().remove();
         var eGridDiv = document.querySelector('#approvalgrid1');
         new agGrid.Grid(eGridDiv, gridOptions);
         gridOptions.api.sizeColumnsToFit();
      }

      function approvalGrid2() {
         var columnDefs2 = [
            {headerName: "대상", field: "empName"},
            {headerName: "부서변경", field: "deptChangeStatus"},
            {headerName: "직급변경", field: "positionChangeStatus"},
            {headerName: "호봉변경", field: "hobongChangeStatus"},
            {headerName: "은퇴", field: "retirementStatus"},
            {headerName: "파견", field: "dispatchStatus"},
            {headerName: "휴직", field: "leaveStatus"}
         ];
         gridOptions = {
            columnDefs: columnDefs2,
            rowData: detailappointmentList,
            localeText: {
               noRowsToShow: '조회할 공고를 선택해 주세요.'
            }, // 데이터가 없을 때 뿌려지는 글
            getRowStyle: function (param) {
               return {
                  'text-align': 'center'
               };
            },
            // GRID READY 이벤트, 사이즈 자동조정
            onGridReady: function (event) {
               event.api.sizeColumnsToFit();
            },
            // 창 크기 변경 되었을 때 이벤트
            onGridSizeChanged: function (event) {
               event.api.sizeColumnsToFit();
            },
            onRowClicked: function (event) {
            	var empCode = event.data.empCode;
            	var hosu = event.data.hosu;
               $.ajax({
                  url: "${pageContext.request.contextPath}/empinfomgmt/findChangeDetail",
                  data: {"empCode": empCode, "hosu": hosu},
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
                     changeDetailList = data.changeDetailList;
                     approvalGrid3();
                  }
               });
            }
         }

         $('#approvalgrid2').children().remove();
         var eGridDiv = document.querySelector('#approvalgrid2');
         new agGrid.Grid(eGridDiv, gridOptions);
         gridOptions.api.sizeColumnsToFit();
      }

      function approvalGrid3() {
         var columnDefs3 = [
            {headerName: "발령전", field: "beforeChange"},
            {headerName: "발령후", field: "afterChange"},
            {headerName: "승인여부", field: "approvalStatus"},
            {headerName: "상태", field: "status", hide: true}
         ];
         gridOptions = {
            columnDefs: columnDefs3,
            rowData: changeDetailList,
            localeText: {
               noRowsToShow: '조회할 사원을 선택해 주세요.'
            }, // 데이터가 없을 때 뿌려지는 글
            getRowStyle: function (param) {
               return {
                  'text-align': 'center'
               };
            },
            // GRID READY 이벤트, 사이즈 자동조정
            onGridReady: function (event) {
               event.api.sizeColumnsToFit();
            },
            // 창 크기 변경 되었을 때 이벤트
            onGridSizeChanged: function (event) {
               event.api.sizeColumnsToFit();
            }
         }
         $('#approvalgrid3').children().remove();
         var eGridDiv = document.querySelector('#approvalgrid3');
         new agGrid.Grid(eGridDiv, gridOptions);
         gridOptions.api.sizeColumnsToFit();
      }

      function approvalAppointmentRequest() {
         for (let a = 0; a < changeDetailList.length; a += 1) {
            changeDetailList[a].approvalStatus = "승인"
            changeDetailList[a].status = "update"
         }
         console.log(changeDetailList);
         approvalGrid3();
      }

      function referAppointmentRequest() {
         for (let a = 0; a < changeDetailList.length; a += 1) {
            changeDetailList[a].approvalStatus = "반려"
            changeDetailList[a].status = "update"
         }
         console.log(changeDetailList);
         approvalGrid3();
      }

      function confirmAppointmentRequest() {
         var sendData = JSON.stringify(changeDetailList);
         $.ajax({
            type: "PUT",
            url: "${pageContext.request.contextPath}/empinfomgmt/confirmAppointment",
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
                  return;
               }
               alert("확정되었습니다")
            }
         })
         location.reload();
      }



      function appointmentInfo() {
         $.ajax({
            type: "GET",
            url: '${pageContext.request.contextPath}/empinfomgmt/appointment',
            success: function (data) {
               if (data.errorCode < 0) {
                  let str = "내부 서버 오류가 발생했습니다\n";
                  str += "관리자에게 문의하세요\n";
                  str += "에러 위치 : " + $(this).attr("id");
                  str += "에러 메시지 : " + data.errorMsg;
                  alert(str);
                  return;
               }
               let appointmentInfoData = data.infoList;
               console.log(appointmentInfoData);
               appointmentInfoGrid(appointmentInfoData);
            }
         });
      }

      function appointmentInfoGrid(appointmentInfoData) {
         var columnDefs1 = [
            {headerName: "호수", field: "hosu", width: "200px"},
            {headerName: "제목", field: "title", width: "250px"},
            {headerName: "발령근거", field: "appointment_detail", width: "150px"},
            {headerName: "발령인원", field: "appointment_count", width: "150px"},
            {headerName: "발령날짜", field: "appointment_date", width: "250px"},
            {headerName: "승인여부", field: "approval_status", width: "150px"}
         ];
         const gridOptions = {
            columnDefs: columnDefs1,
            rowData: appointmentInfoData,
            suppressHorizontalScroll: true,
            onRowClicked: function (event) {
               const hosu = event.data.hosu;
               appointemp(hosu); // hosu란 호수데이터값을 appointemp에 보냄
            },
            localeText: {
               noRowsToShow: '조회 결과가 없습니다.'
            }, // 데이터가 없을 때 뿌려지는 글
            getRowStyle: function (param) {
               return {
                  'text-align': 'center'
               };
            },
            // GRID READY 이벤트, 사이즈 자동조정
            onGridReady: function (event) {
               event.api.sizeColumnsToFit();
            },
            // 창 크기 변경 되었을 때 이벤트
            onGridSizeChanged: function (event) {
               event.api.sizeColumnsToFit();
            }
         }
         $('#appointmentInfoGrid').children().remove();
         var eGridDiv = document.querySelector('#appointmentInfoGrid');
         new agGrid.Grid(eGridDiv, gridOptions);
         gridOptions.api.sizeColumnsToFit();
      }

      function appointemp(hosu) {
         console.log(hosu); // 보낸 호수데이터값을 찍어보고 잘들어갔는지 확인
         let gridOptions = {};
         $.ajax({
            type: "GET",
            url: '${pageContext.request.contextPath}/empinfomgmt/appointmentemp', // 컨트롤러에서부터 DB까지 hosu의 값을 들고오고
            data: {"hosu": hosu}, // 데이터에 뿌린뒤
            success: function (data) {
               if (data.errorCode < 0) {
                  let str = "내부 서버 오류가 발생했습니다\n";
                  str += "관리자에게 문의하세요\n";
                  str += "에러 위치 : " + $(this).attr("id");
                  str += "에러 메시지 : " + data.errorMsg;
                  alert(str);
                  return;
               }

               let appointmentemp_count = data.countlist;

               console.log(appointmentemp_count);
               appointmentGridEmp(appointmentemp_count);
            }
         });
      }

      function appointmentGridEmp( appointmentemp_count) {
         console.log(appointmentemp_count);
         var columnDefs2 = [
            {headerName: "발령구분", field: "type", width: "300px"},
            {headerName: "발령인원", field: "count"},
         ];
         gridOptions = {
            columnDefs: columnDefs2,
            rowData: [
               {type: "부서이동", count: appointmentemp_count.deptChangeStatus},
               {type: "호봉승급", count: appointmentemp_count.hobongChangeStatus},
               {type: "승진", count: appointmentemp_count.positionChangeStatus},
               {type: "퇴직", count: appointmentemp_count.retirementStatus},
               {type: "파견", count: appointmentemp_count.dispatchStatus},
               {type: "휴직", count: appointmentemp_count.leaveStatus}
            ],
            onRowClicked: function (event) {
               let hosu = appointmentemp_count.hosu;
               let type = event.data.type
               console.log(type);
               console.log(hosu);
               appointmentType(type, hosu);
            },
            localeText: {
               noRowsToShow: '조회 결과가 없습니다.'
            }, // 데이터가 없을 때 뿌려지는 글
            getRowStyle: function (param) {
               return {
                  'text-align': 'center'
               };
            },
            // GRID READY 이벤트, 사이즈 자동조정
            onGridReady: function (event) {
               event.api.sizeColumnsToFit();
            },
            // 창 크기 변경 되었을 때 이벤트
            onGridSizeChanged: function (event) {
               event.api.sizeColumnsToFit();
            }
         }
         $('#appointmentGridEmp').children().remove();
         var eGridDiv = document.querySelector('#appointmentGridEmp');
         new agGrid.Grid(eGridDiv, gridOptions);
         gridOptions.api.sizeColumnsToFit();
      }

      function appointmentType(type, hosu) {
         $.ajax({
            type: "GET",
            url: '${pageContext.request.contextPath}/empinfomgmt/appointmentemptype',
            data: {"type": type, "hosu": hosu},
            success: function (data) {
               if (data.errorCode < 0) {
                  let str = "내부 서버 오류가 발생했습니다\n";
                  str += "관리자에게 문의하세요\n";
                  str += "에러 위치 : " + $(this).attr("id");
                  str += "에러 메시지 : " + data.errorMsg;
                  alert(str);
                  return;
               }
               let typeList = data.typelist;
               appointmentTypeGrid(typeList, type);
            }
         })
      }

      function appointmentTypeGrid(typeList, type) {
         console.log(typeList,"typeList");
         console.log(type,"type");
         var dept = [
            {headerName: "사원번호", field: "empCode"},
            {headerName: "사원이름", field: "empName"},
            {headerName: "이전부서", field: "lastDept", width: "400px"},
            {headerName: "발령부서", field: "nextDept", width: "400px"}
         ];
         var position = [
            {headerName: "사원번호", field: "empCode"},
            {headerName: "사원이름", field: "empName"},
            {headerName: "이전직급", field: "lastPosition", width: "400px"},
            {headerName: "발령직급", field: "nextPosition", width: "400px"}
         ];
         var retirement = [
            {headerName: "사원번호", field: "empCode"},
            {headerName: "사원이름", field: "empName"},
            {headerName: "퇴직일", field: "retirementDate", width: "400px"}
         ];
         var dispatch = [
            {headerName: "사원번호", field: "empCode"},
            {headerName: "사원이름", field: "empName"},
            {headerName: "파견일", field: "dispatchDate", width: "400px"},
            {headerName: "파견복귀일", field: "dispatchReturnDate", width: "400px"}
         ];
         var leave = [
            {headerName: "사원번호", field: "empCode"},
            {headerName: "사원이름", field: "empName"},
            {headerName: "휴직일", field: "leaveDate", width: "400px"},
            {headerName: "휴직복직예정일", field: "reinstatementDate", width: "400px"}
         ];
         var hobong = [
            {headerName: "사원번호", field: "empCode"},
            {headerName: "사원이름", field: "empName"},
            {headerName: "이전호봉", field: "lastHobong", width: "400px"},
            {headerName: "발령호봉", field: "nextHobong", width: "400px"}
         ];
         let result = null;
         if (type == "승진")
            result = position;
         else if (type == "호봉승급")
            result = hobong;
         else if (type == "부서이동")
            result = dept;
         else if (type == "퇴직")
            result = retirement;
         else if (type == "파견")
            result = dispatch;
         else if (type == "휴직")
            result = leave;

         gridOptions = {
            columnDefs: result,
            rowData: typeList,
            localeText: {
               noRowsToShow: '해당 부분에 발령이 예정된 인원이 없습니다.'
            }, // 데이터가 없을 때 뿌려지는 글
            getRowStyle: function (param) {
               return {
                  'text-align': 'center'
               };
            },
            // GRID READY 이벤트, 사이즈 자동조정
            onGridReady: function (event) {
               event.api.sizeColumnsToFit();
            },
            // 창 크기 변경 되었을 때 이벤트
            onGridSizeChanged: function (event) {
               event.api.sizeColumnsToFit();
            }
         }
         $('#appointmentTypeGrid').children().remove();
         var eGridDiv = document.querySelector('#appointmentTypeGrid');
         new agGrid.Grid(eGridDiv, gridOptions);
         gridOptions.api.sizeColumnsToFit();
      }


   </script>
</head>
<body>
<section id="tabs" class="wow fadeInDown"
         style="height:700px; width:1100px; text-align: center;">

   <div class="container">
      <nav>
         <div class="nav nav-tabs" id="nav-tab" role="tablist">
            <a class="nav-item nav-link active"
               data-toggle="tab" href="#appointmentApproval" role="tab"
               aria-controls="nav-home" aria-selected="true">발령결재</a>
            <a class="nav-item nav-link"
               data-toggle="tab" href="#appointmentHistory" role="tab"
               aria-controls="nav-profile" aria-selected="false">인사발령이력</a>
         </div>
      </nav>
   </div>

   <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">

      <div class="tab-pane fade show active" id="appointmentApproval" role="tabpanel"
           aria-labelledby="approval-tab">
         <table style="margin:0px">
            <tr>
               <td>
                  <table>
                     <tr>
                        <td>
                           <h5>발령공고</h5>
                           <div id="approvalgrid1" style="height: 250px; width:500px; margin: 15px 20px"
                                class="ag-theme-balham"></div>
                        </td>
                     </tr>
                     <tr>
                        <td>
                           <h5>발령내용</h5>
                           <div id="approvalgrid2" style="height: 250px; width:500px; margin: 15px 20px"
                                class="ag-theme-balham"></div>
                        </td>
                     </tr>
                  </table>
               </td>
               <td>
                  <h5>발령 상세정보</h5>
                  <div id="approvalgrid3" style="height: 450px; width:500px; margin: 10px 5px"
                       class="ag-theme-balham"></div>
                  <input type="button" value="승인" class="ui-button ui-widget ui-corner-all" id="approval">
                  <input type="button" value="반려" class="ui-button ui-widget ui-corner-all" id="refer">
                  <input type="button" value="확정" class="ui-button ui-widget ui-corner-all" id="confirm">
               </td>
            </tr>
         </table>
      </div>

      <div class="tab-pane fade active" id="appointmentHistory" role="tabpanel"
           aria-labelledby="history-tab">
         <table style="margin:0px">
            <tr>
               <td>
                  <table>
                     <tr>
                        <td>
                           <div id="appointmentInfoGrid" style="height: 250px; width:500px; margin: 15px 20px"
                                class="ag-theme-balham"></div>
                        </td>
                     </tr>
                     <tr>
                        <td>
                           <h4 style="margin-right: 300px">발령인원</h4>
                           <div id="appointmentGridEmp" style="height: 250px; width:500px; margin: 15px 20px"
                                class="ag-theme-balham"></div>
                        </td>
                     </tr>
                  </table>
               </td>
               <td>
                  <div id="appointmentTypeGrid" style="height: 500px; width:500px; margin: 10px 5px"
                       class="ag-theme-balham"></div>
               </td>
            </tr>
         </table>
      </div>

   </div>
</section>
</body>
</html>
