package top.how2l.dao.user.userDao;

import top.how2l.dao.BaseDao;
import top.how2l.pojo.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * 通过邮箱和用户密码来验证登录用户是否是正确的，进而返回登录对象
 */
public class userDaoImpl implements userDao {
    /**
     * 判断登录的用户是否合法
     *
     * @param connection  数据库连接对象
     * @param userAccount 用户账号
     * @param password    用户密码
     * @return
     */
    public user login(Connection connection, String userAccount, String password) {
        /*建立预编译对象*/
        PreparedStatement psm = null;
        /*建立结果集*/
        ResultSet rs = null;
        /*建立用来接收结果的用户对象*/
        user user = null;
        /*开始查询*/
        if (connection != null) {
            /*查询语句*/
            String sql = "select * from blog.user where email=? AND password=?";
            try {

                /*开始查询*/
                rs = BaseDao.execute(connection, psm, rs, sql, new Object[]{userAccount, password});
                if (rs.next()) {
                    user = new user();
                    user.setPk_uid(rs.getLong("pk_uid"));
                    user.setUsername(rs.getString("username"));/*用户昵称*/
                    user.setAvatar(rs.getString("avatar"));
                    /*user.setGmt_create(rs.getDate("gmt_create"));
                    user.setGmt_modified(rs.getDate("gmt_modified"));*/
                    user.setEmail(userAccount);
                    user.setDescr(rs.getString("descr"));

                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return user;
    }

    /**
     * 判断用户昵称中是否存在和给定内容类似的用户
     *
     * @param connection  数据库连接对象
     * @param userContent 给定的内容
     * @return 用户集合
     */
    public ArrayList<user> userSearchJudge(Connection connection, String userContent) {
        /*建立预编译对象*/
        PreparedStatement psm = null;
        /*建立结果集*/
        ResultSet rs = null;
        /*建立用来接收结果的用户对象*/
        ArrayList<user> result = new ArrayList<top.how2l.pojo.user>();
        /*开始查询*/
        if (connection != null) {
            /*模糊查询语句的%需要在具体编译时，通过参数的形式注入到参数里面*/
            String sql = "select * from blog.user where username like ?";
            try {
                /*开始查询*/
                rs = BaseDao.blurExecute(connection, psm, rs, sql, new Object[]{userContent});
                while (rs.next()) {

                    user user = new user();
                    user.setPk_uid(rs.getLong("pk_uid"));
                    user.setUsername(rs.getString("username"));/*用户昵称*/
                    result.add(user);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 用户注册
     *
     * @param connection
     * @param mainAccount
     * @param username
     * @param password
     * @return
     */
    @Override
    public int userRegister(Connection connection, String mainAccount, String username, String password) {
//开始创建预编译对象
        PreparedStatement psm = null;
        //开始创建结果集用来接收结果
        ResultSet rs = null;
        //接收结果
        int result = 0;
        if (connection != null) {
            String sql = "INSERT INTO `user`(`username`,`password`,`email`) VALUE(?,?,?)";
            try {
                result = BaseDao.update(connection, psm, rs, sql, new Object[]{username, password, mainAccount});
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
