package top.how2l.filter;

import top.how2l.pojo.user;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 对登录的拦截判断
 */
public class loginFilter implements Filter {
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        //过滤器，从session中获取用户
        user user = (user) request.getSession().getAttribute("user");
        if (user == null) {//已经被移除或者注销了，或者未登录
            response.sendRedirect("login.jsp");
        } else {
            chain.doFilter(req, resp);
        }
    }

    public void destroy() {

    }
}
