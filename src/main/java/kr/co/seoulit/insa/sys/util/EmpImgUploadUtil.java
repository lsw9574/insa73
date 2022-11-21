package kr.co.seoulit.insa.sys.util;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;

public class EmpImgUploadUtil {
	public static String doFileUpload(HttpServletRequest request, FileItem fileitem, String empCode) throws FileNotFoundException, IOException {
		InputStream in = fileitem.getInputStream();
		String fileName = fileitem.getName().substring(fileitem.getName().lastIndexOf("\\")+1);
		System.out.println("#### fileitem_Name : "+fileitem.getName());
		System.out.println("#### fileName : "+fileName);
		String fileExt = fileName.substring(fileName.lastIndexOf("."));
		System.out.println("#### empCode : "+empCode);
		System.out.println("#### fileExt : "+fileExt);
				
		String saveFileName = empCode + fileExt;
		String pathTomcat = "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\insa71_3\\profile" + saveFileName;
		String pathEclipse = "C:\\Download" + saveFileName;
		FileOutputStream foutTomcat = new FileOutputStream(pathTomcat);
		FileOutputStream foutEclipse = new FileOutputStream(pathEclipse);
		int bytesRead = 0;
		byte[] buffer = new byte[8192];
		while ((bytesRead = in.read(buffer, 0, 8192)) != -1) {
			foutTomcat.write(buffer, 0, bytesRead);
			foutEclipse.write(buffer, 0, bytesRead);
		}
		in.close();
		foutTomcat.close();
		foutEclipse.close();
		return pathTomcat;
	}
}
