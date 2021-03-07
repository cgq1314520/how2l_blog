package top.how2l.pojo.blog;


import lombok.Data;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

/**
 * @author 小帆远航
 * @since 2020-11-23
 * 与博客有关的所有内容信息，用于内容页面展示
 */
@Data
public class ArticleInfo implements Serializable {

    private static final long serialVersionUID = 1L;


    private Integer pkBid;


    private Date gmtCreate;


    private Date gmtModified;


    private Integer version;


    private String title;


    private String describe;


    private Integer views;


    private Long authorId;


    private String authorName;


    private String authorAvator;


    private Integer isPass;


    private Integer isOriginal;


    private String url;


    private Integer categoryId;


    private String categoryName;

    /*具体的内容信息，是利用markdown写的*/
    private String content;

    /*具体的标签内容*/
    private ArrayList<String> keywords;
}
