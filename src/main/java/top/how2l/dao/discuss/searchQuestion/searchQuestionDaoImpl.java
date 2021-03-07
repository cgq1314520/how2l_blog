package top.how2l.dao.discuss.searchQuestion;

import top.how2l.dao.BaseDao;
import top.how2l.pojo.blog.dto.ArticlePart;
import top.how2l.pojo.discuss.discussAsk;
import top.how2l.pojo.discuss.discussReply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class searchQuestionDaoImpl implements searchQuestionDao {
    public ArrayList<discussAsk> getAllQuestion(Connection connection) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获得些许discussAsk实体对象，用来存储展示信息
        ArrayList<discussAsk> result = new ArrayList<discussAsk>();

        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译
            String sql = "SELECT a.pk_daid,a.gmt_create,a.title,a.discussContent,a.userid,a.sort,b.username FROM discuss_ask AS a,`user` AS b WHERE a.userid=b.pk_uid";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.execute(connection, pstm, rs, sql, null);
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    discussAsk discussAsk = new discussAsk();
                    discussAsk.setPkDaId(rs.getInt("pk_daid"));
                    discussAsk.setGmtCreate(rs.getDate("gmt_create"));
                    discussAsk.setTitle(rs.getString("title"));
                    discussAsk.setDiscussContent(rs.getString("discussContent"));
                    discussAsk.setSort(rs.getString("sort"));
                    discussAsk.setUserid(rs.getLong("userid"));
                    discussAsk.setUsername(rs.getString("username"));
                    result.add(discussAsk);
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
     * 通过具体的问题id查找详细的问题信息
     *
     * @param connection
     * @param pkDaId     问题id
     * @return
     */
    public discussAsk getDetailQuestionInfo(Connection connection, int pkDaId) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获得discussAsk实体对象，用来存储展示信息
        discussAsk result = new discussAsk();

        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译
            String sql = "SELECT a.pk_daid,a.gmt_create,a.title,a.discussContent,a.userid,a.sort,b.username,b.avatar FROM discuss_ask AS a,`user` AS b WHERE a.userid=b.pk_uid AND a.pk_daid=?";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.execute(connection, pstm, rs, sql, new Object[]{pkDaId});
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    result.setPkDaId(rs.getInt("pk_daid"));
                    result.setGmtCreate(rs.getDate("gmt_create"));
                    result.setTitle(rs.getString("title"));
                    /*内容本身存储的是html内容*/
                    result.setDiscussContent(rs.getString("discussContent"));
                    result.setSort(rs.getString("sort"));
                    result.setUserid(rs.getLong("userid"));
                    result.setUsername(rs.getString("username"));
                    result.setAuthorAvator(rs.getString("avatar"));
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
     * 通过问题的id查询所有的回复
     *
     * @param connection
     * @param pkDaId     问题的id
     * @return
     */
    public ArrayList<discussReply> getAllReplyAnswer(Connection connection, int pkDaId) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获得些许discussAsk实体对象，用来存储展示信息
        ArrayList<discussReply> result = new ArrayList<discussReply>();

        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译
            String sql = "SELECT a.`gmt_create`,a.`reply`,b.`username`,b.`avatar` FROM `blog`.`discuss_reply` AS a,`user` AS b WHERE a.`parentId`=?  AND a.`userid`=b.`pk_uid`";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.execute(connection, pstm, rs, sql, new Object[]{pkDaId});
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    discussReply discussReply = new discussReply();
                    discussReply.setGmtCreate(rs.getDate("gmt_create"));
                    discussReply.setReplyContent(rs.getString("reply"));
                    discussReply.setUsername(rs.getString("username"));
                    discussReply.setAvatar(rs.getString("avatar"));

                    result.add(discussReply);
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
     * 根据给定的用户的id，查询该用户的所有问题
     *
     * @param connection
     * @param userid
     * @return
     */
    @Override
    public ArrayList<discussAsk> getAllQuestByUserId(Connection connection, long userid) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获得些许discussAsk实体对象，用来存储展示信息
        ArrayList<discussAsk> result = new ArrayList<discussAsk>();

        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译
            String sql = "SELECT a.pk_daid,a.gmt_create,a.title,a.discussContent,a.userid,a.sort,b.username FROM discuss_ask AS a,`user` AS b WHERE a.userid=b.pk_uid AND a.userid=?";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.execute(connection, pstm, rs, sql, new Object[]{userid});
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    discussAsk discussAsk = new discussAsk();
                    discussAsk.setPkDaId(rs.getInt("pk_daid"));
                    discussAsk.setGmtCreate(rs.getDate("gmt_create"));
                    discussAsk.setTitle(rs.getString("title"));
                    discussAsk.setDiscussContent(rs.getString("discussContent"));
                    discussAsk.setSort(rs.getString("sort"));
                    discussAsk.setUserid(rs.getLong("userid"));
                    discussAsk.setUsername(rs.getString("username"));
                    result.add(discussAsk);
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
