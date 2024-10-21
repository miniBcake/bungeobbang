package com.bungeobbang.app.biz.advice;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@Aspect
public class ErrorAdvice {
    //발생한 에러 확인로그 출력
    @AfterThrowing(pointcut = "PointcutCommon.allPointcut()", throwing = "ex")
    public void afterThrowing(JoinPoint joinPoint, Throwable ex) {
        log.error("AOP: errorThrowing : {}\n\terrorMsg : {}\n\tStackTrace : {}", joinPoint.getSignature(), ex.getMessage(), ex.getStackTrace());
    }
}
