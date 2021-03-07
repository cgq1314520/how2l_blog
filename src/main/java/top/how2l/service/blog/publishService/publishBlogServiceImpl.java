package top.how2l.service.blog.publishService;

import top.how2l.dao.BaseDao;
import top.how2l.dao.blog.publishBlog.publishBlogDao;
import top.how2l.dao.blog.publishBlog.publishBlogDaoImpl;

/**
 * 具体实现发布博客的业务操作
 */
public class publishBlogServiceImpl implements publishBlogService {
    /*创建dao层对象用来操纵dao层*/
    private publishBlogDao publishBlogDao = null;

    public publishBlogServiceImpl() {
        this.publishBlogDao = new publishBlogDaoImpl();
    }

    public int publishBlog(String title, String descr, long author_id, int category_id, String content, int is_original, String keywords) {
        /*调用dao层对象处理*/
        return publishBlogDao.insertBlog(BaseDao.getConnection(), title, descr, author_id, category_id, content, is_original, keywords);
    }
}
