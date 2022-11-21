package kr.co.seoulit.insa.newempsvc.documentmgmt.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import kr.co.seoulit.insa.newempsvc.documentmgmt.to.GanttDataTO;
import kr.co.seoulit.insa.newempsvc.documentmgmt.to.GanttLinksTO;

@Mapper
public interface EducationMapper {
	public void insertData(GanttDataTO data);
	
	public void insertLinks(GanttLinksTO links);
	
	public ArrayList<GanttDataTO> findganttDataList();
	
	public ArrayList<GanttLinksTO> findganttLinksList();
	
}
