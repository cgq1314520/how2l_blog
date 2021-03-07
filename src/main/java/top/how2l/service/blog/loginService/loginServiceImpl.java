package top.how2l.service.blog.loginService;

import top.how2l.dao.BaseDao;
import top.how2l.dao.user.userDao.userDao;
import top.how2l.dao.user.userDao.userDaoImpl;
import top.how2l.pojo.user;

public class loginServiceImpl implements loginService {
    private userDao loginDao;

    public loginServiceImpl() {
        loginDao = new userDaoImpl();
    }

    /*根据用户名进行对用户是否存在的查询*/
    public user login(String userAccount, String password) {
        user login = loginDao.login(BaseDao.getConnection(), userAccount, password);
        return login;
    }

    public static void main(String[] args) {
        new loginServiceImpl().login("3039958291", "111111");
    }
}
