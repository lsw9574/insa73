package kr.co.seoulit.insa.newempsvc.newempinfomgmt.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.seoulit.insa.newempsvc.newempinfomgmt.mapper.NewEmpMapper;
import kr.co.seoulit.insa.newempsvc.newempinfomgmt.mapper.SuccessApplicantMapper;
import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.ApplicantTO;
import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.NewResumeTO;
import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.PersonalityInterviewTO;


@Service
public class NewEmpInfoServiceImpl implements NewEmpInfoService
{

	@Autowired
	private NewEmpMapper newempMapper;
	
	@Autowired
	private SuccessApplicantMapper applicantMapper;
	
	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<NewResumeTO> findresumeList(int year, String half,String workplaceCode) {
		// TODO Auto-generated method stub
		System.out.println(year+half);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", (Integer)year);
		map.put("half", half);
		map.put("workplaceCode", workplaceCode);
		newempMapper.findresumeList(map);
		
		ArrayList<NewResumeTO> resumelist = (ArrayList<NewResumeTO>)map.get("result");
		return resumelist;
	}

	@Override
	public ArrayList<PersonalityInterviewTO> findPInewempList(int year, String half,String workplaceCode) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		map.put("half", half);
		map.put("workplaceCode", workplaceCode);
		return newempMapper.findPInewempList(map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public ArrayList<ApplicantTO> FindAllSuccessApplicant(int year, String half,String workplaceCode) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		map.put("year", (Integer)year);
		map.put("half", half);
		map.put("workplaceCode", workplaceCode);
		applicantMapper.FindAllSuccessApplicant(map);
		ArrayList<ApplicantTO> FindAllSuccessApplicantList = (ArrayList<ApplicantTO>) map.get("result");
		return FindAllSuccessApplicantList;
	}

	@Override
	public void updateresumeNewemp(NewResumeTO nemp)
	{
		// TODO Auto-generated method stub
		newempMapper.UpdateResumeNewemp(nemp);
	}

	@Override
	public String produceNewcode(int year, int half)
	{
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("year", year);
		map.put("half", half);
		String no=newempMapper.produceNewcode(map);
		if(no == null)
			no = newempMapper.insertNewcode(map);
		return no;
	}

	@Override
	public void insertResumeAndPI(NewResumeTO resume, PersonalityInterviewTO pi)
	{
		// TODO Auto-generated method stub

		newempMapper.InsertResume(resume);
		newempMapper.InsertPI(pi);
	}
}
