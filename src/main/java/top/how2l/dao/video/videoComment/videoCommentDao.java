package top.how2l.dao.video.videoComment;

import top.how2l.pojo.blog.Comment;

import java.sql.Connection;
import java.util.ArrayList;

public interface videoCommentDao {
    /*查询对应视频的所有评论，并组织在ArrayList中去*/
    public ArrayList<ArrayList<Comment>> getComment(Connection connection, int pkBid);

    /*给对应视频插入评论*/
    public int insertComment(Connection connection, int pkBid, long uid, String comment, int parent);
}
