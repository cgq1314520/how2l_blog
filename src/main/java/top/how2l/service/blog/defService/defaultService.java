package top.how2l.service.blog.defService;

import top.how2l.pojo.blog.dto.ArticlePart;

import java.util.ArrayList;

/**
 * 具体业务实现的代码，实现操作dao层，得到default首页展示信息的方法
 */
public interface defaultService {
    /*得到博客的部分信息用于首页展示*/
    public ArrayList<ArticlePart> getArticlePartInfo();
}
