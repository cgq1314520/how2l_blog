package top.how2l.pojo.discuss;

import lombok.Data;

import java.util.Date;

/**
 * 具体的问题答复数据库表对应的实体类
 */
@Data
public class discussReply {
    /*问题答复条目的唯一id*/
    private int pkDrId;
    /*问题答复的内容*/
    private String replyContent;
    /*回复的用户名*/
    private String username;
    /*用户头像*/
    private String avatar;
    /*回复时间*/
    private Date gmtCreate;
}
