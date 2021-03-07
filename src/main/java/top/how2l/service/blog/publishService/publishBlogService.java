package top.how2l.service.blog.publishService;

/**
 * 处理发布博客的具体业务操作
 */
public interface publishBlogService {
    public int publishBlog(String title, String descr, long author_id, int category_id, String content, int is_original, String keywords);
}
