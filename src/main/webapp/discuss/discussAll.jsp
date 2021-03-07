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
            /*点击提问题之后的响应事件，先判断用户是否存在，如果不存在，跳转到登录界面*/
            /*你问我答区域点击问题提交时的响应事件*/
            $("#submitQuestion").click(function () {
                /*获取问题的标题*/
                var questionTitle = $(".questionInput").val();
                if (questionTitle == "" || (String)(questionTitle).trim() == "") {
                    alert("亲,提问先给出问题呀！");
                    return;
                }
                /*获取问题的内容,这里直接获取markdown格式的内容*/
                var questionContent = $("#editorhtml").val();
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
                $.ajax({
                    type: "post",
                    url: "addQuestion",
                    dataType: "text",
                    data: {
                        /*携带给后台的参数:问题标题、问题内容、用户id*/
                        questionTitle: questionTitle,
                        questionContent: questionContent,
                        userid:${user.pk_uid},
                        sort: sortsPut
                    },
                    success: function (result) {
                        if (result == '问题添加成功\r\n') {
                            alert("问题添加成功");
                            /*关闭弹出层*/
                            $(".floatDiv").hide();
                        } else {
                            alert("问题添加失败，请重新尝试");
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

<%--
阅读tomcat源码时，无论是初始化还是启动时为什么我都没有发现责任链下engine模块到host的链条？

在网页上搜索很多博客时，通过他们画出的时序图，我都发现这里应该是逐级链条式响应的，但是为什么我在阅读时却没有看到呢？
其实由engine到host时是通过事件触发的机制进行的，所以没有直观的感受。
--%>


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
<!--top end-->
<article>
    <!--lbox begin-->
    <div class="lbox">
        <!--最顶部的导航-->
        <div class="whitebg lanmu" style="padding:20px !important;"><img src="static/images/lm04.jpg">
            <h1 style="color:skyblue">你问我答</h1>
            <p style="color:red">在热烈的讨论中获取养料，在你问我答的循环之中共同成长...
                在我们逐渐成长的过程中，希望你不要随着age的增长忘记讨论，所以在此留下你的足迹，让我们一起伴你成长...</p>
        </div>
        <%--以下利用循环将所有的问题信息展示到页面上--%>
        <c:forEach items="${allQuestion}" var="message" varStatus="allQuestion">
            <div class="whitebg lanmu canopen"> <!-- <img src="images/lm04.jpg"> -->
                <div class="simpleDesc"><span>2回答</span> <span>10浏览</span> <span>0点赞</span></div>
                <p style="border-bottom:1px solid lightgrey;height:35px;line-height:35px;font-weight:bold;font-size:13px;overflow: hidden">
                    <span class="iconfont">&#xe629;</span><a
                        href="discussDetail?pkDaId=${message.pkDaId}">${message.title}</a></p>
                <div style="overflow: hidden;font-size:12px;height: 55px;" class="discussContentConta"><span
                        class="iconfont">&#xe693;</span><a>${message.discussContent}...</a></div>
                <span style="float:left;font-size: 15px;margin-top:5px;">
                <c:forEach items="${message.sortDetail}" var="sortmessage" varStatus="Detail">
                    <c:if test="${Detail.index==0}">
                        <a style="margin-right: 10px;background-color: #07caec;width:max-content;padding:2px 5px !important;color:white;border-radius: 3px;">${sortmessage}</a>
                    </c:if>
                    <c:if test="${Detail.index==1}">
                        <a style="margin-right: 10px;background-color: #FE4365;width:max-content;padding:2px 5px !important;color:white;border-radius: 3px;">${sortmessage}</a>
                    </c:if>
                    <c:if test="${Detail.index==2}">
                        <a style="margin-right: 10px;background-color: #4fef0a;width:max-content;padding:2px 5px !important;color:white;border-radius: 3px;">${sortmessage}</a>
                    </c:if>
                </c:forEach>
            </span>
                <span style="float:right;font-size:14px;margin-top:5px"><a
                        style="color:red;cursor: pointer">${message.username}</a>&nbsp&nbsp&nbsp${message.gmtCreate}</span>
            </div>
        </c:forEach>


        <!--bloglist end-->
    </div>
    <div class="rbox" style="margin:20px 0;">
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