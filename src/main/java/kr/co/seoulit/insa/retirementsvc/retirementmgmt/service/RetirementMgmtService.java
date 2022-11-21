package kr.co.seoulit.insa.retirementsvc.retirementmgmt.service;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.ResultTO;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementPersonTO;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementReceiptTO;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementSetMgmtTO;

import java.util.ArrayList;
import java.util.HashMap;

public interface RetirementMgmtService {

    public void modifyRetirementSetMgmt(RetirementSetMgmtTO retirementSetMgmtTO);

    public ArrayList<RetirementSetMgmtTO> findRetirementSetMgmtDetail();

    public HashMap<String, Object> findRetirementPay(String empCode);

    public RetirementReceiptTO viewReport(String empCode);

    public ArrayList<RetirementPersonTO> findRetirementList(String empCode, String startDate, String endDate);

    public ResultTO retirementApply(RetirementPersonTO retirementPersonTO);

    public HashMap<String, String> registRetirementReceipt(String empCode);
}
