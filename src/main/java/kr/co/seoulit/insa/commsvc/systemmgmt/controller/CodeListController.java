package kr.co.seoulit.insa.commsvc.systemmgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import kr.co.seoulit.insa.commsvc.systemmgmt.service.SystemMgmtService;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.CodeTO;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.DetailCodeTO;


@RequestMapping("/systemmgmt/*")
@RestController
public class CodeListController {

    @Autowired
    private SystemMgmtService systemMgmtService;

    ModelMap map = null;

    @GetMapping("codelist")
    public ModelMap detailCodelist(@RequestParam String code) {

        map = new ModelMap();

        try {
            ArrayList<DetailCodeTO> detailCodeList = systemMgmtService.findDetailCodeList(code);

            map.put("detailCodeList", detailCodeList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }
    @PutMapping("codelist")
    public ModelMap batchCodelist(@RequestBody ArrayList<DetailCodeTO> detailCodeList) {

        map = new ModelMap();

        try {
            systemMgmtService.batchCodelistProcess(detailCodeList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception e) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", e.getMessage());
        }
        return map;
    }

    @GetMapping("code/rest")
    public ModelMap detailCodelistRest(@RequestParam String code1, String code2, String code3) {

        map = new ModelMap();

        try {

            ArrayList<DetailCodeTO> detailCodeList = systemMgmtService.findDetailCodeListRest(code1, code2, code3);
            map.put("detailCodeList", detailCodeList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (Exception dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());
        }
        return map;
    }


    @GetMapping("codelist/all")
    public ModelMap codelist() {
        map = new ModelMap();
        try {
            ArrayList<CodeTO> codeList = systemMgmtService.findCodeList();
            map.put("codeList", codeList);
            map.put("errorMsg", "success");
            map.put("errorCode", 0);

        } catch (DataAccessException dae) {
            map.clear();
            map.put("errorCode", -1);
            map.put("errorMsg", dae.getMessage());

        }
        return map;
    }
}
