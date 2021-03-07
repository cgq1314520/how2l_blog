package top.how2l.service.blog.commentService;


import top.how2l.dao.BaseDao;
import top.how2l.dao.blog.comment.commentDao;
import top.how2l.dao.blog.comment.commentDaoImpl;
import top.how2l.pojo.blog.Comment;

import java.sql.Connection;
import java.util.ArrayList;

/**
 * 用来处理评论信息的业务处理
 */
public class commentServiceImpl implements commentService {
    //初始化dao层的接口对象，用来操纵dao层进行数据操作
    commentDao commentDao = null;

    public commentServiceImpl() {
        commentDao = new commentDaoImpl();
    }

    /**
     * 通过调用dao层方法实现对于数据库的查询，从而得到评论要展示的信息，并返回给servlet层，即查询评论
     *
     * @return
     */
    public ArrayList<ArrayList<Comment>> getComments(int pkBid) {
        Connection connection = BaseDao.getConnection();
        ArrayList<ArrayList<Comment>> comment = commentDao.getComment(connection, pkBid);
        return comment;
    }

    /**
     * 插入一条新的评论
     *
     * @param pkBid
     * @param uid
     * @param comment
     * @param parent
     * @return
     */
    public int insertComment(int pkBid, long uid, String comment, int parent) {
        Connection connection = BaseDao.getConnection();
        int result = commentDao.insertComment(connection, pkBid, uid, comment, parent);
        return result;
    }

    public static void main(String[] args) {
        ArrayList<ArrayList<Comment>> comments = new commentServiceImpl().getComments(1);
        for (ArrayList<Comment> comment : comments) {
            System.out.println(comment);
        }
    }
}
