package top.how2l.servlet.blog;

import top.how2l.pojo.blog.ArticleInfo;
import top.how2l.service.blog.infoService.infoService;
import top.how2l.service.blog.infoService.infoServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

/**
 * 处理从博客页面请求到博客具体信息，并显示到页面上,显示到info页面上去
 */
public class infoShow extends HttpServlet {
    @Override
    public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        //获取超链接传递过来的4个参数
        Integer pkBid = Integer.valueOf(req.getParameter("pkBid"));
        /*Date gmtCreate= Date.valueOf(req.getParameter("gmtCreate"));
        Integer views=Integer.valueOf(req.getParameter("views"));
        String authorName=req.getParameter("authorName");
        String describe=req.getParameter("describe");
        String title=req.getParameter("title");
        String avatar=req.getParameter("avatar");*/
        // 开始通过该pKBid进行具体文件内容的查询了
        infoService infoService = new infoServiceImpl();
        ArticleInfo detailInfo = infoService.getDetailInfo(pkBid);
/*
        detailInfo.setPkBid(pkBid);
        detailInfo.setAuthorName(authorName);
        detailInfo.setGmtCreate(gmtCreate);
        detailInfo.setViews(views);
        detailInfo.setDescribe(describe);
        detailInfo.setTitle(title);
        detailInfo.setAuthorAvator(avatar);*/

        //给jsp页面传递参数
        req.setAttribute("article", detailInfo);
        //页面跳转
        req.getRequestDispatcher("ToInfoPage").forward(req, res);
    }
}
