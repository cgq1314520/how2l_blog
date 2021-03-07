package top.how2l.servlet.user;

import top.how2l.service.user.userRegisterService;
import top.how2l.service.user.userRegisterServiceImpl;
import top.how2l.util.redisUtils;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 用来处理注册功能的请求即 /register
 */
public class registerServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*接收注册时传递进来的各种信息*/
        /*用户邮箱*/
        String mailAccount = req.getParameter("useraccount");
        /*邮箱验证码*/
        String var = req.getParameter("var");
        /*用户昵称*/
        String name = req.getParameter("name");
        /*用户密码*/
        String password = req.getParameter("password");
        /*在redis中验证邮箱账号验证是否正确，也即验证码是否正确*/
        String s = redisUtils.get(mailAccount);
        /*如果验证码是匹配的，则进行插入后直接进行返回成功，否则返回失败*/
        int result = 0;
        if (s.equals(var)) {
            //正确，进行用户的注册，并返回到登录页面让用户用邮箱登录
            userRegisterService userRegisterService = new userRegisterServiceImpl();
            result = userRegisterService.userRegister(name, mailAccount, password);
            if (result != 0) {
                req.setAttribute("message", "注册成功,请登录");
            } else {
                req.setAttribute("message", "注册失败,请重新注册");
            }
        } else {
            req.setAttribute("message", "验证码错误，请重新输入");
        }
        req.getRequestDispatcher("login.jsp").forward(req, resp);

    }
}
