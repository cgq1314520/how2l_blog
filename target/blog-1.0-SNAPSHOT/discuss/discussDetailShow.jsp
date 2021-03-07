<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <title>博客来了</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="static/editormd/js/jquery.min.js"></script>
    <%--以下的代码块放在这里有效，如果放在其他js之后就会失效--%>
    <script type="text/javascript">
        $(function () {
            /*功能1：在此异步请求回复的结果进行展示*/
            searchReplyAnswer();

            function searchReplyAnswer() {
                var questionId =${questionDetail.pkDaId};
                $.ajax({
                    type: "post",
                    url: "searchReplyAnswer",
                    dataType: "json",
                    data: {
                        /*携带给后台的参数:当前问题的id*/
                        questionId: questionId
                    },
                    success: function (result) {
                        $("#replyCount").html("共计" + result.length + "条回答");
                        /*开始添加具体回复*/
                        var replyHtml = "";

                        for (let i = 0; i < result.length; i++) {
                            replyHtml += "<div class=\"content_box whitebg\" style=\"border-bottom:1px solid lightgrey;margin:0px;padding:20px 0px;font-size:14px;font-family:'PingFang SC'\">";
                            replyHtml += "<p class=\"bloginfo\" style=\"margin-top:1px;\"><i class=\"avatar\"><img src=\"" + result[i].avatar + "\"></i><span style=\"padding-left: 0px;padding-right: 15px;\"><span style=\"font-weight:bold;padding-right:10px;color:black;\">" + result[i].username + "</span>" + result[i].gmtCreate + "</span></p>";
                            replyHtml += "<div style=\"margin-top:1px;padding:5px 15px;\" class='replyContainer'>" + result[i].replyContent + "</div>";
                            replyHtml += "</div>"
                        }
                        /*开始添加html*/
                        $(".replyHtml").html(replyHtml);
                    },
                    error: function (error) {
                        alert("请求异常");
                    }
                })
            };

            /*功能2：将具体的问题内容展示到显示的位置处*/
            $(".con_text").html($("#hidden").val())

            /*功能3：点击回复问题按钮时的响应事件*/
            $("#submitAnswer").click(function () {
                /*获取评论的内容*/
                var replyAnswer = $("#editorhtml0").val();
                /*当评论用户不存在，也即没有登录时：让异步请求的网址跳转到登录页面*/
                /*获取评论用户的id*/
                var userid = "";
                /*将请求发送到哪里的URL*/
                var url = "";
                //以下两句三元表达式的作用为：如果用户已登录，则提交问题的回答时直接提交，否则先跳转到登录页面
                userid = ${user==null} ? -1 : ${user.pk_uid}+"";
                url = ${user==null} ? "loginRegister" : "addReplyQuestion";
                /*获取当前问题的id*/
                var questionId =${questionDetail.pkDaId};
                /*异步提交用户的回复评论*/
                $.ajax({
                    type: "post",
                    url: url,
                    dataType: "text",
                    data: {
                        /*携带给后台的参数:回复的内容、用户id、回复问题的id*/
                        replyContent: replyAnswer,
                        userid: userid,
                        questionId: questionId
                    },
                    success: function (result) {
                        if (result == '您的回复失败,请重新尝试\r\n') {
                            alert("您的回复失败,请重新尝试");
                        }
                        if (result == '回复成功\r\n') {
                            alert("回复成功");
                            searchReplyAnswer();
                        } else {
                            //这种情况说明是还没有登录，所以跳转
                            alert("您还没有登录，请先登录");
                            window.location.href = url;
                        }
                    },
                    error: function (error) {
                        alert("请求异常");
                    }
                })
            });

            /*点击提问题之后的响应事件，先判断用户是否存在，如果不存在，跳转到登录界面*/
            /*功能4：你问我答区域点击问题提交时的响应事件*/
            $("#submitQuestion").click(function () {
                /*获取问题的标题*/
                var questionTitle = $(".questionInput").val();
                if (questionTitle == "" || (String)(questionTitle).trim() == "") {
                    alert("亲,提问先给出问题呀！");
                    return;
                }
                /*获取问题的内容,这里直接获取markdown格式的内容*/
                var questionContent = $("#editormd").val();
                if (questionContent == "" || (String)(questionContent).trim() == "") {
                    alert("请先输入问题的具体内容呀！");
                    return;
                }
                /*获取问题的标签选择结果并拼接为字符串*/
                var sortsPut = "";
                var sortElement = $(".sortAnswer");
                if (sortElement.length == 0) {
                    alert("请选择问题的标签分类");
                    return;
                }
                for (let i = 0; i < sortElement.length; i++) {
                    let now = sortElement.eq(i);
                    sortsPut += now.attr('value');
                    if (i != sortElement.length - 1) {
                        sortsPut += ",";
                    }
                }
                /*现在进行问题的提交，这里还需要进行问题提出者id的记录，通过异步提交将问题记录插入数据库*/
                /*当评论用户不存在，也即没有登录时：让异步请求的网址跳转到登录页面*/
                /*获取评论用户的id*/
                var userid = "";
                /*将请求发送到哪里的URL*/
                var url = "";
                //以下两句三元表达式的作用为：如果用户已登录，则提交问题的回答时直接提交，否则先跳转到登录页面
                userid = ${user==null} ? -1 : ${user.pk_uid}+"";      //注意：把""必须加上，否则后面没有登录时，是不存在的就会导致js直接出错
                url = ${user==null} ? "loginRegister" : "addQuestion";
                $.ajax({
                    type: "post",
                    url: url,
                    dataType: "text",
                    data: {
                        /*携带给后台的参数:问题标题、问题内容、用户id*/
                        questionTitle: questionTitle,
                        questionContent: questionContent,
                        userid: userid,
                        sort: sortsPut
                    },
                    success: function (result) {
                        if (result == '问题添加成功\r\n') {
                            alert("问题添加成功");
                            /*关闭弹出层*/
                            $(".floatDiv").hide();
                        }
                        if (result == '问题添加失败，请重新尝试\r\n') {
                            alert("问题添加失败，请重新尝试");
                        } else {
                            //说明还没有登录，先登录
                            alert("您还没有登录，请先登录");
                            //这种情况说明是还没有登录，所以跳转
                            window.location.href = url;
                        }
                    },
                    error: function (error) {
                        alert("请求异常");
                    }
                })
            });

        })
    </script>
    <script src="static/editormd/js/editormd.js"></script>
    <script src="static/js/comm.js"></script>
    <link rel="stylesheet" href="static/editormd/css/style.css"/>
    <link rel="stylesheet" href="static/editormd/css/editormd.css"/>
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

    <style>
        .personinfo i {
            position: absolute;
            right: 30px;
            top: 15px;
            z-index: 8;
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
        <%--以下将全部的问题信息展示到页面上,利用editormd模板来进行展示--%>
        <div class="content_box whitebg">
            <h2 class="htitle"><span class="con_nav">您现在的位置是：<a href="info.html">你问我答</a>><a
                    href="info.html">${questionDetail.username}的问题交流区</a></span></h2>
            <p class="bloginfo"><i class="avatar"><img src="${questionDetail.authorAvator}"></i><span
                    style="padding-left: 15px;padding-right: 30px;">${questionDetail.username}</span><span>${questionDetail.gmtCreate}</span>
            </p>
            <h1 class="con_tilte">${questionDetail.title}</h1>
            <span style="float:left;font-size: 15px;margin:15px 0px;display:block;width:100%;border-bottom:1px solid lightgrey;padding-bottom:10px;">
                <c:forEach items="${questionDetail.sortDetail}" var="sortmessage" varStatus="Detail">
                    <a style="margin-right: 10px;background-color: #E9F1FA;width:max-content;padding:2px 5px !important;color:black;border-radius: 3px;">${sortmessage}</a>
                </c:forEach>
            </span>
            <textarea id="hidden" style="display: none;">${questionDetail.discussContent}</textarea>
            <div class="con_text">

            </div>
        </div>
        <%--这部分用来显示回答的答复--%>
        <div class="whitebg"> <!-- <img src="images/lm04.jpg"> -->
            <div style="border-bottom: 1px solid lightgrey;font-weight: bold;height: 50px;line-height: 50px;"
                 id="replyCount">
                <%--总共有多少条评论的展示--%>
            </div>
            <div class="replyHtml">
                <%--所有回复的展示--%>
            </div>

        </div>
        <%--以下为用来回答问题的部分--%>
        <div class="whitebg" style="padding:0 0 10px 0;"> <!-- <img src="images/lm04.jpg"> -->
            <div id="layout" style="margin-top:0px;">

                <div id="test-editormd0" class="editormd editormd-vertical" style="border:none;">
                    <textarea style="display:none;" class="form-control" id="editormd0" name="editormd"></textarea>
                    <!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
                    <!-- html textarea 需要开启配置项 saveHTMLToTextarea == true -->
                    <textarea class="editormd-html-textarea" name="editorhtml" id="editorhtml0"></textarea>
                </div>
            </div>
            <span style="cursor:pointer;height: 35px;line-height: 35px;text-align:center;width: 70px;border-radius: 5px;background-color: red;border: 1px solid red;float: right;color:white;margin-right:15px;"
                  id="submitAnswer">回复</span>
        </div>
        <!--bloglist end-->
    </div>
    <div class="rbox">
        <div class="whitebg">
            <c:if test="${user!=null}">
                <!--问答的部分-->
                <div style="border-bottom: 1px solid grey;height: 35px;padding-bottom: 5px;width: 100%;margin-bottom: 15px;">
                    <span style="float:left;height:30px;line-height: 30px;width: 70px;font-size: 13px;">我的问答</span>
                    <!--点击以下的弹出层之后就会弹出一个悬浮框，在这个悬浮框中进行问题的填写，填写前先判断用户是否存在-->
                    <span id="openQuestion"
                          style="float: right;height: 30px;line-height: 30px;border-radius:5px;border:1px solid red; width: 70px;text-align: center;font-size: 13px;font-weight: bold;color:red;cursor: pointer;">+提问题</span>
                </div>
                <div>
                    <span style="float:left;font-size: 15px;cursor: pointer;">我的提问</span>
                    <span style="float:right;font-size: 15px;cursor: pointer;">我的回答</span>
                </div>
            </c:if>
            <c:if test="${user==null}">
                <div>
                    <span style="float:left;font-size: 15px;cursor: pointer;">点击<a href="loginRegister"
                                                                                   style="color: red">登录</a>以查看更多问答信息</span>
                </div>
            </c:if>
        </div>

        <div class="whitebg tuijian">
            <h2 class="htitle">本栏推荐</h2>
            <section class="topnews imgscale"><a href="info.html"><img
                    src="images/h2.jpg"><span>6条网页设计配色原则,让你秒变配色高手</span></a></section>
            <ul>
                <li><a href="info.html"><i><img src="images/text01.jpg"></i>
                    <p>十条设计原则教你学会如何设计网页布局!</p>
                </a></li>
                <li><a href="info.html"><i><img src="images/text02.jpg"></i>
                    <p>用js+css3来写一个手机栏目导航</p>
                </a></li>
                <li><a href="info.html"><i><img src="images/text03.jpg"></i>
                    <p>6条网页设计配色原则,让你秒变配色高手</p>
                </a></li>
                <li><a href="info.html"><i><img src="images/text04.jpg"></i>
                    <p>三步实现滚动条触动css动画效果</p>
                </a></li>
                <li><a href="info.html"><i><img src="images/text05.jpg"></i>
                    <p>个人博客，属于我的小世界！</p>
                </a></li>
                <li><a href="info.html"><i><img src="images/text06.jpg"></i>
                    <p>安静地做一个爱设计的女子</p>
                </a></li>
                <li><a href="info.html"><i><img src="images/text07.jpg"></i>
                    <p>个人网站做好了，百度不收录怎么办？来，看看他们怎么做的。</p>
                </a></li>
            </ul>
        </div>

        <div class="ad whitebg imgscale">
            <ul>
                <a href="info.html"><img src="images/ad.jpg"></a>
            </ul>
        </div>
        <div class="whitebg cloud">
            <h2 class="htitle">标签云</h2>
            <ul>
                <a href="" target="_blank">个人博客模板</a> <a href="" target="_blank">css动画</a> <a href=""
                                                                                              target="_blank">布局</a> <a
                    href="" target="_blank">今夕何夕</a> <a href="" target="_blank">SEO</a> <a href=""
                                                                                           target="_blank">女程序员</a> <a
                    href="" target="_blank">小世界</a> <a href="" target="_blank">个人博客</a> <a href=""
                                                                                           target="_blank">网页设计</a>
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
                <a href="info.html"><img src="images/ad02.jpg"></a>
            </ul>
        </div>
        <div class="whitebg tongji">
            <h2 class="htitle">站点信息</h2>
            <ul>
                <li><b>建站时间</b>：2018-10-24</li>
                <li><b>网站程序</b>：帝国cms</li>
                <li><b>主题模板</b>：<a href="http://www.yangqq.com" target="_blank">《今夕何夕》</a></li>
                <li><b>文章统计</b>：299条</li>
                <li><b>文章评论</b>：490条</li>
                <li><b>统计数据</b>：<a href="info.html">百度统计</a></li>
            </ul>
        </div>
    </div>
</article>
<%--以下的这个div标签是点击提问题后弹出的层，用于问题的描述--%>
<div class="floatDiv"
     style="position: fixed;width: 100%;height:100%;top:0px;left:0px;border-radius: 5px;z-index: 10;display: none;">
    <%--这个用于底层的遮障层，保证了下面容器不透明--%>
    <div style="width: 100%;height: 100%;background-color: black;position:absolute;top:0;left:0;opacity: 0.6;">
    </div>
    <%--真正用于发布问题的容器--%>
    <div style="position:absolute;width:70%;height:610px;top:0px;left:0px;margin:2% 15%;background-color:white;border-radius:5px;z-index: 11;overflow-y: scroll;overflow-x: unset;overflow-style: unset">
        <input type="text" class="questionInput" placeholder="请输入问题的标题,一句话描述清楚问题,并以问号结尾"
               title="请输入问题的标题,一句话描述清楚问题,并以问号结尾"/>
        <span style="float:right;position: absolute;right:10px;top:10px;cursor: pointer" class="closeQuestionContainer">X</span>
        <div class="questionContent" style="width: 90%;margin:10px 5%;height:250px;border: 1px solid lightgrey">
            <%--这里就是editormd输入问题的部分--%>
        </div>
        <%--点击下面的标签后弹出隐藏的标签选择框，最多选三个，这个可以在首页展示，同时在问题首页可以根据标签设置分类--%>
        <span id="addSort"
              style="padding:2px 5px;width: max-content;display:block;font-size:15px;font-weight:bold;border: 1px solid lightgrey;height:30px;line-height: 30px;margin:20px auto 20px 5%;">+添加标签(最多三个)</span>
        <div style="float:left;margin:0px auto 10px 5%;width:90%;display:block;border-bottom: 1px solid lightgrey;padding-bottom:5px">
            <span class="sortResult">
            </span>
        </div>
        <%--复选框的容器--%>
        <div class="toggleCheckBox" style="display:block;width:90%;margin:10px auto 0px 5%;padding:10px 0px 0px 0px;">
            <span class="checkBoxGroup" style="display: none;">
                <%--isclick代表是否已经被点击过了,如果已被点击则不能重新添加此标签--%>
                <span class="checkbox" isclick="false" name="category" value="java" style="background-color: #07caec;">java</span>
                <span class="checkbox" isclick="false" name="category" value="c"
                      style="background-color: #FE4365;">c</span>
                <span class="checkbox" isclick="false" name="category" value="c++" style="background-color: #4fef0a;">c++</span>
                <span class="checkbox" isclick="false" name="category" value="math" style="background-color: #07caec;">math</span>
                <span class="checkbox" isclick="false" name="category" value="化学"
                      style="background-color: #FE4365;">化学</span>
                <span class="checkbox" isclick="false" name="category" value="js"
                      style="background-color: #4fef0a;">js</span>
                <span class="checkbox" isclick="false" name="category" value="html" style="background-color: #07caec;">html</span>
                <span class="checkbox" isclick="false" name="category" value="tomcat"
                      style="background-color: #FE4365;">tomcat</span>
                <span class="checkbox" isclick="false" name="category" value="spring"
                      style="background-color: #4fef0a;">spring</span>
                <span class="checkbox" isclick="false" name="category" value="maven" style="background-color: #07caec;">maven</span>
                <span class="checkbox" isclick="false" name="category" value="nodejs"
                      style="background-color: #FE4365;">nodejs</span>
                <span class="checkbox" isclick="false" name="category" value="sql" style="background-color: #4fef0a;">sql</span>
        </span>
        </div>

        <p style="margin:10px auto 10px 5%;height: 35px;line-height: 35px;font-size: 15px;border-top: 1px solid lightgrey;">
            选择提问方式</p>
        <div class="submitButtonGroup"
             style="width:90%;margin:20px auto;padding-top: 20px;border-top: 1px solid lightgrey;">
            <%--点击提交后就通过comm.js中的异步方法将内容提交--%>
            <span style="cursor:pointer;height: 35px;line-height: 35px;text-align:center;width: 70px;border-radius: 5px;background-color: red;border: 1px solid red;float: right;color:white;"
                  id="submitQuestion">提交</span>
            <span style="cursor:pointer;height: 35px;line-height: 35px;text-align:center;width: 70px;border-radius: 5px;background-color: white;border: 1px solid grey;float: right;color:black;margin-right: 20px;"
                  class="closeQuestionContainer">取消</span>
        </div>
    </div>
</div>

<link href="static/css/base.css" rel="stylesheet">
<link href="static/css/m.css" rel="stylesheet">
<script src="static/editormd/js/jquery.min.js"></script>
<script src="static/editormd/js/editormd.js"></script>
<script type="text/javascript">
    var testEditor;
    $(function () {
        testEditor = editormd("test-editormd0", {
            syncScrolling: "single",
            path: "static/editormd/lib/",
            //这个配置在simple.html中并没有，但是为了能够提交表单，使用这个配置可以让构造出来的HTML代码直接在第二个隐藏的textarea域中，方便post提交表单。
            saveHTMLToTextarea: true,
            /*关闭表情*/
            toolbarIcons: "mini",
            emoji: false,
            tocDropdown: true,//加载完成后 配置生成目录
            tableSize: 2,
            /*关闭toolbar*/
            /* toolbar:false,*/
            /*图片上传功能,支持的图片有如下几种*/
            imageUpload: true,
            imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
            imageUploadURL: "upLoadFile",
            onload: function () {
                this.width("100%");
                this.height("250");
            }
        });
    });
</script>


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