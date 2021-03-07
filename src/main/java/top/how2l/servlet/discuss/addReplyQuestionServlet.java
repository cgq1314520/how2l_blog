package top.how2l.servlet.discuss;

import top.how2l.service.discuss.questionAddService.addQuestionService;
import top.how2l.service.discuss.questionAddService.addQuestionServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 添加问题回复的servlet
 */
public class addReplyQuestionServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*获取传递过来的回复参数评论内容*/
        String replyContent = req.getParameter("replyContent");

        /*获取评论用户id*/
        Long userid = Long.valueOf(req.getParameter("userid"));
        /*获取评论问题的id*/
        int questionId = Integer.valueOf(req.getParameter("questionId"));

        /*开始调用service层进行回复的添加*/
        addQuestionService addQuestionService = new addQuestionServiceImpl();
        int i = addQuestionService.insertReplyAnswer(replyContent, userid, questionId);
        if (i != 1) {
            /*给ajax请求发送成功的响应数据,json格式*/
            resp.setContentType("application/text;charset=utf-8");
            //通过response对象获得输出流。
            PrintWriter out = resp.getWriter();
            //输出失败信息
            out.println("您的回复失败,请重新尝试");
            out.close();
        } else {
            /*给ajax请求发送成功的响应数据*/
            resp.setContentType("application/text;charset=utf-8");
            //通过response对象获得输出流。
            PrintWriter out = resp.getWriter();
            //输出成功信息
            out.println("回复成功");
            out.close();
        }

    }
}
