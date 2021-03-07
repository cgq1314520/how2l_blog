package top.how2l.servlet.blog;

import top.how2l.service.blog.publishService.publishBlogService;
import top.how2l.service.blog.publishService.publishBlogServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 用来处理博客的提交事件:FileSubmit
 */
public class PublishBlogServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*获取参数*/
        String title = req.getParameter("title");
        String descr = req.getParameter("describe");
        String Content = req.getParameter("Content");
        String sort = req.getParameter("sort");
        long userid = Long.valueOf(req.getParameter("userid"));
        String keywords = req.getParameter("keywords");
        /*将关键字中的逗号全部替换为英文的*/
        keywords.replaceAll("，", ",");
        /*调用业务层进行处理*/
        publishBlogService publishBlogService = new publishBlogServiceImpl();

        int i = publishBlogService.publishBlog(title, descr, userid, 1, Content, 1, keywords);
        resp.setContentType("application/text;charset=utf-8");
        resp.getWriter().write("success");
    }
}
