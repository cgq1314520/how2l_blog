<%@page language="java" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-cn">
<head>
    <%--
        <meta charset="utf-8" />
    --%>
    <title>博客发布</title>
    <link href="static/css/base.css" rel="stylesheet">
    <link href="static/css/m.css" rel="stylesheet">
    <script src="static/js/jquery-1.8.3.min.js"></script>
    <script src="static/editormd/js/jquery.min.js"></script>
    <script src="static/editormd/js/editormd.js"></script>
    <script src="static/js/comm.js"></script>
    <link rel="stylesheet" href="static/editormd/css/style.css"/>
    <link rel="stylesheet" href="static/editormd/css/editormd.css"/>
    <style>
        input {
            height: 35px;
            line-height: 35px;
            margin: 20px auto;
            color: black;
            border: 1px solid grey;
            border-radius: 8px;
            padding-left: 5px;
            width: 90%;
        }

        input:focus {
            outline: none;
            border: 2px solid skyblue;
        }

        input:-webkit-autofill {
            box-shadow: 0 0 0px 1000px white inset !important;
        }

        .personinfo {
            position: relative;
            width: max-content;
            line-height: 50px;
            height: 50px;
        }

        .personinfo i {
            position: absolute;
            right: 30px;
            top: 15px;
            z-index: 9999;
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

<div style="width: 100%;height:95%;position: absolute;top:60px;left:0px;">
    <div id="publishCont">
        <input type="text" name="title" required placeholder="请输入文章标题" title="请输入文章标题" id="publishtitle"/>
        <input type="text" name="coredesc" required placeholder="请输入文章核心概述" title="请输入文章核心概述" id="publishdescribe"/>
        <input type="text" name="keywords" required placeholder="请输入标题或概述中的关键字(最多3个,逗号分割)" title="请输入标题或概述中的关键字"
               id="publishKey"/>
        <select id="publishsort">
            <option value="other">请选择文章分类</option>
            <option value="java">java</option>
            <option value="css">css</option>
            <option value="c++">c++</option>
            <option value="c">c</option>
        </select>
        <button type="submit" id="publishsubmitBtn">发布</button>
    </div>
    <div id="layout" style="margin-top:0px;">

        <div id="test-editormd" class="editormd editormd-vertical editormd-theme-dark">
            <textarea style="display:none;" class="form-control" id="editormd" name="editormd"></textarea>
            <!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
            <!-- html textarea 需要开启配置项 saveHTMLToTextarea == true -->
            <textarea class="editormd-html-textarea" name="editorhtml" id="editorhtml"></textarea>
        </div>
    </div>

</div>

<script src="static/editormd/js/jquery.min.js"></script>
<script src="static/editormd/js/editormd.js"></script>
<script type="text/javascript">
    var testEditor;
    $(function () {
        testEditor = editormd("test-editormd", {
            syncScrolling: "single",
            path: "static/editormd/lib/",
            theme: "3024-day",//主题 夜间模式
            /*previewTheme : "dark",*/ //主题 夜间模式
            editorTheme: "pastel-on-dark",//主题 夜间模式
            tex: true,                   // 开启科学公式TeX语言支持，默认关闭
            flowChart: true,             // 开启流程图支持，默认关闭
            sequenceDiagram: true,       // 开启时序/序列图支持，默认关闭,
            //这个配置在simple.html中并没有，但是为了能够提交表单，使用这个配置可以让构造出来的HTML代码直接在第二个隐藏的textarea域中，方便post提交表单。
            saveHTMLToTextarea: true,
            /*关闭表情*/
            emoji: false,
            tocDropdown: true,//加载完成后 配置生成目录
            /*关闭toolbar*/
            /* toolbar:false,*/
            /*图片上传功能,支持的图片有如下几种*/
            imageUpload: true,
            imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
            imageUploadURL: "upLoadFile",
            onload: function () {
                this.width("100%");
                this.height("85%");
            }
        });
        /*markdown中的文件提交，通过提交html的方式来进行接受，并用submit来接受请求*/
        $("#publishsubmitBtn").click(
            function () {
                submitblog();
            }
        )
        /*通过以下的方式将要传递的内容通过post的方式来上传到后台中去*/

        /*同时还是通过异步进行处理的，这样可以使得响应更加快捷*/
        function submitblog() {
            /*获取文章标题*/
            const title = $("#publishtitle").val();
            /*获取文章概述*/
            const describe = $("#publishdescribe").val();
            /*获取文章具体markdown格式的内容*/
            const Content = $("#editormd").val();
            /*获取文章具体markdown格式的关键字*/
            const keywords = $("#publishKey").val();
            /*获取文章的类别*/
            const sort = $("#publishsort").find("option:selected").val();
            $.ajax({
                type: "post",
                url: "FileSubmit",
                datetype: "text",
                data: {
                    title: title,
                    describe: describe,
                    Content: Content,
                    sort: sort,
                    keywords: keywords,
                    userid:${user.pk_uid}
                },
                success: function (result) {
                    alert(result);
                },
                error: function () {
                    alert("发布失败");
                }
            })
        }
    });
</script>
</body>
</html>
