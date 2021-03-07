package top.how2l.dao.blog.comment;

import top.how2l.pojo.blog.Comment;

import java.sql.Connection;
import java.util.ArrayList;

/**
 * 用来实现对评论表进行操作的dao层接口
 */
public interface commentDao {
    /*查询对应文章的所有评论，并组织在ArrayList中去*/
    public ArrayList<ArrayList<Comment>> getComment(Connection connection, int pkBid);

    /*给对应文章插入评论*/
    public int insertComment(Connection connection, int pkBid, long uid, String comment, int parent);
}
