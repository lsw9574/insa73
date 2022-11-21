package kr.co.seoulit.insa.commsvc.systemmgmt.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EmpLogoutController {

	@GetMapping("logout")
	public ModelAndView empLogout(HttpServletRequest request) {
		ModelAndView modelAndView=new ModelAndView();
		try{
			
			request.getSession().invalidate();
			modelAndView.setViewName("redirect:" + "/loginForm/view");
			
		}catch(Exception e){
			modelAndView.addObject("errorMsg", "게시글이 등록되었습니다.");
			modelAndView.addObject("errorCode",0);
		}

		return modelAndView;
	}
}

