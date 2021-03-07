package top.how2l.servlet.person;

import top.how2l.pojo.user;
import top.how2l.service.person.personInfoShowService.personInfoSearchService;
import top.how2l.service.person.personInfoShowService.personShowServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 个人中心的信息展示界面跳转以及信息的得到
 */
public class personShowServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*得到用户的id*/
        Long userid = Long.valueOf(req.getParameter("userid"));
        /*通过用户的id进行查询用户的主体信息，包括用户的个人信息详细版，其他部分都通过异步请求进行得到*/
        personInfoSearchService personInfoSearchService = new personShowServiceImpl();
        user userDetailInfo = personInfoSearchService.getUserDetailInfo(userid);
        req.setAttribute("userDetailInfo", userDetailInfo);
        req.getRequestDispatcher("person/personInfo.jsp").forward(req, resp);
    }
}
