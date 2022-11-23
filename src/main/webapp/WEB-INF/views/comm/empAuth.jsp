<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* Tabs*/
section .section-title {
    text-align: center;
    color: #007b5e;
    text-transform: uppercase;
}
#tabs{
   /*background: #333333;*/
    color: #eee;
    background-color: rgba( 051,051, 051, 0.8 );
}
#tabs h6.section-title{
    color: #eee;
}

#nav-home td{
   margin-right:7px;
   margin-left:7px;
}
</style>
<script>
   var AuthorityGridOptions={};
   var EmpListGridOptions={};

   
   $(document).ready(function(){
      empInfoList = [];
      authadminCodeList = [];
      
      findEmpInfo();
      $("#authority_btn").click(modifyAuthority); //권한부여/해지 버튼
   });
   
   function findEmpInfo(){
      $.ajax({
         url:'${pageContext.request.contextPath}/empinfomgmt/emplist',
         data: {
            "value": "전체부서",
            //전체부서/회계팀/인사팀/전산팀
            "workplaceCode":"${sessionScope.workplaceCode}"
         },
         dataType:"json",
         success : function(data){
            if(data.errorCode < 0){
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
         }
      });
   }
   
   function showEmpListGrid() {
      var columnDefs = [ { headerName : "사원코드", field : "empCode" , checkboxSelection: true}, 
                     { headerName : "사원명", field : "empName" }, 
                        { headerName : "직급", field : "position" },
                        { headerName : "부서", field : "deptName" }
      ];
      EmpListGridOptions = {
        onRowClicked: function(event) {
           findAuthAdimCode();
       },
         columnDefs : columnDefs,
         rowData : empInfoList,
         defaultColDef : { editable : false, width : 100 },
         rowSelection : 'single', 
         enableColResize : true,
         enableSorting : true,
         enableFilter : true,
         enableRangeSelection : true,
         suppressRowClickSelection : false,
         animateRows : true,
         suppressHorizontalScroll : true,
         localeText : { noRowsToShow : '조회 결과가 없습니다.' },
         
         getRowStyle : function(param) {
            if (param.node.rowPinned) {
               return {
                  'font-weight' : 'bold',
                  background : '#dddddd'
               };
            }
            return {
               'text-align' : 'center'
            };
         },
         getRowHeight : function(param) {
            if (param.node.rowPinned) {
               return 30;
            }
            return 24;
         },
         
         onGridReady : function(event) {
            event.api.sizeColumnsToFit();
         },
         
         onGridSizeChanged : function(event) {
            event.api.sizeColumnsToFit();
         }
      };
      
      $('#myGrid1').children().remove();
      var eGridDiv = document.querySelector('#myGrid1');
      new agGrid.Grid(eGridDiv, EmpListGridOptions);

   }
   
   function findAuthAdimCode(){      
     employeeRowNode = EmpListGridOptions.api.getSelectedNodes();
     empCode = employeeRowNode[0].data.empCode;
      $.ajax({
         url:'${pageContext.request.contextPath}/systemmgmt/authcode',
         data:{
            "empCode"   : empCode
         },
         dataType:"json",
         success : function(data){
            if(data.errorCode < 0){
               var str = "내부 서버 오류가 발생했습니다\n";
               str += "관리자에게 문의하세요\n";
               str += "에러 위치 : " + $(this).attr("id");
               str += "에러 메시지 : " + data.errorMsg;
               alert(str);
               return;
            }
            authadminCodeList =data.authadminCodeList;
            
            console.log("!!!authadminCodeList"+authadminCodeList);
            showAuthorityListGrid();      
         }
      });
   }
   
   
   function showAuthorityListGrid() {
         var columnDefs = [ { headerName : "권한그룹명", field : "admin_authority", checkboxSelection: true }, 
                        { headerName : "권한그룹코드", field:"admin_code" },
                        { headerName : "권한여부",  field: "authority", cellRenderer: function (params) {
                            if (params.value == "1") {
                               // params.node.setSelected(true);
                                return params.value =  "🟢" ;
                            }
                            return '✖️' ; 
                        }}
         ];
      AuthorityGridOptions = {
         columnDefs : columnDefs,
         rowData : authadminCodeList,
         defaultColDef : {
            editable : false,
            width : 100
         },
         rowSelection : 'single',
         enableColResize : true,
         enableSorting : true,
         enableFilter : true,
         enableRangeSelection : true,
         suppressRowClickSelection : false,
         animateRows : true,
         suppressHorizontalScroll : true,
         localeText : { noRowsToShow : '조회 결과가 없습니다.' },
         getRowStyle : function(param) {
            if (param.node.rowPinned) {
               return { 'font-weight' : 'bold', background : '#dddddd' };
            }
            
            return { 'text-align' : 'center' };
         },
         getRowHeight : function(param) {
            if (param.node.rowPinned) {
               return 30;
            }
            return 24;
         },
         onGridReady : function(event) { event.api.sizeColumnsToFit(); },
         onGridSizeChanged : function(event) { event.api.sizeColumnsToFit(); }
      }
      
      $('#myGrid2').children().remove();
      
      var eGridDiv = document.querySelector('#myGrid2');
      new agGrid.Grid(eGridDiv, AuthorityGridOptions);
   }
   
   function modifyAuthority(){
         authorityList = AuthorityGridOptions.api.getSelectedRows();
         empList = EmpListGridOptions.api.getSelectedRows();
         
         console.log("권한리스트");
         console.log(authorityList);
         console.log("사원리스트");
         console.log(empList);
         
         if(authorityList.length == 0 | empList.length == 0){
            Swal.fire({
               icon:'warning',
               title:'(o´〰`o)',
               text:'사원 혹은 권한여부를 모두 선택하여 주세요'
            });
            return;
         }
         
         adminCode = authorityList[0].admin_code;
         empCode = empList[0].empCode
         console.log("권한 :"+adminCode+"사원"+empCode);
         
         $.ajax({
        	type : "PUT",
            url:'${pageContext.request.contextPath}/systemmgmt/authcode',
            data:{
               "empCode" : empCode , 
               "adminCode": adminCode
            },
            dataType:"json",
            success : function(data){
               if(data.errorCode < 0){
                  var str = "내부 서버 오류가 발생했습니다\n";
                  str += "관리자에게 문의하세요\n";
                  str += "에러 위치 : " + $(this).attr("id");
                  str += "에러 메시지 : " + data.errorMsg;
                  alert(str);
                  return;
               }
               alert("수정되었습니다");
               console.log("처리 상태 : "+data.errorMsg);
            }
         }); 
         
         $('#myGrid2').children().remove();
         findAuthAdimCode();
         location.reload();
      }


</script>
</head>
<body>
      <section id="tabs" style="height:630px; display: inline-block; text-align: center;" class="wow fadeInDown">
      
         <h6 class="section-title h3" style="text-align:center;padding-top:20px">사원권한관리</h6>
         <div class="container">
            <hr style="background-color:white; height: 1px;">
         </div>
         
            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
               <table style="margin : auto;">
               <tr>
                  <td>
                  <div id="divPart1" style="display:inline-block;">
                     <div id="myGrid1" style="height: 450px; width: 450px; display:inline-block; margin : auto;" class="ag-theme-balham"></div>
                  </div> 
                  </td>
                  
                  <td>
                  <div id="divPart2" style="display:inline-block;">
                     <div id="myGrid2" style="height: 450px; width: 450px; display:inline-block;" class="ag-theme-balham"></div>
                  </div>               
                  </td>
               </tr>
               </table>
               <input type="button" id = "authority_btn" value="권한부여" class="btn btn-light">
               <input type="button" id = "authority_btn" value="권한해지" class="btn btn-light"> 
            </div>   
   </section>

</body>
</html>