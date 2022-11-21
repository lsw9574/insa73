package kr.co.seoulit.insa.commsvc.systemmgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import kr.co.seoulit.insa.commsvc.systemmgmt.service.SystemMgmtService;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.AdminCodeTO;


@RequestMapping("/systemmgmt/*")
@RestController
public class AuthCodeMgtController {

    @Autowired
    private SystemMgmtService systemMgmtService;
    ModelMap map = null;

//	public ModelMap	adminCodeList(HttpServletRequest request, HttpServletResponse response) {
//
//		map = new ModelMap();
//
//		try {
//			ArrayList<AdminCodeTO> authCodeList = (ArrayList<AdminCodeTO>) systemMgmtService.adminCodeList();
//			map.put("authCodeList", authCodeList);
//
//		} catch (Exception e) {
//			map.put("errorCode", -1);
//			map.put("errorMsg", e.getMessage());
//		}
//		return map;
//	}

    @PutMapping("authcode")
    public ModelAndView modifyAuthority(@RequestParam String empCode, String adminCode) {
        map = new ModelMap();

        try {
            systemMgmtService.modifyAuthority(empCode, adminCode);
            map.put("errorCode", 0);
            map.put("errorMsg", "Success!");

        } catch (Exception e) {
            map.put("errorCode", -1);
            map.put("errorMsg", e.getMessage());

        }

        return null;
    }


    @GetMapping("authcode")
    public ModelMap authadminCodeList(@RequestParam String empCode) {
        map = new ModelMap();

        try {
            ArrayList<AdminCodeTO> authadminCodeList = systemMgmtService.authadminCodeList(empCode);
            map.put("authadminCodeList", authadminCodeList);

        } catch (Exception e) {
            map.put("errorCode", -1);
            map.put("errorMsg", e.getMessage());
        }

        return map;
    }


}
