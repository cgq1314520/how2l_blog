package top.how2l.pojo.video;

import lombok.Data;

import java.util.Date;

@Data
public class videoDetail {
    private int dbId;
    /*视频标题*/
    private String title;
    /*视频发布者的userid*/
    private long userId;
    /*用户的加入时间*/
    private Date userTime;
    /*视频的发布者*/
    private String name;
    /*发布者的头像*/
    private String avatar;
    /*视频在服务器中的地址*/
    private String videoUrl;
    /*视频的封面地址*/
    private String videoBackUrl;
    /*视频发布时间*/
    private Date publishTime;
}
