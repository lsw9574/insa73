package kr.co.seoulit.insa.attdsvc.attdmgmt.service;

import java.util.ArrayList;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.seoulit.insa.attdsvc.attdmgmt.mapper.DailyAttndMapper;
import kr.co.seoulit.insa.attdsvc.attdmgmt.mapper.ExcusedAttndMapper;
import kr.co.seoulit.insa.attdsvc.attdmgmt.to.DayAttdTO;
import kr.co.seoulit.insa.attdsvc.attdmgmt.to.RestAttdTO;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.ResultTO;

@Service
public class AttdMgmtServiceImpl implements AttdMgmtService {

	@Autowired
	private DailyAttndMapper dayAttdMapper;
	@Autowired
	private ExcusedAttndMapper restAttdMapper;

	@Override
	public ArrayList<DayAttdTO> findDayAttdList(String empCode, String applyDay) {

		HashMap<String , Object> map = new HashMap<>();
		map.put("empCode", empCode);
		map.put("applyDay", applyDay);

		ArrayList<DayAttdTO> dayAttdList = null;
		dayAttdList = dayAttdMapper.selectDayAttdList(map);
		return dayAttdList;

	}


	@Override
	public ResultTO registDayAttd(DayAttdTO dayAttd) {

		HashMap<String , Object> map = new HashMap<>();
		map.put("empCode",dayAttd.getEmpCode());
		map.put("attdTypeCode",dayAttd.getAttdTypeCode());
		map.put("attdTypeName",dayAttd.getAttdTypeName());
		map.put("applyDay",dayAttd.getApplyDay());
		map.put("time",dayAttd.getTime());

		dayAttdMapper.batchInsertDayAttd(map);
		ResultTO resultTO = new ResultTO();
		resultTO.setErrorCode((String) map.get("errorCode"));
		resultTO.setErrorMsg((String) map.get("errorMsg"));
		return resultTO;

	}

	@Override
	public void removeDayAttdList(ArrayList<DayAttdTO> dayAttdList) {

		for (DayAttdTO dayAttd : dayAttdList) {
			dayAttdMapper.deleteDayAttd(dayAttd);
		}

	}

//	@Override
//	public void insertDayAttd(DayAttdTO dayAttd) {
//		dayAttdMapper.insertDayAttd(dayAttd);
//	}

	@Override
	public ArrayList<RestAttdTO> findRestAttdList(String empCode, String startDate, String endDate, String code) {

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("empCode", empCode);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("code", code);
		ArrayList<RestAttdTO> restAttdList = null;

		if (code.equals(""))
			restAttdList = restAttdMapper.selectRestAttdList(map);
		else
			restAttdList = restAttdMapper.selectRestAttdListCode(map);

		return restAttdList;
	}

	@Override
	public void registRestAttd(RestAttdTO restAttd) {

		restAttdMapper.insertRestAttd(restAttd);

	}

	@Override
	public void removeRestAttdList(ArrayList<RestAttdTO> restAttdList) {

		for (RestAttdTO restAttd : restAttdList) {
			restAttdMapper.deleteRestAttd(restAttd);
		}
	}

}
