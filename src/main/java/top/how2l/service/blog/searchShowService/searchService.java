package top.how2l.service.blog.searchShowService;

import java.util.ArrayList;

/**
 * @author 小帆远航
 * 进行对搜索内容查询的处理接口，总共有4类搜索策略，所以在此个业务层中需要处理dao层的四种响应结果，并返回给用户
 * 返回结果包装在：ArrayList<Object>之中，
 * 返回结果ArrayList中的
 * 第一个为：查询到与搜索栏like的用户信息（如果存在）--返回用户信息
 * --对应查询语句：select * from user where user.username like %查询内容%;
 * 第二个为：查询到与搜索栏like的标题信息（如果存在) --返回博客信息
 * --对应查询语句：select * from user where article_info.title like %查询内容%;
 * 第三个为：查询到与搜索栏like的概述信息（如果存在）--返回博客信息
 * --对应查询语句：select * from user where article_info.descr like %查询内容%;
 * 第四个为：查询到的与搜索栏具有相同关键字的博客标题信息 --返回博客信息（浏览器端显示标题信息）
 * --这个需要经过业务层的处理才行
 * （先找到所有的关键字，再判断搜索内容中包含哪些关键字，然后逐个在所有博客标题中判断
 * 包含和搜索内容相同的关键字对应的文章即可，最后将所有找到的博客，根据关键字相同个数
 * 进行排序，然后返回博客信息）
 * 第五个为：查询到与搜索栏具有相同关键字的博客概述信息 --返回博客信息（浏览器端显示概述信息）
 * --同样也要进过业务层的处理
 */
public interface searchService {
    /*根据搜索的内容展示所有和搜索内容相关的东西，并封装到ArrayList中去*/
    public ArrayList<Object> searchItemGet(String searchContent);
}
