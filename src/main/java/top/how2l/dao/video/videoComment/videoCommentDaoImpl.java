package top.how2l.dao.video.videoComment;

import top.how2l.dao.BaseDao;
import top.how2l.pojo.blog.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class videoCommentDaoImpl implements videoCommentDao{
    /*根据pkBid来查询该文章对应的所有评论 */
    public ArrayList<ArrayList<Comment>> getComment(Connection connection, int pkBid) {
        /**
         * 根据以下两步我们可以知道：我们的返回结果结构应该是：ArrayList<ArrayList<comment>>
         * 其中里层的每一个ArrayList存储着当前文章的一份根评论和其子评论，外层的ArrayList则存储
         * 着所有份数的评论
         * 也即里层的每一个ArrayList相当于是如下结构：
         *  根评论:评论内容
         *        子评论1：评论内容
         *        子评论2：评论内容
         *        子评论3：评论内容
         *        ...
         * 而外层的则相当于是上面形式的这种有很多个，即所有评论
         */
        /*
         * 第一步：得到当前文章的所有根评论，每一个根评论对应着一个ArrayList
         * 来存储其对应的子评论和其本身，也即评论的第一条就是根评论
         */
        //开始创建预编译对象
        PreparedStatement psm = null;
        //开始创建结果集用来接收结果
        ResultSet rs = null;
        //开始创建用来保存结果的结果集
        ArrayList<ArrayList<Comment>> result = new ArrayList<ArrayList<Comment>>();

        if (connection != null) {
            try {
                //创建查询所有根评论,根评论的parent默认为0,同时连表查询用户头像、用户昵称
                String sql = "SELECT b.*,c.username,c.avatar FROM (SELECT * FROM blog.videoComment WHERE id=?) AS b,blog.user AS c WHERE b.parent=0 AND b.`uid`=c.pk_uid";
                //开始查询
                rs = BaseDao.execute(connection, psm, rs, sql, new Object[]{pkBid});
                //将查询得到的结果放入到多个ArrayList中去
                while (rs.next()) {
                    //用来存放该根评论对应所有评论的集合
                    ArrayList<Comment> tempList = new ArrayList<Comment>();
                    //用来接收根评论的实体类
                    Comment temp = new Comment();
                    temp.setCoid(rs.getInt("coid"));
                    temp.setId(rs.getInt("id"));
                    temp.setCoTime(rs.getTime("coTime"));
                    temp.setUid(rs.getLong("uid"));
                    temp.setParent(rs.getInt("parent"));
                    temp.setText(rs.getString("content"));
                    temp.setAuthor_name(rs.getString("username"));
                    temp.setAuthor_avatar(rs.getString("avatar"));

                    //查询完成后，将数据保存
                    tempList.add(temp);

                    //保存到整体中去
                    result.add(tempList);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        /*
         * 第二步：得到对应根评论下的子评论，然后将这些评论都存储到对应的ArrayList中
         */
        for (ArrayList<Comment> comments : result) {
            try {
                //在遍历的过程中为当前的ArrayList添加子评论
                //通过查找某条项目的coid是根评论的coid来查询子评论
                int parent = comments.get(0).getCoid();
                //开始根据pkBid和coid来查询对应的子评论
                String sql = "SELECT DISTINCT  b.*,c.username,c.avatar FROM(SELECT * FROM videoComment WHERE videoComment.`parent`=? AND videoComment.id=?) AS b,user AS c WHERE b.`uid`=c.pk_uid ";
                //开始执行查询语句进行查询
                rs = BaseDao.execute(connection, psm, rs, sql, new Object[]{parent, pkBid});
                //开始将查询到的子评论放到对应根目录所在的ArrayList中
                while (rs.next()) {
                    //用来接收子根评论的实体类
                    Comment son = new Comment();
                    son.setCoid(rs.getInt("coid"));
                    son.setId(rs.getInt("id"));
                    son.setCoTime(rs.getTime("coTime"));
                    son.setUid(rs.getLong("uid"));
                    son.setParent(rs.getInt("parent"));
                    son.setText(rs.getString("content"));
                    son.setAuthor_name(rs.getString("username"));
                    son.setAuthor_avatar(rs.getString("avatar"));

                    //查询完成后，将子评论数据保存到对应的ArrayList中去
                    comments.add(son);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        //关闭资源
        BaseDao.closeResource(connection, psm, rs);
        return result;
    }

    /**
     * 通过给定的参数实现插入评论
     *
     * @param connection
     * @param pkBid      评论的文章
     * @param uid        评论的用户id
     * @param comment    评论的内容
     * @param parent     评论的根
     * @return
     */
    public int insertComment(Connection connection, int pkBid, long uid, String comment, int parent) {
        //开始创建预编译对象
        PreparedStatement psm = null;
        //开始创建结果集用来接收结果
        ResultSet rs = null;
        //接收结果
        int result = 0;
        if (connection != null) {
            String sql = "INSERT INTO videoComment(id,uid,parent,content) VALUE(?,?,?,?)";
            try {
                result = BaseDao.update(connection, psm, rs, sql, new Object[]{pkBid, uid, parent, comment});
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
