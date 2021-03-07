package top.how2l.util;

import top.how2l.dao.BaseDao;
import top.how2l.dao.blog.defaultPage.defaultDao;
import top.how2l.dao.blog.defaultPage.defaultDaoImpl;
import top.how2l.pojo.blog.dto.ArticlePart;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * 搜索时涉及到的工具类操作：主要有 所有关键字查询，搜索内容关键字找出，博客标题关键字数量判断并排序
 * (1)：获取当前库中的所有关键字并存在一个map中(去重，逗号前后要进行分割)------通过util包中的工具类来做
 * (2)：检索搜索的内容中具有哪些关键字---同样也通过util包中的工具类来做
 * (3)：得到所有含有(2)中关键字的博客标题|概述，并按照数量的多寡进行排序，最后将对应的博客信息存储到ArrayList中--同样通过工具类来做
 */
public class searchUtil {
    private static defaultDao defaultDao;
    private static Connection connection;

    static {
        defaultDao = new defaultDaoImpl();
        connection = BaseDao.getConnection();
    }

    /*将以上(1)(2)(3)统筹起来的方法*/
    public static ArrayList<ArrayList<ArticlePart>> BlogKeyWordsGet(String searchContent) {
        /*第0步：创建用来接收结果的结果集*/
        ArrayList<ArrayList<ArticlePart>> result = new ArrayList<ArrayList<ArticlePart>>();

        /*第一步：获取所有关键字*/
        ArrayList<String> allKeyWords = getAllKeyWords();
        /*第二步：检索搜索的内容中具有哪些关键字，并用另外的一个ArrayList记录*/
        ArrayList<String> searchContentContainsKeyWords = getSearchContentContainsKeyWords(searchContent, allKeyWords);
        /*第三步：查询博客中所有标题包含第二步得到关键字的博客信息,在这里我们通过模糊查询来进行查询，在此先进行模糊查询语句的拼接*/
        StringBuilder sqlTemp = new StringBuilder("SELECT DISTINCT a.pk_bid,a.gmt_create,a.title,a.descr,a.views," +
                "b.username,b.avatar,a.is_original,c.category_name FROM article_info AS a,`user` AS b," +
                "article_category AS c WHERE a.author_id = b.`pk_uid` AND a.`category_id`=c.`pk_caid` AND (");
        for (int i = 0; i < searchContentContainsKeyWords.size(); i++) {
            sqlTemp.append("a.title like ? OR ");
        }
        /*去除最后的OR */
        String sql = sqlTemp.substring(0, sqlTemp.length() - 3);
        sql += ")";
        /*将包含的关键字集合转换为数组*/
        String[] objects = searchContentContainsKeyWords.toArray(new String[searchContentContainsKeyWords.size()]);
        /*通过这个生成的查询语句和关键字数组进行具体的查询*/
        ArrayList<ArticlePart> articleKeyWordsByTitle = defaultDao.ArticleSearchByKeyWordsBlurSearch(connection, sql, objects);
        /**这里应该还需要进行对每个博客标题含有第二步中关键字个数的判断，进而排序，之后再做排序*/
        /*第四步：查询博客中所有概述包含第二步得到关键字的博客信息,在这里我们通过模糊查询来进行查询，在此先进行模糊查询语句的拼接*/
        StringBuilder sqlTemp1 = new StringBuilder("SELECT DISTINCT a.pk_bid,a.gmt_create,a.title,a.descr,a.views," +
                "b.username,b.avatar,a.is_original,c.category_name FROM article_info AS a,`user` AS b," +
                "article_category AS c WHERE a.author_id = b.`pk_uid` AND a.`category_id`=c.`pk_caid` AND (");
        for (int i = 0; i < searchContentContainsKeyWords.size(); i++) {
            sqlTemp1.append("a.descr like ? OR ");
        }
        /*去除最后的OR */
        String sql1 = sqlTemp1.substring(0, sqlTemp1.length() - 3);
        sql1 += ")";
        /*通过这个生成的查询语句和关键字数组进行具体的查询*/
        ArrayList<ArticlePart> articleKeyWordsDescr = defaultDao.ArticleSearchByKeyWordsBlurSearch(connection, sql1, objects);
        /**这里应该还需要进行对每个博客概述含有第二步中关键字个数的判断，进而排序，之后再做*/

        result.add(articleKeyWordsByTitle);
        result.add(articleKeyWordsDescr);
        BaseDao.closeResource(connection, null, null);
        return result;
    }

    /*得到搜索内容中包含的所有关键字*/
    private static ArrayList<String> getSearchContentContainsKeyWords(String searchContent, ArrayList<String> allKeyWords) {
        /*定义一个结果集用来存储搜索内容包含的关键字有哪些*/
        ArrayList<String> result = new ArrayList<String>();
        for (int i = 0; i < allKeyWords.size(); i++) {
            /*通过String类的indexOf()方法判断当前搜索的内容是否包含该索引处的关键字*/
            if (searchContent.indexOf(allKeyWords.get(i)) != -1) {
                result.add(allKeyWords.get(i));
            }
        }
        return result;
    }

    /*得到数据库中的所有关键字*/
    private static ArrayList<String> getAllKeyWords() {
        ArrayList<String> result = new ArrayList<String>();
        /*查询得到所有的关键字，并存储再map的String*/
        Map<Integer, String> stringObjectMap = defaultDao.ArticleKeyWordsSearch(connection);
        /*开始对所有的关键字进行去重,通过temp作为中间件进行去重*/
        Map<String, Integer> temp = new HashMap<String, Integer>();
        for (int j = 0; j < stringObjectMap.size(); j++) {
            if (!temp.containsKey(stringObjectMap.get(j))) {
                result.add(stringObjectMap.get(j));
                temp.put(stringObjectMap.get(j), j);
            }
        }
        return result;
    }

    public static void main(String[] args) {
        ArrayList<ArrayList<ArticlePart>> rs = BlogKeyWordsGet("java框架使用");
        for (ArrayList<ArticlePart> r : rs) {
            System.out.println(r);
        }
    }
}
