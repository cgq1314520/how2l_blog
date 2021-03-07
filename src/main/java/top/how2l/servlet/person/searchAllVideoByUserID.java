package top.how2l.servlet.person;

import com.fasterxml.jackson.databind.ObjectMapper;
import top.how2l.pojo.video.videoPart;
import top.how2l.service.video.videoInfoService;
import top.how2l.service.video.videoService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * 根据用户的id来查询该用户发布的所有视频
 */
public class searchAllVideoByUserID extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        /*得到用户的id*/
        Long userid = Long.valueOf(req.getParameter("userid"));
        /*根据用户的id来查询当前用户发布的所有视频*/
        videoService videoService = new videoInfoService();
        ArrayList<videoPart> allVideoByUserId = videoService.getAllVideoByUserId(userid);
        System.out.println(allVideoByUserId);
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
        String json = mapper.writeValueAsString(allVideoByUserId);
        /* System.out.println(json);*/
        //把数据写到response对象上。
        // 注： Servlet容器会将response对象上存放的 数据取出来
        //，打一个包（响应数据包）， 然后发送给浏览器。
        out.println(json);
        //如果没有调用out.close，则容器会自动 关闭out。
        out.close();
    }
}
