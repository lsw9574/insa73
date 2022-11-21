package kr.co.seoulit.insa.newempsvc.documentmgmt.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kr.co.seoulit.insa.newempsvc.documentmgmt.service.NDocumentMgmtService;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.GanttDataTO;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.GanttLinksTO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RequestMapping("/documentmgmt/*")
@RestController
public class ProgressEducationController
{
	@Autowired
	private NDocumentMgmtService documentMgmtService;
	
	ModelMap map = null;
	
	@PostMapping("educationmgmt")
	public ModelMap educationManage(HttpServletRequest request) {
		map = new ModelMap();
		String sendData = request.getParameter("jsonData");
		try
		{
			System.out.println(sendData);
			JSONObject jsonobj = JSONObject.fromObject(sendData);
			JSONArray jsonarr_data = JSONArray.fromObject(jsonobj.get("data"));
			JSONArray jsonarr_link = JSONArray.fromObject(jsonobj.get("links"));
			Gson gson = new Gson();
			ArrayList<GanttDataTO> dataList = gson.fromJson(jsonarr_data.toString() ,new TypeToken<ArrayList<GanttDataTO>>(){}.getType());
			for(GanttDataTO to : dataList)
				to.setOpen("true");
			ArrayList<GanttLinksTO> linkList = gson.fromJson(jsonarr_link.toString() ,new TypeToken<ArrayList<GanttLinksTO>>(){}.getType());
			
			documentMgmtService.InsertEducationData(dataList,linkList);
			map.put("errorMsg","success");
			map.put("errorCode", 0);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errorCode", -1);
			map.put("errorMsg",e);
		}
		return map;
	}
	
	@GetMapping("ganttchartdata")
	public ModelMap getGanttChart() {
		map = new ModelMap();
		try {
			ArrayList<GanttDataTO> datas = documentMgmtService.findganttDataList();
			ArrayList<GanttLinksTO> links = documentMgmtService.findganttLinksList();
			HashMap<String, Object> datamap = new HashMap<>();
			datamap.put("data", datas);
			datamap.put("links", links);
			map.put("datalinks", datamap);
		} catch (Exception e) {
			map.put("errorCode", -1);
			map.put("errorMsg", e.getMessage());
		}
		return map;
	}
}
