package top.how2l.dao.blog.publishBlog;

import java.net.ConnectException;
import java.sql.Connection;

/**
 * 添加博客的dao层接口实现
 * INSERT INTO article_info(title,descr,author_id,is_pass,is_original,category_id,content)
 * VALUE('你还好吗','这是一篇抒情文章',2017011367,1,1,1,'fjdslfklsjkfslflsj')
 */
public interface publishBlogDao {
    /*也即根据传递过来的参数进行对博客的插入*/
    public int insertBlog(Connection connection, String title, String descr, long author_id, int category_id, String content, int is_original, String keywords);
}
