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

    static {
        InputStream resourceAsStream = BaseDao.class.getClassLoader().getResourceAsStream("sql.properties");
        Properties properties = new Properties();
        try {
            properties.load(resourceAsStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
        //初始化连接参数
        driver = properties.getProperty("driver");
        url = properties.getProperty("url");
        username = properties.getProperty("user");
        password = properties.getProperty("password");
    }

    /**
     * 通过类加载进行对数据库连接驱动的加载，然后通过驱动管理获取数据库连接对象
     * 通过数据库连接对象来产生其他对象，然后通过其他对象来实现对数据库的操作
     *
     * @return 数据库连接
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName(driver);
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return connection;
    }

    /**
     * 执行查询操作
     *
     * @param connection 当前的数据库的连接操作
     * @param psm        当前预编译的表操作对象
     * @param rs         用来接收结果集的对象
     * @param sql        传递过来的待用查询语句
     * @param params     查询语句中携带的所有参数
     * @return 查询结果集
     */
    public static ResultSet execute(Connection connection, PreparedStatement psm, ResultSet rs, String sql, Object[] params) {

        try {
            //对查询语句进行预编译
            psm = connection.prepareStatement(sql);
            //开始对查询语句中的参数进行设置
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    psm.setObject(i + 1, params[i]);
                }
            }
            //开始执行查询语句
            rs = psm.executeQuery();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        //返回结果
        return rs;
    }

    /**
     * 执行模糊查询操作，由于是预编译的，所以需要分开写
     *
     * @param connection 当前的数据库的连接操作
     * @param psm        当前预编译的表操作对象
     * @param rs         用来接收结果集的对象
     * @param sql        传递过来的待用查询语句
     * @param params     查询语句中携带的所有参数
     * @return 查询结果集
     */
    public static ResultSet blurExecute(Connection connection, PreparedStatement psm, ResultSet rs, String sql, Object[] params) {

        try {
            //对查询语句进行预编译
            psm = connection.prepareStatement(sql);
            //开始对查询语句中的参数进行设置
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    psm.setObject(i + 1, "%" + params[i] + "%");
                }
            }
            //开始执行查询语句
            rs = psm.executeQuery();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        //返回结果
        return rs;
    }

    /**
     * 更新操作(包括增加、删除、修改操作)
     *
     * @param connection 当前数据库的连接对象
     * @param psm        用来编译sql语句的对象
     * @param rs         空
     * @param sql        待执行的更新语句
     * @param params     更新语句中的参数
     * @return 更新设计的行数
     */
    public static int update(Connection connection, PreparedStatement psm, ResultSet rs, String sql, Object[] params) {
        //用来记录更新的行数
        int num = 0;
        try {
            //对更新语句先进行预编译，保证基本的安全，防止sql注入（实质是将特殊字符如||等都用\做了转义）
            psm = connection.prepareStatement(sql);
            //开始对预编译语句进行参数插入
            for (int i = 0; i < params.length; i++) {
                psm.setObject(i + 1, params[i]);
            }
            //开始执行更新语句
            num = psm.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return num;
    }

    /**
     * 关闭所有打开的资源---这些资源在调用方已经是准备好的，这是为了使用方便
     *
     * @param connection 待关闭的数据库连接资源
     * @param psm        待关闭的预编译对象资源
     * @param rs         待关闭的结果集资源
     * @return 关闭成功返回去true，否则放回false
     */
    public static boolean closeResource(Connection connection, PreparedStatement psm, ResultSet rs) {
        boolean flag = true;
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
                flag = false;
            }
        }
        if (psm != null) {
            try {
                psm.close();
            } catch (SQLException e) {
                e.printStackTrace();
                flag = false;
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
                flag = false;
            }
        }
        return flag;
    }
}
