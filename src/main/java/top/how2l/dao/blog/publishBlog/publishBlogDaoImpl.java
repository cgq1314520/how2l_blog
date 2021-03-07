package top.how2l.dao.blog.publishBlog;

import top.how2l.dao.BaseDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * 具体操作数据库的部分代码
 */
public class publishBlogDaoImpl implements publishBlogDao {
    public int insertBlog(Connection connection, String title, String descr, long author_id, int category_id, String content, int is_original, String keywords) {
        /*创建预编译对象*/
        PreparedStatement psm = null;
        /*创建结果集对象*/
        ResultSet rs = null;
        /*创建一个用来接收插入结果的返回值,1代表插入成功，0代表出错*/
        int result = 0;
        /*开始具体的业务*/
        if (connection != null) {
            /*书写操作数据库的具体sql语句*/
            String sql = "INSERT INTO article_info(title,descr,author_id,is_original,category_id,content,keywords) VALUE(?,?,?,?,?,?,?)";
            /*进行对此的插入操作*/
            result = BaseDao.update(connection, psm, rs, sql, new Object[]{title, descr, author_id, is_original, category_id, content, keywords});
        }
        return result;
    }
}
