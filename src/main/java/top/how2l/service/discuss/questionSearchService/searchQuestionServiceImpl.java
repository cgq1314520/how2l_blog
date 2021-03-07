package top.how2l.service.discuss.questionSearchService;

import top.how2l.dao.BaseDao;
import top.how2l.dao.discuss.searchQuestion.searchQuestionDao;
import top.how2l.dao.discuss.searchQuestion.searchQuestionDaoImpl;
import top.how2l.pojo.discuss.discussAsk;
import top.how2l.pojo.discuss.discussReply;

import java.sql.Connection;
import java.util.ArrayList;

/**
 * 查询问题信息的具体实现业务，包括对查询到的具体标签分类的划分处理
 */
public class searchQuestionServiceImpl implements searchQuestionService {
    private searchQuestionDao questionDao = null;

    public searchQuestionServiceImpl() {
        this.questionDao = new searchQuestionDaoImpl();
    }

    public ArrayList<discussAsk> searchQuestion() {
        /*得到连接对象*/
        Connection connection = BaseDao.getConnection();
        /*请求数据*/
        ArrayList<discussAsk> allQuestion = questionDao.getAllQuestion(connection);
        /*对标签分类进行划分处理*/
        for (int i = 0; i < allQuestion.size(); i++) {
            /*得到每一个问题对应的标签字符串*/
            String sort = allQuestion.get(i).getSort();
            /*将标签字符串通过逗号进行划分*/
            String[] split = sort.split(",");
            /*将划分后的每一个分类放入要传递给客户端的具体分类标签集合中（即实体类对应的ArrayList中）*/
            ArrayList<String> sorts = new ArrayList<String>();
            for (int i1 = 0; i1 < split.length; i1++) {
                sorts.add(split[i1]);
            }
            /*添加标签分类到当前问题对象的集合中*/
            allQuestion.get(i).setSortDetail(sorts);
        }
        return allQuestion;
    }

    /**
     * 查询当前文章的具体详细信息用于展示
     *
     * @param pkDaId
     * @return
     */
    public discussAsk searchQuestionDetailInfo(int pkDaId) {
        /*得到连接对象*/
        Connection connection = BaseDao.getConnection();
        /*请求数据*/
        discussAsk detailQuestion = questionDao.getDetailQuestionInfo(connection, pkDaId);
        /*得到每一个问题对应的标签字符串*/
        String sort = detailQuestion.getSort();
        /*将标签字符串通过逗号进行划分*/
        String[] split = sort.split(",");
        /*将划分后的每一个分类放入要传递给客户端的具体分类标签集合中（即实体类对应的ArrayList中）*/
        ArrayList<String> sorts = new ArrayList<String>();
        for (int i1 = 0; i1 < split.length; i1++) {
            sorts.add(split[i1]);
        }
        /*添加标签分类到当前问题对象的集合中*/
        detailQuestion.setSortDetail(sorts);
        //返回结果
        return detailQuestion;
    }

    /**
     * 根据问题id查询所有的回复
     *
     * @param pkDaId
     * @return
     */
    public ArrayList<discussReply> getAllReplyAnswerInfo(int pkDaId) {
        /*得到连接对象*/
        Connection connection = BaseDao.getConnection();
        /*请求数据*/
        ArrayList<discussReply> allReplyAnswer = questionDao.getAllReplyAnswer(connection, pkDaId);
        return allReplyAnswer;
    }

    /**
     * 查询给定用户的所有问题,这个可以和第一个方法结合起来，通过第二个参数为变长参数来控制
     *
     * @param useriId
     * @return
     */
    @Override
    public ArrayList<discussAsk> searchQuestByUserId(long useriId) {
        /*得到连接对象*/
        Connection connection = BaseDao.getConnection();
        /*请求数据*/
        ArrayList<discussAsk> allQuestion = questionDao.getAllQuestByUserId(connection, useriId);
        /*对标签分类进行划分处理*/
        for (int i = 0; i < allQuestion.size(); i++) {
            /*得到每一个问题对应的标签字符串*/
            String sort = allQuestion.get(i).getSort();
            /*将标签字符串通过逗号进行划分*/
            String[] split = sort.split(",");
            /*将划分后的每一个分类放入要传递给客户端的具体分类标签集合中（即实体类对应的ArrayList中）*/
            ArrayList<String> sorts = new ArrayList<String>();
            for (int i1 = 0; i1 < split.length; i1++) {
                sorts.add(split[i1]);
            }
            /*添加标签分类到当前问题对象的集合中*/
            allQuestion.get(i).setSortDetail(sorts);
        }
        return allQuestion;
    }
}
