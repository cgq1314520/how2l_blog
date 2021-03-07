package top.how2l.servlet.blog.jumpToPage;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 跳转到发布博客的页面的servlet
 */
public class jumpToPublishBlog extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("blogInfo/publishBlog.jsp").forward(req, resp);
    }
}
