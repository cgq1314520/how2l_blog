package top.how2l.service.user;

import top.how2l.dao.BaseDao;
import top.how2l.dao.user.userDao.userDao;
import top.how2l.dao.user.userDao.userDaoImpl;

import java.sql.Connection;

public class userRegisterServiceImpl implements userRegisterService {
    private userDao user;

    public userRegisterServiceImpl() {
        this.user = new userDaoImpl();
    }

    @Override
    public int userRegister(String username, String userAccount, String password) {
        Connection connection = BaseDao.getConnection();
        int i = user.userRegister(connection, userAccount, username, password);
        return i;
    }
}
