package top.how2l.service.blog.loginService;

import top.how2l.pojo.user;

/**
 * 开始对来自servlet的信息进行业务处理并调用dao层进行数据库的查询
 */
public interface loginService {
    public user login(String userAccount, String password);
}
