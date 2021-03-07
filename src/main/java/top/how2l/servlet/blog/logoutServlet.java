package top.how2l.servlet.blog;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 登录退出功能的实现
 */
public class logoutServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*清除session*/
        req.getSession().removeAttribute("user");
        /*重定向到首页*/
        resp.sendRedirect("default.jsp");
    }
}
