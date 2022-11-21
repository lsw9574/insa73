package kr.co.seoulit.insa.attdsvc.attdappvl.service;

import java.util.ArrayList;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.seoulit.insa.attdsvc.attdappvl.to.DayAttdMgtTO;
import kr.co.seoulit.insa.attdsvc.attdappvl.to.MonthAttdMgtTO;
import kr.co.seoulit.insa.attdsvc.attdappvl.mapper.AnnualVacationMgtMapper;
import kr.co.seoulit.insa.attdsvc.attdappvl.mapper.DailyAttndMgtMapper;
import kr.co.seoulit.insa.attdsvc.attdappvl.mapper.MonthlyAttndMgtMapper;
import kr.co.seoulit.insa.attdsvc.attdappvl.to.AnnualLeaveMgtTO;
import kr.co.seoulit.insa.attdsvc.attdmgmt.mapper.ExcusedAttndMapper;
import kr.co.seoulit.insa.attdsvc.attdmgmt.to.RestAttdTO;



@Service
public class AttdAppvlServiceImpl implements AttdAppvlService {
	
	@Autowired
	private DailyAttndMgtMapper dayAttdMgtMapper;
	@Autowired
	private ExcusedAttndMapper excusedAttndMapper;
	@Autowired
	private MonthlyAttndMgtMapper monthAttdMgtMapper;
	@Autowired
	private AnnualVacationMgtMapper annualVacationMgtMapper;

	
	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<DayAttdMgtTO> findDayAttdMgtList(String applyDay) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("applyDay",applyDay);
		dayAttdMgtMapper.batchDayAttdMgtProcess(map);
		
		return (ArrayList<DayAttdMgtTO>) map.get("result");
	}

	@Override
	public void modifyDayAttdMgtList(ArrayList<DayAttdMgtTO> dayAttdMgtList) {

		for (DayAttdMgtTO dayAttdMgt : dayAttdMgtList) {
			if (dayAttdMgt.getStatus().equals("update")) {
				dayAttdMgtMapper.updateDayAttdMgtList(dayAttdMgt);
			}
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<MonthAttdMgtTO> findMonthAttdMgtList(String applyYearMonth) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("applyYearMonth", applyYearMonth);

		monthAttdMgtMapper.batchMonthAttdMgtProcess(map);

		return (ArrayList<MonthAttdMgtTO>) map.get("result");
	}

	@Override
	public void modifyMonthAttdMgtList(ArrayList<MonthAttdMgtTO> monthAttdMgtList) {

		for (MonthAttdMgtTO monthAttdMgt : monthAttdMgtList) {
			if (monthAttdMgt.getStatus().equals("update")) {
				monthAttdMgtMapper.updateMonthAttdMgtList(monthAttdMgt);
			}
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<AnnualLeaveMgtTO> findAnnualVacationMgtList(String applyYearMonth) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("applyYearMonth", applyYearMonth);

		annualVacationMgtMapper.batchAnnualVacationMgtProcess(map);

		return (ArrayList<AnnualLeaveMgtTO>) map.get("result");
	}

	@Override
	public void modifyAnnualVacationMgtList(ArrayList<AnnualLeaveMgtTO> annualVacationMgtList) {

		for (AnnualLeaveMgtTO annualVacationMgt : annualVacationMgtList) {
			if (annualVacationMgt.getStatus().equals("update")) {
				annualVacationMgtMapper.updateAnnualVacationMgtList(annualVacationMgt);
				annualVacationMgtMapper.updateAnnualVacationList(annualVacationMgt);
			}
		}

	}

	@Override
	public void cancelAnnualVacationMgtList(ArrayList<AnnualLeaveMgtTO> annualVacationMgtList) {

		for (AnnualLeaveMgtTO annualVacationMgt : annualVacationMgtList) {
			if (annualVacationMgt.getStatus().equals("update")) {
				annualVacationMgtMapper.cancelAnnualVacationMgtList(annualVacationMgt);
				annualVacationMgtMapper.cancelAnnualVacationList(annualVacationMgt);
			}
		}

	}

	@Override
	public ArrayList<RestAttdTO> findRestAttdListByDept(String deptName, String startDate, String endDate) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<RestAttdTO> restAttdList = null;
		map.put("deptName", deptName);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		
		if (deptName.equals("모든부서")) {
			restAttdList = excusedAttndMapper.selectRestAttdListByAllDept(startDate);
		} else {

			restAttdList = excusedAttndMapper.selectRestAttdListByDept(map);
		}

		return restAttdList;
	}

	@Override
	public void modifyRestAttdList(ArrayList<RestAttdTO> restAttdList) {

		for (RestAttdTO restAttd : restAttdList) {
			System.out.println(restAttd.getStatus());
			if (restAttd.getStatus().equals("update")) {
				excusedAttndMapper.updateRestAttd(restAttd);
			}
		}
	}
	
}
