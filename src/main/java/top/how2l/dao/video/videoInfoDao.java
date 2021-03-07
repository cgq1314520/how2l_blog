package top.how2l.dao.video;

import top.how2l.dao.BaseDao;
import top.how2l.pojo.discuss.discussAsk;
import top.how2l.pojo.video.videoDetail;
import top.how2l.pojo.video.videoPart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class videoInfoDao implements videoDao {
    /*查询视频的详细信息*/
    @Override
    public videoDetail getVideoDetailInfo(Connection connection, int dbId) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //获取用于存储结果的实体对象
        videoDetail result = new videoDetail();

        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译
            String sql = "SELECT a.`dbId`,a.`title`,a.`userid`,a.`dbVideoUrl`,a.`dbVideoBackUrl`,a.`gmt_create` as atime,b.`avatar`,b.`username`,b.`gmt_create` as btime FROM dbvideo AS a,`user` AS b WHERE a.`dbId`=? AND a.`userid`=b.`pk_uid`";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.execute(connection, pstm, rs, sql, new Object[]{dbId});
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    result.setDbId(rs.getInt("dbId"));
                    result.setTitle(rs.getString("title"));
                    result.setUserId(rs.getLong("userid"));
                    result.setVideoUrl(rs.getString("dbVideoUrl"));
                    result.setVideoBackUrl(rs.getString("dbVideoBackUrl"));
                    result.setPublishTime(rs.getDate("atime"));
                    result.setAvatar(rs.getString("avatar"));
                    result.setName(rs.getString("username"));
                    result.setUserTime(rs.getTime("btime"));
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
     * 查询视频的基本信息
     * @param connection
     * @return
     */
    @Override
    public ArrayList<videoPart> getAllVideoInfoShow(Connection connection) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //生成一个用来接收查询结果的结果集
        ArrayList<videoPart> result = new ArrayList<>();
        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译
            String sql = "SELECT a.`dbId`,a.`dbVideoBackUrl`,a.`title` FROM dbvideo AS a;";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.execute(connection, pstm, rs, sql, null);
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    videoPart temp = new videoPart();
                    temp.setDbId(rs.getInt("dbId"));
                    temp.setVideoBackUrl(rs.getString("dbVideoBackUrl"));
                    temp.setTitle(rs.getString("title"));
                    result.add(temp);
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
     * 通过用户的id来查询用户发布的所有视频
     *
     * @param connection
     * @param userid
     * @return
     */
    @Override
    public ArrayList<videoPart> getAllVideoByUserId(Connection connection, long userid) {
        //获得一个预编译对象，从而使得登陆安全
        PreparedStatement pstm = null;
        //获得一个结果集对象
        ResultSet rs = null;
        //生成一个用来接收查询结果的结果集
        ArrayList<videoPart> result = new ArrayList<>();
        //注意这儿的connection对象不能为空，否则就根本不能链接了，因为其为数据库对象，刚刚进入BaseDao中就需要预编译sql语句，所以要判断
        if (connection != null) {
            //要想通过BaseDao中的查询方法获得博客的基本信息，我们就需要一个sql语句，传递给prestament对象进行预编译
            String sql = "SELECT a.`dbId`,a.`dbVideoBackUrl`,a.`title`,a.`gmt_create` FROM dbvideo AS a where a.userid=?";

            try {
                //调用BaseDao中的查询方法，从而获得结果集
                rs = BaseDao.execute(connection, pstm, rs, sql, new Object[]{userid});
                //通过获得的结果集来给ArticlePart赋值
                while (rs.next()) {
                    videoPart temp = new videoPart();
                    temp.setDbId(rs.getInt("dbId"));
                    temp.setVideoBackUrl(rs.getString("dbVideoBackUrl"));
                    temp.setTitle(rs.getString("title"));
                    temp.setGmtCreate(rs.getDate("gmt_create"));
                    result.add(temp);
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
