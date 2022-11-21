package kr.co.seoulit.insa.commsvc.systemmgmt.controller;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/systemmgmt/*")
@RestController
public class RespiratoryHospitalServiceController {

	private ModelMap map = new ModelMap();

	@RequestMapping("getRprtHospServiceXml")
	public ModelMap getRprtHospServiceXml() {

		BufferedReader br = null;
		HttpURLConnection urlconnection = null;
		try {
			// API 호출하기 위한 파라미터 설정
			String serviceKey = "QRCDu34k%2FSbgnc6lGW3mEENtq1ZqUWon2exCdPpuC0OaEi%2BQ9Kmz%2BLrixvm6rCmiT0sN9AL6r0JCY2o854wayw%3D%3D";
			String pageNo = "1";
			String numOfRows = "4231";
			String resultType = "json";

			String urlstr = "http://apis.data.go.kr/B551182/rprtHospService/getRprtHospService" + "serviceKey="
					+ serviceKey + "&pageNo=" + pageNo + "&numOfRows=" + numOfRows + "&resultType=" + resultType;

			URL url = new URL(urlstr);

			urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			urlconnection.setRequestProperty("Content-type", "application/json");

			System.out.println("Response code: " + urlconnection.getResponseCode());

			// 응답 읽기
			if (urlconnection.getResponseCode() >= 200 && urlconnection.getResponseCode() <= 300) {
				br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));
			} else {
				br = new BufferedReader(new InputStreamReader(urlconnection.getErrorStream(), "UTF-8"));
			}

			StringBuilder sb = new StringBuilder();
			String line = "";
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			map.put("api", sb.toString());
			br.close();
			urlconnection.disconnect();
		} catch (IOException e) {
			map.put("fail", e.getMessage());
		}
		;

		return map;
	}
}