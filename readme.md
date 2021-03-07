## 利用tomcat+jsp实现blog(博客系统)

![image-20210208184156948](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20210208184156948.png)

**数据库依据上模块进行建立：注意对于数据库表之间的联系不用外键进行操作，而是通过程序层面来进行关联**

### 搭建项目准备工作

- 利用maven来搭建一个web项目，利用模板来创建

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20210208185717422.png" alt="image-20210208185717422" style="zoom:80%;" />

- 配置Tomcat

<img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20210208190025654.png" alt="image-20210208190025654" />

![image-20210208190600613](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20210208190600613.png)

- 测试项目是否可运行

> 在浏览器访问 http:localhost:8080/blog/
>
> 如果界面弹出tomcat中的index.jsp中的页面则说明正确

![image-20210208190824735](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20210208190824735.png)

- 导入依赖的包

jsp |Servlet | mysql驱动 | jstl 依赖

```xml
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>top.how2l</groupId>
  <artifactId>blog</artifactId>
  <version>1.0-SNAPSHOT</version>
  <!--打包方式为war-->
  <packaging>war</packaging>

  <dependencies>
    <!--配置连接数据库的依赖-->
    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>5.1.47</version>
    </dependency>
    <!--配置jsp和servlet的依赖-->
    <dependency>
      <groupId>javax.servlet.jsp</groupId>
      <artifactId>jsp-api</artifactId>
      <version>2.1.1</version>
    </dependency>
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>servlet-api</artifactId>
      <version>2.3</version>
    </dependency>
    <!--项目中使用JSTL和EL表达式-->
    <dependency>
      <groupId>taglibs</groupId>
      <artifactId>standard</artifactId>
      <version>1.0</version>
    </dependency>
      <!--添加lombok依赖，减少工作量-->
    <dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <version>1.18.12</version>
    </dependency>
  </dependencies>
</project>

```



- **构建项目包结构**--**添加java源文件目录、添加resources资源目录**

![image-20210208191208416](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20210208191208416.png)

- **创建mvc三层架构**

<img src="C:\\Users\\Administrator\\AppData\\Roaming\\Typora\\typora-user-images\\image-20210208192131364.png" alt="image-20210208192131364" style="zoom:80%;" />

- 连接blog数据库

  <img src="C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20210209112006430.png" alt="image-20210209112006430" style="zoom:67%;" />

- 编写对应的实体类，与数据库对应，也即表和类相互映射

![image-20210209113920399](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20210209113920399.png)

- 编写基础部分代码（包括与数据库连接相关的东西）

编写数据库的配置文件，用于jdbc连接数据库运用，为**sql.properties**

```properties
driver=com.mysql.jdbc.Driver
#在和mysql传递数据的过程中，使用unicode编码格式，并且字符集设置为utf-8
url=jdbc:mysql://127.0.0.1:3306/blog?useSSL=false&useUnicode=true&characterEncoding=utf-8
user=root
password=123456
```

编写**操作数据库的公共类**，包括增删查改等操作(**dao层操作数据库**)

```java
package top.how2l.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/**
 * 操作数据库的基础公共类，主要是对数据库的增删查改操作
 */
public class BaseDao {
    //利用静态代码块来进行在类加载时执行
    //以下初始化配置文件中的连接参数
    private static String driver;
    private static String url;
    private static String username;
    private static String password;
    static{
        InputStream resourceAsStream = BaseDao.class.getClassLoader().getResourceAsStream("sql.properties");
        Properties properties=new Properties();
        try {
            properties.load(resourceAsStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //初始化连接参数
        driver=properties.getProperty("driver");
        url=properties.getProperty("url");
        username=properties.getProperty("username");
        password=properties.getProperty("password");
    }

    /**
     * 通过类加载进行对数据库连接驱动的加载，然后通过驱动管理获取数据库连接对象
     * 通过数据库连接对象来产生其他对象，然后通过其他对象来实现对数据库的操作
     * @return 数据库连接
     */
    public static Connection getConnection(){
        Connection connection=null;
        try {
            Class.forName(driver);
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return  connection;
    }

    /**
     * 执行查询操作
     * @param connection 当前的数据库的连接操作
     * @param psm   当前预编译的表操作对象
     * @param rs    用来接收结果集的对象
     * @param sql   传递过来的待用查询语句
     * @param params 查询语句中携带的所有参数
     * @return        查询结果集
     */
    public static ResultSet execute(Connection connection, PreparedStatement psm,ResultSet rs,String sql,Object[] params){

        try {
            //对查询语句进行预编译
            psm=connection.prepareStatement(sql);
            //开始对查询语句中的参数进行设置
            for (int i = 0; i < params.length; i++) {
                psm.setObject(i+1,params[i]);
            }
            //开始执行查询语句
            rs=psm.executeQuery();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        //返回结果
        return rs;
    }

    /**
     * 更新操作(包括增加、删除、修改操作)
     * @param connection 当前数据库的连接对象
     * @param psm        用来编译sql语句的对象
     * @param rs         空
     * @param sql        待执行的更新语句
     * @param params     更新语句中的参数
     * @return           更新设计的行数
     */
    public static int update(Connection connection,PreparedStatement psm,ResultSet rs,String sql,Object[] params){
        //用来记录更新的行数
        int num=0;
        try {
            //对更新语句先进行预编译，保证基本的安全，防止sql注入（实质是将特殊字符如||等都用\做了转义）
            psm=connection.prepareStatement(sql);
            //开始对预编译语句进行参数插入
            for (int i = 0; i < params.length; i++) {
                psm.setObject(i+1,params[i]);
            }
            //开始执行更新语句
            num = psm.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return  num;
    }

    /**
     * 关闭所有打开的资源---这些资源在调用方已经是准备好的，这是为了使用方便
     * @param connection  待关闭的数据库连接资源
     * @param psm   待关闭的预编译对象资源
     * @param rs    待关闭的结果集资源
     * @return     关闭成功返回去true，否则放回false
     */
    public static boolean closeResource(Connection connection,PreparedStatement psm,ResultSet rs){
        boolean flag=true;
        if(rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
                flag=false;
            }
        }
        if(psm!=null){
            try {
                psm.close();
            } catch (SQLException e) {
                e.printStackTrace();
                flag=false;
            }
        }
        if(connection!=null){
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
                flag=false;
            }
        }
        return flag;
    }
}


```

- 首先编写一个字符过滤器，也即让编码正确

```java
package top.how2l.filter;

import javax.servlet.*;
import java.io.IOException;

/**
 * 实现对编码的设置的过滤器
 */
public class EncodingFilter implements Filter {
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//通过过滤器一次性设置页面的编码格式都为utf8
        request.setCharacterEncoding("utf8");

        response.setContentType("text/html;charset=utf8");
        response.setContentType("image/jpeg");
        //注意以下的部分，在这个里面通过chain来调用新一个doFilter是固定的写法，否则在请求一次页面后这个类不是就会退出的吗，
        // 一退出，其他页面请求时又给怎么办，所以一直要通过chain来调用这个方法，使得其他页面请求时也可以被过滤
        chain.doFilter(request,response);
    }

    public void destroy() {

    }
}

```

```xml
<!--拦截所有的请求，并对其的编码进行设置-->
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>top.how2l.filter.EncodingFilter</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
```

- 



#### 开始编写前端页面

省略

#搜索功能实现原理：
在发布每篇博客时，要求让用户自己选择添加该篇文章的关键字（和标题内容要对应，可以有多个关键字，多个之间用","分割，注意关键字必须要包含在文章标题或者概述里面），那么在添加博客后也会将该片博客的关键字插入关键字字段；

那么我们在查询时，就会经历以下步骤：

##第一种：查找用户

**这个就一种方法，如果查询的东西恰好是某个用户的用户名，则将该用户的昵称和其id返回客户端展示，同时提供跳转到当前用户主页的链接**

##第二种：查找博客

**第一步：先通过查询数据库得到当前所有博客所涉及到的所有关键字（通过用户贡献得到）**

**第二步：通过java服务端dao层处理，查看待查询的内容涉及哪些关键字，然后将这些关键字通过java代码找出来(如果没有涉及到关键字，则返回一个默认数据页面)**

**第三步：查询所有的博客文章标题（也可以是概述），然后逐个通过java代码判断是否含有第二步找出来的关键字，且当前这个标题含有多少个第二步得到的关键字
           这儿我们也可以直接通过多个select + like %关键字%的语句进行筛选符合要求的标题和概述；比如我们发现搜索的内容涉及到的关键字有：tomcat jsp servlet
           这三个，为了统计每个标题涉及到的关键字的个数，我们可以通过先得到标题，然后再通过一个for循环依次判断该标题是否含有这三个关键字，含有一个关键字就对其
           含关键字的数目进行加一，最后再将其插入到一个优先队列中进行关键字个数的排序；然后将其返回到客户端按顺序展示，这样最后我们就得到了一个比较标准的搜索结果了**

**第四步：将第三步得到的所有文章标题通过该标题含有的关键字数目进行排序（这样就很不可靠的保证了一定的可靠性），然后返回给客户端，让其遍历展示给客户**

综上所述我们的数据库博客信息表需要一个关键字字段（注意：关键字不区分大小写）

/**
 * 进行对搜索内容查询的处理接口，总共有4类搜索策略，所以在此个业务层中需要处理dao层的四种响应结果，并返回给用户
 * 返回结果包装在：ArrayList<Object>之中，
 *      返回结果ArrayList中的
 *          第一个为：查询到与搜索栏like的用户信息（如果存在）--返回用户信息
 *                    --对应查询语句：select * from user where user.username like %查询内容%;
 *          第二个为：查询到与搜索栏like的标题信息（如果存在) --返回博客信息
 *                    --对应查询语句：select * from user where article_info.title like %查询内容%;
 *          第三个为：查询到与搜索栏like的概述信息（如果存在）--返回博客信息
 *                    --对应查询语句：select * from user where article_info.descr like %查询内容%;
 *          第四个为：查询到的与搜索栏具有相同关键字的博客标题信息 --返回博客信息（浏览器端显示标题信息）
 *                    --这个需要经过业务层的处理才行
 *                     （先找到所有的关键字，再判断搜索内容中包含哪些关键字，然后逐个在所有博客标题中判断
 *                      包含和搜索内容相同的关键字对应的文章即可，最后将所有找到的博客，根据关键字相同个数
 *                      进行排序，然后返回博客信息）
 *          第五个为：查询到与搜索栏具有相同关键字的博客概述信息 --返回博客信息（浏览器端显示概述信息）
 *                    --同样也要进过业务层的处理
 */