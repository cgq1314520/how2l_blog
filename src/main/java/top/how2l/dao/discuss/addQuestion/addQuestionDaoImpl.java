package top.how2l.dao.discuss.addQuestion;

import top.how2l.dao.BaseDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * 具体添加问题到库的具体数据库操作实现
 */
public class addQuestionDaoImpl implements addQuestionDao {
    /*添加问题的具体实现*/
    public int insertQuestion(Connection connection, String title, String content, Long userid, String sort) {
        //开始创建预编译对象
        PreparedStatement psm = null;
        //开始创建结果集用来接收结果
        ResultSet rs = null;
        //接收结果
        int result = 0;
        if (connection != null) {
            String sql = "INSERT INTO `blog`.`discuss_ask` (`title`, `discussContent`, `userid`,`sort`) VALUES (?, ?, ?,?)";
            try {
                result = BaseDao.update(connection, psm, rs, sql, new Object[]{title, content, userid, sort});
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 添加回复到回复表中
     *
     * @param connection
     * @param reply
     * @param userid
     * @param questionid
     * @return
     */
    public int insertReplyAnswer(Connection connection, String reply, long userid, int questionid) {
        //开始创建预编译对象
        PreparedStatement psm = null;
        //开始创建结果集用来接收结果
        ResultSet rs = null;
        //接收结果
        int result = 0;
        if (connection != null) {
            String sql = "INSERT INTO `blog`.`discuss_reply` (`reply`, `userid`, `parentId`) VALUES (?, ?,?)";
            try {
                result = BaseDao.update(connection, psm, rs, sql, new Object[]{reply, userid, questionid});
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
}
