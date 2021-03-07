package top.how2l.dao.blog.defaultPage;

import top.how2l.dao.BaseDao;
import top.how2l.pojo.blog.dto.ArticlePart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * 具体实现怎么得到首页展示信息的方法，其实就是查询博客部分信息的dao层实现
 */
public class defaultDaoImpl implements defaultDao {
    public ArrayList<ArticlePart> getDefaultShowInfo(Connection connection) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获得些许ArticlePart实体对象，用来存储展示信息
        ArrayList<ArticlePart> result = new ArrayList<ArticlePart>();

        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译
            String sql = "SELECT DISTINCT a.pk_bid,a.gmt_create,a.title,a.descr,a.views,b.username,b.avatar,a.is_original,c.category_name FROM article_info AS a,`user` AS b,article_category AS c WHERE a.author_id = b.`pk_uid` AND a.`category_id`=c.`pk_caid` AND a.is_pass=1";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.execute(connection, pstm, rs, sql, null);
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    ArticlePart articlePart = new ArticlePart();
                    articlePart.setPkBid(rs.getInt("pk_bid"));
                    articlePart.setGmtCreate(rs.getDate("gmt_create"));
                    articlePart.setTitle(rs.getString("title"));
                    articlePart.setDescribe(rs.getString("descr"));
                    articlePart.setViews(rs.getInt("views"));
                    articlePart.setAuthorName(rs.getString("username"));
                    articlePart.setAuthorAvator(rs.getString("avatar"));
                    articlePart.setIsOriginal(rs.getInt("is_original"));
                    articlePart.setCategoryName(rs.getString("category_name"));
                    result.add(articlePart);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //最后关闭连接资源，这就是为什么在BaseDao中把所有的可关闭对象提出来的原因，因为好统一关闭
        BaseDao.closeResource(connection, pstm, rs);
        return result;
    }

    /**
     * 根据输入的内容查询是否有和输入内容相似的博客标题
     *
     * @param connection
     * @param searchContent 待查询内容
     * @return
     */
    public ArrayList<ArticlePart> ArticleTitleSearchJudge(Connection connection, String searchContent) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获得些许ArticlePart实体对象，用来存储展示信息
        ArrayList<ArticlePart> result = new ArrayList<ArticlePart>();

        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译
            String sql = "SELECT DISTINCT a.pk_bid,a.gmt_create,a.title,a.descr,a.views,b.username,b.avatar,a.is_original,c.category_name FROM article_info AS a,`user` AS b,article_category AS c WHERE a.author_id = b.`pk_uid` AND a.`category_id`=c.`pk_caid` AND a.title like ?";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.blurExecute(connection, pstm, rs, sql, new Object[]{searchContent});
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    ArticlePart articlePart = new ArticlePart();
                    articlePart.setPkBid(rs.getInt("pk_bid"));
                    articlePart.setGmtCreate(rs.getDate("gmt_create"));
                    articlePart.setTitle(rs.getString("title"));
                    articlePart.setDescribe(rs.getString("descr"));
                    articlePart.setViews(rs.getInt("views"));
                    articlePart.setAuthorName(rs.getString("username"));
                    articlePart.setAuthorAvator(rs.getString("avatar"));
                    articlePart.setIsOriginal(rs.getInt("is_original"));
                    articlePart.setCategoryName(rs.getString("category_name"));
                    result.add(articlePart);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 根据输入的内容查询是否有和输入内容相似的博客概述，然后返回博客信息
     *
     * @param connection
     * @param searchContent 待查询内容
     * @return
     */
    public ArrayList<ArticlePart> ArticleDescSearchJudge(Connection connection, String searchContent) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获得些许ArticlePart实体对象，用来存储展示信息
        ArrayList<ArticlePart> result = new ArrayList<ArticlePart>();

        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译
            String sql = "SELECT DISTINCT a.pk_bid,a.gmt_create,a.title,a.descr,a.views,b.username,b.avatar,a.is_original,c.category_name FROM article_info AS a,`user` AS b,article_category AS c WHERE a.author_id = b.`pk_uid` AND a.`category_id`=c.`pk_caid` AND a.descr like ?";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.blurExecute(connection, pstm, rs, sql, new Object[]{searchContent});
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    ArticlePart articlePart = new ArticlePart();
                    articlePart.setPkBid(rs.getInt("pk_bid"));
                    articlePart.setGmtCreate(rs.getDate("gmt_create"));
                    articlePart.setTitle(rs.getString("title"));
                    articlePart.setDescribe(rs.getString("descr"));
                    articlePart.setViews(rs.getInt("views"));
                    articlePart.setAuthorName(rs.getString("username"));
                    articlePart.setAuthorAvator(rs.getString("avatar"));
                    articlePart.setIsOriginal(rs.getInt("is_original"));
                    articlePart.setCategoryName(rs.getString("category_name"));
                    result.add(articlePart);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 查询所有的关键字并放入map之中
     *
     * @param connection 连接对象
     * @return
     */
    public Map<Integer, String> ArticleKeyWordsSearch(Connection connection) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获得一个Map实体对象，用来存储查询结果
        Map<Integer, String> result = new HashMap<Integer, String>();

        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //查询所有的关键字并初步去重
            String sql = "SELECT DISTINCT `keywords` FROM `article_info`;";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.blurExecute(connection, pstm, rs, sql, null);
                //通过获得的结果集来给ArticlePart赋值
                int sum = 0;
                while (rs.next()) {
                    /*对keywords进行按英文逗号分割并去重,因为在写博客时，关键字之间的无论中英文的逗号都会被替换为英文的*/
                    String[] keywords = rs.getString("keywords").split(",");
                    for (int i = 0; i < keywords.length; i++) {
                        result.put(sum, keywords[i]);
                        sum++;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 根据工具类生成好的查询语句 和 查询参数 进行"关键字"模式下的博客模糊查询
     * 在这里将title或者descr中的关键字进行高亮显示
     *
     * @param connection
     * @param sql        生成的查询语句
     * @param objects    传递的参数（也即包含哪些关键字）
     * @return
     */
    public ArrayList<ArticlePart> ArticleSearchByKeyWordsBlurSearch(Connection connection, String sql, String[] objects) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获得些许ArticlePart实体对象，用来存储展示信息
        ArrayList<ArticlePart> result = new ArrayList<ArticlePart>();

        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.blurExecute(connection, pstm, rs, sql, objects);
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    ArticlePart articlePart = new ArticlePart();
                    articlePart.setPkBid(rs.getInt("pk_bid"));
                    articlePart.setGmtCreate(rs.getDate("gmt_create"));
                    String title = "";
                    for (int i = 0; i < objects.length; i++) {
                        if (rs.getString("title").indexOf(objects[i]) != -1) {
                            String[] titles = rs.getString("title").split(objects[i]);
                            for (int i1 = 0; i1 < titles.length; i1++) {
                                title += titles[i1];
                                if (i1 < titles.length - 1) {
                                    title += "<span style='color:red'>" + objects[i] + "</span>";
                                }
                            }
                        }
                    }
                    articlePart.setTitle(title);
                    articlePart.setDescribe(rs.getString("descr"));
                    articlePart.setViews(rs.getInt("views"));
                    articlePart.setAuthorName(rs.getString("username"));
                    articlePart.setAuthorAvator(rs.getString("avatar"));
                    articlePart.setIsOriginal(rs.getInt("is_original"));
                    articlePart.setCategoryName(rs.getString("category_name"));
                    result.add(articlePart);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 查询该用户的所有博客信息
     *
     * @param connection
     * @param userid
     * @return
     */
    @Override
    public ArrayList<ArticlePart> getAllArticleInfoWithUserId(Connection connection, long userid) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获得些许ArticlePart实体对象，用来存储展示信息
        ArrayList<ArticlePart> result = new ArrayList<ArticlePart>();

        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译
            String sql = "SELECT DISTINCT a.pk_bid,a.gmt_create,a.title,a.descr,a.views,b.username,b.avatar,a.is_original,c.category_name FROM article_info AS a,`user` AS b,article_category AS c WHERE a.author_id = b.`pk_uid` AND a.`category_id`=c.`pk_caid` AND a.is_pass=1 AND a.`author_id`=?";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.execute(connection, pstm, rs, sql, new Object[]{userid});
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    ArticlePart articlePart = new ArticlePart();
                    articlePart.setPkBid(rs.getInt("pk_bid"));
                    articlePart.setGmtCreate(rs.getDate("gmt_create"));
                    articlePart.setTitle(rs.getString("title"));
                    articlePart.setDescribe(rs.getString("descr"));
                    articlePart.setViews(rs.getInt("views"));
                    articlePart.setAuthorName(rs.getString("username"));
                    articlePart.setAuthorAvator(rs.getString("avatar"));
                    articlePart.setIsOriginal(rs.getInt("is_original"));
                    articlePart.setCategoryName(rs.getString("category_name"));
                    result.add(articlePart);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //最后关闭连接资源，这就是为什么在BaseDao中把所有的可关闭对象提出来的原因，因为好统一关闭
        BaseDao.closeResource(connection, pstm, rs);
        return result;
    }
}
