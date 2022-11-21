<%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>호흡기 진료 지정 의료기관 정보서비스(건강보험심사평가원)</title>
<style>
section .section-title {
      text-align: center;
      color: #007b5e;
      text-transform: uppercase;
}

#tabs {
      background: #333333;
      color: #eee;
      background-color: rgba(051, 051, 051, 0.8);
}

#tabs h6.section-title {
      color: #eee;
}

#container {
      margin: auto 0;
      padding-left: 5px;
      padding-right: 5px;
}

select {
      font-size: small;
}
.example-header{
margin-top:20px;
margin-left:50px;
}
#hospital-grid{
margin:auto;
margin-top:50px;
}

</style>

<script type="text/javascript">
  $(document).ready(function() {
    $.ajax({
      url : "${pageContext.request.contextPath}/systemmgmt/rprtHospService.do",
      dataType : "json",
      data : {
        method : "getRprtHospServiceXml"
      },
      success : function(data) {
        //병의원 배열에 저장
        //일단 10개만 불러왔다
        //3289개 목록을 어떻게 효율적으로 처리할 것인지가 문제
        const hospListJinju = data.hosp;
        console.log(hospListJinju);

        var columnDefs = [
          //{headerName : "시도",field : "sidoCdNm"},
          {headerName : "시군구",field : "sgguCdNm"},
          {headerName : "요양기관명",field : "yadmNm"},
          {headerName : "신속항원검사",field : "ratPsblYn"},
          {headerName : "PCR검사",field : "pcrPsblYn"},
          {headerName : "운영시작일자",field : "mgtStaDd"},
          {headerName : "전화번호",field : "telno"},
          ];

          var gridOptions = {
              columnDefs : columnDefs,
              rowData : hospListJinju,
              defaultColDef : {
                editable : false,
                width : 100,
                resizable:true,
              },
              
              pagination: true,
              paginationPageSize: 10,
              
              
              enableRangeSelection : true,
              suppressRowClickSelection : false,
              animateRows : true,
              suppressHorizontalScroll : true,
              localeText : { noRowsToShow : '조회 결과가 없습니다.' },
              onGridReady : function(event) { event.api.sizeColumnsToFit(); },
              onGridSizeChanged : function(event) { event.api.sizeColumnsToFit(); }
          };
            //gridOptions.rowStyle = {textAlign: "center"};
              var eGridDiv = document.querySelector('#hospital-grid');
              new agGrid.Grid(eGridDiv, gridOptions);
              gridOptions.api.sizeColumnsToFit();
      },
     
    });
  });
</script>
</head>
<body>
      <section id="tabs" style="width: 100%; height: 560px;"
            class="wow fadeInDown">
            <h6 class="section-title h3" style="padding-top:20px">호흡기 진료 지정 의료기관 정보서비스(건강보험심사평가원)</h6>
            
            <div class="container">
                  <hr style="background-color: white; height: 1px;">
            </div>
            <div id="hospital-grid" style="height: 350px; width: 100%"
                  class="ag-theme-balham"></div>
      </section>
</body>
</html>