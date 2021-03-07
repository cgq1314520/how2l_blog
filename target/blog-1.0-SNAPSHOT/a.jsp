<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <title>博客来了</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="static/css/base.css" rel="stylesheet">
    <link href="static/css/m.css" rel="stylesheet">
    <script src="static/js/jquery-1.8.3.min.js"></script>
    <script src="static/js/comm.js"></script>
    <!--[if lt IE 9]>
    <script src="static/js/modernizr.js"></script>
    <![endif]-->
</head>
<body>
<!--top begin-->
<header id="header">
    <div class="navbox">
        <h2 id="mnavh"><span class="navicon"></span></h2>
        <div class="logo"><a href="index.html">博客来了</a></div>
        <nav>
            <ul id="starlist">
                <li><a href="index.html">首页</a></li>
                <li><a href="list.html">个人博客日记</a></li>
                <li class="menu"><a href="list2.html">博客网站制作</a>
                    <ul class="sub">
                        <li><a href="#">推荐工具</a></li>
                        <li><a href="#">JS经典实例</a></li>
                        <li><a href="#">网站建设</a></li>
                        <li><a href="#">CSS3|Html5</a></li>
                        <li><a href="#">心得笔记</a></li>
                    </ul>
                    <span></span></li>
                <li><a href="list3.html">网页设计心得</a></li>
                <li><a href="daohang.html"><%=session.getAttribute("a")%>
                </a></li>
                <li><a href="about.html"><%=request.getAttribute("name")%>
                </a></li>
            </ul>
        </nav>
        <div class="searchico"></div>
    </div>
</header>
<div class="searchbox">
    <div class="search">
        <form action="/e/search/index.php" method="post" name="searchform" id="searchform">
            <input name="keyboard" id="keyboard" class="input_text" value="请输入关键字词" style="color: rgb(153, 153, 153);"
                   onFocus="if(value=='请输入关键字词'){this.style.color='#000';value=''}"
                   onBlur="if(value==''){this.style.color='#999';value='请输入关键字词'}" type="text">
            <input name="show" value="title" type="hidden">
            <input name="tempid" value="1" type="hidden">
            <input name="tbname" value="news" type="hidden">
            <input name="Submit" class="input_submit" value="搜索" type="submit">
        </form>
    </div>
    <div class="searchclose"></div>
</div>
<!--top end-->
<article>
    <!--lbox begin-->
    <div class="lbox">
        <!--一个滑动图片窗口-->
        <div class="banbox">
            <div class="banner">
                <div id="banner" class="fader">
                    <li class="slide"><a href="/" target="_blank"><img src="static/images/1.jpg"></a></li>
                    <li class="slide"><a href="/" target="_blank"><img src="static/images/2.jpg"></a></li>
                    <li class="slide"><a href="/" target="_blank"><img src="static/images/3.jpg"></a></li>
                    <li class="slide"><a href="/" target="_blank"><img src="static/images/4.jpg"></a></li>
                    <div class="fader_controls">
                        <div class="page prev" data-target="prev"></div>
                        <div class="page next" data-target="next"></div>
                        <ul class="pager_list">
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!--banbox end-->

        <!--headline begin
        <div class="headline">
          <ul>
            <li><a href="/" title="为什么说10月24日是程序员的节日？"><img src=static/mages/h1.jpg" alt="为什么说10月24日是程序员的节日？"><span>为什么说10月24日是程序员的节日？</span></a></li>
            <li><a href="/" title="个人网站做好了，百度不收录怎么办？来，看看他们怎么做的"><img src=static/mages/h2.jpg" alt="个人网站做好了，百度不收录怎么办？来，看看他们怎么做的。"><span>个人网站做好了，百度不收录怎么办？来，看看他们怎么做的。</span></a></li>
          </ul>
        </div>-->
        <!--headline end-->
        <div class="clearblank"></div>
        <div class="tab_box whitebg">
            <div class="tab_buttons">
                <ul>
                    <li class="newscurrent">站主博客</li>
                    <li>java技术</li>
                    <li>博客开发历程</li>
                    <li>推荐博主</li>
                </ul>
            </div>

            <div class="newstab">
                <!--这个标签的显示对应着上面tab_buttons中第一个li节点的点击事件，通过comm.js中的函数动态变化-->
                <div class="newsitem">
                    <div class="newspic">
                        <!--先显示左边的两个图片(为了好看☺)-->
                        <ul>
                            <li><a href="info.html"><img src="static/images/2.jpg"><span>站主的博客，属于我的小世界！</span></a></li>
                            <li><a href="info.html"><img src="static/images/4.jpg"><span>站住啊？别走☺</span></a></li>
                        </ul>
                    </div>
                    <!--然后显示具体的内容-->
                    <ul class="newslist">
                        <li><i></i><a href="info.html">站主的博客，属于我的小世界！</a>
                            <p>
                                个人博客，用来做什么？我刚开始就把它当做一个我吐槽心情的地方，也就相当于一个网络记事本，写上一些关于自己生活工作中的小情小事，也会放上一些照片，音乐。每天工作回家后就能访问自己的网站，一边听着音乐，一边写写文章。</p>
                        </li>

                        <li><i></i><a href="info.html">努力的做一个有技术的编程者</a>
                            <p>自从入了这行，很多人跟我说可以做网络教程，我也有考虑，但最终没有实现，因为我觉得在这个教程泛滥的时代，直接做一套免费的原创个人博客模板更为实在。</p>
                        </li>

                        <li><i></i><a href="info.html">我是怎么评价自己的？</a>
                            <p>
                                为了挨打轻一些，问我哪里来的，我瞎说了一个说那个谁家的，结果，打得更凶。最后事情还原了真相，我妈说，你要说说奶奶家的，都不会打你了。从此以后，我知道撒谎是会付出更惨痛的代价的，我不再撒谎，也不喜欢爱撒谎的人。</p>
                        </li>

                        <li><i></i><a href="info.html">个人网站做好了，怎么让它看起来更加优秀？</a>
                            <p>不管你是学前端的还是后端的，作为一个程序员，做一个自己的博客，那是必然的。咱们的圈子就这么大，想让更多的人了解你，看看你的技术多牛逼，扔一个博客地址就行了</p>
                        </li>

                        <li><i></i><a href="info.html">做个人博客如何用帝国cms美化留言增加头像选择</a>
                            <p>帝国cms的留言板系统很简单，用户名，邮箱，电话，没有头像显示，如果要增加头像选择，而又不增加表或者字段的情况下，选择改用其中一个字段，比如电话这个，修改一下即可</p>
                        </li>

                    </ul>
                </div>
                <!--这个标签的显示对应着上面tab_buttons中第二个li节点的点击事件，通过comm.js中的函数动态变化-->
                <div class="newsitem">
                    <div class="newspic">
                        <ul>
                            <li><a href="info.html"><img src="static/images/3.jpg"><span>java技术，怎么提高更好呢！</span></a></li>
                            <li><a href="info.html"><img
                                    src="static/images/1.jpg"><span>个人网站做好了，百度不收录怎么办？来，看看他们怎么做的</span></a></li>
                        </ul>
                    </div>
                    <ul class="newslist">
                        <li><i></i><a href="info.html">安静地做一个爱设计的女子</a>
                            <p>自从入了这行，很多人跟我说可以做网络教程，我也有考虑，但最终没有实现，因为我觉得在这个教程泛滥的时代，直接做一套免费的原创个人博客模板更为实在。</p>
                        </li>
                        <li><i></i><a href="info.html">我是怎么评价自己的？</a>
                            <p>
                                为了挨打轻一些，问我哪里来的，我瞎说了一个说那个谁家的，结果，打得更凶。最后事情还原了真相，我妈说，你要说说奶奶家的，都不会打你了。从此以后，我知道撒谎是会付出更惨痛的代价的，我不再撒谎，也不喜欢爱撒谎的人。</p>
                        </li>
                        <li><i></i><a href="info.html">个人博客，属于我的小世界！</a>
                            <p>
                                个人博客，用来做什么？我刚开始就把它当做一个我吐槽心情的地方，也就相当于一个网络记事本，写上一些关于自己生活工作中的小情小事，也会放上一些照片，音乐。每天工作回家后就能访问自己的网站，一边听着音乐，一边写写文章。</p>
                        </li>
                        <li><i></i><a href="info.html">个人网站做好了，百度不收录怎么办？来，看看他们怎么做的。</a>
                            <p>不管你是学前端的还是后端的，作为一个程序员，做一个自己的博客，那是必然的。咱们的圈子就这么大，想让更多的人了解你，看看你的技术多牛逼，扔一个博客地址就行了</p>
                        </li>
                        <li><i></i><a href="info.html">做个人博客如何用帝国cms美化留言增加头像选择</a>
                            <p>帝国cms的留言板系统很简单，用户名，邮箱，电话，没有头像显示，如果要增加头像选择，而又不增加表或者字段的情况下，选择改用其中一个字段，比如电话这个，修改一下即可</p>
                        </li>
                    </ul>
                </div>
                <!--这个标签的显示对应着上面tab_buttons中第三个li节点的点击事件，通过comm.js中的函数动态变化-->
                <div class="newsitem">
                    <div class="newspic">
                        <ul>
                            <li><a href="info.html"><img src="static/images/3.jpg"><span>博客开发历程！</span></a></li>
                            <li><a href="info.html"><img
                                    src="static/images/4.jpg"><span>个人网站做好了，百度不收录怎么办？来，看看他们怎么做的</span></a></li>
                        </ul>
                    </div>
                    <ul class="newslist">
                        <li><i></i><a href="info.html">安静地做一个爱设计的女子</a>
                            <p>自从入了这行，很多人跟我说可以做网络教程，我也有考虑，但最终没有实现，因为我觉得在这个教程泛滥的时代，直接做一套免费的原创个人博客模板更为实在。</p>
                        </li>
                        <li><i></i><a href="info.html">我是怎么评价自己的？</a>
                            <p>
                                为了挨打轻一些，问我哪里来的，我瞎说了一个说那个谁家的，结果，打得更凶。最后事情还原了真相，我妈说，你要说说奶奶家的，都不会打你了。从此以后，我知道撒谎是会付出更惨痛的代价的，我不再撒谎，也不喜欢爱撒谎的人。</p>
                        </li>
                        <li><i></i><a href="info.html">个人博客，属于我的小世界！</a>
                            <p>
                                个人博客，用来做什么？我刚开始就把它当做一个我吐槽心情的地方，也就相当于一个网络记事本，写上一些关于自己生活工作中的小情小事，也会放上一些照片，音乐。每天工作回家后就能访问自己的网站，一边听着音乐，一边写写文章。</p>
                        </li>
                        <li><i></i><a href="info.html">个人网站做好了，百度不收录怎么办？来，看看他们怎么做的。</a>
                            <p>不管你是学前端的还是后端的，作为一个程序员，做一个自己的博客，那是必然的。咱们的圈子就这么大，想让更多的人了解你，看看你的技术多牛逼，扔一个博客地址就行了</p>
                        </li>
                        <li><i></i><a href="info.html">做个人博客如何用帝国cms美化留言增加头像选择</a>
                            <p>帝国cms的留言板系统很简单，用户名，邮箱，电话，没有头像显示，如果要增加头像选择，而又不增加表或者字段的情况下，选择改用其中一个字段，比如电话这个，修改一下即可</p>
                        </li>
                    </ul>
                </div>
                <!--这个标签的显示对应着上面tab_buttons中第四个li节点的点击事件，通过comm.js中的函数动态变化-->
                <div class="newsitem">
                    <div class="newspic">
                        <ul>
                            <li><a href="info.html"><img src="static/images/h2.jpg"><span>个那些博主值得推荐！</span></a></li>
                            <li><a href="info.html"><img
                                    src="static/images/h1.jpg"><span>个人网站做好了，百度不收录怎么办？来，看看他们怎么做的</span></a></li>
                        </ul>
                    </div>
                    <ul class="newslist">
                        <li><i></i><a href="info.html">我是怎么评价自己的？</a>
                            <p>
                                为了挨打轻一些，问我哪里来的，我瞎说了一个说那个谁家的，结果，打得更凶。最后事情还原了真相，我妈说，你要说说奶奶家的，都不会打你了。从此以后，我知道撒谎是会付出更惨痛的代价的，我不再撒谎，也不喜欢爱撒谎的人。</p>
                        </li>
                        <li><i></i><a href="info.html">个人博客，属于我的小世界！</a>
                            <p>
                                个人博客，用来做什么？我刚开始就把它当做一个我吐槽心情的地方，也就相当于一个网络记事本，写上一些关于自己生活工作中的小情小事，也会放上一些照片，音乐。每天工作回家后就能访问自己的网站，一边听着音乐，一边写写文章。</p>
                        </li>
                        <li><i></i><a href="info.html">安静地做一个爱设计的女子</a>
                            <p>自从入了这行，很多人跟我说可以做网络教程，我也有考虑，但最终没有实现，因为我觉得在这个教程泛滥的时代，直接做一套免费的原创个人博客模板更为实在。</p>
                        </li>
                        <li><i></i><a href="info.html">个人网站做好了，百度不收录怎么办？来，看看他们怎么做的。</a>
                            <p>不管你是学前端的还是后端的，作为一个程序员，做一个自己的博客，那是必然的。咱们的圈子就这么大，想让更多的人了解你，看看你的技术多牛逼，扔一个博客地址就行了</p>
                        </li>
                        <li><i></i><a href="info.html">做个人博客如何用帝国cms美化留言增加头像选择</a>
                            <p>帝国cms的留言板系统很简单，用户名，邮箱，电话，没有头像显示，如果要增加头像选择，而又不增加表或者字段的情况下，选择改用其中一个字段，比如电话这个，修改一下即可</p>
                        </li>
                    </ul>
                </div>
            </div>

        </div>


        <!--tab_box end--
        <div class="zhuanti whitebg">
          <h2 class="htitle"><span class="hnav"><a href="info.html">原创模板</a><a href="info.html">古典</a><a href="info.html">清新</a><a href="info.html">低调</a></span>精彩专题</h2>
          <ul>
            <li> <i class="ztpic"><a href="/" target="_blank"><img src=static/mages/1.jpg"></a></i> <b>个人博客模板《今夕何夕》-响应式个人...</b><span>个人博客模板《今夕何夕》，宽屏响应式个人博客模板，采用冷色系为主，固定导航栏和侧边栏，无缝滚动图片...</span><a href="" target="_blank" class="readmore">文章阅读</a> </li>
            <li> <i class="ztpic"><a href="/" target="_blank"><img src=static/mages/2.jpg"></a></i> <b>个人博客模板《今夕何夕》-响应式个人...</b><span>个人博客模板《今夕何夕》，宽屏响应式个人博客模板，采用冷色系为主，固定导航栏和侧边栏，无缝滚动图片...</span><a href="" target="_blank" class="readmore">文章阅读</a> </li>
            <li> <i class="ztpic"><a href="/" target="_blank"><img src=static/mages/3.jpg"></a></i> <b>个人博客模板《今夕何夕》-响应式个人...</b><span>个人博客模板《今夕何夕》，宽屏响应式个人博客模板，采用冷色系为主，固定导航栏和侧边栏，无缝滚动图片...</span><a href="" target="_blank" class="readmore">文章阅读</a> </li>
            <li> <i class="ztpic"><a href="/" target="_blank"><img src=static/mages/4.jpg"></a></i> <b>个人博客模板《今夕何夕》-响应式个人...</b><span>个人博客模板《今夕何夕》，宽屏响应式个人博客模板，采用冷色系为主，固定导航栏和侧边栏，无缝滚动图片...</span><a href="" target="_blank" class="readmore">文章阅读</a> </li>
            <li> <i class="ztpic"><a href="/" target="_blank"><img src=static/mages/h2.jpg"></a></i> <b>个人博客模板《今夕何夕》-响应式个人...</b><span>个人博客模板《今夕何夕》，宽屏响应式个人博客模板，采用冷色系为主，固定导航栏和侧边栏，无缝滚动图片...</span><a href="" target="_blank" class="readmore">文章阅读</a> </li>
            <li> <i class="ztpic"><a href="/" target="_blank"><img src=static/mages/h1.jpg"></a></i> <b>个人博客模板《今夕何夕》-响应式个人...</b><span>个人博客模板《今夕何夕》，宽屏响应式个人博客模板，采用冷色系为主，固定导航栏和侧边栏，无缝滚动图片...</span><a href="" target="_blank" class="readmore">文章阅读</a> </li>
          </ul>
        </div>
        <div class="ad whitebg"> <img src=static/mages/longad.jpg"> </div>-->
        <div class="whitebg bloglist">
            <h2 class="htitle">最新博文</h2>
            <ul>


                <!--通过以下的一个标签来实现对一个具体博文的标签的设置，包括其作者以及昵称以及作品名称，作品的简单介绍等情况，分为设置或者没有设置图片两种状态-->
                <!--这儿是重文本的一个标签，下面的是一个非重文本标签，也即存在图片描述-->
                <li>
                    <h3 class="blogtitle"><a href="info.html" target="_blank">【个人博客网站制作】自己不会个人博客网站制作，你会选择用什么博客程序源码？</a>
                    </h3>
                    <p class="blogtext">
                        这些开源的博客程序源码，都是经过很多次版本测试的，都有固定的使用人群。我所知道的主流的博客程序有，Z-blog，Emlog，WordPress，Typecho等，免费的cms系统有，织梦cms（dedecms），phpcms，帝国cms（EmpireCMS）！... </p>
                    <p class="bloginfo"><i class="avatar"><img alt="作者的头像文件，如果存在则放上，否则放默认图片"
                                                               src="static/images/avatar.jpg"></i><span>昵称</span><span>2018-10-28</span>
                    </p>
                    <!--这儿我们可以放置三个图标，用来代表当前的点赞数，浏览量以及差评量，或者说还有评论量，可以通过异步请求的方式来实现点赞后快速相应的目的-->
                    <a href="info.html" class="viewmore" style="background-color:skyblue">阅读更多</a>
                </li>

                <!--这儿是一个展示有图片标题的标签，注意无论是图片还是titile上都应该有指向具体内容的链接，当然这个时候我们应该携带上具体的参数-->
                <!--实现思想，可以设计两个类似的实体类，一个只是存储一些基本的字段，就比如说是下面的文章id(隐式的放到链接后面来作为参数而查询)标题作者时间以及概述，而另一个标签则是包含了所有的内容
                    包括内容等，这样我们在查询时就可以减小查询所携带的数据量了，从而减少查询的压力，所以我们在下面链接的标签上应该加上具体文章对应的参数用来
                    定位文章-->
                <li>
                    <h3 class="blogtitle"><a href="info.html" target="_blank">宝宝个人博客模板-亲子博客模板-宝宝个人网站模板</a></h3>
                    <!--下面的这个span标签是一个用来展示图片的标签-->
                    <span class="blogpic imgscale"><a href="info.html" title=""><img src="static/images/b02.jpg" alt=""></a></span>
                    <p class="blogtext">
                        这是一个记录宝宝成长点滴的个人博客，用作于宝宝博客，亲子博客，都是适用的。颜色为蓝色调，头部有飘动的卡通云，采用css3动画效果，布局简单，代码精简，还有相册功能，发图片，视频，时间轴可记录重要时刻，也可记录宝宝的生长发育状况，也可以统计宝宝博客网站的所有文章... </p>
                    <p class="bloginfo"><i class="avatar"><img src="static/images/avatar.jpg"></i><span>XX</span><span>2018-10-28</span><span>【<a
                            href="info.html">最新模板</a>】</span></p>
                    <!--这儿我们可以放置三个图标，用来代表当前的点赞数，浏览量以及差评量，或者说还有评论量，可以通过异步请求的方式来实现点赞后快速相应的目的-->
                    <a href="info.html" class="viewmore">阅读更多</a>
                </li>
                <!--***************************************************************************************************以下重复的*********************************************-->
                <li>
                    <h3 class="blogtitle"><a href="info.html" target="_blank">【个人博客网站制作】自己不会个人博客网站制作，你会选择用什么博客程序源码？</a>
                    </h3>
                    <p class="blogtext">
                        这些开源的博客程序源码，都是经过很多次版本测试的，都有固定的使用人群。我所知道的主流的博客程序有，Z-blog，Emlog，WordPress，Typecho等，免费的cms系统有，织梦cms（dedecms），phpcms，帝国cms（EmpireCMS）！... </p>
                    <p class="bloginfo"><i class="avatar"><img alt="作者的头像文件，如果存在则放上，否则放默认图片"
                                                               src="static/images/avatar.jpg"></i><span>昵称</span><span>2018-10-28</span>
                    </p>
                    <!--这儿我们可以放置三个图标，用来代表当前的点赞数，浏览量以及差评量，或者说还有评论量，可以通过异步请求的方式来实现点赞后快速相应的目的-->
                    <a href="info.html" class="viewmore" style="background-color:skyblue">阅读更多</a>
                </li>
                <li>
                    <h3 class="blogtitle"><a href="info.html" target="_blank">宝宝个人博客模板-亲子博客模板-宝宝个人网站模板</a></h3>
                    <!--下面的这个span标签是一个用来展示图片的标签-->
                    <span class="blogpic imgscale"><a href="info.html" title=""><img src="static/images/b02.jpg" alt=""></a></span>
                    <p class="blogtext">
                        这是一个记录宝宝成长点滴的个人博客，用作于宝宝博客，亲子博客，都是适用的。颜色为蓝色调，头部有飘动的卡通云，采用css3动画效果，布局简单，代码精简，还有相册功能，发图片，视频，时间轴可记录重要时刻，也可记录宝宝的生长发育状况，也可以统计宝宝博客网站的所有文章... </p>
                    <p class="bloginfo"><i class="avatar"><img src="static/images/avatar.jpg"></i><span>XX</span><span>2018-10-28</span><span>【<a
                            href="info.html">最新模板</a>】</span></p>
                    <!--这儿我们可以放置三个图标，用来代表当前的点赞数，浏览量以及差评量，或者说还有评论量，可以通过异步请求的方式来实现点赞后快速相应的目的-->
                    <a href="info.html" class="viewmore">阅读更多</a>
                </li>
                <li>
                    <h3 class="blogtitle"><a href="info.html" target="_blank">【个人博客网站制作】自己不会个人博客网站制作，你会选择用什么博客程序源码？</a>
                    </h3>
                    <p class="blogtext">
                        这些开源的博客程序源码，都是经过很多次版本测试的，都有固定的使用人群。我所知道的主流的博客程序有，Z-blog，Emlog，WordPress，Typecho等，免费的cms系统有，织梦cms（dedecms），phpcms，帝国cms（EmpireCMS）！... </p>
                    <p class="bloginfo"><i class="avatar"><img alt="作者的头像文件，如果存在则放上，否则放默认图片"
                                                               src="static/images/avatar.jpg"></i><span>昵称</span><span>2018-10-28</span>
                    </p>
                    <!--这儿我们可以放置三个图标，用来代表当前的点赞数，浏览量以及差评量，或者说还有评论量，可以通过异步请求的方式来实现点赞后快速相应的目的-->
                    <a href="info.html" class="viewmore" style="background-color:skyblue">阅读更多</a>
                </li>
                <li>
                    <h3 class="blogtitle"><a href="info.html" target="_blank">宝宝个人博客模板-亲子博客模板-宝宝个人网站模板</a></h3>
                    <!--下面的这个span标签是一个用来展示图片的标签-->
                    <span class="blogpic imgscale"><a href="info.html" title=""><img src="static/images/b02.jpg" alt=""></a></span>
                    <p class="blogtext">
                        这是一个记录宝宝成长点滴的个人博客，用作于宝宝博客，亲子博客，都是适用的。颜色为蓝色调，头部有飘动的卡通云，采用css3动画效果，布局简单，代码精简，还有相册功能，发图片，视频，时间轴可记录重要时刻，也可记录宝宝的生长发育状况，也可以统计宝宝博客网站的所有文章... </p>
                    <p class="bloginfo"><i class="avatar"><img src="static/images/avatar.jpg"></i><span>XX</span><span>2018-10-28</span><span>【<a
                            href="info.html">最新模板</a>】</span></p>
                    <!--这儿我们可以放置三个图标，用来代表当前的点赞数，浏览量以及差评量，或者说还有评论量，可以通过异步请求的方式来实现点赞后快速相应的目的-->
                    <a href="info.html" class="viewmore">阅读更多</a>
                </li>
                <li>
                    <h3 class="blogtitle"><a href="info.html" target="_blank">【个人博客网站制作】自己不会个人博客网站制作，你会选择用什么博客程序源码？</a>
                    </h3>
                    <p class="blogtext">
                        这些开源的博客程序源码，都是经过很多次版本测试的，都有固定的使用人群。我所知道的主流的博客程序有，Z-blog，Emlog，WordPress，Typecho等，免费的cms系统有，织梦cms（dedecms），phpcms，帝国cms（EmpireCMS）！... </p>
                    <p class="bloginfo"><i class="avatar"><img alt="作者的头像文件，如果存在则放上，否则放默认图片"
                                                               src="static/images/avatar.jpg"></i><span>昵称</span><span>2018-10-28</span>
                    </p>
                    <!--这儿我们可以放置三个图标，用来代表当前的点赞数，浏览量以及差评量，或者说还有评论量，可以通过异步请求的方式来实现点赞后快速相应的目的-->
                    <a href="info.html" class="viewmore" style="background-color:skyblue">阅读更多</a>
                </li>
                <li>
                    <h3 class="blogtitle"><a href="info.html" target="_blank">宝宝个人博客模板-亲子博客模板-宝宝个人网站模板</a></h3>
                    <!--下面的这个span标签是一个用来展示图片的标签-->
                    <span class="blogpic imgscale"><a href="info.html" title=""><img src="static/images/b02.jpg" alt=""></a></span>
                    <p class="blogtext">
                        这是一个记录宝宝成长点滴的个人博客，用作于宝宝博客，亲子博客，都是适用的。颜色为蓝色调，头部有飘动的卡通云，采用css3动画效果，布局简单，代码精简，还有相册功能，发图片，视频，时间轴可记录重要时刻，也可记录宝宝的生长发育状况，也可以统计宝宝博客网站的所有文章... </p>
                    <p class="bloginfo"><i class="avatar"><img src="static/images/avatar.jpg"></i><span>XX</span><span>2018-10-28</span><span>【<a
                            href="info.html">最新模板</a>】</span></p>
                    <!--这儿我们可以放置三个图标，用来代表当前的点赞数，浏览量以及差评量，或者说还有评论量，可以通过异步请求的方式来实现点赞后快速相应的目的-->
                    <a href="info.html" class="viewmore">阅读更多</a>
                </li>
                <li>
                    <h3 class="blogtitle"><a href="info.html" target="_blank">【个人博客网站制作】自己不会个人博客网站制作，你会选择用什么博客程序源码？</a>
                    </h3>
                    <p class="blogtext">
                        这些开源的博客程序源码，都是经过很多次版本测试的，都有固定的使用人群。我所知道的主流的博客程序有，Z-blog，Emlog，WordPress，Typecho等，免费的cms系统有，织梦cms（dedecms），phpcms，帝国cms（EmpireCMS）！... </p>
                    <p class="bloginfo"><i class="avatar"><img alt="作者的头像文件，如果存在则放上，否则放默认图片"
                                                               src="static/images/avatar.jpg"></i><span>昵称</span><span>2018-10-28</span>
                    </p>
                    <!--这儿我们可以放置三个图标，用来代表当前的点赞数，浏览量以及差评量，或者说还有评论量，可以通过异步请求的方式来实现点赞后快速相应的目的-->
                    <a href="info.html" class="viewmore" style="background-color:skyblue">阅读更多</a>
                </li>
                <li>
                    <h3 class="blogtitle"><a href="info.html" target="_blank">宝宝个人博客模板-亲子博客模板-宝宝个人网站模板</a></h3>
                    <!--下面的这个span标签是一个用来展示图片的标签-->
                    <span class="blogpic imgscale"><a href="info.html" title=""><img src="static/images/b02.jpg" alt=""></a></span>
                    <p class="blogtext">
                        这是一个记录宝宝成长点滴的个人博客，用作于宝宝博客，亲子博客，都是适用的。颜色为蓝色调，头部有飘动的卡通云，采用css3动画效果，布局简单，代码精简，还有相册功能，发图片，视频，时间轴可记录重要时刻，也可记录宝宝的生长发育状况，也可以统计宝宝博客网站的所有文章... </p>
                    <p class="bloginfo"><i class="avatar"><img src="static/images/avatar.jpg"></i><span>XX</span><span>2018-10-28</span><span>【<a
                            href="info.html">最新模板</a>】</span></p>
                    <!--这儿我们可以放置三个图标，用来代表当前的点赞数，浏览量以及差评量，或者说还有评论量，可以通过异步请求的方式来实现点赞后快速相应的目的-->
                    <a href="info.html" class="viewmore">阅读更多</a>
                </li>
                <!--***************************************************************************************************以上重复的*********************************************-->

            </ul>
        </div>
        <!--bloglist end-->
    </div>
    <div class="rbox">
        <div class="card">
            <!--用户信息表中的内容展示-->
            <h2>站点信息</h2>
            <p>网名：java想成神</p>
            <p>职业：java工程师</p>
            <p>现居：地球</p>
            <p>网址：www.hmy.cn</p>
            <ul class="linkmore">
                <!--网站地址-->
                <li><a href="www.hmy.cn" target="_blank" class="iconfont icon-zhuye" title="网站地址"></a></li>
                <!--邮箱地址-->
                <li><a href="http://www.php.cn/webpage/" target="_blank" class="iconfont icon-youxiang"
                       title="我的邮箱"></a></li>
                <!--跳转到qq进行联系-->
                <li><a href="http://www.php.cn/yuanma/" target="_blank" class="iconfont icon---" title="QQ联系我"></a></li>
                <!--贴出个人的微信个人图片信息，用来进行联系-->
                <li id="weixin"><a href="#" target="_blank" class="iconfont icon-weixin" title="关注我的微信"></a><i><img
                        src="static/images/wx.png"></i></li>
            </ul>
        </div>
        <div class="whitebg notice">
            <h2 class="htitle">网站公告</h2>
            <ul>
                <li><a href="info.html">十条设计原则教你学会如何设计网页布局!</a></li>
                <li><a href="info.html">用js+css3来写一个手机栏目导航</a></li>
                <li><a href="info.html">6条网页设计配色原则,让你秒变配色高手</a></li>
                <li><a href="info.html">三步实现滚动条触动css动画效果</a></li>
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
            <h2 class="htitle">站长推荐</h2>
            <section class="topnews imgscale"><a href="info.html"><img src="static/images/h2.jpg"><span>6条网页设计配色原则,让你秒变配色高手</span></a>
            </section>
            <ul>
                <li><a href="info.html"><i><img src="static/images/text01.jpg"></i>
                    <p>十条设计原则教你学会如何设计网页布局!</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text02.jpg"></i>
                    <p>用js+css3来写一个手机栏目导航</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text03.jpg"></i>
                    <p>6条网页设计配色原则,让你秒变配色高手</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text04.jpg"></i>
                    <p>三步实现滚动条触动css动画效果</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text05.jpg"></i>
                    <p>个人博客，属于我的小世界！</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text06.jpg"></i>
                    <p>安静地做一个爱设计的女子</p>
                </a></li>
                <li><a href="info.html"><i><img src="static/images/text07.jpg"></i>
                    <p>个人网站做好了，百度不收录怎么办？来，看看他们怎么做的。</p>
                </a></li>
            </ul>
        </div>
        <div class="ad whitebg imgscale">
            <ul>
                <a href="info.html"><img src="static/images/ad.jpg"></a>
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
                <li><b>网站程序</b>：ThinkPHP</li>
                <li><b>主题模板</b>：<a href="http://www.yangqq.com" target="_blank">《今夕何夕》</a></li>
                <li><b>文章统计</b>：299条</li>
                <li><b>文章评论</b>：490条</li>
                <li><b>统计数据</b>：<a href="info.html">百度统计</a></li>
                <li><b>微信公众号</b>：扫描二维码，关注我们</li>
                <img src="static/images/wxgzh.jpg" class="tongji_gzh">
            </ul>
        </div>
        <div class="links whitebg">
            <h2 class="htitle"><span class="sqlink"><a href="info.html">申请链接</a></span>友情链接</h2>
            <ul>
                <li><a href="http://www.yangqq.com" target="_blank">XX个人博客</a></li>
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