package top.how2l.service.blog.commentService;

import top.how2l.pojo.blog.Comment;

import java.util.ArrayList;

/**
 * 用来处理评论的接口
 */
public interface commentService {
    /*根据文章id来查询对应评论信息*/
    public ArrayList<ArrayList<Comment>> getComments(int pkBid);

    /*根据文章编号用户编号评论内容以及根评论内容进行评论的插入*/
    public int insertComment(int pkBid, long uid, String comment, int parent);

}
