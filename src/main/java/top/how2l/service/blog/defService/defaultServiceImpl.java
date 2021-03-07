package top.how2l.service.blog.defService;

import org.junit.jupiter.api.Test;
import top.how2l.dao.BaseDao;
import top.how2l.dao.blog.defaultPage.defaultDao;
import top.how2l.dao.blog.defaultPage.defaultDaoImpl;
import top.how2l.pojo.blog.dto.ArticlePart;

import java.sql.Connection;
import java.util.ArrayList;

/**
 * 得到博客部分信息接口的实现类
 */
public class defaultServiceImpl implements defaultService {
    //初始化dao层的接口对象，用来操纵dao层进行数据操作
    defaultDao defaultDao = null;

    public defaultServiceImpl() {
        defaultDao = new defaultDaoImpl();
    }

    /**
     * 通过调用dao层方法实现对于数据库的查询，从而得到首页要展示的信息，并返回给servlet层
     *
     * @return
     */
    @Test
    public ArrayList<ArticlePart> getArticlePartInfo() {
        Connection connection = BaseDao.getConnection();
        ArrayList<ArticlePart> defaultShowInfo = defaultDao.getDefaultShowInfo(connection);
        return defaultShowInfo;
    }
}
