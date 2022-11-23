package kr.co.seoulit.insa.newempsvc.newempinfomgmt.service;

import java.util.ArrayList;

import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.ApplicantTO;
import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.NewResumeTO;
import kr.co.seoulit.insa.newempsvc.newempinfomgmt.to.PersonalityInterviewTO;

public interface NewEmpInfoService {
	
	public ArrayList<NewResumeTO> findresumeList(int year, String half,String workplaceCode);
	
	public ArrayList<PersonalityInterviewTO> findPInewempList(int year, String half,String workplaceCode);
	
	public ArrayList<ApplicantTO> FindAllSuccessApplicant(int year, String half,String workplaceCode);
	
	public void updateresumeNewemp(NewResumeTO nemp);
	
	public String produceNewcode(int year, int half);

	public void insertResumeAndPI(NewResumeTO resume, PersonalityInterviewTO pi);
}
