package top.how2l.service.blog.infoService;

import top.how2l.pojo.blog.ArticleInfo;

/**
 * 进行对博客具体信息查询的接口，返回数据应该是一个博客的所有具体内容
 */
public interface infoService {
    /*根据博客的pkBid来查询具体的文章信息*/
    public ArticleInfo getDetailInfo(Integer pkBid);
}
