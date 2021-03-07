package top.how2l.servlet.blog;

import com.fasterxml.jackson.databind.ObjectMapper;
import top.how2l.pojo.blog.dto.ArticlePart;
import top.how2l.pojo.user;
import top.how2l.service.blog.searchShowService.searchService;
import top.how2l.service.blog.searchShowService.searchServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.SimpleFormatter;

/**
 * 处理搜索框关键字匹配并显示固定内容的servlet
 */
public class searchShowServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*得到搜索的内容*/
        String content = req.getParameter("searchContent");
        System.out.println(content);
        /*最终返回的四类结果包含在一个ArrayList<Object>中去，这个ArrayList包含三个元素，第一个为用户信息，第二个为博客标题信息，第三个为博客概述信息*/
        ArrayList<Object> result = new ArrayList<Object>();

        /*得到service层对象*/
        searchService service = new searchServiceImpl();

        /*给ajax请求返回对应的相似信息（如果查询到的话）通过四种四个方面进行查询到的结果*/
        result = service.searchItemGet(content);
        System.out.println(result.get(3));
        System.out.println(result.get(4));
        /*给客户端返回数据*/
        //设置content-type消息头，告诉浏览器， 服务器返回的数据类型。
        //我这里是返回 json 类型
        resp.setContentType("application/json;charset=utf-8");

        //通过response对象获得输出流。
        PrintWriter out = resp.getWriter();

        //构建 对象 转 json 类
        ObjectMapper mapper = new ObjectMapper();
        /**
         * 这里是我返回给前端的对象,其他类型也可以
         */
        //把 对象转为 json 字符串
        String json = mapper.writeValueAsString(result);
        /* System.out.println(json);*/
        //把数据写到response对象上。
        // 注： Servlet容器会将response对象上存放的 数据取出来
        //，打一个包（响应数据包）， 然后发送给浏览器。
        out.println(json);

        //如果没有调用out.close，则容器会自动 关闭out。
        out.close();
    }
}
