package top.how2l.dao.blog.infoPage;

import top.how2l.dao.BaseDao;
import top.how2l.pojo.blog.ArticleInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

/**
 * 通过文章主键来实现对具体内容的查询
 */
public class infoDaoImpl implements infoDao {
    public ArticleInfo getDetailInfo(Connection connection, Integer pkBid) {
        /*获取预编译对象*/
        PreparedStatement psm = null;
        /*获取一个结果集对象用来接收结果*/
        ResultSet rs = null;
        /*创建一个博客对象，用来存储文章信息*/
        ArticleInfo articleInfo = new ArticleInfo();

        /*开始查找信息*/
        if (connection != null) {
            String sql = "select * from article_info where pk_bid=?";
            /*开始调用basedao进行查询*/
            try {
                rs = BaseDao.execute(connection, psm, rs, sql, new Integer[]{pkBid});
                /*将查询结果放到对象中去*/
                if (rs.next()) {
                    articleInfo.setPkBid(rs.getInt("pk_bid"));
                    articleInfo.setGmtCreate(rs.getDate("gmt_create"));
                    articleInfo.setTitle(rs.getString("title"));
                    articleInfo.setDescribe(rs.getString("descr"));
                    articleInfo.setViews(rs.getInt("views"));
                    articleInfo.setAuthorId(rs.getLong("author_id"));
                    articleInfo.setIsPass(rs.getInt("is_pass"));
                    articleInfo.setIsOriginal(rs.getInt("is_original"));
                    articleInfo.setUrl(rs.getString("url"));
                    articleInfo.setCategoryId(rs.getInt("category_id"));
                    articleInfo.setContent(rs.getString("content"));
                    String keywords = rs.getString("keywords");
                    String[] split = keywords.split(",");
                    articleInfo.setKeywords(new ArrayList<String>(Arrays.asList(split)));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        //最后关闭连接资源，这就是为什么在BaseDao中把所有的可关闭对象提出来的原因，因为好统一关闭
        BaseDao.closeResource(connection, psm, rs);
        return articleInfo;
    }
}
