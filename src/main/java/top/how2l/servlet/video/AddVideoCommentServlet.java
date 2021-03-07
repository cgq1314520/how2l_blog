package top.how2l.servlet.video;

import top.how2l.service.blog.commentService.commentService;
import top.how2l.service.blog.commentService.commentServiceImpl;
import top.how2l.service.video.videoComment.videoCommentService;
import top.how2l.service.video.videoComment.videoCommentServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class AddVideoCommentServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*获取要进行添加的评论的内容*/
        //获取评论的文章
        int pkVid = Integer.valueOf(req.getParameter("pkVid"));
        //获取评论的用户id
        long uid = Long.valueOf(req.getParameter("uid"));
        //获取评论的内容
        String comment = req.getParameter("comment");
        //获取根评论id
        int parent = Integer.valueOf(req.getParameter("parent"));
        //进行文明用语检查，现在还没有实现

        //调用service层进行评论的插入
        videoCommentService comm = new videoCommentServiceImpl();
        int i = comm.insertComment(pkVid, uid, comment, parent);
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
