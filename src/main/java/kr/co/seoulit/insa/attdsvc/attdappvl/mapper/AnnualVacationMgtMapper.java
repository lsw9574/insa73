package kr.co.seoulit.insa.attdsvc.attdappvl.mapper;

import java.util.HashMap;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.attdsvc.attdappvl.to.AnnualLeaveMgtTO;

@Mapper
public interface AnnualVacationMgtMapper {
   public HashMap<String, Object> batchAnnualVacationMgtProcess(HashMap<String,Object> map);
   public void updateAnnualVacationMgtList(AnnualLeaveMgtTO annualVacationMgt);
   public void updateAnnualVacationList(AnnualLeaveMgtTO annualVacationMgt);
   public void cancelAnnualVacationMgtList(AnnualLeaveMgtTO annualVacationMgt);
   public void cancelAnnualVacationList(AnnualLeaveMgtTO annualVacationMgt);
}