package kr.co.seoulit.insa.sys.view;


import org.springframework.core.Ordered;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@SuppressWarnings("deprecation")
@Controller  
public class HomeController extends WebMvcConfigurerAdapter{
	
       @Override
       public void addViewControllers(ViewControllerRegistry registry ) {
           registry.addViewController( "/" ).setViewName( "loginForm" ); 
           registry.addViewController( "/home*" ).setViewName( "loginForm" ); 
           registry.setOrder( Ordered.HIGHEST_PRECEDENCE );     
          
       }

	

}