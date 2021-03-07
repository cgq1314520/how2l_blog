package top.how2l.dao.video;

import top.how2l.pojo.video.videoDetail;
import top.how2l.pojo.video.videoPart;

import java.sql.Connection;
import java.util.ArrayList;

/**
 * 与视频点播相关的增删查改数据库操作
 */
public interface videoDao {
    /*根据视频id查询视频的信息，并返回视频详细信息对应的实体类*/
    public videoDetail getVideoDetailInfo(Connection connection, int dbId);

    /*查询所有视频的大概信息*/
    public ArrayList<videoPart> getAllVideoInfoShow(Connection connection);

    /*查询所有的视频大概信息通过用户的id*/
    public ArrayList<videoPart> getAllVideoByUserId(Connection connection, long userid);
}
