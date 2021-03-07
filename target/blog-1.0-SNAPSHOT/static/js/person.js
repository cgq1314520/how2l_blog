$(document).ready(function () {
    var userid1 = $("#useridHidden").val();
    var htmlContext = "";
    /*个人中心界面的详细信息展示的异步请求,博客的信息直接通过indedata(和首页的请求方式一样得到)*/
    $.ajax({
        type: "post",
        url: "getAllArticleWithUserID",
        dataType: "json",
        data: {
            /*待查询的内容,后台查询时从三个方面进行查询：用户昵称,文章标题,文章概述（后面有视频时还可以通过视频标题等进行判断）*/
            userid: userid1
        },
        success: function (result) {
            if (result.length > 0) {
                /*将查询内容展示到博客的信息列表中去*/
                for (let i = 0; i < result.length; i++) {
                    htmlContext += "<li>";
                    htmlContext += "<p><a href='info?pkBid=" + result[i].pkBid + "' target='_blank' style='font-size:16px;font-weight:bold;padding-left:10px;'>【博客】" + result[i].title + "</a></p>";
                    htmlContext += "<p style='padding-left:20px;color:grey;font-size:14px;'>" + result[i].describe + "... </p>"
                    htmlContext += "<p style=\"padding-left:20px;color:grey;font-size:13px;line-height:28px;\"><span style='display:inline-block;'>" + result[i].gmtCreate + "</span>";
                    if (result[i].isOriginal == 1) {
                        htmlContext += "<span class='iconfont' style='color: #00c4ff;margin-left:18px;line-height:18px;display:inline-block;'>&#xe68b;</span>";
                    } else {
                        htmlContext += "<span class='iconfont' style='color: #d81e06;margin-left:18px;line-height:18px;display:inline-block;'>&#xe636;</span>";
                    }
                    htmlContext += "<span class='iconfont' style='color: darkgray ;padding-right:5px;'>&#xe625;</span><span style=\"line-height: 28px;display:inline-block;\">" + result[i].views + "</span>"
                    htmlContext += "<span style='float: right;padding-right: 25px;'><span style='color:deepskyblue;cursor:pointer;padding-right: 15px;' class='ReEdit' value='" + result[i].pkBid + "'>重新编辑</span><span style='color:deepskyblue;cursor:pointer;padding-right:15px;' class='del' value='" + result[i].pkBid + "'>删除</span></span></p>"
                    htmlContext += "</li>";
                }
                $(".SortContentShow .blogShow").html(htmlContext);

                /*接下来进行对最近文章的展示，这里通过js的排序函数对数据按照创建时间进行排序*/
                result.sort(function (a, b) {
                    /*替换掉所有的-，最后转为数字*/
                    a = parseInt((String)(a.gmtCreate).replace(/-/g, ''));
                    b = parseInt((String)(b.gmtCreate).replace(/-/g, ''));
                    return a - b;
                });
                //开始将数据展示到最近博客处
                var html1 = "";
                for (let i = 0; i < result.length; i++) {
                    if (i == 3) {
                        break;
                    }
                    html1 += "<li>";
                    html1 += "<a href='info?pkBid=" + result[i].pkBid + "' style=\"color: black;font-size: 15px;\">" + result[i].title + "</a>";
                    html1 += "<a href='info?pkBid=" + result[i].pkBid + "' style='color:grey;font-size:14px;'>浏览量" + result[i].views + "&nbsp&nbsp&nbsp&nbsp" + result[i].gmtCreate + "</a>";
                    html1 += "</li>";
                }
                $(".blogNear ul").html(html1);

                /*接下来对文章根据文章的访问量进行排序，从而构造自己的热门文章*/
                var html2 = "";
                result.sort(function (a, b) {
                    return b.views - a.views;
                });
                //开始将数据展示到热门博客处
                for (let i = 0; i < result.length; i++) {
                    if (i == 3) {
                        break;
                    }
                    html2 += "<li>";
                    html2 += "<a href='info?pkBid=" + result[i].pkBid + "' style=\"color: black;font-size: 15px;\">" + result[i].title + "</a>";
                    html2 += "<a href='info?pkBid=" + result[i].pkBid + "' style='color:grey;font-size:14px;'>浏览量" + result[i].views + "&nbsp&nbsp&nbsp&nbsp" + result[i].gmtCreate + "</a>";
                    html2 += "</li>";
                }
                $(".personViews ul").html(html2);
            }
        }
    });
    /*根据用户id来查询该用户的所有问题*/
    $.ajax({
        type: "post",
        url: "GetAllquestionByUserID",
        dataType: "json",
        data: {
            /*待查询的内容,后台查询时从三个方面进行查询：用户昵称,文章标题,文章概述（后面有视频时还可以通过视频标题等进行判断）*/
            userid: userid1
        },
        success: function (result) {
            var htmlContext = "";
            if (result.length > 0) {
                /*将查询内容展示到博客的信息列表中去*/
                for (let i = 0; i < result.length; i++) {
                    console.log(result[i].sortDetail);
                    htmlContext += "<li>";
                    htmlContext += " <p style=\"border-bottom:1px solid lightgrey;height:28px;line-height:28px;font-weight:bold;font-size:13px;overflow: hidden\"><span class=\"iconfont\" style='line-height:28px;height:28px;' >&#xe629;</span><a style='line-height:28px;height:28px;' href=\"discussDetail?pkDaId=" + result[i].pkDaId + "\">" + result[i].title + "</a></p>"
                    htmlContext += "<div style=\"overflow: hidden;font-size:12px;height: 35px;padding:0px 5px;\" class=\"discussContentConta\"><span class=\"iconfont\" style=\"float:left;\">&#xe693;</span><a style='display:inline-block;height:28px;'>" + result[i].discussContent + "...</a></div>";
                    htmlContext += "<span style=\"float:left;font-size: 13px;padding-left: 16px;\">";
                    for (let j = 0; j < result[i].sortDetail.length; j++) {
                        if (j == 0) htmlContext += "<a style=\"margin-right: 10px;background-color: #07caec;width:max-content;padding:2px 5px !important;color:white;border-radius: 3px;\">" + result[i].sortDetail[j] + "</a>";
                        if (j == 1) htmlContext += "<a style=\"margin-right: 10px;background-color: #FE4365;width:max-content;padding:2px 5px !important;color:white;border-radius: 3px;\">" + result[i].sortDetail[j] + "</a>";
                        if (j == 2) htmlContext += "<a style=\"margin-right: 10px;background-color: #4fef0a;width:max-content;padding:2px 5px !important;color:white;border-radius: 3px;\">" + result[i].sortDetail[j] + "</a>";
                    }
                    htmlContext += " </span>";
                    htmlContext += "<span style=\"float:right;font-size:14px;padding-right: 15px;\"><a style=\"color:skyblue;cursor: pointer\">删除</a>&nbsp&nbsp&nbsp" + result[i].gmtCreate + "</span>";
                    htmlContext += "</li>";
                }
                $(".SortContentShow .discussShow").html(htmlContext);
            }
        }
    });

    /*根据该用户的id来查询当前用户发布的所有视频*/
    $.ajax({
        type: "post",
        url: "GetAllVideoByUserID",
        dataType: "json",
        data: {
            /*待查询的内容,后台查询时从三个方面进行查询：用户昵称,文章标题,文章概述（后面有视频时还可以通过视频标题等进行判断）*/
            userid: userid1
        },
        success: function (result) {
            var htmlContext = "";
            if (result.length > 0) {
                /*将查询内容展示到博客的信息列表中去*/
                for (let i = 0; i < result.length; i++) {
                    htmlContext += "<li style=\"width:40%;float:left;padding:10px;\">";
                    htmlContext += "<i class=\"videoUpImg\" style='height:94px;display:block;width:180px;float:left;'>";
                    htmlContext += " <a href=\"videoDetail?dbID=" + result[i].dbId + "\" target=\"_blank\" style=\"height:94px;display:block;\">";
                    htmlContext += "<img src='" + result[i].videoBackUrl + "'style=\"height:94px;width:180px;\">";
                    htmlContext += " </a></i>";
                    htmlContext += "<span style=\"color:black;line-height:45px;height:45px;padding-left:13px;font-size:15px;font-weight:bold;cursor:pointer\">" + result[i].title + "</span>";
                    htmlContext += "<span style=\"color:grey;line-height:45px;padding-left:13px;font-size:14px;cursor:pointer\">" + result[i].gmtCreate + "&nbsp&nbsp</span>";
                    htmlContext += "</li>"
                }
                $(".SortContentShow .videoShow").html(htmlContext);
            }
        }
    });
    /*6个顶部资源的点击事件*/
    $(".personInfoShow").click(function () {
        /*获取点击元素的id属性*/
        var showName = '.' + $(this).attr('id') + 'Show';
        /*选中class为showName的元素，并让其的display为block,它的兄弟元素都设置为none*/
        $(showName).attr('style', 'display:block !important;')
        $(showName).siblings().attr('style', 'display:none !important');
    });

    /*内容管理之通过点击删除或者编辑进行对博客的编辑*/
    $(".SortContentShow").on('click', '.ReEdit', function () {
        alert("点击了重新编辑，可以通过写博客的页面进行改动" + $(this).attr('value'));
    })
    $(".SortContentShow").on('click', '.del', function () {
        alert("点击了删除，在删除时通过邮箱验证码进行删除" + $(this).attr('value'))
    })

});