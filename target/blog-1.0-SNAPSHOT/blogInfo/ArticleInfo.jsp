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


    <!--引入markdown相关js文件-->
    <script src="static/editormd/js/jquery.min.js"></script>
    <script src="static/editormd/lib/marked.min.js"></script>
    <script src="static/editormd/lib/prettify.min.js"></script>
    <script src="static/editormd/lib/raphael.min.js"></script>
    <script src="static/editormd/lib/underscore.min.js"></script>
    <script src="static/editormd/lib/sequence-diagram.min.js"></script>
    <script src="static/editormd/lib/flowchart.min.js"></script>
    <script src="static/editormd/lib/jquery.flowchart.min.js"></script>
    <script src="static/editormd/js/editormd.js"></script>
    <!--[if lt IE 9]
     <script src="js/modernizr.js"></script>
    <![endif]-->
    <style>
        .personinfo i {
            position: absolute;
            right: 30px;
            top: 15px;
            z-index: 999;
        }

        .personinfo:hover i {
            position: absolute;
            right: 20px;
            top: 28px;
            z-index: 999;
            width: 40px;
            height: 40px;
            transition: all .3s;
        }

        .sub li a:hover {
            color: deepskyblue !important;
        }
    </style>
</head>
<body>
<!--top begin-->
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

<!--top end-->
<article>
    <!--lbox begin-->
    <div class="lbox">
        <div class="content_box whitebg">
            <h2 class="htitle"><span class="con_nav">您现在的位置是：<a href="info.html">网站首页</a>><a
                    href="info.html">${article.authorName}的个人博客</a></span></h2>
            <h1 class="con_tilte">个人博客，属于我的小世界！</h1>
            <p class="bloginfo"><i class="avatar"><img
                    src="${article.authorAvator}"></i><span>${article.authorName}</span><span>${article.gmtCreate}</span><span>【<a
                    href="info.html"
                    text="${article.authorName}">${article.authorName}</a>】</span><span>${article.views}人已围观</span></p>
            <p class="con_info"><b>简介</b>${article.describe}</p>
            <textarea id="hidden" style="display: none;">${article.content}</textarea>
            <div class="con_text">
                <!--在该div中展示,如有初始化的数据可以放在textarea中-->
                <div id="testEditorMdview">
                    <textarea id="appendTest" style="display:none;"></textarea>
                </div>
                <!--通过以下的标签将所有的内容（markdown）输出到网页上用于展示-->
                <script>
                    $("#testEditorMdview").html('<textarea id="appendTest" style="display:none;" value=""></textarea>');
                    var content = $("#hidden").val();
                    $("#appendTest").val(content);//将需要转换的内容加到转换后展示容器的textarea隐藏标签中
                    //转换开始,第一个参数是上面的div的id
                    editormd.markdownToHTML("testEditorMdview", {
                        htmlDecode: "style,script,iframe", //可以过滤标签解码
                        emoji: true,
                        taskList: true,
                        tex: true,               // 默认不解析
                        flowChart: true,         // 默认不解析
                        sequenceDiagram: true,  // 默认不解析
                    });
                </script>


                <p><span class="diggit">很赞哦！ (74)</span></p>
                <div class="nextinfo">
                    <p>上一篇：<a href="/download/f/886.html">html5 个人博客模板《蓝色畅想》</a></p>
                    <p>下一篇：<a href="/download/f/907.html">个人博客模板《tree》-响应式个人网站模板</a></p>
                </div>
            </div>
        </div>
        <div class="whitebg">
            <h2 class="htitle">相关文章</h2>
            <ul class="otherlink">
                <li><a href="/download/div/2018-04-22/815.html" title="html5个人博客模板《黑色格调》">html5个人博客模板《黑色格调》</a></li>
                <li><a href="/download/div/2018-04-18/814.html" title="html5个人博客模板主题《清雅》">html5个人博客模板主题《清雅》</a></li>
                <li><a href="/download/div/2018-03-18/807.html" title="html5个人博客模板《绅士》">html5个人博客模板《绅士》</a></li>
                <li><a href="/download/div/2018-02-22/798.html" title="html5时尚个人博客模板-技术门户型">html5时尚个人博客模板-技术门户型</a></li>
                <li><a href="/download/div/2017-09-08/789.html" title="html5个人博客模板主题《心蓝时间轴》">html5个人博客模板主题《心蓝时间轴》</a>
                </li>
                <li><a href="/download/div/2017-07-16/785.html" title="古典个人博客模板《江南墨卷》">古典个人博客模板《江南墨卷》</a></li>
                <li><a href="/download/div/2017-07-13/783.html" title="古典风格-个人博客模板">古典风格-个人博客模板</a></li>
                <li><a href="/download/div/2015-06-28/748.html" title="个人博客《草根寻梦》—手机版模板">个人博客《草根寻梦》—手机版模板</a></li>
                <li><a href="/download/div/2015-04-10/746.html" title="【活动作品】柠檬绿兔小白个人博客模板">【活动作品】柠檬绿兔小白个人博客模板</a></li>
                <li><a href="/jstt/bj/2015-01-09/740.html" title="【匆匆那些年】总结个人博客经历的这四年…">【匆匆那些年】总结个人博客经历的这四年…</a></li>
            </ul>
        </div>

        <div class="whitebg gbook">
            <h2 class="htitle">文章评论</h2>
            <div style="height: 40px;line-height: 40px;width:100%;display: flex;">
                <i class='avatar' style="float: left;"><img alt='' src="${article.authorAvator}"></i>
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
                            url: "comment",   //请求的网址
                            data: {"pkBid":${article.pkBid}},
                            dataType: "json",
                            success: function (result) {
                                /*解析返回的数据解析出所有评论，并拼接到显示的内容上*/
                                var commentText = "";
                                if (result.length == 0) {
                                    alert("空空如也")
                                } else {
                                    console.log(result)
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


                    function addComment(parentid, comment) {
                        /*真正进行评论添加的方法，有参数：根评论id,评论内容*/
                        var userid=${user.pk_uid==null}?"0":${user.pk_uid}+"";
                        /*开始添加评论*/
                        $.ajax({
                            url: "addComment",   //请求的网址，也即将要添加的评论加入到这里进行,在此个servlet中将会进行文明用语的检查
                            data: {
                                "pkBid":${article.pkBid},
                                "uid":userid,
                                "comment": comment,
                                "parent": parentid
                            },  //参数：文章id,评论人id(这个应该从登陆的缓存中进行得到),评论内容,根评论id
                            dataType: "text",
                            success: function (result) {
                                /*获取返回的结果*/
                                if (result === '评论成功\r\n') {
                                    alert("评论成功")
                                    /*评论加载成功后，则重新进行评论的加载，所以调用以下函数进行加载*/
                                    loadComment();
                                } else if(result==='301\r\n'){
                                        alert("您还没有登陆奥,接下来将跳转到登录页面")
                                        window.location.href = "/loginRegister";
                                }else {
                                    alert(result)
                                }
                            },
                            error: function (failed) {
                                alert("客官，出错了")
                            }
                        });
                    };

                })
            </script>
            <ul id="commentContainer" style="margin:15px auto">
                <li style="height:40px;line-height:40px;color:deepskyblue;text-align: center;cursor:pointer;"
                    id="comments">查看32条热评<span class="iconfont" style="color:#1296db">&#xe608;</span></li>
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
                <i class='avatar' style="float: left;"><img alt='' src="${article.authorAvator}"></i>
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
    <!--lbox end-->
    <div class="rbox">
        <div class="card">
            <!--用户信息表中的内容展示-->
            <h2>用户信息</h2>
            <p>用户名：java想成神</p>
            <p>职业：java工程师</p>
            <p>现居：地球</p>
            <p>网址：www.hmy.cn</p>
            <ul class="linkmore">
                <!--网站地址-->
                <li><a href="www.hmy.cn" target="_blank" class="iconfont icon-zhuye" title="网站地址"></a></li>
                <!--邮箱地址-->
                <li><a href="http://www.hmy.cn/webpage/" target="_blank" class="iconfont icon-youxiang"
                       title="我的邮箱"></a></li>
                <!--跳转到qq进行联系-->
                <li><a href="http://www.hmy.cn/yuanma/" target="_blank" class="iconfont icon---" title="QQ联系我"></a></li>
                <!--贴出个人的微信个人图片信息，用来进行联系-->
                <li id="weixin"><a href="#" target="_blank" class="iconfont icon-weixin" title="关注我的微信"></a><i><img
                        src="static/images/wx.png}"></i></li>
            </ul>
        </div>

        <div class="whitebg paihang">
            <h2 class="htitle">点击排行</h2>
            <section class="topnews imgscale"><a href="info.html"><img src="static/images/h1.jpg"><span>6条网页设计配色原则,让你秒变配色高手</span></a>
            </section>
            <ul>
                <li><i></i><a href="info.html">十条设计原则教你学会如何设计网页布局!</a></li>
                <li><i></i><a href="info.html">用js+css3来写一个手机栏目导航</a></li>
                <li><i></i><a href="info.html">6条网页设计配色原则,让你秒变配色高手</a></li>
                <li><i></i><a href="info.html">三步实现滚动条触动css动画效果</a></li>
                <li><i></i><a href="info.html">个人博客，属于我的小世界！</a></li>
                <li><i></i><a href="info.html">安静地做一个爱设计的女子</a></li>
                <li><i></i><a href="info.html">个人网站做好了，百度不收录怎么办？来，看看他们怎么做的。</a></li>
                <li><i></i><a href="info.html">做个人博客如何用帝国cms美化留言增加头像选择</a></li>
            </ul>
        </div>
        <div class="whitebg tuijian">
            <h2 class="htitle">本栏推荐</h2>
            <section class="topnews imgscale"><a href="info.html"><img src="static/images/h1.jpg"><span>6条网页设计配色原则,让你秒变配色高手</span></a>
            </section>
            <ul>
                <li><a href="info.html"><i><img src="static/images/text01.jpg"></i>
                    <p>十条设计原则教你学会如何设计网页布局!</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text01.jpg"></i>
                    <p>用js+css3来写一个手机栏目导航</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text01.jpg"></i>
                    <p>6条网页设计配色原则,让你秒变配色高手</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text01.jpg"></i>
                    <p>三步实现滚动条触动css动画效果</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text01.jpg"></i>
                    <p>个人博客，属于我的小世界！</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text01.jpg"></i>
                    <p>安静地做一个爱设计的女子</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text01.jpg"></i>
                    <p>个人网站做好了，百度不收录怎么办？来，看看他们怎么做的。</p>
                </a></li>
            </ul>
        </div>
        <div class="ad whitebg imgscale">
            <ul>
                <a href="info.html"><img src="static/images/ad.jpg"></a>
            </ul>
        </div>
        <div class="whitebg cloud">
            <h2 class="htitle">标签云</h2>
            <ul>
                <a href="" target="_blank">个人博客模板</a> <a href="" target="_blank">css动画</a> <a href=""
                                                                                              target="_blank">布局</a> <a
                    href="/}" target="_blank">今夕何夕</a> <a href="/}" target="_blank">SEO</a> <a href="/}"
                                                                                               target="_blank">女程序员</a>
                <a href="/}" target="_blank">小世界</a> <a href="/}" target="_blank">个人博客</a> <a href="/}" target="_blank">网页设计</a>
            </ul>
        </div>
        <div class="whitebg wenzi">
            <h2 class="htitle">猜你喜欢</h2>
            <ul>
                <li><a href="info.html">十条设计原则教你学会如何设计网页布局!</a></li>
                <li><a href="info.html">用js+css3来写一个手机栏目导航</a></li>
                <li><a href="info.html">6条网页设计配色原则,让你秒变配色高手</a></li>
                <li><a href="info.html">三步实现滚动条触动css动画效果</a></li>
                <li><a href="info.html">个人博客，属于我的小世界！</a></li>
                <li><a href="info.html">安静地做一个爱设计的女子</a></li>
                <li><a href="info.html">个人网站做好了，百度不收录怎么办？来，看看他们怎么做的。</a></li>
                <li><a href="info.html">做个人博客如何用帝国cms美化留言增加头像选择</a></li>
            </ul>
        </div>
        <div class="ad whitebg imgscale">
            <ul>
                <a href="info.html"><img src="static/images/ad02.jpg"></a>
            </ul>
        </div>
        <div class="whitebg tongji">
            <h2 class="htitle">站点信息</h2>
            <ul>
                <li><b>建站时间</b>：2018-10-24</li>
                <li><b>网站程序</b>：帝国cms</li>
                <li><b>主题模板</b>：<a href="http://www.yangqq.com" target="_blank">《努力努力》</a></li>
                <li><b>文章统计</b>：299条</li>
                <li><b>文章评论</b>：490条</li>
                <li><b>统计数据</b>：<a href="info.html">百度统计</a></li>
                <li><b>微信公众号</b>：扫描二维码，关注我们</li>
                <img src="static/images/wx.jpg" class="tongji_gzh">
            </ul>
        </div>
    </div>
</article>
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
