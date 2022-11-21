package kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.service;

import java.util.ArrayList;

import kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.to.BaseExtSalTO;
import kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.to.BaseSalaryTO;
import kr.co.seoulit.insa.salarysvc.salarystdinfomgmt.to.SocialInsTO;

public interface SalaryStdInfoMgmtService {
	//급여기준관리
	public ArrayList<BaseSalaryTO> findBaseSalaryList();
	public void modifyBaseSalaryList(ArrayList<BaseSalaryTO> baseSalaryList);

	//초과근무관리
	public ArrayList<BaseExtSalTO> findBaseExtSalList();
	public void modifyBaseExtSalList(ArrayList<BaseExtSalTO> baseExtSalList);
	
	//사회보험관리
	public ArrayList<SocialInsTO> findBaseInsureList(String yearBox);
	public void updateInsureData(ArrayList<SocialInsTO> baseInsureList);
	public void deleteInsureData(ArrayList<SocialInsTO> baseInsureList);

}
