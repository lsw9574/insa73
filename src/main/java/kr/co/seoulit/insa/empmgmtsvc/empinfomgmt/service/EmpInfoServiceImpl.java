package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.service;

import kr.co.seoulit.insa.commsvc.foudinfomgmt.mapper.DeptMapper;
import kr.co.seoulit.insa.commsvc.foudinfomgmt.to.DeptTO;
import kr.co.seoulit.insa.commsvc.systemmgmt.mapper.DetailCodeMapper;
import kr.co.seoulit.insa.commsvc.systemmgmt.to.DetailCodeTO;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.mapper.*;
import kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.to.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

@Service
public class EmpInfoServiceImpl implements EmpInfoService {

	@Autowired
	private EmpAppointmentMapper empAppointmentMapper;
	@Autowired
	private DeptMapper deptMapper;
	@Autowired
	private EmpMapper empMapper;
	@Autowired
	private DetailCodeMapper detailCodeMapper;
	@Autowired
	private FamilyInfoMapper familyInfoMapper;
	@Autowired
	private WorkInfoMapper workInfoMapper;
	@Autowired
	private LicenseInfoMapper licenseInfoMapper;
	@Autowired
	private EmpEvalMapper empEvalMapper;

	@Override
	public EmpTO getEmp(String name) {

		EmpTO empto = null;
		empto = empMapper.selectEmp(name);
		return empto;

	}

	@Override
	public String findLastEmpCode() {

		String empCode = null;
		empCode = empMapper.selectLastEmpCode();
		return empCode;

	}

	@Override
	public EmpTO findAllEmpInfo(String empCode) {
		EmpTO empTO = null;
		empTO = empMapper.selectEmployee(empCode);
		return empTO;

	}

	@Override
	public ArrayList<EmpTO> findEmpList(String deptName) {

		ArrayList<EmpTO> empList = null;
		if (deptName.equals("전체부서")) {
			empList = empMapper.selectEmpList();
		} else if (deptName.substring(deptName.length() - 1, deptName.length()).equals("팀")) {
			empList = empMapper.selectEmpListD(deptName);

		} else {
			empList = empMapper.selectEmpListN(deptName);
		}
		return empList;

	}

	@Override
	public void registEmployee(EmpTO emp) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("empCode", emp.getEmpCode());
		map.put("empName", emp.getEmpName());
		map.put("birthdate", emp.getBirthdate());
		map.put("gender", emp.getGender());
		map.put("mobileNumber", emp.getMobileNumber());
		map.put("address", emp.getAddress());
		map.put("detailAddress", emp.getDetailAddress());
		map.put("postNumber", emp.getPostNumber());
		map.put("email", emp.getEmail());
		map.put("lastSchool", emp.getLastSchool());
		map.put("imgExtend", emp.getImgExtend());
		map.put("deptName", emp.getDeptName());
		map.put("position", emp.getPosition());
		map.put("hobong", emp.getHobong());
		map.put("occupation", emp.getOccupation());
		map.put("employment", emp.getEmployment());

		empMapper.registEmployee(map);

		DetailCodeTO detailCodeto = new DetailCodeTO();
		detailCodeto.setDetailCodeNumber(emp.getEmpCode());
		detailCodeto.setDetailCodeName(emp.getEmpName());
		detailCodeto.setCodeNumber("CO-17");
		detailCodeto.setDetailCodeNameusing("N");
		detailCodeMapper.registDetailCode(detailCodeto);

	}

	@Override
	public void modifyEmployee(EmpTO emp) {

		if (emp.getStatus().equals("update")) {
			empMapper.updateEmployee(emp);
		}
		if (emp.getWorkInfo() != null) {
			ArrayList<WorkInfoTO> workInfoList = emp.getWorkInfo();
			for (WorkInfoTO workInfo : workInfoList) {
				switch (workInfo.getStatus()) {
					case "insert":
						workInfoMapper.insertWorkInfo(workInfo);
						break;
					case "update":
						workInfoMapper.updateWorkInfo(workInfo);
						break;
					case "delete":
						workInfoMapper.deleteWorkInfo(workInfo);
						break;
				}
			}
		}

		if (emp.getLicenseInfoList() != null && emp.getLicenseInfoList().size() > 0) {
			ArrayList<LicenseInfoTO> licenseInfoList = emp.getLicenseInfoList();
			for (LicenseInfoTO licenseInfo : licenseInfoList) {
				switch (licenseInfo.getStatus()) {
					case "insert":
						licenseInfoMapper.insertLicenseInfo(licenseInfo);
						break;
					case "update":
						licenseInfoMapper.updateLicenseInfo(licenseInfo);
						break;
					case "delete":
						licenseInfoMapper.deleteLicenseInfo(licenseInfo);
						break;
				}
			}
		}

		if (emp.getFamilyInfoList() != null && emp.getFamilyInfoList().size() > 0) {
			ArrayList<FamilyInfoTO> familyInfoList = emp.getFamilyInfoList();
			for (FamilyInfoTO familyInfo : familyInfoList) {
				switch (familyInfo.getStatus()) {
					case "insert":
						familyInfoMapper.insertFamilyInfo(familyInfo);
						break;
					case "update":
						familyInfoMapper.updateFamilyInfo(familyInfo);
						break;
					case "delete":
						familyInfoMapper.deleteFamilyInfo(familyInfo);
						break;
				}
			}
		}

	}

	@Override
	public void deleteEmpList(ArrayList<EmpTO> empList) {
		HashMap<String, String> map = new HashMap<>();
		for (EmpTO emp : empList) {
			map.put("empCode", emp.getEmpCode());
			empMapper.deleteEmployee(map);
			DetailCodeTO detailCodeto = new DetailCodeTO();
			detailCodeto.setDetailCodeNumber(emp.getEmpCode());
			detailCodeto.setDetailCodeName(emp.getEmpName());
			detailCodeMapper.deleteDetailCode(detailCodeto);
		}

	}

	@Override
	public ArrayList<DeptTO> findDeptList() {

		ArrayList<DeptTO> deptList = null;
		deptList = deptMapper.selectDeptList();
		return deptList;

	}

	@Override
	public void registEmpEval(EmpEvalTO empeval) {

		empEvalMapper.insertEmpEval(empeval);

	}

	@Override
	public ArrayList<EmpEvalTO> findEmpEval() {

		ArrayList<EmpEvalTO> empevallsit = null;
		empevallsit = empEvalMapper.selectEmpEval();
		return empevallsit;

	}

	@Override
	public ArrayList<EmpEvalTO> findEmpEval(String dept, String year) {
		HashMap<String, String> map = new HashMap<>();
		map.put("deptName", dept);
		map.put("apply_day", year);
		ArrayList<EmpEvalTO> empevallsit = null;

		if (dept.equals("모든부서")) {
			empevallsit = empEvalMapper.selectEmpEval();
		} else {
			empevallsit = empEvalMapper.selectEmpEvalDept(map);
		}
		return empevallsit;

	}

	@Override
	public void modifyEmpEvalList(ArrayList<EmpEvalTO> empevalList) {

		for (EmpEvalTO empeval : empevalList) {
			int evalhap = empeval.getAchievement() + empeval.getAbility() + empeval.getAttitude();
			if (evalhap > 260) {
				empeval.setGrade("A");
			} else if (evalhap > 240) {
				empeval.setGrade("B");
			} else if (evalhap > 220) {
				empeval.setGrade("C");
			} else {
				empeval.setGrade("D");
			}
			empEvalMapper.updateEmpEval(empeval);
		}
	}

	@Override
	public void removeEmpEvalList(String emp_code, String apply_day) {
		HashMap<String, String> map = new HashMap<>();
		map.put("empCode", emp_code);
		map.put("apply_day", apply_day);

		empEvalMapper.deleteEmpEval(map);

	}

	@Override
	public ArrayList<EmpAppointmentInfoTO> allEmpAppointInfo() {
		ArrayList<EmpAppointmentInfoTO> list = null;
		list = empAppointmentMapper.findAppointmentInfo();
		return list;
	}

	@Override
	public ArrayList<EmpAppointmentTypeTO> findAllAppointEmp(String hosu) {
		ArrayList<EmpAppointmentTypeTO> list = empAppointmentMapper.selectAllAppointEmp(hosu);
		return list;
	}

	@Override
	public EmpAppointmentTO countAppointmentEmp(String hosu) {
		EmpAppointmentTO list = empAppointmentMapper.countAppointmentEmp(hosu);
		return list;
	}

	@Override
	public ArrayList<EmpAppointmentTypeTO> findAppointmentInfoEmp(String hosu, String type) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("hosu", hosu);
		map.put("type", type);
		ArrayList<EmpAppointmentTypeTO> list = empAppointmentMapper.selectAppointmentInfoEmp(map);
		System.out.println(list);
		return list;
	}

	@Override
	public String increasingAppointmentSeq() {
		String hosu = empAppointmentMapper.IncreasingAppointmentSeq();
		System.out.println("hosu" + hosu);

		return hosu;
	}

	@Override
	public EmpAppointmentInfoTO generateHosu() {
		Calendar now = Calendar.getInstance();
		String hosu = empAppointmentMapper.getHosu();
		if (hosu == null) {
			String year = Integer.toString(now.get(Calendar.YEAR));
			String month = Integer.toString((now.get(Calendar.MONTH)) + 1);
			if (month.length() < 2)
				month = '0' + month;
			hosu = year + month + "-1";
		}
		EmpAppointmentInfoTO empAppointmentInfoTO = new EmpAppointmentInfoTO();
		empAppointmentInfoTO.setHosu(hosu);
		return empAppointmentInfoTO;
	}

	@Override
	public void registAppoint(ArrayList<ArrayList<EmpAppointmentRegTO>> arr) {
		for (ArrayList<EmpAppointmentRegTO> arr_info : arr)
			for (EmpAppointmentRegTO to : arr_info)
				if (to.getStartDate().equals(""))
					continue;
				else
					empAppointmentMapper.insertEmpAppointment2(to);
	}

	@Override
	public void registAppointmentNumber(EmpAppointmentTO empAppointmentto) {
		empAppointmentMapper.insertAppointmentNumber(empAppointmentto);
	}

	@Override
	public ArrayList<EmpAppointmentTO> findAppointmentList() {
		ArrayList<EmpAppointmentTO> appointmentList = null;
		appointmentList = empAppointmentMapper.selectAppointmentList();

		return appointmentList;
	}

	@Override
	public ArrayList<EmpAppointmentTO> findDetailAppointmentList(String hosu) {
		ArrayList<EmpAppointmentTO> detailAppointmentList = null;
		detailAppointmentList = empAppointmentMapper.selectDetailAppointmentList(hosu);

		return detailAppointmentList;
	}

	@Override
	public ArrayList<EmpAppointmentTO> findChangeDetailList(String empCode, String hosu) {
		ArrayList<EmpAppointmentTO> changeDetailList = null;
		changeDetailList = empAppointmentMapper.selectChangeDetailList(empCode, hosu);

		return changeDetailList;
	}

	@Override
	public void modifyAppointment(ArrayList<EmpAppointmentTO> confirmAppointment) {
		for (EmpAppointmentTO empAppointmentTO : confirmAppointment) {
			if (empAppointmentTO.getStatus().equals("update")) {
				empAppointmentMapper.updateAppointment(empAppointmentTO);
			}
		}
	}
}
