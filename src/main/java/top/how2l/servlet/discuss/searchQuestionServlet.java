package top.how2l.servlet.discuss;

import top.how2l.pojo.discuss.discussAsk;
import top.how2l.service.discuss.questionSearchService.searchQuestionService;
import top.how2l.service.discuss.questionSearchService.searchQuestionServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * 处理你问我答界面首页请求的servlet
 */
public class searchQuestionServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*请求service层得到数据*/
        searchQuestionService questionService = new searchQuestionServiceImpl();
        /*开始从service层请求得到数据*/
        ArrayList<discussAsk> discussAsks = questionService.searchQuestion();
        /*将数据响应给客户端*/
        req.setAttribute("allQuestion", discussAsks);

        /*请求转发到问答主页*/
        req.getRequestDispatcher("discuss/discussAll.jsp").forward(req, resp);

    }
}
