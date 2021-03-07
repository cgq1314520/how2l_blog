<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <title>how2l</title>
    <meta name="keywords" content="blog"/>
    <meta name="description" content="blog"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="static/css/base.css" rel="stylesheet">
    <link href="static/css/m.css" rel="stylesheet">
    <script src="static/js/jquery-1.8.3.min.js"></script>
    <script src="static/js/comm.js"></script>
    <link rel="stylesheet" type="text/css" href="static/css/person.css">
    <script src="static/js/person.js"></script>
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

            </ul>
        </nav>
    </div>
</header>

<article>
    <div class="topImg">
        <span>${userDetailInfo.pk_uid}的个人中心</span>
    </div>
    <div class="leftIntr">
        <div class="personIntr">
            <div class="imageContainer">
                <i>
                    <img src="${userDetailInfo.avatar}"/>
                </i>
                <span style="color:black;font-size: 15px;">【昵称】${userDetailInfo.username}</span>
                <span style="font-size:14px;color:grey">【简介】${userDetailInfo.descr}&nbsp&nbsp${userDetailInfo.gmt_create}</span>
            </div>
            <div class="imageDescr">
                <ul style="color:black;font-size:15px;border-bottom: 1px solid lightgrey">
                    <li>原创</li>
                    <li>视频</li>
                    <li>点击</li>
                    <li>评论</li>
                </ul>
                <ul style="color:grey;font-size: 14px;">
                    <li>${userDetailInfo.blogNumbers} 篇</li>
                    <li>${userDetailInfo.videoNumbers} 个</li>
                    <li>${userDetailInfo.views} 次</li>
                    <li>${userDetailInfo.commentNumbers} 次</li>
                </ul>
            </div>
        </div>
        <!--近期文章，写3片即可,通过异步进行请求得到-->
        <input value="${userDetailInfo.pk_uid}" hidden id="useridHidden">
        <div class="blogNear">
            <p class="jinqi">近期文章</p>
            <ul>
                <li>
                    <a style="color: black;font-size: 15px;">数据结构到底该 怎么学</a>
                    <a style="color: grey;font-size: 14px;">浏览量20&nbsp&nbsp2021-1-2</a>
                </li>
                <li>
                    <a style="color: black;font-size: 15px;">数据结构到底该 怎么学</a>
                    <a style="color: grey;font-size: 14px;">浏览量20&nbsp&nbsp2021-1-2</a>
                </li>
                <li>
                    <a style="color: black;font-size: 15px;">数据结构到底该 怎么学</a>
                    <a style="color: grey;font-size: 14px;">浏览量20&nbsp&nbsp2021-1-2</a>
                </li>
            </ul>
        </div>
        <!-- 热门文章，按照浏览量来进行得到放3个 -->
        <div class="personViews">
            <p class="jinqi">热门文章</p>
            <ul>
                <li>
                    <a style="color: black;font-size: 15px;">数据结构到底该 怎么学</a>
                    <a style="color: grey;font-size: 14px;">浏览量20&nbsp&nbsp2021-1-2</a>
                </li>
                <li>
                    <a style="color: black;font-size: 15px;">数据结构到底该 怎么学</a>
                    <a style="color: grey;font-size: 14px;">浏览量20&nbsp&nbsp2021-1-2</a>
                </li>
                <li>
                    <a style="color: black;font-size: 15px;">数据结构到底该 怎么学</a>
                    <a style="color: grey;font-size: 14px;">浏览量20&nbsp&nbsp2021-1-2</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="rightIntr">
        <!-- 顶部点击切换显示的到底是博客还是视频还是问答的导航栏 -->
        <div class="topNavSort">
            <ul>
                <%--isclick代表当前选中的那个标签--%>
                <li id="blog" class="personInfoShow">博客</li>
                <li id="resource" class="personInfoShow">资源</li>
                <li id="discuss" class="personInfoShow">问答</li>
                <li id="video" class="personInfoShow">视频</li>
                <li id="guanzhu" class="personInfoShow">关注</li>
                <li id="owner" class="personInfoShow">收藏</li>
            </ul>
        </div>
        <div class="SortContentShow">
            <ul class="blogShow" style="display: block;">
                <img src="static/images/kong.jpg" style="width:96%;height:100%;margin:0px 2%;"/>
            </ul>
            <ul class="resourceShow" style="display: none;">
                <img src="static/images/kong.jpg" style="width:96%;height:100%;margin:0px 2%;"/>
            </ul>
            <ul class="discussShow" style="display: none;">
                <img src="static/images/kong.jpg" style="width:96%;height:100%;margin:0px 2%;"/>
            </ul>
            <ul class="videoShow" style="display: none">
                <img src="static/images/kong.jpg" style="width:96%;height:100%;margin:0px 2%;"/>
            </ul>
            <ul class="guanzhuShow" style="display: none">
                <img src="static/images/kong.jpg" style="width:96%;height:100%;margin:0px 2%;"/>
            </ul>
            <ul class="ownerShow" style="display: none">
                <img src="static/images/kong.jpg" style="width:96%;height:100%;margin:0px 2%;"/>
            </ul>
        </div>
    </div>


</article>
<footer>
    <div class="box">
        <div class="wxbox">
            <ul>
                <li><img src="static/images/wxgzh.jpg"><span>微信公众号</span></li>
                <li><img src="static/images/wx.png"><span>我的微信</span></li>
            </ul>
        </div>
        <div class="endnav">
            <p><b>关于我</b></p>
            <p>关于我的一些概述！！！！！！！！！！！！！！！！！</p>
            <p>&copy; 2019 XX公司&nbsp;&nbsp;ICP备XXXXXXXX号&nbsp;&nbsp;技术支持：<a href="http://www.php.cn/" title="php中文网"
                                                                            target="_blank">个人博客</a></p>
        </div>
    </div>
    <a id="jump" href="#">
        <div class="top"></div>
    </a></footer>
</body>
</html>
