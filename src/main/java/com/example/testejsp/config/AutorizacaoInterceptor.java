package com.example.testejsp.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.stereotype.Component;

@Component
public class AutorizacaoInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if (request.getSession().getAttribute("usuarioLogado") != null) {
            return true;
        }

        response.sendRedirect("/login");
        return false;
    }
}