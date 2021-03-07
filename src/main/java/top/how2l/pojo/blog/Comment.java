package top.how2l.pojo.blog;

import lombok.Data;

import java.util.Date;

/**
 * 由于我们的评论功能比较简单，所以将其设计在一张表中，通过一个父类的id指向其父类评论
 */
@Data
public class Comment {
    /*评论用户的用户昵称*/
    private String author_name;
    /*评论用户的头像*/
    private String author_avatar;
    /*评论的唯一id*/
    private int coid;
    /*被评论的文章的id*/
    private int id;
    /*评论的创建时间*/
    private Date coTime;
    /*评论的用户id*/
    private Long uid;
    /*父评论的id*/
    private int parent;
    /*评论内容*/
    private String text;
}
