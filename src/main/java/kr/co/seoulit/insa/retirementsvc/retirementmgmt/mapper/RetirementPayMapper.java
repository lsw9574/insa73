package kr.co.seoulit.insa.retirementsvc.retirementmgmt.mapper;

import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementPayTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.HashMap;

@Mapper
public interface RetirementPayMapper {
    public void selectRetirementPay(HashMap<String, Object> map);
}