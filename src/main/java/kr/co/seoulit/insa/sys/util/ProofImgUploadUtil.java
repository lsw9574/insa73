package kr.co.seoulit.insa.sys.util;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;


public class ProofImgUploadUtil {
	public static String doFileUpload(HttpServletRequest request, FileItem fileitem, String cashCode)
			throws FileNotFoundException, IOException {

			InputStream in = fileitem.getInputStream();
			String fileName = fileitem.getName().substring(fileitem.getName().lastIndexOf("\\")+1);
			String fileExt = fileName.substring(fileName.lastIndexOf("."));

			String saveFileName = cashCode + fileExt;
			
			String pathEclipse = "C:\\Users\\cheol\\RealFinalPersonnelProject\\hr\\WebContent\\receipt\\" + saveFileName;
			String pathTomcat = "C:\\dev\\Tomcat 9.0\\apache-tomcat-9.0.54\\webapps\\hr\\receipt\\" + saveFileName;
			
			FileOutputStream foutEclipse = new FileOutputStream(pathEclipse);
			FileOutputStream foutTomcat = new FileOutputStream(pathTomcat);
			int bytesRead = 0;
			byte[] buffer = new byte[8192];
			while ((bytesRead = in.read(buffer, 0, 8192)) != -1) {
				foutEclipse.write(buffer, 0, bytesRead);
				foutTomcat.write(buffer, 0, bytesRead);
			}
			in.close();
			foutEclipse.close();
			foutTomcat.close();

			return pathEclipse + saveFileName;
		}
}
