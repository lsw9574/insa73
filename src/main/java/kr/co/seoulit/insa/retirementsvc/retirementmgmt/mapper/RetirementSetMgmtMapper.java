package kr.co.seoulit.insa.retirementsvc.retirementmgmt.mapper;

import kr.co.seoulit.insa.retirementsvc.retirementmgmt.to.RetirementSetMgmtTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface RetirementSetMgmtMapper {
    public void updateRetirementSetMgmt(RetirementSetMgmtTO retirementSetMgmtTO);
    public ArrayList<RetirementSetMgmtTO> selectRetirementSetMgmtDetail();
}