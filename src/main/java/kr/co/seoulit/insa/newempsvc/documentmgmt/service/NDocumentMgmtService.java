package kr.co.seoulit.insa.newempsvc.documentmgmt.service;

import java.util.ArrayList;

import kr.co.seoulit.insa.newempsvc.documentmgmt.to.ConditionTO;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.GanttDataTO;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.GanttLinksTO;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.RecruitmentTO;


public interface NDocumentMgmtService {
	public void registCondition(ConditionTO nemp);

	public ArrayList<ConditionTO> FindAllTermlist();

	public void InsertEducationData(ArrayList<GanttDataTO> dataList, ArrayList<GanttLinksTO> linksList);

	public ArrayList<GanttDataTO> findganttDataList();

	public ArrayList<GanttLinksTO> findganttLinksList();

	public ArrayList<RecruitmentTO> FindNewemprecruit(int year, String half);

	public void RegisterEmp(ArrayList<RecruitmentTO> recruitList);
	
}
