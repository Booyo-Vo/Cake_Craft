package com.goodee.cakecraft.controller;

import java.io.FileInputStream;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.goodee.cakecraft.service.AdminEmpService;
import com.goodee.cakecraft.vo.EmpBase;
import com.goodee.cakecraft.vo.EmpIdList;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ExcelController {
	//ANSI코드
	final String LJY = "\u001B[42m";
	final String RESET = "\u001B[0m";
	
	@Autowired
	private AdminEmpService adminEmpService;
	
	//엑셀로 전체사원 정보 다운로드
	@GetMapping("/emp/getExcel")
	public void getExcel(HttpServletResponse response) {
		try{
			//사원리스트 받아오기
			List<EmpBase> adminEmpList = adminEmpService.getEmpList();	
			
			// 새로운 워크북 생성
			Workbook workbook = new XSSFWorkbook();
			//시트이름을 Employee Data로 지정
			Sheet sheet = workbook.createSheet("Employee Data");
			//시트이름을 엑셀 파일이름을 Employee Data로 지정
			final String fileName = "Employee Data";
			
			// 헤더 행 생성
			Row headerRow = sheet.createRow(0);
			headerRow.createCell(0).setCellValue("사원번호");
			headerRow.createCell(1).setCellValue("이름");
			headerRow.createCell(2).setCellValue("주민번호");
			headerRow.createCell(3).setCellValue("부서");
			headerRow.createCell(4).setCellValue("팀");
			headerRow.createCell(5).setCellValue("직급");
			headerRow.createCell(6).setCellValue("전화번호");
			headerRow.createCell(7).setCellValue("연차개수");
			headerRow.createCell(8).setCellValue("주소");
			headerRow.createCell(9).setCellValue("이메일");
			headerRow.createCell(10).setCellValue("입사일");
			headerRow.createCell(11).setCellValue("퇴사일");
			headerRow.createCell(12).setCellValue("근무상태");

			// 데이터 행 생성
			int rowNum = 1;
			for (EmpBase emp : adminEmpList) {
				Row dataRow = sheet.createRow(rowNum++);
				dataRow.createCell(0).setCellValue(emp.getId());
				dataRow.createCell(1).setCellValue(emp.getEmpName());
				dataRow.createCell(2).setCellValue(emp.getSocialNo());
				dataRow.createCell(3).setCellValue(emp.getDeptNm());
				dataRow.createCell(4).setCellValue(emp.getTeamNm());
				dataRow.createCell(5).setCellValue(emp.getPositionNm());
				dataRow.createCell(6).setCellValue(emp.getEmpPhone());
				dataRow.createCell(7).setCellValue(emp.getDayoffCnt());
				dataRow.createCell(8).setCellValue(emp.getAddress());
				dataRow.createCell(9).setCellValue(emp.getEmail());
				dataRow.createCell(10).setCellValue(emp.getHireDate());
				dataRow.createCell(11).setCellValue(emp.getRetireDate());
				dataRow.createCell(12).setCellValue(emp.getEmpStatus());
			}
			// HTTP 응답 헤더에 Content-Type을 excel로 설정
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode(fileName, "UTF-8")+".xlsx");//파일이름을 설정하여 다운로드 하도록
	
			workbook.write(response.getOutputStream());
			workbook.close();
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	    
	//엑셀로 사원 대량등록
	@PostMapping("/emp/addExcel") 
	@ResponseBody
	public int addExcell(HttpSession session,
							@RequestParam("file") MultipartFile file) {   
		log.debug(LJY + "addExcel file:" + file + RESET);
		int excelRow = 0;
		try (Workbook workbook = new XSSFWorkbook(file.getInputStream())) { //새로운 엑셀파일을 생성
			Sheet sheet = workbook.getSheetAt(0); // 엑셀 파일의 첫번째 시트 가져오기
			excelRow=sheet.getPhysicalNumberOfRows();

			for (int rowIndex = 2; rowIndex <= sheet.getPhysicalNumberOfRows()+1; rowIndex++) { //세번째줄 부터 있는 인원수만큼 반복됨
				Row row = sheet.getRow(rowIndex);
				if (!"".equals(row.getCell(0).getStringCellValue())) { //값 받아오기
					EmpBase empbase = new EmpBase();
					empbase.setEmpName(row.getCell(0).getStringCellValue());
					empbase.setDeptNm(row.getCell(1).getStringCellValue());
					empbase.setTeamNm(row.getCell(2).getStringCellValue());
					empbase.setPositionNm(row.getCell(3).getStringCellValue());
					empbase.setEmpPhone(row.getCell(4).getStringCellValue());
					empbase.setAddress(row.getCell(5).getStringCellValue());
					empbase.setSocialNo(row.getCell(6).getStringCellValue());
					empbase.setEmail(row.getCell(7).getStringCellValue());
					String hireDate = row.getCell(8).getStringCellValue();
					empbase.setHireDate(hireDate);

					//세선에 저장된 로그인 아이디를 받아옴
					EmpIdList loginMember = (EmpIdList)session.getAttribute("loginMember");
					String loginId = loginMember.getId();
					log.debug(LJY + loginId + "<- addEmp loginId"+ RESET);

					//empbase에 로그인된 아이디 담기
					empbase.setModId(loginId);
					empbase.setRegId(loginId);
					log.debug(LJY + loginId + "<- addEmp loginId"+ RESET);

					//사원추가 (service 안에서 이름이 코드로 변경, 사원번호생성, 사원추가, idlist추가가 이루어짐)
					int addEmpRow = adminEmpService.addEmp(empbase);
						log.debug(LJY + "addExcel addEmpRow:" + addEmpRow + RESET);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return excelRow; // 등록 후 리스트 페이지로 리다이렉트
	}

	//엑셀파일 양식 다운로드
	@GetMapping("/excel/getExcelFrom")
	public void getExcelFrom(HttpServletResponse response, HttpServletRequest request) {

		String fileName = "addEmpForm.xlsx"; // 엑셀 파일 이름
		String filePath = request.getServletContext().getRealPath("/excel/"+fileName); // 파일의 실제 경로

		try (InputStream inputStream = new FileInputStream(filePath)) { //엑셀파일을 읽어옴
			Workbook workbook = new XSSFWorkbook(inputStream);

			// HTTP 응답 헤더에 Content-Type을 excel로 설정
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

			// 엑셀 파일 내보내기
			OutputStream outputStream = response.getOutputStream();
			workbook.write(outputStream);
			outputStream.flush();
			//버퍼에 남아있는 데이터를 강제로 보내고 버퍼를 비웁니다.

			workbook.close();
		} catch (IOException e) {
			e.printStackTrace();
			// 예외 처리
		}
	}
	
	//엑셀로 체크박스로 선택된 사원 정보 다운로드
	@GetMapping("/emp/getSelectExcel")
	public void getSelectExcel(@RequestParam("ids") String ids, 
								HttpServletResponse response) throws IOException {
		
		log.debug(LJY + ids + "<- getSelectExcel ids"+ RESET);
		// 선택된 사원 아이디 목록을 문자열로부터 배열로 변환
		String[] selectedIds = ids.split(",");
		
		 // 선택된 사원 정보를 저장할 리스트 생성
		List<EmpBase> selectedEmpList = new ArrayList<>();
		
		//받아온 아이디값을 돌려서
		for (String id : selectedIds) {
			//해당아이디 정보를 받아옴
			EmpBase empbase = adminEmpService.getAdminEmpById(id); 
			if (empbase != null) {
				//정보를 리스트에 저장
				selectedEmpList.add(empbase);
			}
		}
		
		try{
			// 새로운 워크북 생성
			Workbook workbook = new XSSFWorkbook();
			//시트이름을 Employee Data로 지정
			Sheet sheet = workbook.createSheet("Employee Data");
			//시트이름을 엑셀 파일이름을 Employee Data로 지정
			final String fileName = "Employee Data";
			
			// 헤더 행 생성
			Row headerRow = sheet.createRow(0);
			headerRow.createCell(0).setCellValue("사원번호");
			headerRow.createCell(1).setCellValue("이름");
			headerRow.createCell(2).setCellValue("주민번호");
			headerRow.createCell(3).setCellValue("부서");
			headerRow.createCell(4).setCellValue("팀");
			headerRow.createCell(5).setCellValue("직급");
			headerRow.createCell(6).setCellValue("전화번호");
			headerRow.createCell(7).setCellValue("연차개수");
			headerRow.createCell(8).setCellValue("주소");
			headerRow.createCell(9).setCellValue("이메일");
			headerRow.createCell(10).setCellValue("입사일");
			headerRow.createCell(11).setCellValue("퇴사일");
			headerRow.createCell(12).setCellValue("근무상태");

			// 데이터 행 생성
			int rowNum = 1;
			for (EmpBase emp : selectedEmpList) {
				Row dataRow = sheet.createRow(rowNum++);
				dataRow.createCell(0).setCellValue(emp.getId());
				dataRow.createCell(1).setCellValue(emp.getEmpName());
				dataRow.createCell(2).setCellValue(emp.getSocialNo());
				dataRow.createCell(3).setCellValue(emp.getDeptNm());
				dataRow.createCell(4).setCellValue(emp.getTeamNm());
				dataRow.createCell(5).setCellValue(emp.getPositionNm());
				dataRow.createCell(6).setCellValue(emp.getEmpPhone());
				dataRow.createCell(7).setCellValue(emp.getDayoffCnt());
				dataRow.createCell(8).setCellValue(emp.getAddress());
				dataRow.createCell(9).setCellValue(emp.getEmail());
				dataRow.createCell(10).setCellValue(emp.getHireDate());
				dataRow.createCell(11).setCellValue(emp.getRetireDate());
				dataRow.createCell(12).setCellValue(emp.getEmpStatus());
			}
			// HTTP 응답 헤더에 Content-Type을 excel로 설정
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode(fileName, "UTF-8")+".xlsx");//파일이름을 설정하여 다운로드 하도록
	
			workbook.write(response.getOutputStream());
			workbook.close();
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	    
}


