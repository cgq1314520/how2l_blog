<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>how2l</title>
    <link href="static/css/base.css" rel="stylesheet">
    <link href="static/css/m.css" rel="stylesheet">
    <script src="static/js/jquery-1.8.3.min.js"></script>
    <script src="static/js/comm.js"></script>
    <script>
        $(function () {
            $(".zhuanti ul li").hover(function () {
                $(this).find(".zhezhang").css("opacity", "0.5");
            }, function () {
                /*移出去时背景回复*/
                $(this).find(".zhezhang").css("opacity", "0");
            })
        })
    </script>
    <style type="text/css">
        .lbox .zhuanti ul li {
            width: 20%;
            border: none;
        }

        .zhuanti li span {
            padding-top: 10px;
            height: 24px;
            overflow: hidden;
            /*汉字多于部分显示省略号*/
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .zhuanti li span a {
            cursor: pointer;
            color: grey;
        }

        .zhuanti li:hover span a, li span a:hover {
            font-weight: bold;
            color: skyblue;
        }

        .zhezhang { /*遮障层，当聚焦时显示*/
            background-color: black;
            position: absolute;;
            margin-top: -100px;
            z-index: 10;
            width: 20%;
            opacity: 0;
        }

        .htitle:hover {
            color: deepskyblue;
            font-weight: bold;
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
<%--具体的搜索主要从：用户昵称|博客标题|博客概述等几个之中进行模糊搜索--%>
<div class="searchbox">
    <div class="search">
        <input name="keyboard" autocomplete="off" id="keyboard" class="input_text" placeholder="请输入关键词" type="text">
        <input name="Submit" class="input_submit" value="搜索" type="submit">
        <ul id="searchItem">
        </ul>
    </div>
</div><article>
    <!--lbox begin-->
    <div class="lbox" style="width: 100%;">
        <div class="zhuanti whitebg">
            <h2 class="htitle"><span class="hnav"><a href="/" target="_blank"></a></span>&nbsp推 广</h2>
            <ul>
                <c:forEach items="${AllVideoInfo}" var="message" varStatus="info">
                    <%--点击跳转到视频的详情页面，传递的参数是视频ID--%>
                    <li>
                        <i class="ztpic"><a href="zbDetail?zbID=${message.dbId}" target="_blank">
                            <img src=${message.videoBackUrl}></a></i><i class="ztpic zhezhang"
                                                                 style="background-color: black;"><a
                            href="zbDetail?dbID=${message.dbId}" target="_blank"></a></i> <span><a
                            href="zbDetail?dbID=${message.dbId}">${message.title}</a></span>
                    </li>
                </c:forEach>
            </ul>
        </div>

        <!--bloglist end-->
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
    </a>
</footer>
</body>
</html>
