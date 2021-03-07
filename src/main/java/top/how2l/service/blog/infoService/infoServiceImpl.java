package top.how2l.service.blog.infoService;

import top.how2l.dao.BaseDao;
import top.how2l.dao.blog.infoPage.infoDao;
import top.how2l.dao.blog.infoPage.infoDaoImpl;
import top.how2l.pojo.blog.ArticleInfo;

import java.sql.Connection;

/**
 * 具体实现查询博客信息的业务操作
 */
public class infoServiceImpl implements infoService {
    /*初始化dao层的接口对象，用来操作数据库*/
    infoDao infoDao = null;

    public infoServiceImpl() {
        infoDao = new infoDaoImpl();
    }

    public ArticleInfo getDetailInfo(Integer pkBid) {
        Connection connection = BaseDao.getConnection();
        ArticleInfo detailInfo = infoDao.getDetailInfo(connection, pkBid);
        return detailInfo;
    }
}
