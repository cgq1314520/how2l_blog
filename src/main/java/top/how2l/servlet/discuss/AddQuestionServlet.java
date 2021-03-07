package top.how2l.servlet.discuss;

import com.fasterxml.jackson.databind.ObjectMapper;
import top.how2l.service.discuss.questionAddService.addQuestionService;
import top.how2l.service.discuss.questionAddService.addQuestionServiceImpl;
import top.how2l.util.message;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 添加问题的处理响应，当我们点击提问题并提交问题之后，就会交由此处进行处理
 */
public class AddQuestionServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*接收问题的标题参数值*/
        String questionTitle = req.getParameter("questionTitle");
        /*接收问题的具体内容值*/
        String questionContent = req.getParameter("questionContent");
        /*接收问题的具体发布者*/
        Long userid = Long.valueOf(req.getParameter("userid"));
        /*接收问题的分类标签*/
        String sort = req.getParameter("sort");

        addQuestionService addQuestionService = new addQuestionServiceImpl();
        int i = addQuestionService.insertQuestion(questionTitle, questionContent, userid, sort);
        if (i != 1) {
            /*给ajax请求发送成功的响应数据,json格式*/
            resp.setContentType("application/text;charset=utf-8");
            //通过response对象获得输出流。
            PrintWriter out = resp.getWriter();
            //输出失败信息
            out.println("问题添加失败,请重新尝试");
            out.close();
        } else {
            /*给ajax请求发送成功的响应数据*/
            resp.setContentType("application/text;charset=utf-8");
            //通过response对象获得输出流。
            PrintWriter out = resp.getWriter();
            //输出成功信息
            out.println("问题添加成功");
            out.close();
        }

    }
}
