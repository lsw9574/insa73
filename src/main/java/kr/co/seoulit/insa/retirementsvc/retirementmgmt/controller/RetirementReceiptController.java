package kr.co.seoulit.insa.retirementsvc.retirementmgmt.controller;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.ResultTO;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.service.RetirementMgmtService;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementPersonTO;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementReceiptTO;
import net.sf.jasperreports.engine.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;

@RequestMapping("/retirementmgmt/*")
@RestController
public class RetirementReceiptController {
    @Autowired
    private RetirementMgmtService retirementMgmtService;

    ModelMap map = null;

    @PostMapping("/registRetirementReceipt")
    public ModelMap registRetirementReceipt(
            @RequestParam String empCode
            , HttpServletResponse response) {
        map = new ModelMap();

        try {
            HashMap<String, String> resultMap = retirementMgmtService.registRetirementReceipt(empCode);
            map.put("errorCode", resultMap.get("errorCode"));
            map.put("errorMsg", resultMap.get("errorMsg"));
        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }

    @PutMapping("retirementApply")
    public ModelMap retirementApply(@RequestBody RetirementPersonTO retirementPersonTO) {
        map = new ModelMap();
        ResultTO resultTO = null;
        try {
            resultTO = retirementMgmtService.retirementApply(retirementPersonTO);
            map.put("errorCode", resultTO.getErrorCode());
            map.put("errorMsg", resultTO.getErrorMsg());
        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }

    @GetMapping("retirementReceiptlist")
    public ModelMap findRetirementList(@RequestParam String empCode, String startDate, String endDate) {
        map = new ModelMap();
        System.out.println(empCode + "," + startDate + endDate);
        try {
            ArrayList<RetirementPersonTO> retirementPersonList = retirementMgmtService.findRetirementList(empCode, startDate, endDate);
            map.put("retirementPersonList", retirementPersonList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }

    @GetMapping("report")
    public ModelMap retirementReceiptReport(HttpServletRequest request, HttpServletResponse response) { // 재직증명서 신청

        String empCode = request.getParameter("empCode"); // 해쉬맵 생성, URL에서 보낸 파라미터값을 맵에 담는다

//        response.setContentType("application/json; charset=UTF-8");
//        response.setCharacterEncoding("utf-8");

        map = new ModelMap();

        try {

            RetirementReceiptTO to = retirementMgmtService.viewReport(empCode);
            JasperReport jasperReport = JasperCompileManager
                    .compileReport((request.getServletContext().getRealPath("/report/retirement.jrxml")));
            // JasperCompileManager = 네트워크전송을위한보고서디자인개체를얻기위한클래스
            // 보고서 컴파일 기능을 제공

            JRDataSource datasource = new JREmptyDataSource();
            // 내부에 지정된 수의 가상 레코드로 데이터소스를 시뮬레이트하는 클래스
            map.put("empName", to.getEmpName());
            map.put("deptName", to.getDeptName());
            map.put("birthdate", to.getBirthdate());
            map.put("position", to.getPosition());
            map.put("address", to.getAddress());
            map.put("retirementRange", to.getRetirementRange());
            map.put("hiredate", to.getHiredate());
            map.put("retiredate", to.getRetiredate());
            map.put("retirementPayCheckDate", to.getRetirementPayCheckDate());
            map.put("retirementPayDate", to.getRetirementPayDate());
            map.put("retirementPay", to.getRetirementPay());
            map.put("workplaceName", to.getWorkplaceName());
            map.put("workplaceAddress", to.getWorkplaceAddress());
            map.put("today", to.getToday());
            ServletOutputStream outputStream = null;

            // 결과가 올바로 넘어 왔는지 출력으로 확인
            for (String key : map.keySet()) {
                System.out.println(key);
                System.out.println(map.get(key));
            }
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, map, datasource);
            // 맵에 담았던 값과 제스퍼 리포트를 인자값에 넣어서 JasperPrint를 실행한다.
            // JasperFillManager= 보고서디자인에 데이터를 채우는 클래스
            // fillReport (jasperReport형식, Map형식, dataSource형식)

            outputStream = response.getOutputStream(); // 응답되어진것에대한적합한 OutputStream을 반환해줌
            response.setContentType("application/pdf"); // PDF형식으로 변환!
            // JasperExportManager.exportReportToPdfFile(jasperPrint,"C:\\insa\\Insa_1th_Project.zip_expanded\\insa2\\WebContent\\report\\test01.pdf");
            // // 본인 이클립스 경로
            // JasperExportManager.exportReportToPdfFile(jasperPrint,
            // (request.getServletContext().getRealPath("/report/test01.pdf")));

            JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
            // JasperExportManager = 생성된보고서를 pdf,html,xml 형식으로 내보내는 class
            // 첫번째 매개변수로 생성 된 보고서를 pdf 형식으로 두번째 매개변수로 지정된 출력스트림에 사용함

            outputStream.flush();
        } catch (Exception e) {
            map.put("errorCode", -1);
            map.put("errorMsg", e.getMessage());
        }

        return map;
    }
}