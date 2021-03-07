package top.how2l.dao.discuss.addQuestion;

import java.sql.Connection;

/**
 * 具体添加问题的数据库操作层，此处为实现的接口
 */
public interface addQuestionDao {
    /*将浏览器传递过来的问题标题、问题内容、以及问题发布者id，对应标签 保存入库*/
    public int insertQuestion(Connection connection, String title, String content, Long userid, String sort);

    /*将问题的回复添加到表中*/
    public int insertReplyAnswer(Connection connection, String reply, long userid, int questionid);
}
