package kr.co.seoulit.insa.newempsvc.newempinfomgmt.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.co.seoulit.insa.newempsvc.newempinfomgmt.service.NewEmpInfoService;
import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.ApplicantTO;
import net.sf.json.JSONObject;

@RequestMapping("/newempinfomgmt/*")
@RestController
public class PassedPersonnelController {
	@Autowired
	private NewEmpInfoService newempInfoService;
	ModelMap map = null;

	@GetMapping("applicant")
	public ModelMap applicantList(HttpServletRequest request) {
		map = new ModelMap();
		String sendData = request.getParameter("sendData");
		try
		{
			JSONObject json = JSONObject.fromObject(sendData);
			int year = Integer.parseInt( (String) json.get("year") );
			String half = (String) json.get("half");
			ArrayList<ApplicantTO> applist = newempInfoService.FindAllSuccessApplicant(year, half);
			for(ApplicantTO to : applist)
			{
				System.out.println("이름 : "+to.getName());
				System.out.println("코드 : "+to.getCode());
				System.out.println("면접점수 : "+to.getInterview_avg());
				System.out.println("인성점수 : "+to.getPersonality_avg());
			}
			map.put("applilist", applist);
			map.put("errorMsg","success");
			map.put("errorCode", 0);
		} catch (Exception e) {
			map.put("errorMsg", e.getMessage());
			map.put("errorCode", -1);
		}
		return map;
	}
}
