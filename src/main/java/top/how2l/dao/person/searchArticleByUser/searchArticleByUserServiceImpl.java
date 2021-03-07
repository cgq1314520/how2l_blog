package top.how2l.dao.person.searchArticleByUser;

import top.how2l.dao.BaseDao;
import top.how2l.dao.blog.defaultPage.defaultDao;
import top.how2l.dao.blog.defaultPage.defaultDaoImpl;
import top.how2l.pojo.blog.dto.ArticlePart;

import java.sql.Connection;
import java.util.ArrayList;

public class searchArticleByUserServiceImpl implements searchArticleByUserService {
    private defaultDao defaultDao;

    public searchArticleByUserServiceImpl() {
        this.defaultDao = new defaultDaoImpl();
    }

    @Override
    public ArrayList<ArticlePart> getAllArticleByUser(long userid) {
        Connection connection = BaseDao.getConnection();
        ArrayList<ArticlePart> allArticleInfoWithUserId = defaultDao.getAllArticleInfoWithUserId(connection, userid);
        return allArticleInfoWithUserId;
    }
}
