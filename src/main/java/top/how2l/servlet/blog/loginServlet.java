package top.how2l.servlet.blog;

import top.how2l.pojo.user;
import top.how2l.service.blog.loginService.loginService;
import top.how2l.service.blog.loginService.loginServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 用来处理登陆的请求，即/login的请求
 */
public class loginServlet extends HttpServlet {
    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String userAccount = req.getParameter("userAccount");
        String userPassword = req.getParameter("password");
        /*开始登陆验证*/
        loginService loginService = new loginServiceImpl();
        user login = loginService.login(userAccount, userPassword);
        if (login == null) {/*登陆失败，给出error信息,并在login.jsp页面中显示*/
            req.setAttribute("error", "用户名或者密码错误");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        } else {  /*登陆成功，则将用户信息放入缓存，并跳转到主页中去*/
            req.getSession().setAttribute("user", login);
            //页面跳转（frame.jsp）
            res.sendRedirect("/");
        }
    }
}
