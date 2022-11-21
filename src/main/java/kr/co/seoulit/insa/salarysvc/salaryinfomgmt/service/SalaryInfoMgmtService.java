package kr.co.seoulit.insa.salarysvc.salaryinfomgmt.service;

import java.util.ArrayList;
import java.util.List;

import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.FullTimeSalTO;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.PayDayTO;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.RetirementSalaryTO;
import kr.co.seoulit.insa.salarysvc.salaryinfomgmt.to.SalaryBonusTO;

public interface SalaryInfoMgmtService {
	public ArrayList<FullTimeSalTO> findselectSalary(String ApplyYearMonth, String empCode);
	public ArrayList<FullTimeSalTO> findAllMoney(String empCode);
	public ArrayList<PayDayTO> findPayDayList();
	public void modifyFullTimeSalary(List<FullTimeSalTO> fullTimeSalary);
	public ArrayList<RetirementSalaryTO> findretirementSalaryList(String empCode);
	public ArrayList<SalaryBonusTO> findBonusSalary(String empCode);
}
