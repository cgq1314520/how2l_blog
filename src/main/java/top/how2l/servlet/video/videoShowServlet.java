package top.how2l.servlet.video;

import top.how2l.pojo.video.videoPart;
import top.how2l.service.video.videoInfoService;
import top.how2l.service.video.videoService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 * 这个servlet即为所有视频大概展示的页面
 */
public class videoShowServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        videoService videoService = new videoInfoService();

        ArrayList<videoPart> allVideoInfo = videoService.getAllVideoInfo();

        req.setAttribute("AllVideoInfo", allVideoInfo);

        req.getRequestDispatcher("video/videoShow.jsp").forward(req, resp);
    }
}
