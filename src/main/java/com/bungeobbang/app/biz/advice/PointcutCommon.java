package com.bungeobbang.app.biz.advice;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class PointcutCommon {
    //로그인 확인, 작성자 일치확인, 권한 검증 등 AOP사용 포인트 컷
    @Pointcut("execution(boolean com.bungeabbang.app.biz..*Impl.*(..))")
    public void cudAllPointcut() {}

    //에러 발생 시 에러코드, service사용 로그 등 포인트 컷
    @Pointcut("execution(* com.bungeabbang.app.biz..*Impl.*(..))")
    public void allPointcut() {}

//    //존재하지 않는 데이터 접근 확인용 등 포인트 컷 -> View에서 js확인으로 변경
//    @Pointcut("execution(* com.bungeabbang.app.biz..*Impl.selectOne(..))")
//    public void selecOnePointcut() {}
}
