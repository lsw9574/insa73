package kr.co.seoulit.insa.commsvc.systemmgmt.controller;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import kr.co.seoulit.insa.commsvc.systemmgmt.service.SystemMgmtService;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.MenuTO;

@RequestMapping("/systemmgmt/*")
@RestController
public class MenuController {
	
	@Autowired
	private SystemMgmtService systemMgmtService;
	
	ModelMap map = null;
	
	@GetMapping("menulist")
	public ModelMap findMenuList() {
		map = new ModelMap();
		try {

			ArrayList<MenuTO> menuList = systemMgmtService.findMenuList();
			ArrayList<MenuTO> navbarList = new ArrayList<>();

			for (MenuTO menuBean : menuList) {
				if (menuBean.getNavbar_name() != null) {
					navbarList.add(menuBean);
				}
			}
			map.put("menuList", menuList);
			map.put("navbarList", navbarList);
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
