package top.how2l.dao.person.searchUserInfo;

import top.how2l.dao.BaseDao;
import top.how2l.pojo.discuss.discussAsk;
import top.how2l.pojo.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 * 具体的用户信息查询
 */
public class searchUserInfoDaoImpl implements searchUserInfoDao {

    @Override
    public user userInfoSearch(Connection connection, long userid) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获得user实体对象，用来存储展示信息
        user user = new user();
        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译#查询当前用户的详细信息
            String sql = "SELECT a.* FROM `user` AS a WHERE a.pk_uid=?";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.execute(connection, pstm, rs, sql, new Object[]{userid});
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    user.setPk_uid(rs.getLong("pk_uid"));
                    user.setUsername(rs.getString("username"));
                    user.setAvatar(rs.getString("avatar"));
                    user.setGmt_create(rs.getDate("gmt_create"));
                    user.setGmt_modified(rs.getDate("gmt_modified"));
                    user.setEmail(rs.getString("email"));
                    user.setDescr(rs.getString("descr"));
                    user.setBlogNumbers(rs.getInt("BlogNumbers"));
                    user.setVideoNumbers(rs.getInt("videoNumbers"));
                    user.setCommentNumbers(rs.getInt("commentNumbers"));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            String sql1 = "SELECT IFNULL(c.views,0) AS views FROM (SELECT SUM(a.views)AS views FROM article_info AS a WHERE a.author_id=?)AS c";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.execute(connection, pstm, rs, sql1, new Object[]{userid});
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    user.setViews(rs.getInt("views"));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //最后关闭连接资源，这就是为什么在BaseDao中把所有的可关闭对象提出来的原因，因为好统一关闭
        BaseDao.closeResource(connection, pstm, rs);
        return user;
    }
}
