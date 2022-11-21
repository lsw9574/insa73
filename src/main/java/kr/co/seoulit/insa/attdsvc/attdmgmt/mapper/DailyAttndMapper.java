package kr.co.seoulit.insa.attdsvc.attdmgmt.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.insa.attdsvc.attdmgmt.to.DayAttdTO;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.ResultTO;
@Mapper
public interface DailyAttndMapper {
	public ArrayList<DayAttdTO> selectDayAttdList(HashMap<String , Object> map);
	public ResultTO batchInsertDayAttd(HashMap<String , Object> map);
	public void insertDayAttd(DayAttdTO dayAttd);
	public void deleteDayAttd(DayAttdTO dayAttd);
}
