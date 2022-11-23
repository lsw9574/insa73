package kr.co.seoulit.insa.sys.aop;


import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.ModelAndView;

import kr.co.seoulit.insa.commsvc.systemmgmt.exception.IdNotFoundException;
import kr.co.seoulit.insa.commsvc.systemmgmt.exception.PwMissMatchException;
import lombok.extern.slf4j.Slf4j;

@RestControllerAdvice
@Slf4j
@Component
@Aspect
@Configuration
public class CommonAspect {  //한개로 다 만들기!!! 원장님요구
//https://github.com/tintoll/StartSpringBoot/blob/master/spring_boot_start.md	

    //exception 잡는놈들
    @org.springframework.web.bind.annotation.ExceptionHandler(IdNotFoundException.class)
    public ModelAndView idNotFoundExceptionHandler(HttpServletRequest request, IdNotFoundException e) {
        ModelAndView mv = new ModelAndView("/loginForm");
        mv.addObject("errorCode", -1);
        mv.addObject("errorMsg", e.getMessage());
        System.out.println("#######################IdNotFoundException#################1");

        //log.error("Request: " + request.getRequestURL() +"\n"+ " raised " + e);

        return mv;
    }

    @org.springframework.web.bind.annotation.ExceptionHandler(PwMissMatchException.class)
    public ModelAndView pwMissMatchException(HttpServletRequest request, PwMissMatchException e) {
        ModelAndView mv = new ModelAndView("/loginForm");
        mv.addObject("errorCode", -1);
        mv.addObject("errorMsg", e.getMessage());
        System.out.println("#######################PwMissMatchException#################1");
        //log.error("Request: " + request.getRequestURL() +"\n"+ " raised " + e);
        return mv;
    }


    @ExceptionHandler
    public ModelMap defaultExceptionHandler(HttpServletRequest request, Exception exception) {

        ModelMap map = new ModelMap();

        map.put("errorCode", -1);
        map.put("errorMsg", exception.getMessage());

        //log.error("defaultExceptionHandler", exception);

        return map;
    }


    //조인포인트 설정  <log 찍음>
    @Around("execution(* kr..service.*.*(..)) || execution(* kr..mapper.*.*(..))")
    public Object logPrint(ProceedingJoinPoint joinPoint) throws Throwable {
        String type = "";
        String name = joinPoint.getSignature().getDeclaringTypeName();

        if (name.indexOf("Facade") > -1) {
            type = "ServiceFacadeImpl  \t:  ";
        } else if (name.indexOf("Service") > -1) {
            type = "ServiceImpl  \t:  ";
        } else if (name.indexOf("Mapper") > -1) {
            type = "Mapper  \t\t:  ";
        }
        log.info(type + name + "." + joinPoint.getSignature().getName() + "()");
        Object obj = joinPoint.proceed();

        return obj;
    }
}