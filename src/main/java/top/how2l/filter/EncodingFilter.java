package top.how2l.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 实现对编码的设置的过滤器
 */
public class EncodingFilter implements Filter {
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        //通过过滤器一次性设置页面的编码格式都为utf-8
        HttpServletResponse hResponse = (HttpServletResponse) response;
        hResponse.setHeader("Content-Type", "text/html;charset=UTF-8");
        hResponse.setCharacterEncoding("UTF-8");

        HttpServletRequest hRequest = (HttpServletRequest) request;
        hRequest.setCharacterEncoding("UTF-8");

        chain.doFilter(request, response);
    }

    public void destroy() {

    }
}
