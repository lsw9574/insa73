<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
section .section-title {
    text-align: center;
    color: #007b5e;
    text-transform: uppercase;
}
#tabs{
   text-align: center;
   margin-left:50px;
   background: #333333;
    color: #eee;
    background-color: rgba( 051,051, 051, 0.5 );
}
#tabs h6.section-title{
    color: #eee;
}

form .form-group{
   margin-bottom:2px;
   flex-wrap: nowrap;
   text-align:center;
}

.form-group .btn.btn-sm{
   margin: 0;
}
</style>
<script>
var empBean={};

   $(document).ready(function(){
       $("#txt_dept").click(function(){ //부서
         getCode('CO-07',"txt_dept","deptCode");
      });
      $("#txt_posi").click(function(){ //직급
         getCode('CO-04',"txt_posi","position");
      }); 
      $("#txt_gend").click(function(){ //성별
         getCode('CO-01',"txt_gend","gender");
      });
      $("#txt_lasc").click(function(){ //최종학력
         getCode('CO-02',"txt_lasc","last_shcool");
      });
      $("#btn_crenum").click(function(){ //사원번호생성
         creatEmpCode();
      });
      $("#txt_hobong").click(function(){ //호봉생성
         getCode('CO-12',"txt_hobong","hobong")
      });
      $("#txt_occupation").click(function(){ //근무형태생성
         getCode('CO-03',"txt_occupation","occupation")
      });
      $("#txt_employment").click(function(){ //고용형태생성
         getCode('CO-05',"txt_employment","employment")
      });
      
      /* 등록시 이벤트 */
      $("#regist_btn").click(function(){  registEmp(); }); 
            
      /*  tab 구현 */
      $( "#registTab" ).tabs();
   
      /* 주소 검색 버튼 */
      $(function() { $("#addr_btn").postcodifyPopUp(); });
      
   
      /* 사진찾기*/
      $("#findPhoto").button().click(function(){
          $("#emp_img_file").click(); //사진찾기 버튼을 누르면 숨겨진 file 태그를 클릭
      });     
      // 사진 등록 form의 ajax 부분
        $("#emp_img_form").ajaxForm({
         dataType: "json",
         success: function(responseText, statusText, xhr, $form){
            alert(responseText.errorMsg);
            location.reload();
         }
      });      
      
   });
   
   function readURL(input){
      
      if (input.files && input.files[0]) {
         var reader = new FileReader();
         reader.onload = function (e) {
            // 이미지 Tag의 SRC속성에 읽어들인 File내용을 지정 (아래 코드에서 읽어들인 dataURL형식)
            console.log(e.target);
            $("#profileImg").attr("src", e.target.result);
         }
      reader.readAsDataURL(input.files[0]); //File내용을 읽어 dataURL형식의 문자열로 저장
      }
   }
   
   /* 사원등록 */
   function registEmp(){      
      saveInfo();      
      
      var sendData = JSON.stringify(empBean);   
      alert(sendData);
       $.ajax({
         type : "POST" ,
         url : "${pageContext.request.contextPath}/empinfomgmt/employee",
           data : sendData,
           contentType:"application/json",
         dataType : "json",
         success : function(data) {
            if(data.errorCode<0){
                 var error=/unique constraint/;
                 if(error.test(data.errorMsg)){
                    alert("해당 사원번호가 있습니다"+data.errorMsg);
                    return false;
                 }              
              }
              alert("사원을 등록했습니다");
              location.reload();            
         }
      }); 
      
   }
   


   
function saveInfo(){
	
      empBean.empCode=$("#txt_code").val(); 
      empBean.empName=$("#txt_name").val();
      empBean.birthdate=$("#txt_birth").val();
      empBean.gender=$("#txt_gend").val();
      empBean.mobileNumber=$("#txt_mnum").val();
      empBean.address=$("#txt_addr").val();
      empBean.detailAddress=$("#txt_daddr").val();
      empBean.postNumber=$("#txt_pnum").val();
      empBean.email=$("#txt_emain").val();
      empBean.lastSchool=$("#txt_lasc").val();            
      empBean.deptName=$("#deptCode").val();
      empBean.position=$("#position").val();
      empBean.hobong=$("#txt_hobong").val();
      empBean.occupation=$("#txt_occupation").val();
      empBean.employment=$("#txt_employment").val();
      empBean.workplaceCode="${sessionScope.workplaceCode}";
      
   }
   
   /* 부서,직급 선택창 띄우기 */
   function getCode(code,inputText,inputCode){
      option="width=220; height=200px; left=300px; top=300px; titlebar=no; toolbar=no,status=no,menubar=no,resizable=no, location=no";
      window.open("${pageContext.request.contextPath}/comm/codeWindow/view?code="
                  +code+"&inputText="+inputText+"&inputCode="+inputCode,"newwins",option);
   }
   
   /* 달력 띄우기 */
   $(function(){
      $("#txt_birth").datepicker({
         changeMonth : true,
         changeYear : true,
         dateFormat : "yy/mm/dd",
         dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
         monthNamesShort : [ "1", "2", "3", "4", "5", "6", "7", "8", "9","10", "11", "12" ],
         yearRange: "1970:2022",
      })
      
      $("#txt_hiredate").datepicker({
         changeMonth : true,
         changeYear : true,
         showOn:"button",
         buttonImage:"${pageContext.request.contextPath}/image/cal.png",
         buttonImageOnly:true,
         dateFormat : "yy/mm/dd",
         dayNamesMin : [ "일", "월", "화", "수", "목", "금", "토" ],
         monthNamesShort : [ "1", "2", "3", "4", "5", "6", "7", "8", "9",
               "10", "11", "12" ],
         yearRange: "2000:2050",
      })
   })
   
   /* 사번생성 */
      function creatEmpCode(){
         $.ajax({
        	type : "GET",
            url : "${pageContext.request.contextPath}/empinfomgmt/employee",
            dataType:'json',
            success:function(data){
               if(data.errorCode < 0){
                  var str = "내부 서버 오류가 발생했습니다\n";
                  str += "관리자에게 문의하세요\n";
                  str += "에러 위치 : " + $(this).attr("id");
                  str += "에러 메시지 : " + data.errorMsg;
                  alert(str);
                  return;
               }
      
               var lastEmpCode = data.lastEmpCode;
               var lastNumber = lastEmpCode.substring(1);
               console.log(lastNumber);
               var newCode = "A" + (Number(lastNumber)+1);
               console.log(newCode);
               $("#txt_code").val(newCode);
               $("#emp_img_empCode").val(newCode);
            }
         });
      }
   
   /* 사진찾기 버튼 눌렀을 때 실행되는 함수 */

</script>

<script> 
   
</script>
</head>
<body>
   <section id="tabs"  class="wow fadeInDown">
   <div class="container">
      <h6 class="section-title h3" style="text-align:center;">사원등록</h6>
      <hr style="background-color:white; height: 3px;">
        <div id="registTab1">
         <!-- 사진박스 -->
         <div id="divImg" style="display:inline-block;"> 
            <img id="profileImg" src="${pageContext.request.contextPath}/profile/profile.png" width="180px" height="200px"><br>
            <form id="emp_img_form" action="${pageContext.request.contextPath }/foudinfomgmt/empImg.do" enctype="multipart/form-data" method="post"> 
               <input type="hidden" name="empCode" id="emp_img_empCode">
               <input type="file" name="empImgFile" style="display: none;" id="emp_img_file" onChange="readURL(this)">
               <button type="button" style="width:150px" class="btn btn-light btn-sm btn-outline-dark active" id="findPhoto">사진찾기</button> <br>
            </form>
            <br /> 
         </div>
   
         <!-- 사원정보 -->
         <form id="regist_form" action="<%=request.getContextPath()%>/empinfomgmt/empRegist.do" method="post">   
            <input type="hidden" name="method" value="registEmployee">
    
            <hr style="background-color:white;">
                 <div class="form-group row">
                   <label for="btn_crenum" class="col-md-3 col-form-label text-md-right">사원번호</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_code" class="form-control" name="emp_code" readonly>
                        </div>
                         <input type="button" class="btn btn-light btn-sm" id='btn_crenum' value="사번생성">
                </div>
                
                <div class="form-group row">
                   <label for="txt_name" class="col-md-3 col-form-label text-md-right">이름</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_name" class="form-control" name="emp_name">
                        </div>
                </div>
                <div class="form-group row">
                   <label for="txt_dept" class="col-md-3 col-form-label text-md-right">부서</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_dept" class="form-control" name="dept_name" readonly>
                           <input type="hidden" id="deptCode">
                        </div>
                </div>
                <div class="form-group row">
                   <label for="txt_posi" class="col-md-3 col-form-label text-md-right">직급</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_posi" class="form-control" name="position" readonly>
                           <input type="hidden" id="position">
                        </div>
                </div>
                <div class="form-group row">
                   <label for="txt_gend" class="col-md-3 col-form-label text-md-right">성별</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_gend" class="form-control" name="gender" readonly>
                        </div>
                </div>
                <div class="form-group row">
                   <label for="txt_birth" class="col-md-3 col-form-label text-md-right">생년월일</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_birth" class="form-control" name="birthday" readonly>
                        </div>
                </div>
                
                <div class="form-group row">
                   <label for="txt_addr" class="col-md-3 col-form-label text-md-right">주소</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_addr" class="form-control postcodify_address" name="address">
                        </div>
                         <input type="button" class="btn btn-light btn-sm" id="addr_btn" value="검색" >
                </div>
                <div class="form-group row">
                   <label for="txt_daddr" class="col-md-3 col-form-label text-md-right">상세주소</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_daddr" class="form-control" name="detail_address">
                        </div>
                </div>
                <div class="form-group row">
                   <label for="txt_pnum" class="col-md-3 col-form-label text-md-right">우편번호</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_pnum" class="form-control postcodify_postcode5" name="post_numbe">
                        </div>
                </div>
                <div class="form-group row">
                   <label for="txt_mnum" class="col-md-3 col-form-label text-md-right">전화번호</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_mnum" class="form-control" name="mobile_number">
                        </div>
                </div>
                <div class="form-group row">
                   <label for="txt_emain" class="col-md-3 col-form-label text-md-right">이메일</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_emain" class="form-control" name="email">
                        </div>
                </div>
                <div class="form-group row">
                   <label for="txt_lasc" class="col-md-3 col-form-label text-md-right">최종학력</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_lasc" class="form-control" name="last_school" readonly>
                        </div>
                </div>
                <div class="form-group row">
                   <label for="txt_hobong" class="col-md-3 col-form-label text-md-right">호봉</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_hobong" class="form-control" name="hobong" readonly>
                        </div>
                </div>
                <div class="form-group row">
                   <label for="txt_occupation" class="col-md-3 col-form-label text-md-right">근무형태</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_occupation" class="form-control" name="occupation" readonly>
                        </div>
                </div>
                <div class="form-group row">
                   <label for="txt_employment" class="col-md-3 col-form-label text-md-right">고용형태</label>
                         <div class="col-md-6">
                           <input type="text" id="txt_employment" class="form-control" name="employment" readonly>
                        </div>
                </div>
                <input type="hidden" name="img_extend" id="img_extend">
                  <input type="button" id="regist_btn" class="btn btn-light btn-sm" value="등록">
            <input type="reset"  class="btn btn-light btn-sm" value="취소">
         </form>
      </div>   
   </div>   
</section>
</body>
</html>