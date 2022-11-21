package kr.co.seoulit.insa.newempsvc.documentmgmt.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.seoulit.insa.newempsvc.documentmgmt.mapper.NewempApprovalMapper;
import kr.co.seoulit.insa.newempsvc.documentmgmt.mapper.ConditionMapper;
import kr.co.seoulit.insa.newempsvc.documentmgmt.mapper.EducationMapper;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.ConditionTO;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.GanttDataTO;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.GanttLinksTO;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.RecruitmentTO;

@Service
public class NDocumentMgmtServiceImpl implements NDocumentMgmtService {

	@Autowired
	private ConditionMapper conditionMapper;
	
	@Autowired
	private EducationMapper educationMapper;
	
	@Autowired
	private NewempApprovalMapper approvalMapper;
	
	@Override
	public void registCondition(ConditionTO nemp) {
		conditionMapper.registCondition(nemp);
	}

	@Override
	public ArrayList<ConditionTO> FindAllTermlist() {
		// TODO Auto-generated method stub
		return conditionMapper.FindAllTermlist();
	}

	@Override
	public void InsertEducationData(ArrayList<GanttDataTO> dataList, ArrayList<GanttLinksTO> linksList) {
		// TODO Auto-generated method stub
		for(GanttDataTO data : dataList)
			educationMapper.insertData(data);
		
		for(GanttLinksTO link : linksList)
			educationMapper.insertLinks(link);
	}

	@Override
	public ArrayList<GanttDataTO> findganttDataList() {
		// TODO Auto-generated method stub
		return educationMapper.findganttDataList();
	}

	@Override
	public ArrayList<GanttLinksTO> findganttLinksList() {
		// TODO Auto-generated method stub
		return educationMapper.findganttLinksList();
	}

	@Override
	public ArrayList<RecruitmentTO> FindNewemprecruit(int year, String half) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		map.put("year", year);
		map.put("half", half);
		return approvalMapper.findnewempcruit(map);
	}

	@Override
	public void RegisterEmp(ArrayList<RecruitmentTO> recruitList) {
		// TODO Auto-generated method stub
		for(RecruitmentTO to : recruitList)
			approvalMapper.RegisterEmp(to);
	}

}
