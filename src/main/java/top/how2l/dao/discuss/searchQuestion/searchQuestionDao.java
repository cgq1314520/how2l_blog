package top.how2l.dao.discuss.searchQuestion;

import top.how2l.pojo.discuss.discussAsk;
import top.how2l.pojo.discuss.discussReply;

import java.sql.Connection;
import java.util.ArrayList;

/**
 * 查询所有问题的数据库操作
 */
public interface searchQuestionDao {
    /*通过给定connection对象实现所有问题查询*/
    public ArrayList<discussAsk> getAllQuestion(Connection connection);

    /*通过给定的问题id查询具体的问题信息*/
    public discussAsk getDetailQuestionInfo(Connection connection, int pkDaId);

    /*通过给定的问题的id查询当前问题的所有评论*/
    public ArrayList<discussReply> getAllReplyAnswer(Connection connection, int pkDaId);

    /*通过给定的用户id查询该用户提出的所有问题*/
    public ArrayList<discussAsk> getAllQuestByUserId(Connection connection, long userid);
}
