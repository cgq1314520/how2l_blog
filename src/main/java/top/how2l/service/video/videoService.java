package top.how2l.service.video;

import top.how2l.pojo.video.videoDetail;
import top.how2l.pojo.video.videoPart;

import java.util.ArrayList;

/**
 * 视屏点播对应的service的所由增删查改接口
 */
public interface videoService {
    /*查询给定id视频的具体信息*/
    public videoDetail getDetailVideoInfo(int id);

    /*查询所有视屏的大概信息--注意后面了添加上分页*/
    public ArrayList<videoPart> getAllVideoInfo();

    /*查询给定用户发布的所有视频*/
    public ArrayList<videoPart> getAllVideoByUserId(long userid);
}
