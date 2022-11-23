package kr.co.seoulit.insa.empmgmtsvc.documentmgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.service.DocumentMgmtService;
import kr.co.seoulit.insa.empmgmtsvc.documentmgmt.to.CertificateTO;


@RequestMapping("/documentmgmt/*")
@RestController
public class CertificateApprovalController {

    @Autowired
    private DocumentMgmtService documentMgmtService;
    ModelMap map = null;

    @GetMapping("certificate-approval")
    public ModelMap findCertificateListByDept(@RequestParam String deptName, String startDate, String endDate,String workplaceCode) {

        map = new ModelMap();
        try {
            ArrayList<CertificateTO> certificateList = documentMgmtService.findCertificateListByDept(deptName, startDate, endDate,workplaceCode);
            map.put("certificateList", certificateList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }

    @PutMapping("certificate-approval")
    public ModelMap modifyCertificateList(@RequestBody ArrayList<CertificateTO> certificateList) {

        map = new ModelMap();

        try {
            documentMgmtService.modifyCertificateList(certificateList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());

        }
        return map;
    }

}
