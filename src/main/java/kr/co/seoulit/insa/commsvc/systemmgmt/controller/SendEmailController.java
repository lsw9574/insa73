package kr.co.seoulit.insa.commsvc.systemmgmt.controller;

import java.sql.Connection;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
@Controller
public class SendEmailController {
//    private DataSourceTransactionManager dataSourceTransactionManager = DataSourceTransactionManager.getInstance();
    private Multipart multipart;
    
    @GetMapping("sendEmail")
    public ModelMap sendEmail(HttpServletRequest request) {
    	
       ModelMap map = new ModelMap();
       map.put("empCode", request.getParameter("empCode"));
       map.put("usage", request.getParameter("usage"));
       map.put("date", request.getParameter("requestDay"));
       map.put("end", request.getParameter("useDay"));
       
       String eMail = request.getParameter("eMail");

       String host = "smtp.naver.com";
       final String user = "wit_wit@naver.com"; 
       final String password = "he0202";
       int port = 465;
       
		/*
		 * String recipient = eMail; //받는 사람의 메일주소를 입력해주세요 String subject = "메일테스트";
		 * //메일 제목 입력해주세요. String body = user+"님으로 부터 메일을 받았습니다."; //메일 내용 입력해주세요.
		 */       
       JasperReport jasperReport;
       JasperPrint jasperPrint = null;
       try {
          jasperReport = JasperCompileManager.compileReport((request.getServletContext().getRealPath("/report/employment.jrxml")));
          //Connection con = dataSourceTransactionManager.getConnection(); 
          //jasperPrint = JasperFillManager.fillReport(jasperReport, map, con);
          //JasperExportManager.exportReportToPdfFile(jasperPrint, (request.getServletContext().getRealPath("/report/test01.pdf")));

          // Get the session object
          Properties props = new Properties();
          props.put("mail.smtp.host", host);
          props.put("mail.smtp.port", port);
          props.put("mail.smtp.auth", "true");
          props.put("mail.smtp.ssl.enable", "true");
          props.put("mail.smtp.ssl.trust", host);


          Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
             protected PasswordAuthentication getPasswordAuthentication() {      
                return new javax.mail.PasswordAuthentication(user, password);
             }
          });
           MimeMessage message = new MimeMessage(session);
             message.setFrom(new InternetAddress(user));  
             message.addRecipient(Message.RecipientType.TO, new InternetAddress(eMail));
           System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@eMail:   "+eMail);
             // Subject
             message.setSubject("제목: 메일 전송(아이리포트)");
             multipart = new MimeMultipart();
                   
             // Text
             MimeBodyPart mbp1 = new MimeBodyPart();
                mbp1.setText("본문내용 : 메일 전송(아이리포트)");
                multipart.addBodyPart(mbp1);

             // send the message
             //if(fileName != null){
                   DataSource source = new FileDataSource((request.getServletContext().getRealPath("/report/test01.pdf")));
                   BodyPart messageBodyPart = new MimeBodyPart();
                   messageBodyPart.setDataHandler(new DataHandler(source));
                   messageBodyPart.setFileName("test01.pdf");
                   multipart.addBodyPart(messageBodyPart);
                   
             //  }
             message.setContent(multipart);
                Transport.send(message);
             System.out.println("메일 발송 성공!");
             ((Connection) jasperPrint).close();
             ((Connection) jasperReport).close();
             props.clear();
             ((Connection) mbp1).close();
             ((Connection) multipart).close();
             ((Connection) source).close();
             ((Connection) message).close();

       } catch (Exception e) {
          e.printStackTrace();
          System.out.println("메일에러" + e);
       }
       return map;
    }
}