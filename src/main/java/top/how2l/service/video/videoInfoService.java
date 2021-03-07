package top.how2l.service.video;

import top.how2l.dao.BaseDao;
import top.how2l.dao.video.videoDao;
import top.how2l.dao.video.videoInfoDao;
import top.how2l.pojo.video.videoDetail;
import top.how2l.pojo.video.videoPart;

import java.sql.Connection;
import java.util.ArrayList;

/**
 * 查询视频的具体信息用于播放展示
 */
public class videoInfoService implements videoService {
    private videoDao videoDao;

    public videoInfoService() {
        this.videoDao = new videoInfoDao();
    }

    @Override
    public videoDetail getDetailVideoInfo(int id) {
        Connection connection = BaseDao.getConnection();
        videoDetail videoDetailInfo = videoDao.getVideoDetailInfo(connection, id);
        return videoDetailInfo;
    }

    @Override
    public ArrayList<videoPart> getAllVideoInfo() {
        Connection connection = BaseDao.getConnection();
        ArrayList<videoPart> allVideoInfoShow = videoDao.getAllVideoInfoShow(connection);
        return allVideoInfoShow;
    }

    @Override
    public ArrayList<videoPart> getAllVideoByUserId(long userid) {
        Connection connection = BaseDao.getConnection();
        ArrayList<videoPart> allVideoByUserId = videoDao.getAllVideoByUserId(connection, userid);
        return allVideoByUserId;
    }
}
