package kr.co.seoulit.insa.commsvc.systemmgmt.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.RequestContext;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.servlet.ServletRequestContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import kr.co.seoulit.insa.commsvc.systemmgmt.service.SystemMgmtService;
import kr.co.seoulit.insa.sys.util.EmpImgUploadUtil;


@RequestMapping("/systemmgmt/*")
@RestController
public class EmpImgController {
	
	@Autowired
	private SystemMgmtService systemMgmtService;
	
	ModelMap map = null;
	
//	public ModelMap handleRequestInternal(HttpServletRequest request) {
//
//		map = new ModelMap();
//
//        DiskFileItemFactory factory = new DiskFileItemFactory(); //디스크에 있는 파일 읽어오는 class
//        ServletFileUpload upload = new ServletFileUpload(factory); //읽어온파일 서버에 올리는 애
//        RequestContext rc = new ServletRequestContext(request);
//
//        String empCode = null;
//        String empImgUrl = null;
//        String check = (String)request.getSession().getAttribute("newcheck");
//
//        int newCheck = 0;
//        try {
//
//
//			/*
//			1. all : 모든 경고를 억제
//			2. cast : 캐스트 연산자 관련 경고 억제
//			3. dep-ann : 사용하지 말아야 할 주석 관련 경고 억제
//			4. deprecation : 사용하지 말아야 할 메소드 관련 경고 억제
//			5. fallthrough : switch문에서의 break 누락 관련 경고 억제
//			6. finally : 반환하지 않는 finally 블럭 관련 경고 억제
//			7. null : null 분석 관련 경고 억제
//			8. rawtypes : 제네릭을 사용하는 클래스 매개 변수가 불특정일 때의 경고 억제
//			9. unchecked : 검증되지 않은 연산자 관련 경고 억제
//			10. unused : 사용하지 않는 코드 관련 경고 억제
//			*/
//			List<FileItem> items = upload.parseRequest(rc);
//	        for (FileItem fileItem : items){
//	        	System.out.println("######## fileItem"+fileItem);
//	        	if(fileItem.isFormField()){
//	        		if("empCode".equals(fileItem.getFieldName())){
//	        			empCode = fileItem.getString();
//	        			System.out.println("empCode:"+empCode);
//	        		}
//	        		if("newcheck".equals(fileItem.getFieldName())){
//	        			check = fileItem.getString();
//	        			System.out.println("check:"+check);
//	        		}
//	        	} else {
//	        		if((fileItem.getName() != null) && (fileItem.getSize() > 0)){
//	        			empImgUrl = EmpImgUploadUtil.doFileUpload(request, fileItem, empCode);
//	        			System.out.println("empImgUrl:"+empImgUrl);
//	        		}
//	        	}
//	        }
//
//	        if("1".equals(check)) {
//	        	newCheck = 1;
//	        }
//
//	        if(newCheck == 0) {
//	        	System.out.println("@@@@@@@@@@들어가나@@@@@@@@@@@@@@@@@@@@@@@@@");
//	        	systemMgmtService.registEmpImg(empCode, empImgUrl.substring(empImgUrl.lastIndexOf(".")+1));
//	        }
//
//	        map.put("empImgUrl", empImgUrl);
//	        map.put("errorCode", 0);
//	        map.put("errorMsg", "사진 저장에 성공했습니다");
//        } catch (FileUploadException e){
//
//        	map.put("errorCode", -1);
//        	map.put("errorMsg", "사진 저장에 실패했습니다");
//        } catch (IOException e){
//
//        	map.put("errorCode", -1);
//        	map.put("errorMsg", "사진 저장에 실패했습니다");
//        }
//
//		return map;
//	}

}