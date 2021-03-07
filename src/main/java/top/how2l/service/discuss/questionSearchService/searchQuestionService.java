package top.how2l.service.discuss.questionSearchService;

import top.how2l.pojo.discuss.discussAsk;
import top.how2l.pojo.discuss.discussReply;

import java.util.ArrayList;

/**
 * 处理查询具体有哪些问题的业务层处理，含包含对标签的解析
 */
public interface searchQuestionService {
    /*查询所有的问题的基本信息*/
    public ArrayList<discussAsk> searchQuestion();

    /*根据给定的问题id查询当前问题的详细信息*/
    public discussAsk searchQuestionDetailInfo(int pkDaId);

    /*根据问题查询其所有回复*/
    public ArrayList<discussReply> getAllReplyAnswerInfo(int pkDaId);

    /*查询指定用户所提出过的所有问题*/
    public ArrayList<discussAsk> searchQuestByUserId(long useriId);
}
