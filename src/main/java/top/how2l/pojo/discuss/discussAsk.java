package top.how2l.pojo.discuss;

import lombok.Data;

import java.util.ArrayList;
import java.util.Date;

/**
 * 具体的问题发布数据库表对应的实体类
 */
@Data
public class discussAsk {
    /*问题发布条目对应的唯一键*/
    private int pkDaId;
    /*问题的标题*/
    private String title;
    /*问题的发布时间*/
    private Date gmtCreate;
    /*问题的内容*/
    private String discussContent;
    /*问题的发布者id*/
    private long userid;
    /*问题发布者的昵称*/
    private String username;
    /*问题的发布者头像*/
    private String authorAvator;
    /*问题的具体标签内容,没有经过划分*/
    private String sort;
    /*问题的标签，经过service层的划分，是一个数组,用于具体的html标签循环展示,最多有3个标签*/
    private ArrayList<String> sortDetail;
    /*浏览量*/
    private int views;

}
