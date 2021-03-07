package top.how2l.dao.blog.infoPage;

import top.how2l.pojo.blog.ArticleInfo;

import java.sql.Connection;

/**
 * 具体实现查询数据库中具体文章信息的操作接口
 */
public interface infoDao {
    /*通过connection对象和查询参数(也即文章对应的主键)实现对具体文章的查询*/
    public ArticleInfo getDetailInfo(Connection connection, Integer pkBid);
}
