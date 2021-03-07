package top.how2l.servlet.blog;

import top.how2l.pojo.user;
import top.how2l.service.blog.commentService.commentService;
import top.how2l.service.blog.commentService.commentServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 实现评论添加的功能
 */
public class AddCommentServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("解耦");
        /*获取要进行添加的评论的内容*/
        /*先判断用户是否登录，如果没有登录，则返回让跳转的信息进行跳转*/
        user user=(user) req.getSession().getAttribute("user");
        System.out.println(user+"fds");
        if(user==null){
            resp.setContentType("application/json;charset=utf-8");

            //通过response对象获得输出流。
            PrintWriter out = resp.getWriter();

            //输出重定向到首页的状态码
            out.println("301");
            System.out.println();
            out.close();
            return;
        }
        //获取评论的文章
        int pkBid = Integer.valueOf(req.getParameter("pkBid"));
        //获取评论的用户id
        long uid = Long.valueOf(req.getParameter("uid"));
        //获取评论的内容
        String comment = req.getParameter("comment");
        //获取根评论id
        int parent = Integer.valueOf(req.getParameter("parent"));
        //进行文明用语检查，现在还没有实现

        //调用service层进行评论的插入
        commentService comm = new commentServiceImpl();
        int i = comm.insertComment(pkBid, uid, comment, parent);
        if (i == 1) {
            resp.setContentType("application/json;charset=utf-8");

            //通过response对象获得输出流。
            PrintWriter out = resp.getWriter();

            //输出成功信息
            out.println("评论成功");

            out.close();
        } else {
            resp.setContentType("application/json;charset=utf-8");

            //通过response对象获得输出流。
            PrintWriter out = resp.getWriter();

            //输出成功信息
            out.println("评论失败");

            out.close();
        }

    }
}
