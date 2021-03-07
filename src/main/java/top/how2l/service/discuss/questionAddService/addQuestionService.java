package top.how2l.service.discuss.questionAddService;

/**
 * 具体添加问题处理的业务层
 */
public interface addQuestionService {
    /*将问题添加到表中*/
    public int insertQuestion(String title, String content, long userid, String sort);

    /*将问题的回复添加到表中,即用户userID将回复内容replyContent添加给questionId这个问题*/
    public int insertReplyAnswer(String replyContent, long userid, int questionId);

}
