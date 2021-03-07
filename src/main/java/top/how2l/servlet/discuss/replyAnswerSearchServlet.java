package top.how2l.servlet.discuss;

import com.fasterxml.jackson.databind.ObjectMapper;
import top.how2l.pojo.discuss.discussReply;
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
 * 查询回复的结果
 */
public class replyAnswerSearchServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        /*得到具体的问题的id*/
        int questionId = Integer.valueOf(req.getParameter("questionId"));
        /*请求service层得到数据*/
        searchQuestionService questionService = new searchQuestionServiceImpl();
        /*开始从service层请求得到数据*/
        ArrayList<discussReply> allReplyAnswerInfo = questionService.getAllReplyAnswerInfo(questionId);

        //给浏览器传递数据
        //设置content-type消息头，告诉浏览器， 服务器返回的数据类型。
        //我这里是返回 json 类型
        response.setContentType("application/json;charset=utf-8");

        //通过response对象获得输出流。
        PrintWriter out = response.getWriter();

        //构建 对象 转 json 类
        ObjectMapper mapper = new ObjectMapper();
        /**
         * 这里是我返回给前端的对象,其他类型也可以
         */
        //把 对象转为 json 字符串
        String json = mapper.writeValueAsString(allReplyAnswerInfo);
        /* System.out.println(json);*/
        //把数据写到response对象上。
        // 注： Servlet容器会将response对象上存放的 数据取出来
        //，打一个包（响应数据包）， 然后发送给浏览器。
        out.println(json);

        //如果没有调用out.close，则容器会自动 关闭out。
        out.close();
    }
}
