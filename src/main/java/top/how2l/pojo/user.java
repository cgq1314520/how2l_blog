package top.how2l.pojo;


import lombok.Data;

import java.util.Date;

@Data
public class user {
    private Long pk_uid;
    private String username;
    private String password;
    private String avatar;
    //该字段在首次添加时自动进行填充内容
    private Date gmt_create;
    //该字段在首次添加以及每一次更新时都会自动改变

    private Date gmt_modified;
    private String email;
    private String descr;
    //配置这个为逻辑删除，也即不是真正的删除，只是一个标志位的变换

    public user() {
    }

    private Integer deleted;

    public user(Long pk_uid, String username) {
        this.pk_uid = pk_uid;
        this.username = username;
    }

    //当前用户的文章数量
    private int blogNumbers;
    //当前用户的视频数目
    private int videoNumbers;
    //当前用户的文章浏览量和视频浏览量之和
    private int views;
    //属于当前用户的评论数目
    private int commentNumbers;
}
