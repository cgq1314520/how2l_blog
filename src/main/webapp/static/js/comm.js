$(document).ready(function () {
    /*点击发送验证码后给用户发送验证码，点击后禁用60s才能重发*/
    $(".sendVer").click(function () {
        /*获取邮箱账号*/
        var userAccount = $(".userAccount").val();
        if (userAccount == "" || userAccount == null) {
            alert("请先输入您的邮箱账号");
        } else {
            $.ajax({
                type: "post",
                url: "mailServlet",
                data: {
                    /*发送方的邮箱账号*/
                    userAccount: userAccount
                },
                success: function (result) {
                    alert(result);
                    /*标签的禁用事件，当前的点击获取验证码的标签被禁用60s*/
                    var countdown = 60;

                    function settime() {
                        if (countdown == 1) {
                            $('.sendVer').css("pointer-events", "auto");
                            $('.sendVer').css("color", "skyblue");
                            $('.sendVer').html("获取验证码");
                            countdown = 60;
                        } else {
                            $('.sendVer').css("pointer-events", "none");
                            $('.sendVer').css("color", "grey");
                            $('.sendVer').html("(" + countdown + "s)");
                            countdown--;
                        }
                    }

                    for (var i = 0; i < 60; i++) {
                        function begin() {
                            setTimeout(function () {
                                settime()
                            }, 1000 * i)
                        }

                        begin();
                    }

                }
            })
        }

    })
    /*你问我答区域的提问题按钮的点击响应事件*/
    $("#openQuestion").click(function () {
        $(".floatDiv").show();
        /*同时动态加载js及css文件,从而让editormd显示正常*/
        $('.questionContent').html("            <div id=\"layout\" style=\"margin-top:0px;\">\n" +
            "\n" +
            "                <div id=\"test-editormd\" class=\"editormd editormd-vertical editormd-theme-dark\">\n" +
            "                    <textarea style=\"display:none;\" class=\"form-control\" id=\"editormd\" name=\"editormd\"></textarea>\n" +
            "                    <!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->\n" +
            "                    <!-- html textarea 需要开启配置项 saveHTMLToTextarea == true -->\n" +
            "                    <textarea class=\"editormd-html-textarea\" name=\"editorhtml\" id=\"editorhtml\"></textarea>\n" +
            "                </div>\n" +
            "            </div>\n" +
            "        <link rel=\"stylesheet\" href=\"static/editormd/css/style.css\" />\n" +
            "        <link rel=\"stylesheet\" href=\"static/editormd/css/editormd.css\" />\n" +
            "        <script src=\"static/editormd/js/jquery.min.js\"></script>\n" +
            "        <script src=\"static/editormd/js/editormd.js\"></script>\n" +
            "        <script type=\"text/javascript\">\n" +
            "            var testEditor;\n" +
            "            $(function() {\n" +
            "                testEditor = editormd(\"test-editormd\", {\n" +
            "                    syncScrolling : \"single\",\n" +
            "                    path    : \"static/editormd/lib/\",\n" +
            "                    tex: true,                   // 开启科学公式TeX语言支持，默认关闭\n" +
            "                    flowChart: true,             // 开启流程图支持，默认关闭\n" +
            "                    sequenceDiagram: true,       // 开启时序/序列图支持，默认关闭,\n" +
            "                    //这个配置在simple.html中并没有，但是为了能够提交表单，使用这个配置可以让构造出来的HTML代码直接在第二个隐藏的textarea域中，方便post提交表单。\n" +
            "                    saveHTMLToTextarea : true,\n" +
            "                    /*关闭表情*/\n" +
            "                    emoji:false,\n" +
            "                    tocDropdown:true,//加载完成后 配置生成目录\n" +
            "                    /*关闭toolbar*/\n" +
            "                    /* toolbar:false,*/\n" +
            "                    toolbarIcons:\"mini\",\n" +
            "                    /*图片上传功能,支持的图片有如下几种*/\n" +
            "                    imageUpload : true,\n" +
            "                    placeholder:\"请输入您的问题?\",\n" +
            "                    imageFormats : [ \"jpg\", \"jpeg\", \"gif\", \"png\", \"bmp\", \"webp\" ],\n" +
            "                    imageUploadURL : \"upLoadFile\",\n" +
            "                    onload: function () {\n" +
            "                        this.width(\"100%\");\n" +
            "                        this.height(\"250px\");\n" +
            "                    }\n" +
            "                });\n" +
            "            });\n" +
            "        </script>");
    });
    $(".floatDiv").on('click', '.closeQuestionContainer', function () {
        $(".floatDiv").hide();
        $('.questionContent').html("");
    });

    /*你问我答区点击删除标签时的响应*/
    $(".sortResult").on('click', '.sorticon', function () {
        /*首先获取当前删除标签的前一个兄弟结点，选中后用于删除该结点(同时设置对应的标签的isclick为false)，同时删除自己*/
        var pre = $(this).prev();
        var val = pre.attr('value');
        /*第一步：删除后，恢复对应在标签选择里面标签的isclick值为false，让可以重新点击*/
        $("span[value=" + val + "]").attr('isclick', 'false');
        /*第二步：删除当前已选择的该标签元素以及删除标志的元素*/
        pre.remove();
        $(this).remove();
    });
    /*你问我答区域点击分类标签时的响应事件*/
    $(".checkbox").click(function (event) {
        /*当该标签点击后，设置点击标志为true，代表不能再次被点击,当没有点击时才能被再次点击*/
        if ($(this).attr('isclick') == 'false') {
            if ($(".sortResult").children().length < 6) {
                var value = $(this).attr('value');
                var style = $(this).attr('style');
                $(".sortResult").append("<span value='" + value + "' style='" + style + "margin-right:10px;' class='sortAnswer'>" + value + "</span><span class='iconfont sorticon' style=\"color:grey;font-size:10px;width:10px;margin-left:-25px;transform:translateY(-18px);\">&#xe6b0;</span>");
                /*设置状态为已经点击*/
                $(this).attr('isclick', 'true');
            } else {
                alert("最多只能有三个标签")
            }
        } else {
            alert("标签不能重复呀");
        }
    });
    /*你问我答区域点击添加标签后的事件*/
    $("#addSort").click(function () {
        $(".checkBoxGroup").toggle();
    })
    /*初始时搜索下的栏目是隐藏的*/
    $("#searchItem").hide();
    /*当窗口大小发生变化时，触发该事件*/
    window.onresize = function () {
        /*当窗口为全屏时，触发此个*/
        if ($(window).width() > 1024) {
            $("#starlist").show()
            $("#mnavh").removeClass("open");
            $("#mnavh").toggleClass("close");
        } else {
            if ($("#mnavh").hasClass("close")) {
                $("#mnavh").removeClass("close");

                $("#starlist").hide()
            }

        }

    }

    //nav 通过以下的函数来设置实现了导航栏中点击后背景色的设置
    var obj = null;
    var As = document.getElementById('starlist').getElementsByTagName('a');
    obj = As[0];
    for (i = 1; i < As.length; i++) {
        if (window.location.href.indexOf(As[i].href) >= 0) obj = As[i];
    }
    obj.id = 'selected';
    //当点击mnavh所在的标签时，将导航栏中的列表进行展示，并将其class切换为open
    $("#mnavh").click(function () {
        $("#starlist").toggle();
        $("#mnavh").toggleClass("open");
    });
    //search 有关搜索框显示与否的js实现，通过添加或者一处class属性来设置
    $(".searchico").click(function () {
        $(".search").toggleClass("open");
    });
    //searchclose
    $(".searchclose").click(function () {
        $(".search").removeClass("open");
    });
    //图片轮播js,直接调用现成的jquery函数
    /* $('#banner').easyFader();*/


    //tab点击时为什么会跳动的原因在这儿，因为在这儿动态设置了每一个newstab中每一个标签的隐藏和显示,也即四个标签的选择效果
    /*先通过对标签的点击获得点击事件，通过点击事件获取当前点击的对象；siblings函数为选取兄弟节点，*/
    $('.tab_buttons li').click(function () {
        /*获取到点击的对象后便给这个点击的对象添加class属性为newscurrent，这样这个标签就可以通过
        base.css的内容显示了，然后通过后面的函数移除同级兄弟节点的class属性，所以兄弟节点的布局就失效了，变为不加粗了而自己就变粗了*/
        $(this).addClass('newscurrent').siblings().removeClass('newscurrent');

        /*同理，通过获取对标题的点击索引，我们将具体显示栏目中的其他内容都通过sibings函数获得并通过hide给隐藏，而将对应索引页面的给显示出来(show)*/
        $('.newstab>div:eq(' + $(this).index() + ')').show().siblings().hide();
    });

    /*a链接到顶部的滑动效果,调到距离顶部为0的地方，在1000ms内完成跳转*/
    $("#jump").click(function () {
        $("html, body").animate({scrollTop: 0}, 800);
        return false;
    });

    /*动态获取搜索框中的数据。并从数据库中查询标题或者概述like输入内容的博客，并返回他们的标题，给予选择*/
    $("#keyboard").on("input", function () {
        //获取输入的数值
        var content = $("#keyboard").val();
        if (content == "") {
            $("#searchItem").html("");
        } else {
            //通过输入的值进行查询展示
            $.ajax({
                type: "post",
                url: "searchShow",
                dataType: "json",
                data: {
                    /*待查询的内容,后台查询时从三个方面进行查询：用户昵称,文章标题,文章概述（后面有视频时还可以通过视频标题等进行判断）*/
                    searchContent: content
                },
                success: function (result) {
                    let htmlContext = "";
                    /*利用result的内容动态生成html内容进行展示*/
                    for (let i = 0; i < result.length; i++) {
                        /*相似的用户昵称信息*/
                        if (i == 0) {
                            for (let j = 0; j < result[i].length; j++) {
                                htmlContext += "<li><a href='personInfoShow?userUid=" + result[i][j].pk_uid + "'" + ">" + result[i][j].username + "<span class='iconfont' style='color: red;float:right'>&#xe603;</span></a></li>";
                            }
                        }
                        /*相似的博客标题信息搜索展示*/
                        if (i == 1) {
                            for (let j = 0; j < result[i].length; j++) {
                                htmlContext += "<li>" +
                                    "<a href=\"info?" +
                                    "pkBid=" + result[i][j].pkBid +
                                    "&gmtCreate=" + result[i][j].gmtCreate +
                                    "&authorName=" + result[i][j].authorName +
                                    "&views=" + result[i][j].views +
                                    "&describe=" + result[i][j].describe +
                                    "&title=" + result[i][j].title +
                                    "&avatar=" + result[i][j].authorAvator +
                                    "\">" + result[i][j].title + "<span class='iconfont' style='float: right;color:blue;font-size: 18px'>&#xe600;</span></a></li>";
                            }
                        }
                        /*相似的博客概述信息搜索展示*/
                        if (i == 2) {
                            for (let j = 0; j < result[i].length; j++) {
                                htmlContext += "<li>" +
                                    "<a href=\"info?" +
                                    "pkBid=" + result[i][j].pkBid +
                                    "&gmtCreate=" + result[i][j].gmtCreate +
                                    "&authorName=" + result[i][j].authorName +
                                    "&views=" + result[i][j].views +
                                    "&describe=" + result[i][j].describe +
                                    "&title=" + result[i][j].title +
                                    "&avatar=" + result[i][j].authorAvator +
                                    "\" title='" + result[i][j].describe + "'>" + ((String)(result[i][j].describe)).substring(0, 10) + "...<span class='iconfont' style='float: right;color:blue;font-size: 18px'>&#xe600;</span></a></li>";
                            }
                        }
                        /*i==3和i==4分别是通过关键字和标题的对比以及关键字和概述的对比进行搜索内容的查询*/
                        if (i == 3) {
                            for (let j = 0; j < result[i].length; j++) {
                                htmlContext += "<li>" +
                                    "<a href=\"info?" +
                                    "pkBid=" + result[i][j].pkBid +
                                    "&gmtCreate=" + result[i][j].gmtCreate +
                                    "&authorName=" + result[i][j].authorName +
                                    "&views=" + result[i][j].views +
                                    /* "&describe="+result[i][j].describe+*/
                                    /* "&title="+result[i][j].title+*/
                                    "&avatar=" + result[i][j].authorAvator +
                                    "\">" + result[i][j].title + "<span class='iconfont' style='float: right;color:blue;font-size: 18px'>&#xe600;</span></a></li>";
                            }
                        }
                        /*i==4时是通过对比概述和搜索内容中的关键字进行对比进而得到查询结果的*/
                        if (i == 4) {
                            for (let j = 0; j < result[i].length; j++) {
                                htmlContext += "<li>" +
                                    "<a href=\"info?" +
                                    "pkBid=" + result[i][j].pkBid +
                                    "&gmtCreate=" + result[i][j].gmtCreate +
                                    "&authorName=" + result[i][j].authorName +
                                    "&views=" + result[i][j].views +
                                    /* "&describe="+result[i][j].describe+*/
                                    /*"&title="+result[i][j].title+*/
                                    "&avatar=" + result[i][j].authorAvator +
                                    "\" title='" + result[i][j].describe + "'>" + ((String)(result[i][j].describe)).substring(0, 15) + "...<span class='iconfont' style='float: right;color:blue;font-size: 18px'>&#xe600;</span></a></li>";
                            }
                        }
                    }
                    /*  console.log(htmlContext)*/
                    /*将查询内容展示到下面的查询结果列表中去*/
                    $("#searchItem").html(htmlContext);
                }
            })
        }

    });
    var flag = false;
    /*当鼠标指向searchItem上时，flag标志为true*/
    $("#searchItem").mouseenter(function () {
        flag = true;
    })
    $("#searchItem").mouseleave(function () {
        flag = false;
    })
    /*当搜索框聚焦时打开下面的条目进行展示*/
    $("#keyboard").on("focus", function () {
        //让异步请求得到的数据按条目进行展示
        $("#searchItem").show();
    });
    /*搜索栏没有聚焦时,先判断鼠标是否指向ul即searchItem上，如果指向了，则不用隐藏，否则隐藏searchItem*/
    $("#keyboard").on("blur", function () {
        if (flag == true) {
            $("#searchItem").show();
        } else {
            $("#searchItem").hide();
        }
    })

});



