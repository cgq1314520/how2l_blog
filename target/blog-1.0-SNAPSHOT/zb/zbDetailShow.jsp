<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
    <script src="static/js/jquery-1.8.3.min.js"></script>
    <script src="static/js/video.js"></script>
    <script src="static/js/flv.js"></script>


    <link href="static/css/base.css" rel="stylesheet">
    <link href="static/css/video.css" rel="stylesheet">
    <link href="static/css/m.css" rel="stylesheet">
    <script src="static/js/comm.js"></script>
    <title>how2l</title>
</head>

<body style="background-color: black">
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
</div>
<div class="container" style="height: 98%;width: 100%;margin:0;padding:0;">
    <div class="lbox" style="height: 100%;width: 100%;">
        <div class="videotitle" style="position:absolute;margin:10px 10px;">
            <p style="color: white">橘子大战苹果</p>
            <p style="margin-top:2px;color: white"><span>2.2万播放</span><span>300弹幕</span><span>2021-02-28 20:00:01</span></p>
        </div>
        <div class="mainContainer" style="width: 100%;height: 100%;margin:0px;">
            <video id="videoElement" class="centeredVideo" autoplay width="512" height="288" style="height: 100%;width: 100%;">Your browser is
                too old which doesn't support HTML5 video.
            </video>

            <div class="zhezhang" istrue='0'>
                <div class="barrage-container-wrap clearfix">
                    <div class="barrage-container">
                    </div>
                </div>
            </div>
            <!-- <div class="zhezhang"></div> -->
        </div>
        <div class="danmu" id="danmu" >
            <div class="all" style="background-color: black">
                <div style="float:right;height: 30px;line-height: 30px;margin-right: 5px">
                    <span style="height: 30px;line-height: 30px;background-color: deepskyblue;width: 50px;margin-left: 0px;display: inline-block;float:right;text-align: center;color:white;cursor: pointer;"
                          class="send-btn">发送</span>
                    <input type="text" id="danmuInput" name="danmuInput" placeholder="发个友善的弹幕见证当下(´･ᴗ･`)"
                           style="height: 26px;line-height: 28px;width:200px;float:right;">

                </div>
                <div class="dan_notactive" id="dan1">
                    <a href="JavaScript:void(0)" id="a1" class="a_notactive">弹</a>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="videoUrl" hidden value="${videoInfo.videoUrl}">
<script>
    var player = document.getElementById('videoElement');
    var videoUrl = document.getElementById('videoUrl').value;
    if (flvjs.isSupported()) {
        var flvPlayer = flvjs.createPlayer({
            type: 'MP4',
            url: videoUrl
        });
        flvPlayer.attachMediaElement(videoElement);
        flvPlayer.load(); //加载
    }

    function flv_start() {
        player.play();
    }


    function flv_pause() {
        player.pause();
    }

    function flv_destroy() {
        player.pause();
        player.unload();
        player.detachMediaElement();
        player.destroy();
        player = null;
    }

    function flv_seekto() {
        player.currentTime = parseFloat(document.getElementsByName('seekpoint')[0].value);
    }
</script>

</body>

</html>
