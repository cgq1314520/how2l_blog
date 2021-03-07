package top.how2l.servlet.video;

import top.how2l.pojo.video.videoDetail;
import top.how2l.service.video.videoInfoService;
import top.how2l.service.video.videoService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class videoDetailServlet extends HttpServlet {
    private videoService videoService;

    public videoDetailServlet() {
        this.videoService = new videoInfoService();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*获取要显示的视频id参数,然后在数据库中查找其在线地址*/
        int videoId = Integer.valueOf(req.getParameter("dbID"));

        videoDetail video = videoService.getDetailVideoInfo(videoId);

        /*转发到videoDetailShow.jsp，并给其传递视频参数*/
        req.setAttribute("videoInfo", video);
        req.getRequestDispatcher("video/videoDetailShow.jsp").forward(req, resp);
    }
}
