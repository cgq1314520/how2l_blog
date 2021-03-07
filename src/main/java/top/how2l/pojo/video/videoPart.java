package top.how2l.pojo.video;

import lombok.Data;

import java.util.Date;

/**
 * 为了减少内存消耗，声明一个只占据视频信息部分数据的实体类
 */
@Data
public class videoPart {
    private int dbId;
    /*视频标题*/
    private String title;
    /*视频的封面地址*/
    private String videoBackUrl;
    /*视频的发布时间*/
    private Date gmtCreate;
}
