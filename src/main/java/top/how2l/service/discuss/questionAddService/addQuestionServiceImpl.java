package top.how2l.service.discuss.questionAddService;

import top.how2l.dao.BaseDao;
import top.how2l.dao.discuss.addQuestion.addQuestionDao;
import top.how2l.dao.discuss.addQuestion.addQuestionDaoImpl;

import java.sql.Connection;

/**
 * 具体添加问题处理的业务层,具体实现部分
 */
public class addQuestionServiceImpl implements addQuestionService {
    private addQuestionDao add = null;

    public addQuestionServiceImpl() {
        this.add = new addQuestionDaoImpl();
    }

    public int insertQuestion(String title, String content, long userid, String sort) {
        Connection connection = BaseDao.getConnection();
        int i = add.insertQuestion(connection, title, content, userid, sort);
        return i;
    }

    /**
     * 添加问题的回复到表中
     *
     * @param replyContent 回复的内容
     * @param userid       回复的用户
     * @param questionId   回复的问题
     * @return
     */
    public int insertReplyAnswer(String replyContent, long userid, int questionId) {
        Connection connection = BaseDao.getConnection();
        int i = add.insertReplyAnswer(connection, replyContent, userid, questionId);
        return i;
    }
}
