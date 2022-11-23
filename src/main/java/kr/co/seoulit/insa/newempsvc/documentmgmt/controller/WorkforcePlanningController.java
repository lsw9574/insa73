package kr.co.seoulit.insa.newempsvc.documentmgmt.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.co.seoulit.insa.newempsvc.documentmgmt.service.NDocumentMgmtService;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.ConditionTO;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.FileTO;
import net.sf.json.JSONArray;

@RequestMapping("/documentmgmt/*")
@RestController
public class WorkforcePlanningController {
	
	@Autowired
	private NDocumentMgmtService documentMgmtService;
	
	ModelMap map = null;
	
	@PostMapping("condition")
	public ModelMap registTerm(@RequestBody ConditionTO nemp) {
		map = new ModelMap();
		try
		{
			System.out.println("last_school : "+nemp.getLast_school());
			documentMgmtService.registCondition(nemp);
			map.put("errorMsg","success");
			map.put("errorCode", 0);
			nemp=null;
		} catch (Exception e) {
			map.clear();
			map.put("errorMsg", e.getMessage());
			map.put("errorCode", -1);
		}
		return map;
	}
	
	@PostMapping("conditionFile")
	public ModelMap ConditionFile(HttpServletRequest request, @RequestParam("hwp_file") MultipartFile multi)
	{		
		System.out.println("multi.getOriginalFilename() : "+multi.getOriginalFilename());
		System.out.println("multi.getName() : "+multi.getName());
		System.out.println("multi.getContentType() : "+multi.getContentType());
		try {
			if(!multi.isEmpty())
			{
				String uploadPath =request.getServletContext().getContextPath();
				FileTO to = new FileTO();
				to.setFileName(multi.getOriginalFilename());
				to.setUid(multi.getName());
				to.setContentType(multi.getContentType());
				File newFileName = new File(uploadPath+to.getFileName());
				multi.transferTo(newFileName);
			}
		}
		catch(Exception e)
		{
			map.clear();
			map.put("errorMsg", e.getMessage());
			map.put("errorCode", -1);
		}
		return null;
	}
	
	@GetMapping("termslist")
	public ModelMap termList(@RequestParam String workplaceCode)
	{		
		map = new ModelMap();
		try
		{
			ArrayList<ConditionTO> termlist = documentMgmtService.FindAllTermlist(workplaceCode);
			String tempFilename;
			StringTokenizer st = null;
			for(ConditionTO to : termlist)
			{
				tempFilename =to.getHwp_file().substring(0);
				st = new StringTokenizer(tempFilename,"\\");
				String[] arr = new String[3];
				for(int i = 0; i < 3; i++)
					arr[i] = st.nextToken();
				to.setHwp_file(arr[2]);
			}
			JSONArray json = JSONArray.fromObject(termlist);
			map.put("termlist", json);
			map.put("errorMsg","success");
			map.put("errorCode", 0);
		} catch (Exception e) {
			map.put("errorMsg", e.getMessage());
			map.put("errorCode", -1);
		}
		return map;
	}
}
