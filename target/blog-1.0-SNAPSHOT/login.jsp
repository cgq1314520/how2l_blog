<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <title>how2l-detail</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--引入markdown相关样式文件-->
    <!-- <link rel="stylesheet" href="static/editormd/css/style.css}"/>-->
    <link rel="stylesheet" href="static/editormd/css/editormd.preview.css"/>
    <!--博客布局的相关配置-->
    <link href="static/css/base.css" rel="stylesheet">
    <link href="static/css/m.css" rel="stylesheet">
    <script src="static/js/jquery-1.8.3.min.js"></script>
    <script src="static/js/comm.js"></script>
    <style type="text/css">
        .loginClass input {
            height: 35px;
            line-height: 35px;
            margin: 20px auto;
            color: black;
            border: 1px solid grey;
            border-radius: 8px;
            padding-left: 5px;
            width: 90%;
        }

        .loginClass input:focus {
            outline: none;
            border: 2px solid skyblue;
        }

        .loginButton:hover {
            font-weight: bold;
            background-color: deepskyblue !important;
        }

        .registerButton:hover {
            font-weight: bold;
            background-color: red !important;
        }

        input:-webkit-autofill {
            box-shadow: 0 0 0px 1000px white inset !important;
        }
    </style>
</head>
<body>
<!--top begin-->
<header id="header">
    <div class="navbox">
        <h2 id="mnavh"><span class="navicon"></span></h2>
        <div class="logo"><a href="/">how2l</a></div>
        <nav>
            <ul id="starlist">
                <li><a href="/">首页</a></li>
                <li><a href="ToBlog">博客</a></li>
                <li><a href="ToDiscussPage">你问我答</a></li>
                <li><a href="resource">资源</a></li>
                <li><a href="jumpToZB">直播</a></li>
                <li><a href="jumpToVideoShow">视频</a></li>
                <li><a href="ToPublishBlog">创作中心</a></li>
                <c:if test="${user==null}">
                    <li><a href="loginRegister">登录/注册</a>
                    </li>
                </c:if>
                <c:if test="${user!=null}">
                    <%--个人信息 页面展示--%>
                    <li class="personinfo"><a href="detailInfo" class="personinfo"
                                              style="color: white;padding:10px 20px;width:40px;height:40px;"><i
                            class="avatar" style=""><img src="${user.avatar}"/></i></a>
                        <ul class="sub"
                            style="width:200px;background:white;opacity:1;border-bottom-left-radius:5px;border-bottom-right-radius:5px;color:white;margin-left:-65px;margin-top:5px;height: 170px;">
                            <li style="width:100%;height:40px;"><a
                                    style="text-align: center;width:100%;margin:15px auto;padding:0;border-bottom: 1px solid darkgrey;color:black !important;font-weight: bold;font-size: 19px;">${user.username}</a>
                            </li>
                            <li style="width:100%;height:40px;"><a href="ToPersonShow?userid=${user.pk_uid}"
                                                                   style="text-align: center;width:100%;margin:5px auto;padding:10px 0;color:black;height: 40px;line-height: 40px;">个人中心</a>
                            </li>
                            <li style="width:100%;height:40px;"><a href="logout"
                                                                   style="text-align: center;width:100%;margin:5px auto;padding:10px 0;color:black;height: 40px;line-height: 40px;">内容管理</a>
                            </li>
                            <li style="width:100%;height:40px;"><a href="logout"
                                                                   style="text-align: center;width:100%;margin:10px auto;padding:0px 0;color:black;height: 40px;line-height: 40px;border-top: 1px solid lightgrey;">退出</a>
                            </li>
                        </ul>
                    </li>
                </c:if>
                <%--<li><a href="list3.html"><c:out value="${name1}"></c:out></a></li>
                <li><a href="daohang.html"><%=session.getAttribute("a")%></a></li>
                <li><a href="about.html"><%=request.getAttribute("name")%></a></li>--%>
            </ul>
        </nav>
        <div class="searchico"></div>
    </div>
</header>
<div class="searchbox">
    <div class="search">
        <input name="keyboard" autocomplete="off" id="keyboard" class="input_text" placeholder="请输入关键词" type="text"
               pattern="^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"
               title="请输入正确的邮箱格式">
        <%--<input name="show" value="title" type="hidden">
        <input name="tempid"  value="1" type="hidden">
        <input name="tbname" value="news" type="hidden">--%>
        <input name="Submit" class="input_submit" value="搜索" type="submit">
        <ul id="searchItem">

            <%--以下的内容通js中的ajax请求后生成--%>
            <%--1.先展示是用户时查询到的用户昵称，并在最后添加一个用户标志--%>
            <%--以下是如果有用户时，用户信息展示的模板，由于如果查询到的是用户则一定只有一个，所以这里只展示一个，后台如果查询到用户，则返回该用户对象userDetail对象（如果存在则肯定不为null）--%>
            <%--2.再展示是博客时查询到的博客标题（通过含有关键字的数目进行了排序）--%>
            <%--以下是如果有含有对应关键字的标题时进行展示的模板，这里返回的博客文章信息记录在1个ArrayList里面，ArrayList的内容记录着按含关键字顺序得到的对应博客部分信息的对象ArticlePart对象，返回的内容是BlogTitle对象--%>
            <%--也即返回的内容是ArrayList<ArticlePart>对象，且插入时根据对应含关键字的数目进行了排序--%>
            <%--再展示是通过查询博客概述时查询到对应的博客标题,这个与第二个同理，在具体实现时再写--%>
        </ul>
    </div>
</div>

<!--top end-->
<script type="text/javascript">
    $(function () {
        /*获取后台返回的注册成功与否信息*/
        if ($("#message").val().trim() != "") {
            alert($("#message").val());
        }
        $(".loginli").click(function () {
            $(".loginContainer").css("display", "block")
            $(".registerContainer").css("display", "none")
            $(".loginli").css("color", "deepskyblue")
            $(".loginli").css("border-top-left-radius:", "5px")
            $(".loginli").css("border-top-right-radius:", "5px")
            $(".loginli").css("border-left", "1px solid grey")
            $(".loginli").css("border-top", "1px solid grey")
            $(".loginli").css("border-right", "1px solid grey")
            $(".registerli").css("color", "black")
            $(".registerli").css("border", "none")
        })
        $(".registerli").click(function () {
            $(".registerContainer").css("display", "block")
            $(".loginContainer").css("display", "none")
            $(".registerli").css("color", "deepskyblue")
            $(".registerli").css("border-top-left-radius", "5px")
            $(".registerli").css("border-top-right-radius", "5px")
            $(".registerli").css("border-left", "1px solid grey")
            $(".registerli").css("border-top", "1px solid grey")
            $(".registerli").css("border-right", "1px solid grey")
            $(".loginli").css("color", "black")
            $(".loginli").css("border", "none")
        })
    })
</script>
<div style="max-width:400px;margin:100px auto 400px;" class="loginClass">
    <div style="margin:15px auto;width: 100%;">
        <ul style="margin: 15px auto;width: 160px;">
            <li style="display: inline;width: 65px;margin:15px 5px; color: deepskyblue;font-size: 18px;cursor: pointer;padding:10px 15px;border-left: 1px solid grey;border-top:1px solid grey;border-right:1px solid grey; border-top-left-radius: 5px;border-top-right-radius: 5px;"
                class="loginli" id="1">登录
            </li>
            <li style="display: inline;width: 65px;margin:15px 5px; color: black;font-size: 18px;cursor: pointer;padding:10px 15px"
                class="registerli" id="2">注册
            </li>
        </ul>
    </div>
    <h4 style="color: red;margin-left:5%;">${error}</h4>
    <div class="loginContainer">
        <form action="login" method="post" style="margin:auto auto; ">
            <input type="text" name="userAccount" required style="display: block;" placeholder="请输入登录邮箱">
            <input type="password" name="password" required style="display: block;" placeholder="请输入登录密码">
            <button type="submit"
                    style="width: 90%;margin: 15px 5%;height: 35px;line-height: 35px;color: white;background-color: skyblue;border-radius: 5px;outline: none;border:1px solid skyblue"
                    class="loginButton">登录
            </button>
        </form>
    </div>
    <div class="registerContainer" style="display: none;">
        <form action="register" method="post" style="margin:auto auto; ">
            <input type="text" name="useraccount" class="userAccount" placeholder="请输入邮箱号" style="display: block;">
            <input type="text" name="var" placeholder="请输入邮箱验证码"
                   style="display: inline-block;margin-left:15px;margin-top:15px;">
            <%--点击后发送异步请求到servlet并发送验证码到对应用户的邮箱，此时邮箱确保不为空，
            同时将邮箱和验证码存入redis定时300s后过期，然后在正式注册时判断验证码是否正确，从而决定是否可以注册--%>
            <span class="sendVer"
                  style="margin-left: -90px; display: inline-block; height: 35px; line-height: 35px;  padding: 1px 4px; cursor: pointer; text-align: center; color: skyblue; pointer-events: auto;">发送验证码</span>
            <input type="text" name="name" placeholder="请输入昵称" style="display: block">
            <input type="password" name="password" placeholder="请输入密码" style="display: block;">
            <input type="password" name="password" placeholder="请确认密码" style="display: block;">
            <button type="submit"
                    style="width: 90%;margin: 15px 5%;height: 35px;line-height: 35px;color: white;background-color: darkred;border-radius: 5px;outline: none;border:1px solid red"
                    class="registerButton">注册
            </button>
        </form>
    </div>

</div>


<footer>
    <div class="box">
        <div class="wxbox">
            <ul>
                <li><img src="static/images/wx.png"><span>微信公众号</span></li>
                <li><img src="static/images/wx.png"><span>我的微信</span></li>
            </ul>
        </div>
        <div class="endnav">
            <p><b>关于我们</b></p>
            <p>
                js代码(www.jsdaima.com)是IT资源下载与IT技能学习平台。js代码网收集整理了最新IT开发视频教程、网站模板、网站源码、js特效(插件)等，充分满足IT用户对不同类型资源的下载需求。js代码网拒绝滥竽充数，我们只提供精品资源！</p>
            <p>&copy; 2019 XX公司&nbsp;&nbsp;ICP备XXXXXXXX号&nbsp;&nbsp;技术支持：<a href="http://www.jsdaima.com/" title="js代码"
                                                                            target="_blank">js代码（www.jsdaima.com）</a>
            </p>
        </div>
    </div>
    <a href="#">
        <div class="top"></div>
    </a></footer>

<!--js开始由markdown转换为html-->

<!--js结束-->
</body>
</html>
