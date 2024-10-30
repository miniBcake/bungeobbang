package com.bungeobbang.app.biz.common;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

import java.io.IOException;

@WebFilter("*.do")
@Slf4j
public class LogFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String uri = req.getRequestURI();
        String cp = req.getContextPath();
        // 프로젝트 패스만큼 자름
        String command = uri.substring(cp.length());
        log.info("\u001B[35mFilter command start : [{}]\u001B[0m", command);
        chain.doFilter(request, response);
        log.info("\u001B[35mFilter command end : [{}]\u001B[0m", command);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
