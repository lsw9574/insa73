package kr.co.seoulit.insa.attdsvc.attdappvl.mapper;

import java.util.HashMap;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.attdsvc.attdappvl.to.MonthAttdMgtTO;

@Mapper
public interface MonthlyAttndMgtMapper {
	public HashMap<String, Object> batchMonthAttdMgtProcess(HashMap<String, Object> map);
	public void updateMonthAttdMgtList(MonthAttdMgtTO monthAttdMgt);
}
