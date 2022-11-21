<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script
   src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<link rel="stylesheet"
   href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap"
   rel="stylesheet">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
   href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&display=swap"
   rel="stylesheet">
   
<meta charset="UTF-8">
<title>사회보험 환경설정</title>
<style>
#tabs {
   position: relative;
}

.iconG {
   position: absolute;
   top: 25px;
   left: 50px;
}

.headerline {
   position: relative;
   top: 55px;
   right: 10px;
   width: 900px;
   border-bottom: 2px solid #c4c4c4;
}

.sideline {
   position: relative;
   top: 80px;
   right: 30px;
   width: 20px;
   height: 550px;
   border-right: 2px solid #c4c4c4;
}

.socialtext {
   position: absolute;
   top: 20px;
   right: 30px;
   color: #eee;
   font-weight: 600;
   font-size: 27px;
   font-family: 'Nanum Gothic', sans-serif;
}

.yeartable {
   position: absolute;
   top: 140px;
   left: 200px;
   width: 710px;
   height: 50px;
   padding: 10px;
   border: 0px;
   background-color: #FFFEF2;
   font-size: 17px;
   font-family: 'Noto Sans KR', sans-serif;
}

.attyear {
   position: absolute;
   top: 6px;
   left: 30px;
   color: #5c5c79d2;
   font-size: 24px;
   font-weight: 500;
   font-family: 'Noto Sans KR', sans-serif;
   font-size: 24px;
}

.textyear {
   position: absolute;
   top: 6px;
   left: 250px;
   font-size: 24px;
   font-weight: 500;
   font-family: 'Noto Sans KR', sans-serif;
}

.box {
   position: absolute;
   top: 10px;
   left: 140px;
   width: 100px;
   height: 30px;
   padding: 9.5px;
   text-align: center;
   font-weight: 400;
   font-size: 19px;
   font-family: 'Noto Sans KR', sans-serif;
}

.btngroup button {
   position: absolute;
   top: 230px;
   left: 201px;
   width: 96px;
   height: 43px;
   border-top-left-radius: 5px;
   border-top-right-radius: 5px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   font-size: 17px;
   font-weight: 500;
   font-family: 'Noto Sans KR', sans-serif;
   border-top-left-radius: 5px;
}

.btngroup .active {
   color: #ffffff;
   border: 0px none #a6a7eb;
   background-color: #a6a7eb;
}

#btnNation {
   margin-left: 98px;
}

#btnWork {
   margin-left: 196px;
}

#btnIndust {
   margin-left: 294px;
}

.socialcalc {
   position: absolute;
   top: 310px;
   left: 200px;
   width: 710px;
   height: 310px;
   padding: 10px;
   border: 0px;
   background-color: #f1f0ec;
   font-size: 20px;
}

#tabs .insureHead {
   position: absolute;
   top: 25px;
   left: 95px;
   line-height: 1.7em;
   font-weight: 600;
   color: #50525c;
   font-size: 27px;
   font-family: 'Nanum Gothic', sans-serif;
   font-size: 27px;
}

.ratioH1 {
   position: absolute;
   top: 100px;
   left: 95px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 25px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioH2 {
   position: absolute;
   top: 160px;
   left: 95px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 25px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioH3 {
   position: absolute;
   top: 101px;
   left: 360px;
   color: #3b5c1c91;
   font-weight: 500;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioH4 {
   position: absolute;
   top: 161px;
   left: 360px;
   color: #3b5c1c91;
   font-weight: 500;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.txtH1 {
   position: absolute;
   top: 106px;
   left: 283px;
   width: 70px;
   height: 28px;
   font-size: 19.6px;
   font-weight: 500;
   text-align: center;
}

.txtH2 {
   position: absolute;
   top: 166px;
   left: 283px;
   width: 70px;
   height: 28px;
   font-size: 19.6px;
   font-weight: 500;
   text-align: center;
}

.btnUpdateH {
   position: absolute;
   top: 200px;
   left: 510px;
   width: 60px;
   height: 35px;
   border-top-left-radius: 5px;
   border-top-right-radius: 5px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   background-color: #a6a7eb;
   font-size: 18.5px;
   font-weight: 600;
   font-family: 'Noto Sans KR', sans-serif;
   text-align: center;
}

.btndeleteH {
   position: absolute;
   top: 200px;
   left: 575px;
   width: 60px;
   height: 35px;
   border-top-left-radius: 5px;
   border-top-right-radius: 5px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   background-color: #a6a7eb;
   font-size: 18.5px;
   font-weight: 600;
   font-family: 'Noto Sans KR', sans-serif;
   text-align: center;
}

.ratioN1 {
   position: absolute;
   top: 100px;
   left: 95px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 25px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioN2 {
   position: absolute;
   top: 160px;
   left: 95px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 25px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioN3 {
   position: absolute;
   top: 101px;
   left: 435px;
   color: #3b5c1c91;
   font-weight: 500;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioN4 {
   position: absolute;
   top: 161px;
   left: 435px;
   color: #3b5c1c91;
   font-weight: 500;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.txtN1 {
   position: absolute;
   top: 106px;
   left: 355px;
   width: 70px;
   height: 28px;
   font-size: 19.6px;
   font-weight: 500;
   text-align: center;
}

.txtN2 {
   position: absolute;
   top: 166px;
   left: 355px;
   width: 70px;
   height: 28px;
   font-size: 19.6px;
   font-weight: 500;
   text-align: center;
}

.btnUpdateN {
   position: absolute;
   top: 200px;
   left: 510px;
   width: 60px;
   height: 35px;
   border-top-left-radius: 5px;
   border-top-right-radius: 5px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   background-color: #a6a7eb;
   font-size: 18.5px;
   font-weight: 600;
   font-family: 'Noto Sans KR', sans-serif;
   text-align: center;
}

.btndeleteN {
   position: absolute;
   top: 200px;
   left: 575px;
   
   width: 60px;
   height: 35px;
   border-top-left-radius: 5px;
   border-top-right-radius: 5px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   background-color: #a6a7eb;
   font-size: 18.5px;
   font-weight: 600;
   font-family: 'Noto Sans KR', sans-serif;
   text-align: center;
}

.deducW1 {
   position: absolute;
   top: 80px;
   left: 133px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.deducW2 {
   position: absolute;
   top: 80px;
   left: 480px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioW1 {
   position: absolute;
   top: 132px;
   left: 267px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioW2 {
   position: absolute;
   top: 162px;
   left: 134px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioW3 {
   position: absolute;
   top: 193px;
   left: 92px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioW4 {
   position: absolute;
   top: 226px;
   left: 50px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioW5 {
   position: absolute;
   top: 132px;
   left: 470px;
   color: #3b5c1c91;
   font-weight: 500;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioW6 {
   position: absolute;
   top: 163px;
   left: 470px;
   color: #3b5c1c91;
   font-weight: 500;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioW7 {
   position: absolute;
   top: 194px;
   left: 470px;
   color: #3b5c1c91;
   font-weight: 500;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioW8 {
   position: absolute;
   top: 226px;
   left: 470px;
   color: #3b5c1c91;
   font-weight: 500;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.selW1 {
   position: absolute;
   top: 84px;
   left: 320px;
   width: 142px;
   height: 28px;
   font-size: 17px;
   font-weight: 500;
   text-align: left;
   border-top-left-radius: 5px;
   border-top-right-radius: 5px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   background-color: #fffef2;
}

.selW2 {
   position: absolute;
   top: 84px;
   left: 575px;
   width: 120px;
   height: 28px;
   font-size: 17px;
   font-weight: 500;
   text-align: left;
   border-top-left-radius: 5px;
   border-top-right-radius: 5px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   background-color: #fffef2;
}

.txtW3 {
   position: absolute;
   top: 138px;
   left: 390px;
   width: 70px;
   height: 26px;
   font-size: 19.6px;
   font-weight: 500;
   text-align: center;
}

.txtW4 {
   position: absolute;
   top: 169px;
   left: 390px;
   width: 70px;
   height: 26px;
   font-size: 19.6px;
   font-weight: 500;
   text-align: center;
}

.txtW5 {
   position: absolute;
   top: 200px;
   left: 390px;
   width: 70px;
   height: 26px;
   font-size: 19.6px;
   font-weight: 500;
   text-align: center;
}

.txtW6 {
   position: absolute;
   top: 231px;
   left: 390px;
   width: 70px;
   height: 26px;
   font-size: 19.6px;
   font-weight: 500;
   text-align: center;
}

.btnUpdateW {
   position: absolute;
   top: 200px;
   left: 540px;
   width: 60px;
   height: 35px;
   border-top-left-radius: 5px;
   border-top-right-radius: 5px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   background-color: #a6a7eb;
   font-size: 18.5px;
   font-weight: 600;
   font-family: 'Noto Sans KR', sans-serif;
   text-align: center;
}

.btndeleteW {
   position: absolute;
   top: 200px;
   left: 605px;
   width: 60px;
   height: 35px;
   border-top-left-radius: 5px;
   border-top-right-radius: 5px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   background-color: #a6a7eb;
   font-size: 18.5px;
   font-weight: 600;
   font-family: 'Noto Sans KR', sans-serif;
   text-align: center;
}

.ratioD1 {
   position: absolute;
   top: 100px;
   left: 95px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 25px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioD2 {
   position: absolute;
   top: 160px;
   left: 95px;
   color: #3b5c1c91;
   font-weight: 600;
   font-size: 25px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioD3 {
   position: absolute;
   top: 101px;
   left: 345px;
   color: #3b5c1c91;
   font-weight: 500;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.ratioD4 {
   position: absolute;
   top: 161px;
   left: 345px;
   color: #3b5c1c91;
   font-weight: 500;
   font-size: 23px;
   font-family: 'Noto Sans KR', sans-serif;
}

.txtD1 {
   position: absolute;
   top: 106px;
   left: 270px;
   width: 70px;
   height: 28px;
   font-size: 19.6px;
   font-weight: 500;
   text-align: center;
}

.txtD2 {
   position: absolute;
   top: 166px;
   left: 270px;
   width: 70px;
   height: 28px;
   font-size: 19.6px;
   font-weight: 500;
   text-align: center;
}

.btnUpdateD {
   position: absolute;
   top: 200px;
   left: 510px;
   width: 60px;
   height: 35px;
   border-top-left-radius: 5px;
   border-top-right-radius: 5px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   background-color: #a6a7eb;
   font-size: 18.5px;
   font-weight: 600;
   font-family: 'Noto Sans KR', sans-serif;
   text-align: center;
}

.btndeleteD {
   position: absolute;
   top: 200px;
   left: 575px;
   width: 60px;
   height: 35px;
   border-top-left-radius: 5px;
   border-top-right-radius: 5px;
   border-bottom-left-radius: 5px;
   border-bottom-right-radius: 5px;
   background-color: #a6a7eb;
   font-size: 18.5px;
   font-weight: 600;
   font-family: 'Noto Sans KR', sans-serif;
   text-align: center;
}

</style>
<script>
   var baseInsureList = {};
   var Ratio;
   
   $(document).ready(function() {
      var today = new Date();
      var year = today.getFullYear();
      document.getElementById("yearbox").value = year;
      insureData();
      $("#updateH").click(updateInsureData);
      $("#updateN").click(updateInsureData);
      $("#updateW").click(updateInsureData);
      $("#updateD").click(updateInsureData);
      $("#deleteH").click(deleteInsureData);
      $("#deleteN").click(deleteInsureData);
      $("#deleteW").click(deleteInsureData);
      $("#deleteD").click(deleteInsureData);
      $("#yearbox").keydown(function (key) {
            if (key.keyCode == 13) {
               insureData();
            }
        });
      $("#btnHealth").trigger(insureChange(event, '0'));
      $('btngroup').click(function() {
         $('btngroup').removeClass("active");
         $(this).addClass("active");
      });
   });

   function insureData() {
      var yearBox = yearbox.value;
      
      		   $.ajax({
               url : '${pageContext.request.contextPath}/salarystdinfomgmt/social',
               data : {
                  "yearBox" : yearBox,
               },
               dataType : "json",
               success : function(data) {
                  console.log("ch"+data.baseInsureList[0]);
                  
                  if (data.errorCode < 0) {
                     var str = "내부 서버 오류가 발생했습니다\n";
                     str += "관리자에게 문의하세요\n";
                     str += "에러 위치 : " + $(this).attr("id");
                     str += "에러 메시지 : " + data.errorMsg;
                     alert(str);
                     return;
                  }
                  
                  if(data.baseInsureList[0]==null){
                     console.log("**"+data.baseInsureList[0]);
                     Ratio = [];
                     
                     Ratio.push({"healthinsureRates":""}); // 6.86
                     Ratio[0].longtermcareRates=""; // 11.52
                     Ratio[0].nationworkerRates=""; // 4.5
                     Ratio[0].nationuserRates=""; // 4.5
                     Ratio[0].empinsureRates=""; // 1.6
                     Ratio[0].wrkinsureRates=""; // 0.8
                     Ratio[0].jobstabilRates=""; // 0.25
                     Ratio[0].vocacompetencyRates=""; // 0.25
                     Ratio[0].industinsureRates=""; // 6
                     Ratio[0].industinsurecharRates=""; // 0.006 */
                     console.log(Ratio);
                     
                  }else{
                  Ratio = data.baseInsureList;
                  console.log(Ratio);


                  Ratio[0].healthinsureRates; // 6.86
                  Ratio[0].longtermcareRates; // 11.52
                  Ratio[0].nationworkerRates; // 4.5
                  Ratio[0].nationuserRates; // 4.5
                  Ratio[0].empinsureRates; // 1.6
                  Ratio[0].wrkinsureRates; // 0.8
                  Ratio[0].jobstabilRates; // 0.25
                  Ratio[0].vocacompetencyRates; // 0.25
                  Ratio[0].industinsureRates; // 6
                  Ratio[0].industinsurecharRates; // 0.006


                  document.getElementById('txtH1').value = Ratio[0].healthinsureRates;
                  document.getElementById('txtH2').value = Ratio[0].longtermcareRates;
                  document.getElementById('txtN1').value = Ratio[0].nationpenisionRates;
                  document.getElementById('txtN2').value = Ratio[0].nationpenisionRates;
                  document.getElementById('txtW3').value = Ratio[0].empinsureRates;
                  document.getElementById('txtW4').value = Ratio[0].wrkinsureRates;
                  document.getElementById('txtW5').value = Ratio[0].jobstabilRates;
                  document.getElementById('txtW6').value = Ratio[0].vocacompetencyRates;
                  document.getElementById('txtD1').value = Ratio[0].industinsureRates;
                  document.getElementById('txtD2').value = Ratio[0].industinsurecharRates;
               }
               }
            });
   }

   function insureChange(evt, number) {
      var i, socialcalc, btnevt;
      socialcalc = document.getElementsByClassName("socialcalc");
      for (i = 0; i < socialcalc.length; i++) {
         socialcalc[i].style.display = "none";
      }
      btnevt = document.getElementsByClassName("btnevt");
      for (i = 0; i < btnevt.length; i++) {
         btnevt[i].className = btnevt[i].className.replace(" active", "");
      }
      document.getElementById(number).style.display = "block";
      evt.currentTarget.className += " active";
      console.log(evt.currentTarget)
   }

   function deductionChange(e) {
      var paylist = [ "전체", "급여,급상여", "상여" ];
      var target = document.getElementById("deChangeB");

      if (e.value == "pays")
         var d = paylist;
      target.options.length = 0;

      for (x in d) {
         var opt = document.createElement("option");
         opt.value = d[x];
         opt.innerHTML = d[x];
         target.appendChild(opt);
      }
   }
   
   function updateInsureData() {
         Ratio[0].attributionYear=($("#yearbox").val());
         Ratio[0].healthinsureRates=($("#txtH1").val());
         Ratio[0].longtermcareRates=($("#txtH2").val());
         Ratio[0].nationpenisionRates=($("#txtN1").val());
         Ratio[0].nationpenisionRates=($("#txtN2").val());
         Ratio[0].empinsureRates=($("#txtW3").val());
         Ratio[0].wrkinsureRates=($("#txtW4").val());
         Ratio[0].jobstabilRates=($("#txtW5").val());
         Ratio[0].vocacompetencyRates=($("#txtW6").val());
         Ratio[0].industinsureRates=($("#txtD1").val());
         Ratio[0].industinsurecharRates=($("#txtD2").val());
         var sendData = JSON.stringify(Ratio);
         $.ajax({
        	type : "PUT",
            url : "${pageContext.request.contextPath}/salarystdinfomgmt/social",
             data : sendData,
             contentType:"application/json",
            dataType : "json",
            success : function(data) {
               if (data.errorCode < 0) {
                  alert("갱신하지 못하였습니다.");
               } else {
                  alert("갱신 되었습니다.");
               }
            }
         });
         console.log(sendData)
   		 location.reload();
   }
   
   function deleteInsureData() {
      var sendData = JSON.stringify(Ratio);
      $.ajax({
    	 type : "DELETE",
         url : "${pageContext.request.contextPath}/salarystdinfomgmt/social",
          data : sendData,
          contentType:"application/json",
         dataType : "json",
         success : function(data) {
         if (data.errorCode < 0) {
               alert("삭제할 수 없습니다.");
            } else {
               alert("삭제 되었습니다.");
            }
         }
      });
      location.reload();
   }
</script>
</head>

<body>
   <section id="tabs" style="width: 1000px; height: 700px; text-align: center;">
      <div class="container wow fadeInDown">
         <div class="headerline">
            <span class="socialtext">사회보험환경등록</span>
         </div>
         <div class="sideline"></div>

         <!-- 귀속연도 테이블 -->
         <div class="yeartable">
            <div class="attyear">귀속연도</div>
            <div>
               <input type="text" class="box" id="yearbox" maxlength="4"
                  placeholder="연도입력" list="selectYear">
               <datalist id="selectYear">
                  <option value="2020">
                  <option value="2021">
                  <option value="2022">
                  <option value="2023">
               </datalist>
            </div>
            <div class="textyear">년</div>
         </div>

         <!-- 버튼 -->
         <div class=btngroup>
            <button class=btnevt id="btnHealth" onclick="insureChange(event, '0')">건강보험</button>
            <button class=btnevt id="btnNation" onclick="insureChange(event, '1')">국민연금</button>
            <button class=btnevt id="btnWork" onclick="insureChange(event, '2')">고용보험</button>
            <button class=btnevt id="btnIndust" onclick="insureChange(event, '3')">산재보험</button>
         </div>

         <!-- 건강보험Tab -->
         <div id="0" class="socialcalc">
            <div class=iconG>
               <svg xmlns="http://www.w3.org/2000/svg" width="38" height="50"
                  fill="currentColor" class="bi bi-check2-all" viewBox="0 0 16 16">
                       <path
                     d="M12.354 4.354a.5.5 0 0 0-.708-.708L5 10.293 1.854 7.146a.5.5 0 1 0-.708.708l3.5 3.5a.5.5 0 0 0 .708 0l7-7zm-4.208 7-.896-.897.707-.707.543.543 6.646-6.647a.5.5 0 0 1 .708.708l-7 7a.5.5 0 0 1-.708 0z" />
                       <path
                     d="m5.354 7.146.896.897-.707.707-.897-.896a.5.5 0 1 1 .708-.708z" />
                     </svg>
            </div>
            <div class="insureHead">건강보험</div>
            <div class="ratioH1" id="ratioHealth">건강보험부담율</div>
            <div>
               <input type="text" class="txtH1" id="txtH1">
            </div>
            <div class="ratioH3">%</div>
            <div class="ratioH2" id="ratioLong">장기요양보험율</div>
            <div>
               <input type="text" class="txtH2" id="txtH2">
            </div>
            <div class="ratioH4">%</div>
            <div>
               <button class="btnUpdateH" id="updateH">갱신</button>
               <button class="btndeleteH" id="deleteH">삭제</button>
            </div>
         </div>

         <!-- 국민연금 Tab -->
         <div id="1" class="socialcalc">
            <div class=iconG>
               <svg xmlns="http://www.w3.org/2000/svg" width="38" height="50"
                  fill="currentColor" class="bi bi-check2-all" viewBox="0 0 16 16">
            <path
                     d="M12.354 4.354a.5.5 0 0 0-.708-.708L5 10.293 1.854 7.146a.5.5 0 1 0-.708.708l3.5 3.5a.5.5 0 0 0 .708 0l7-7zm-4.208 7-.896-.897.707-.707.543.543 6.646-6.647a.5.5 0 0 1 .708.708l-7 7a.5.5 0 0 1-.708 0z" />
            <path
                     d="m5.354 7.146.896.897-.707.707-.897-.896a.5.5 0 1 1 .708-.708z" />
          </svg>
            </div>
            <div class="insureHead">국민연금</div>
            <div class="ratioN1">국민연금 개인부담율</div>
            <div>
               <input type="text" class="txtN1" id="txtN1">
            </div>
            <div class="ratioN3">%</div>
            <div class="ratioN2">국민연금 사업자부담율</div>
            <div>
               <input type="text" class="txtN2" id="txtN2">
            </div>
            <div class="ratioN4">%</div>
            <div>
               <button class="btnUpdateN" id="updateN">갱신</button>
               <button class="btndeleteN" id="deleteN">삭제</button>
            </div>
         </div>

         <!-- 고용보험 -->
         <div id="2" class="socialcalc">
            <div class=iconG>
               <svg xmlns="http://www.w3.org/2000/svg" width="38" height="50"
                  fill="currentColor" class="bi bi-check2-all" viewBox="0 0 16 16">
            <path
                     d="M12.354 4.354a.5.5 0 0 0-.708-.708L5 10.293 1.854 7.146a.5.5 0 1 0-.708.708l3.5 3.5a.5.5 0 0 0 .708 0l7-7zm-4.208 7-.896-.897.707-.707.543.543 6.646-6.647a.5.5 0 0 1 .708.708l-7 7a.5.5 0 0 1-.708 0z" />
            <path
                     d="m5.354 7.146.896.897-.707.707-.897-.896a.5.5 0 1 1 .708-.708z" />
          </svg>
            </div>
            <div class="insureHead">고용보험</div>
            <div class=deducW1>고용보험 공제방식</div>
            <div>
               <select name="job" class="selW1" id="deChangeA" name="deChangeA" onChange="deductionChange(this)">
                  <option value="wage" selected="selected">1.임금총액방식</option>
                  <option value="pays">2.보수총액방식</option>
                  <option value="tax">3.과세총액방식</option>
               </select>
            </div>
            <div class=deducW2>공제구분</div>
            <div>
               <select name="job" class="selW2" id="deChangeB" name="deChangeB"></select>
            </div>
            <div class=ratioW1>고용보험율</div>
            <div>
               <input type="text" class="txtW3" id="txtW3">
            </div>
            <div class="ratioW5">%</div>
            <div class=ratioW2>실업급여 사업자부담분율</div>
            <div>
               <input type="text" class="txtW4" id=txtW4>
            </div>
            <div class="ratioW6">%</div>
            <div class=ratioW3>고용안정사업 사업자부담분율</div>
            <div>
               <input type="text" class="txtW5" id="txtW5">
            </div>
            <div class="ratioW7">%</div>
            <div class=ratioW4>직업능력개발사업 사업자부담분율</div>
            <div>
               <input type="text" class="txtW6" id="txtW6">
            </div>
            <div class="ratioW8">%</div>
            <div>
               <button class="btnUpdateW" id="updateW">갱신</button>
               <button class="btndeleteW" id="deleteW">삭제</button>
            </div>
         </div>

         <!-- 산재보험 -->
         <div id="3" class="socialcalc">
            <div class=iconG>
               <svg xmlns="http://www.w3.org/2000/svg" width="38" height="50"
                  fill="currentColor" class="bi bi-check2-all" viewBox="0 0 16 16">
            <path
                     d="M12.354 4.354a.5.5 0 0 0-.708-.708L5 10.293 1.854 7.146a.5.5 0 1 0-.708.708l3.5 3.5a.5.5 0 0 0 .708 0l7-7zm-4.208 7-.896-.897.707-.707.543.543 6.646-6.647a.5.5 0 0 1 .708.708l-7 7a.5.5 0 0 1-.708 0z" />
            <path
                     d="m5.354 7.146.896.897-.707.707-.897-.896a.5.5 0 1 1 .708-.708z" />
          </svg>
            </div>
            <div class="insureHead">산재보험</div>
            <div class="ratioD1">산재보험율</div>
            <div>
               <input type="text" class="txtD1" id="txtD1">
            </div>
            <div class="ratioD3">%</div>
            <div class="ratioD2">출퇴근재해요율</div>
            <div>
               <input type="text" class="txtD2" id="txtD2">
            </div>
            <div class="ratioD4">%</div>
            <div>
               <button class="btnUpdateD" id="updateD">갱신</button>
               <button class="btndeleteD" id="deleteD">삭제</button>
            </div>
         </div>
      </div>
   </section>
</body>

</html>