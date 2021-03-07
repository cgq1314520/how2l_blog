package top.how2l.servlet.blog;

import com.fasterxml.jackson.databind.ObjectMapper;
import top.how2l.pojo.blog.Comment;
import top.how2l.service.blog.commentService.commentService;
import top.how2l.service.blog.commentService.commentServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * 该servlet的功能为返回评论的数据给浏览器（返回json数据）
 * 该servlet是浏览器通过异步请求进行请求的
 * 请求时携带的参数是：被评论文章的id即：pkBid的值
 */

/**
 * 注意：评论的请求应该是一个异步加载得到的---所以和info信息页面的请求分离
 * 开始通过该pkBid()进行对该文章评论的查询，返回结果应该是一个集合的嵌套，
 * 其中集合的每一个元素都是一个集合，其中每个子集合就是一个父子类评论的嵌套
 * 其中parent如果不为null，则说明是子评论，否则是原本的评论；子评论
 * 的布局方式和父评论不同，在jsp中可以通过<c:if test=""></c:if>
 * 的方式来进行判断
 */
public class CommentServlet extends HttpServlet {
    @Override
    public void service(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        int pkBid = Integer.valueOf(req.getParameter("pkBid"));
        commentService commentService = new commentServiceImpl();
        ArrayList<ArrayList<Comment>> comments = commentService.getComments(pkBid);
        /*for (ArrayList<Comment> comment : comments) {
            System.out.println(comment);
        }*/

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
        String json = mapper.writeValueAsString(comments);
        /* System.out.println(json);*/
        //把数据写到response对象上。
        // 注： Servlet容器会将response对象上存放的 数据取出来
        //，打一个包（响应数据包）， 然后发送给浏览器。
        out.println(json);

        //如果没有调用out.close，则容器会自动 关闭out。
        out.close();
    }
}
