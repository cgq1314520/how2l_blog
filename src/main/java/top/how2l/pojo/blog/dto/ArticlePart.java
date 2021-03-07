package top.how2l.pojo.blog.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 用于首页default页面内容的展示部分博客信息,同时标注代表可序列化
 * 需要的内容有  标题
 * 核心内容概述
 * 昵称
 * 头像
 * 发布时间
 * 原创标志----通过是否原创来进行标记
 * 这五个部分
 */
@Data
public class ArticlePart implements Serializable {
    private static final long serialVersionUID = 1L;

    /*文章的主键，通过此个来进行jsp页面详细展示时查询具体内容*/
    private Integer pkBid;

    /*创建时间*/
    private Date gmtCreate;

    /*修改时间*//*
    private Date gmtModified;*/

    /*乐观锁机制*/
    /*private Integer version;*/

    /*标题*/
    private String title;

    /*核心描述*/
    private String describe;

    /*浏览量*/
    private Integer views;


    /*作者昵称*/
    private String authorName;

    /*作者头像地址*/
    private String authorAvator;

    /*文章是否审核通过*/
    /* private Integer isPass;*/

    /*文章是否原创，如果原创则标明原创的标志，否则标明引用的标志*/
    private Integer isOriginal;

    /*文章对应的类别名称*/
    private String categoryName;

    /*文章对应的类别名称id*/
    private int categoryNameId;

    public ArticlePart() {
    }

    public ArticlePart(Integer pkBid, Date gmtCreate, String title, String describe, Integer views, String authorName, String authorAvator) {
        this.pkBid = pkBid;
        this.title = title;
        this.gmtCreate = gmtCreate;
        this.describe = describe;
        this.views = views;
        this.authorName = authorName;
        this.authorAvator = authorAvator;
    }
}
