package top.how2l.servlet.blog;

import top.how2l.service.blog.defService.defaultService;
import top.how2l.pojo.blog.dto.ArticlePart;
import top.how2l.service.blog.defService.defaultServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * 该包里面的servlet都是为default首页展示的信息服务的，主要用于请求展示部分博客信息
 */
public class indexServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*调用service层的方法，得到想要展示到default.jsp的数据信息*/
        defaultService defaultService = new defaultServiceImpl();
        /*得到数据*/
        ArrayList<ArticlePart> articlePartInfo = defaultService.getArticlePartInfo();
        /*存入数据让在前端显示*/
        req.setAttribute("info", articlePartInfo);

        //页面跳转
        req.getRequestDispatcher("default.jsp").forward(req, resp);
    }
}
