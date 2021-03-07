package top.how2l.dao.person.searchArticleByUser;

import top.how2l.pojo.blog.dto.ArticlePart;

import java.util.ArrayList;

public interface searchArticleByUserService {
    public ArrayList<ArticlePart> getAllArticleByUser(long userid);
}
