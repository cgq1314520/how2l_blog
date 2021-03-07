package top.how2l.dao.user.userDao;

import top.how2l.pojo.user;

import java.sql.Connection;
import java.util.ArrayList;

/**
 * 用来处理用户登录的dao层对数据库的操作,也即查询是否拥有该用户
 */
public interface userDao {
    /*根据用户邮箱账号和密码进行登录*/
    public user login(Connection connection, String userAccount, String password);

    /*根据给定的内容，判断用户中是否存在相似昵称的用户*/
    public ArrayList<user> userSearchJudge(Connection connection, String userContent);

    /*根据给定的数据进行用户的注册,密码可以考虑md5加密*/
    public int userRegister(Connection connection, String mainAccount, String username, String password);

}
