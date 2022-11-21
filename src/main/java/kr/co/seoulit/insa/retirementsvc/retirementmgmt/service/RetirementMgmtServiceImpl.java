package kr.co.seoulit.insa.retirementsvc.retirementmgmt.service;

import kr.co.seoulit.insa.commsvc.systemmgmt.to.ResultTO;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.mapper.RetirementPayMapper;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.mapper.RetirementReceiptMapper;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.mapper.RetirementSetMgmtMapper;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementPayTO;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementPersonTO;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementReceiptTO;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementSetMgmtTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class RetirementMgmtServiceImpl implements RetirementMgmtService {

    @Autowired
    private RetirementSetMgmtMapper retirementSetMgmtMapper;
    @Autowired
    private RetirementPayMapper retirementPayMapper;
    @Autowired
    private RetirementReceiptMapper retirementReceiptMapper;

    @Override
    public void modifyRetirementSetMgmt(RetirementSetMgmtTO retirementSetMgmtTO) {
        retirementSetMgmtMapper.updateRetirementSetMgmt(retirementSetMgmtTO);
    }

    @Override
    public ArrayList<RetirementSetMgmtTO> findRetirementSetMgmtDetail() {
        return retirementSetMgmtMapper.selectRetirementSetMgmtDetail();
    }

    @Override
    public HashMap<String, Object> findRetirementPay(String empCode) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("empCode", empCode);
        retirementPayMapper.selectRetirementPay(map);
        return map;
    }

    @Override
    public RetirementReceiptTO viewReport(String empCode) {
        HashMap<String, Object> map = findRetirementPay(empCode);
        ArrayList<RetirementPayTO> list = (ArrayList<RetirementPayTO>) map.get("result");
        RetirementPayTO to = list.get(0);
        return retirementReceiptMapper.selectReport(empCode, to.getRetirementRange(), to.getHiredate(), to.getRetiredate(), to.getRetirementPay());
    }

    @Override
    public ArrayList<RetirementPersonTO> findRetirementList(String empCode, String startDate, String endDate) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("empCode", empCode);
        map.put("startDate", startDate);
        map.put("endDate", endDate);

        ArrayList<RetirementPersonTO> retirementPersonList = retirementReceiptMapper.selectRetirementList(empCode, startDate, endDate);
        return retirementPersonList;
    }

    @Override
    public ResultTO retirementApply(RetirementPersonTO retirementPersonTO) {
        HashMap<String, String> map = new HashMap<>();
        map.put("empCode", retirementPersonTO.getEmpCode());
        map.put("retirementDate", retirementPersonTO.getRetirementDate());
        retirementReceiptMapper.updateWorkInfo(map);

        ResultTO resultTO = new ResultTO();
        resultTO.setErrorCode(map.get("errorCode"));
        resultTO.setErrorMsg(map.get("errorMsg"));
        System.out.println(resultTO.getErrorCode() + "," + resultTO.getErrorMsg());

        return resultTO;
    }

    @Override
    public HashMap<String, String> registRetirementReceipt(String empCode) {
        HashMap<String, String> map = new HashMap<>();
        map.put("empCode", empCode);
        System.out.println("영수증임플:" + empCode);
        retirementReceiptMapper.insertRetirementReceipt(map);
        System.out.println(map.get("errorCode") + "," + map.get("errorMsg"));
        return map;
    }

}