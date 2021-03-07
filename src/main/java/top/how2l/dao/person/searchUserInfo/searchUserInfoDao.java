package top.how2l.dao.person.searchUserInfo;

import top.how2l.pojo.user;

import java.sql.Connection;

/**
 * 具体的用户信息数据库查询操作
 */
public interface searchUserInfoDao {
    public user userInfoSearch(Connection connection, long userid);
}
