package kr.co.seoulit.insa.empmgmtsvc.empinfomgmt.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import net.sf.json.JSONObject;

@RequestMapping("/empinfomgmt/*")
@RestController
public class ExcelController {

	HashMap<String, Object> map = new HashMap<String, Object>();

	@GetMapping("excel")
	public HashMap<String, Object> handleRequestInternal(@RequestParam String sendData) {

		XSSFWorkbook xssfWb = null;
		XSSFSheet xssfSheet = null;
		XSSFRow xssfRow = null;
		XSSFCell xssfCell = null;

		try {

			String parameter = sendData.replace("\\", "").replace("[", "").replace("]", "")
					.replace("}\"", "}").replace("\"{", "{");
			System.out.println(" 변환된 전체 파라미터값 " + parameter);

			JSONObject jsonObject = JSONObject.fromObject(parameter);

			System.out.println(jsonObject);

			int rowNo = 0; // 초기 행 번호.
			// 엑셀 객체 생성, 워크시트이름 생성
			xssfWb = new XSSFWorkbook();
			xssfSheet = xssfWb.createSheet("인사고과"); // 엑셀 시트 이름

			// 폰트 설정
			XSSFFont font = xssfWb.createFont();
			font.setFontName(HSSFFont.FONT_ARIAL);
			font.setFontHeightInPoints((short) 14);
			font.setBold(true);

			// 셀 스타일
			CellStyle cellStyle_Title = xssfWb.createCellStyle();
			cellStyle_Title.setBorderTop(BorderStyle.THIN);
			cellStyle_Title.setBorderBottom(BorderStyle.THIN);
			cellStyle_Title.setBorderLeft(BorderStyle.THIN);
			cellStyle_Title.setBorderRight(BorderStyle.THIN);
			cellStyle_Title.setAlignment(HorizontalAlignment.CENTER);

			xssfSheet.setColumnWidth(0, (xssfSheet.getColumnWidth(0)) + (short) 2048);
			xssfSheet.setColumnWidth(1, (xssfSheet.getColumnWidth(1)) + (short) 2048);
			xssfSheet.setColumnWidth(2, (xssfSheet.getColumnWidth(2)) + (short) 2048);
			xssfSheet.setColumnWidth(3, (xssfSheet.getColumnWidth(3)) + (short) 2048); // 3��° �÷� ���� ����
			xssfSheet.setColumnWidth(4, (xssfSheet.getColumnWidth(4)) + (short) 2048); // 4��° �÷� ���� ����
			xssfSheet.setColumnWidth(5, (xssfSheet.getColumnWidth(5)) + (short) 2048); // 5��° �÷� ���� ����
			xssfSheet.setColumnWidth(6, (xssfSheet.getColumnWidth(6)) + (short) 2048); // 8��° �÷� ���� ����
			xssfSheet.setColumnWidth(7, (xssfSheet.getColumnWidth(7)) + (short) 2048);
			xssfSheet.setColumnWidth(8, (xssfSheet.getColumnWidth(8)) + (short) 2048);
			xssfSheet.setColumnWidth(9, (xssfSheet.getColumnWidth(9)) + (short) 2048);

			cellStyle_Title.setFont(font); // cellStle�� font�� ����
			cellStyle_Title.setAlignment(HorizontalAlignment.CENTER); // ����

			xssfSheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 9)); // ù��, ��������, ù��, ��������( 0��° ����
																			// 0~8��° �÷��� �����Ѵ�)
			// Ÿ��Ʋ ����
			xssfRow = xssfSheet.createRow(rowNo++); // �� ��ü �߰�
			xssfCell = xssfRow.createCell((short) 0); // �߰��� �࿡ �� ��ü �߰�
			xssfCell.setCellStyle(cellStyle_Title); // ���� ��Ÿ�� ����
			xssfCell.setCellValue("인사고과관리"); // ������ �Է�

			CellStyle cellStyle_Body = xssfWb.createCellStyle();
			cellStyle_Body.setAlignment(HorizontalAlignment.CENTER);

			// 헤더
			xssfRow = xssfSheet.createRow(rowNo++); // 첫번째 행 ( 칼럼값 만들기
			xssfCell = xssfRow.createCell((short) 0);
			xssfCell.setCellStyle(cellStyle_Body);
			xssfCell.setCellValue("부서");
			xssfCell = xssfRow.createCell((short) 1);
			xssfCell.setCellStyle(cellStyle_Body);
			xssfCell.setCellValue("사원번호");
			xssfCell = xssfRow.createCell((short) 2);
			xssfCell.setCellStyle(cellStyle_Body);
			xssfCell.setCellValue("사원이름");
			xssfCell = xssfRow.createCell((short) 3);
			xssfCell.setCellStyle(cellStyle_Body);
			xssfCell.setCellValue("등록일");
			xssfCell = xssfRow.createCell((short) 4);
			xssfCell.setCellStyle(cellStyle_Body);
			xssfCell.setCellValue("직급");
			xssfCell = xssfRow.createCell((short) 5);
			xssfCell.setCellStyle(cellStyle_Body);
			xssfCell.setCellValue("업적점수");
			xssfCell = xssfRow.createCell((short) 6);
			xssfCell.setCellStyle(cellStyle_Body);
			xssfCell.setCellValue("능력점수");
			xssfCell = xssfRow.createCell((short) 7);
			xssfCell.setCellStyle(cellStyle_Body);
			xssfCell.setCellValue("태도점수");
			xssfCell = xssfRow.createCell((short) 8);
			xssfCell.setCellStyle(cellStyle_Body);
			xssfCell.setCellValue("승인여부");
			xssfCell = xssfRow.createCell((short) 9);
			xssfCell.setCellStyle(cellStyle_Body);
			xssfCell.setCellValue("평가등급");

			int cnt = 1;
			while (true) {
				if (cnt > 1) {
					System.out.println("" + parameter.indexOf(",{"));
					if (parameter.indexOf(",{") != -1) {
						System.out.println("파라미터값 자름 "); // ,{ 가 있을때 자르기
						parameter = parameter.substring(parameter.indexOf(",{") + 1, parameter.lastIndexOf("}") + 1);
						System.out.println("자 " + parameter);
						jsonObject = JSONObject.fromObject(parameter);
					} else {
						System.out.println("break");

						break;
					}
				}

				xssfRow = xssfSheet.createRow(rowNo++);
				xssfCell = xssfRow.createCell((short) 0);
				xssfCell.setCellStyle(cellStyle_Body);
				xssfCell.setCellValue(jsonObject.getString("deptName"));
				xssfCell = xssfRow.createCell((short) 1);
				xssfCell.setCellStyle(cellStyle_Body);
				xssfCell.setCellValue(jsonObject.getString("empCode"));
				xssfCell = xssfRow.createCell((short) 2);
				xssfCell.setCellStyle(cellStyle_Body);
				xssfCell.setCellValue(jsonObject.getString("empName"));
				xssfCell = xssfRow.createCell((short) 3);
				xssfCell.setCellStyle(cellStyle_Body);
				xssfCell.setCellValue(jsonObject.getString("apply_day"));
				xssfCell = xssfRow.createCell((short) 4);
				xssfCell.setCellStyle(cellStyle_Body);
				xssfCell.setCellValue(jsonObject.getString("position"));
				xssfCell = xssfRow.createCell((short) 5);
				xssfCell.setCellStyle(cellStyle_Body);
				xssfCell.setCellValue(jsonObject.getString("achievement"));
				xssfCell = xssfRow.createCell((short) 6);
				xssfCell.setCellStyle(cellStyle_Body);
				xssfCell.setCellValue(jsonObject.getString("ability"));
				xssfCell = xssfRow.createCell((short) 7);
				xssfCell.setCellStyle(cellStyle_Body);
				xssfCell.setCellValue(jsonObject.getString("attitude"));
				xssfCell = xssfRow.createCell((short) 8);
				xssfCell.setCellStyle(cellStyle_Body);
				xssfCell.setCellValue(jsonObject.getString("approval_Status"));
				xssfCell = xssfRow.createCell((short) 9);
				xssfCell.setCellStyle(cellStyle_Body);
				xssfCell.setCellValue(jsonObject.getString("grade"));

				System.out.println(jsonObject.getString("empName") + "의 row data");

				CellStyle cellStyle_Table_Center = xssfWb.createCellStyle();
				cellStyle_Table_Center.setBorderTop(BorderStyle.THIN);
				cellStyle_Table_Center.setBorderBottom(BorderStyle.THIN);
				cellStyle_Table_Center.setBorderLeft(BorderStyle.THIN);
				cellStyle_Table_Center.setBorderRight(BorderStyle.THIN);
				cellStyle_Table_Center.setAlignment(HorizontalAlignment.CENTER);
				cnt++;

			}

			String localFile = "C:\\excel\\" + "인사고과" + ".xlsx";

			File file = new File(localFile);
			FileOutputStream fos = null;
			fos = new FileOutputStream(file);
			xssfWb.write(fos);

			if (xssfWb != null)
				xssfWb.close();
			if (fos != null)
				fos.close();

			map.put("errorCode", 0);
		} catch (Exception e) {
			map.clear();
			map.put("errorCode", -1);
			map.put("errorMsg", "엑셀저장에 실패하였습니다!");
		}


		return map;
	}

}