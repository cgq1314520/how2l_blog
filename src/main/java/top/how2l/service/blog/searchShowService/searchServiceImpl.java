package top.how2l.service.blog.searchShowService;

import top.how2l.dao.BaseDao;
import top.how2l.dao.blog.defaultPage.defaultDao;
import top.how2l.dao.blog.defaultPage.defaultDaoImpl;
import top.how2l.dao.user.userDao.userDao;
import top.how2l.dao.user.userDao.userDaoImpl;
import top.how2l.pojo.blog.dto.ArticlePart;
import top.how2l.pojo.user;
import top.how2l.util.searchUtil;

import java.sql.Connection;
import java.util.ArrayList;

/**
 * 对搜索内容的具体业务处理，其实就是根据接口方法中所述的几个步骤逐步进行插叙
 */
public class searchServiceImpl implements searchService {
    /*创建dao层对象进行操作数据库*/
    /*第一种：与用户相关的dao层对象*/
    private userDao userDao = null;
    /*第二种：与博客相关的dao层对象*/
    private defaultDao defaultDao = null;

    public searchServiceImpl() {
        this.userDao = new userDaoImpl();
        this.defaultDao = new defaultDaoImpl();
    }

    public ArrayList<Object> searchItemGet(String searchContent) {
        /*第0步：创建一个用来存储返回结果的集合*/
        ArrayList<Object> result = new ArrayList<Object>();

        /**第一步：查询是否存在类似用户名的用户集合*/
        Connection connection = BaseDao.getConnection();
        ArrayList<user> users = userDao.userSearchJudge(connection, searchContent);
        result.add(users);

        /**第二步：查询是否存在类似博客标题的博客集合*/
        ArrayList<ArticlePart> articleParts = defaultDao.ArticleTitleSearchJudge(connection, searchContent);
        result.add(articleParts);

        /**第三步：查询到与搜索栏like的概述信息（如果存在）--返回博客信息*/
        ArrayList<ArticlePart> articleParts1 = defaultDao.ArticleDescSearchJudge(connection, searchContent);
        result.add(articleParts1);

        /**第四步：查询是否存在与输入内容具有相同关键字的标题，并将其对应的博客信息返回*/
        //(1)：获取当前库中的所有关键字并存在一个map中(去重，逗号前后要进行分割)------通过util包中的工具类来做
        //(2)：检索搜索的内容中具有哪些关键字---同样也通过util包中的工具类来做
        //(3)：得到所有含有(2)中关键字的博客标题，并按照数量的多寡进行排序--同样通过工具类来做
        //以下中包含两个内容，第一个是通过博客标题和关键字的对比查询到的博客信息，第二个是通过博客概述和关键字对比查询到的博客信息
        ArrayList<ArrayList<ArticlePart>> articleParts2 = searchUtil.BlogKeyWordsGet(searchContent);
        //(4)：将得到的结果添加进结果集
        result.add(articleParts2.get(0));
        result.add(articleParts2.get(1));
        return result;
    }
}
