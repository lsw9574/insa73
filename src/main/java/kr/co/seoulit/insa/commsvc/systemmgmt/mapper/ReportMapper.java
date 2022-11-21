package kr.co.seoulit.insa.commsvc.systemmgmt.mapper;

import java.util.HashMap;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.ReportSalaryTO;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.ReportTO;

@Mapper
public interface ReportMapper {
	
   public ReportTO selectReport(String empCode);
   public ReportSalaryTO selecSalarytReport(HashMap<String, String> map);
   
}