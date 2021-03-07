package top.how2l.service.video.videoComment;

import top.how2l.pojo.blog.Comment;

import java.util.ArrayList;

public interface videoCommentService {
    /*根据视频id来查询对应评论信息*/
    public ArrayList<ArrayList<Comment>> getComments(int pkBid);

    /*根据文章编号用户编号评论内容以及根评论内容进行评论的插入*/
    public int insertComment(int pkVid, long uid, String comment, int parent);
}
