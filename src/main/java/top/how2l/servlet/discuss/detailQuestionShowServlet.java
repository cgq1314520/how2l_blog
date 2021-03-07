package top.how2l.servlet.discuss;

import top.how2l.pojo.discuss.discussAsk;
import top.how2l.service.discuss.questionSearchService.searchQuestionService;
import top.how2l.service.discuss.questionSearchService.searchQuestionServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * 具体的问题信息展示界面，也即在你问我答首页点击问题后进入展示具体问题的界面
 */
public class detailQuestionShowServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*获取问题的请求参数*/
        int pkDaId = Integer.valueOf(req.getParameter("pkDaId"));
        /*请求service层得到数据*/
        searchQuestionService questionService = new searchQuestionServiceImpl();
        /*开始从service层请求得到数据*/
        discussAsk discussAsks = questionService.searchQuestionDetailInfo(pkDaId);
        /*将数据响应给客户端*/
        req.setAttribute("questionDetail", discussAsks);
        /*请求转发到问答主页*/
        req.getRequestDispatcher("discuss/discussDetailShow.jsp").forward(req, resp);
    }
}
