package top.how2l.dao.blog.defaultPage;

import top.how2l.pojo.blog.dto.ArticlePart;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Map;

/**
 * default主页面的基础信息查询，每次30条，返回结果应该是ArticlePart中的实体类
 */
public interface defaultDao {
    /*根据connection来实现对default页面部分博客信息的展示*/
    public ArrayList<ArticlePart> getDefaultShowInfo(Connection connection);

    /*根据给定的输入内容查询是否存在和给定内容相似的标题*/
    public ArrayList<ArticlePart> ArticleTitleSearchJudge(Connection connection, String searchContent);

    /*根据给定的输入内容查询是否存在和给定内容相似的概述，并返回对应博客信息*/
    public ArrayList<ArticlePart> ArticleDescSearchJudge(Connection connection, String searchContent);

    /*查询博客信息表中存在的所有关键字*/
    public Map<Integer, String> ArticleKeyWordsSearch(Connection connection);

    /*根据给定的关键字参数查询哪些博客包含这些关键字（从博客标题和概述中进行模糊查询），其实就是根据搜索内容中包含的关键字进行查询*/
    public ArrayList<ArticlePart> ArticleSearchByKeyWordsBlurSearch(Connection connection, String sql, String[] objects);

    /*根据给定的用户id，查询该用户的所有文章信息*/
    public ArrayList<ArticlePart> getAllArticleInfoWithUserId(Connection connection, long userid);
}
