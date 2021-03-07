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
</div>
<div class="container">
    <div class="lbox">
        <div class="videotitle">
            <p>橘子大战苹果</p>
            <p style="margin-top:2px;"><span>2.2万播放</span><span>300弹幕</span><span>${videoInfo.publishTime}</span></p>
        </div>
        <div class="mainContainer">
            <video id="videoElement" class="centeredVideo" controls autoplay width="512" height="288">Your browser is
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
        <div class="danmu" id="danmu">
            <div class="all">
                <div>
                    <span style="padding-left: 8px;font-size: 14px;">325条弹幕&nbsp&nbsp&nbsp24人正在观看</span>
                </div>
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
        <div class="biaoqian">
             <span style="float:left;font-size: 15px;margin-top:5px;">
                        <a style="margin-right: 10px;background-color: #07caec;width:max-content;padding:3px 7px !important;color:white;border-radius: 3px;">娱乐</a>
                        <a style="margin-right: 10px;background-color: #FE4365;width:max-content;padding:3px 7px !important;color:white;border-radius: 3px;">游戏</a>
                        <a style="margin-right: 10px;background-color: #4fef0a;width:max-content;padding:3px 7px !important;color:white;border-radius: 3px;">电子竞技</a>
            </span>
        </div>
        <div class="whitebg gbook">
            <h2 class="htitle">视频评论</h2>
            <div style="height: 40px;line-height: 40px;width:100%;display: flex;padding:0 10px;">
                <i class='avatar' style="float: left;"><img alt='' src="${article.avatar}"></i>
                <input class="CommentText" value="大人,请输入您的意见"
                       onfocus="if(value=='大人,请输入您的意见'){this.style.color='#000';value=''}"
                       onblur="if(value==''){this.style.color='#999';value='大人,请输入您的意见'}"
                       style="color:#999;border:1px solid darkgrey;border-radius:5px;height: 35px;line-height: 35px;width:100%;margin:0 10px;"/>
                <button id="0" class="addComment"
                        style="color:white;float:right;width: 70px;background-color: orangered;border-radius: 5px;height: 35px;line-height: 35px;">
                    评论
                </button>
            </div>

            <%--通过异步请求来实现对评论的加载--%>
            <script>
                $(function () {
                    /*定义一个变量用来代表根评论id*/
                    var parent;
                    /*当点击回复按钮后，由于是动态添加的元素，所以要用on的方式将元素与父元素绑定来进行添加点击事件，直接click是没有反应的
                    * 也即展开隐藏的输入框*/
                    $("#commentContainer").on('click', '.replyComment', function () {
                        /*先获得该回复对应的根评论id*/
                        parent = $(this).attr("id");
                        /*设置当前隐藏部分的button提交按钮的id*/
                        /*再展开评论输入层，进行评论的输入*/
                        $("#commenthidden").toggle();
                    });

                    /*评论加载函数的真实实现地方*/
                    function loadComment() {
                        $.ajax({
                            url: "videoComment",   //请求的网址为视频评论增加模块
                            data: {"pkVid": ${videoInfo.dbId}},
                            dataType: "json",
                            success: function (result) {
                                /*解析返回的数据解析出所有评论，并拼接到显示的内容上*/
                                var commentText = "";
                                if (result.length == 0) {
                                    alert("空空如也")
                                } else {
                                    /*申明变量用来记录当前是第几个根评论*/
                                    for (let i = 0; i < result.length; i++) {
                                        for (let j = 0; j < result[i].length; j++) {
                                            /*说明是根评论*/
                                            if (result[i][j].parent == 0) {
                                                /*span标签点击后，弹出一个输入框，用来输入要回复该根评论的内容，而通过coid，我们就能确认当前回复的评论的跟评论是那一个了*/
                                                commentText = commentText + "<li class='commentList'><i class='avatar'><img alt='' src='" + result[i][j].author_avatar + "'></i><span>" + result[i][j].author_name + ":</span>" + result[i][j].text + "<span id='" + result[i][j].coid + "' class='replyComment' style='color: #00C1DE;cursor: pointer;'>回复</span></li>";
                                            } else if (result[i][j].parent != 0) {
                                                commentText = commentText + "<li class='son'><i class='avatar'><img alt='' src='" + result[i][j].author_avatar + "'></i><span>" + result[i][j].author_name + ":</span>" + result[i][j].text + "</li>";
                                            }
                                        }
                                    }
                                    $("#commentContainer").html(commentText);
                                }
                            },
                            error: function (failed) {
                                alert("客官，出错了")
                            }

                        });
                    };

                    /*评论加载的点击事件*/
                    $("#commentContainer").on('click', '#comments', function () {
                        //加载评论的函数
                        loadComment();
                    })

                    /*关闭遮障层事件,第一个为点击x号，第二个为评论成功，第三个为评论区回车提交成功*/
                    $("#commentClose").click(function () {
                        $("#commenthidden").toggle();
                    });

                    /*回复时涉及到的提交方式之一：隐藏的评论区中通过回车来进行提交*/
                    $(".hiddenCommentText").keydown(function (e) {
                        if (e.keyCode == 13) {
                            /*得到评论的根评论id,全局变量里面有，即parent，进入这个里面时，一定有了这个*/
                            /*先得到具体的评论内容*/
                            var text = $(".hiddenCommentText").val();
                            if (text == "" || text == null) {
                                alert("请输入评论再进行提交")
                            } else {
                                /*调用提交评论的异步函数，并进行评论的插入*/
                                addComment(parent, text);
                                /*由于是隐藏部分的，所以注意遮障层的关闭*/
                                $("#commenthidden").toggle();
                            }
                        }
                    });

                    /*添加评论的方式二：首页中的添加评论的异步请求,这各代表的是外面的点击请求*/
                    $(".addComment").click(function () {
                        /*获取点击后添加的评论的根请求，默认为0，代表当前输入的就是根请求*/
                        parent = $(this).attr("id");
                        /*先判断异步请求是否为空，或者是“大人，请输入您的意见”，如果这样，提示输入，否则将内容提交到评论处理中，进行添加*/
                        /*第一步：先得到评论的数据,由于是其上一个兄弟元素，所以直接得到*/
                        var comment = $(this).prev().val();
                        if (comment == "" || comment == "大人,请输入您的意见") {
                            alert("客官,请输入评论的内容☺")
                        } else {
                            addComment(parent, comment);
                        }
                    });

                    /*添加评论的方式三：通过隐藏输入框部分的按钮提交*/
                    $(".specialAdd").click(function () {
                        /*获取点击后添加的评论的根请求，由于是隐藏部分的，所以和全局的parent一样*/
                        /*先判断异步请求是否为空，或者是“大人，请输入您的意见”，如果这样，提示输入，否则将内容提交到评论处理中，进行添加*/
                        /*第一步：先得到评论的数据,由于是其上一个兄弟元素，所以直接得到*/
                        var comment = $(this).prev().val();
                        if (comment == "" || comment == "大人,请输入您的意见") {
                            alert("客官,请输入评论的内容☺")
                        } else {
                            addComment(parent, comment);
                            /*由于是隐藏部分的，所以注意遮障层的关闭*/
                            $("#commenthidden").toggle();
                        }
                    });

                    /*真正进行评论添加的方法，有参数：根评论id,评论内容*/
                    function addComment(parentid, comment) {
                        /*开始添加评论*/
                        $.ajax({
                            url: "addVideoComment",   //请求的网址，也即将要添加的评论加入到这里进行,在此个servlet中将会进行文明用语的检查
                            data: {"pkVid": ${videoInfo.dbId}, "uid":${user.pk_uid}, "comment": comment, "parent": parentid},  //参数：评论的视频id,评论人id(这个应该从登陆的缓存中进行得到),评论内容,根评论id
                            dataType: "text",
                            success: function (result) {
                                /*获取返回的结果*/
                                if (result == '评论成功\r\n') {
                                    alert("评论成功")
                                    /*评论加载成功后，则重新进行评论的加载，所以调用以下函数进行加载*/
                                    loadComment();
                                } else {
                                    alert("else进来了" + result + "111")
                                }
                            },
                            error: function (failed) {
                                alert("客官，出错了")
                            }
                        });
                    }

                })
            </script>
            <ul id="commentContainer" style="margin:15px auto">
                <li style="height:40px;line-height:40px;color:deepskyblue;text-align: center;cursor:pointer;"
                    id="comments">查看热评<span class="iconfont" style="color:#1296db">&#xe608;</span></li>
            </ul>
        </div>
        <%--点击回复reply后才会弹出的文本输入框，是绝对定位--%>
        <div style="height: 40px;line-height: 40px;width:100%;height:100%;background-color:#000;opacity:0.8;display:none;position: fixed;z-index: 1000;top: 0px;left: 0px;bottom:0px;"
             id="commenthidden">
            <%--添加一个用来关闭的按钮x--%>
            <div id="commentClose"
                 style="width:10px;height: 40px;margin:auto auto;position: fixed;top:40%;right:25%;color:lightgrey;cursor: pointer ">
                X
            </div>
            <div style="width: 50%;height: 100px;margin:auto auto;display:flex;position:fixed;top:45%;left:25%;"
                 id="hiddenCore">
                <i class='avatar' style="float: left;"><img alt='' src="${article.avatar}"></i>
                <input class="CommentText hiddenCommentText" value="大人,请输入您的意见"
                       onfocus="if(value=='大人,请输入您的意见'){this.style.color='#000';value=''}"
                       onblur="if(value==''){this.style.color='#999';value='大人,请输入您的意见'}"
                       style="color:#999;border:1px solid darkgrey;border-radius:5px;height: 35px;line-height: 35px;width:100%;margin:0 10px;"/>
                <button class="specialAdd"
                        style="color:white;float:right;width: 70px;background-color: red;border-radius: 5px;height: 35px;line-height: 35px;">
                    评论
                </button>
            </div>
        </div>
    </div>
    <div class="rbox">
        <div class="videoAvaratImageShow">
            <i><a><img src="${videoInfo.avatar}"/></a></i>
            <p style="font-size:14px;color:black;">${videoInfo.name}</p>
            <p style="cursor: default;">${videoInfo.userTime}&nbsp</p>
        </div>
        <div class="danmuList">
            <p class="sortTitle">弹幕列表</p>
            <p class="sortDetail"><span style="float: left;padding-left:6px;">时间&nbsp&nbsp&nbsp内容</span><span
                    style="float: right;padding-right:6px;">发送时间</span></p>
            <ul>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>

                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>

                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
                <li><span class="leftSpan">12:30&nbsp&nbsp&nbsp我靠,好厉害</span><span class="rightSpan">2017-02-21</span>
                </li>
            </ul>
        </div>
        <div class="videoUp">
            <p class="sortTitle">相关推荐</p>
            <ul>
                <li>
                    <i class="videoUpImg">
                        <a href="videoDetail?dbID=${message.dbId}" target="_blank">
                            <img src="../1.jpg">
                        </a>
                    </i>
                    <span style="color:black">fdsjfkjsdjfkld</span>
                    <span>2017-01-21&nbspfsdjfsfjkjflsdjf12313</span>
                </li>

            </ul>
        </div>

    </div>
</div>
<input id="videoUrl" hidden value="${videoInfo.videoUrl}">
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
