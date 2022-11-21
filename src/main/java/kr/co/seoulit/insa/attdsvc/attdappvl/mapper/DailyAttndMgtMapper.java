package kr.co.seoulit.insa.attdsvc.attdappvl.mapper;

import java.util.HashMap;
import org.apache.ibatis.annotations.Mapper;
import kr.co.seoulit.insa.attdsvc.attdappvl.to.DayAttdMgtTO;

@Mapper
public interface DailyAttndMgtMapper {
	public HashMap<String, Object> batchDayAttdMgtProcess(HashMap<String, Object> map);
	public void updateDayAttdMgtList(DayAttdMgtTO dayAttdMgt);
}
