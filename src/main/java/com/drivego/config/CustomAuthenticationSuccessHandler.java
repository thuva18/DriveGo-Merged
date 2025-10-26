package com.drivego.config;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Collection;

@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        
        String redirectURL = determineTargetUrl(authorities);
        
        response.sendRedirect(redirectURL);
    }
    
    private String determineTargetUrl(Collection<? extends GrantedAuthority> authorities) {
        // Check roles in order of priority
        for (GrantedAuthority authority : authorities) {
            String role = authority.getAuthority();
            
            if ("ROLE_ADMIN".equals(role)) {
                return "/dashboard"; // Admin dashboard
            }
        }
        
        // Default: all other users (including ROLE_USER) go to customer index
        return "/customer/home";
    }
}