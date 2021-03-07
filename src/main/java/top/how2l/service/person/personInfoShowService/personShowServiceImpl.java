package top.how2l.service.person.personInfoShowService;

import top.how2l.dao.BaseDao;
import top.how2l.dao.person.searchUserInfo.searchUserInfoDao;
import top.how2l.dao.person.searchUserInfo.searchUserInfoDaoImpl;
import top.how2l.pojo.user;

import java.sql.Connection;

/**
 * 查询用户信息的具体实现端
 */
public class personShowServiceImpl implements personInfoSearchService {
    private searchUserInfoDao searchUserInfoDao;

    public personShowServiceImpl() {
        this.searchUserInfoDao = new searchUserInfoDaoImpl();
    }

    @Override
    public user getUserDetailInfo(Long userid) {
        Connection connection = BaseDao.getConnection();
        user user = searchUserInfoDao.userInfoSearch(connection, userid);
        return user;
    }
}
