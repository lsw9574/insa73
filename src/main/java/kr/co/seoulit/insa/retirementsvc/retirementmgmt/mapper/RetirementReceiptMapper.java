package kr.co.seoulit.insa.retirementsvc.retirementmgmt.mapper;

import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementPayTO;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementPersonTO;
import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementReceiptTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.HashMap;

@Mapper
public interface RetirementReceiptMapper {
    public RetirementReceiptTO selectReport(String empCode,String retirementRange,String hireDate,String retireDate,String retirementPay);
    public ArrayList<RetirementPersonTO> selectRetirementList(HashMap<String, Object> map);
    public void updateWorkInfo(HashMap<String, String> map);
}