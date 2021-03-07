$(function () {
    /*弹幕滑动效果的事件*/
    var a_button = document.querySelector('#a1');
    var dan_button = document.querySelector('#dan1');
    var IsActive = false;
    //弹幕按钮的点击事件
    $("#dan1").click(function () {
        if (!IsActive) {
            a_button.className = 'a_active';
            this.className = 'dan_active';
            $(".zhezhang").attr("style", "z-index:100 !important");
        } else {
            a_button.className = 'a_notactive';
            this.className = 'dan_notactive';
            $(".zhezhang").attr("style", "z-index:-1 !important");

        }
        IsActive = !IsActive;
    });
    /*弹幕内容，从后台请求*/
    var barrageArray = [
        {
            id: '用户头像',
            text: '秋天爱美丽',
        },
        {
            id: '用户头像',
            text: '今天很开心啊',
        },
        {
            id: '用户头像',
            text: 'winter has come',
        },
        {
            id: '',
            text: '土耳其现在形势',
        },
        {
            id: '',
            text: '没事早点回家吃饭啊',
        },
        {
            id: '',
            text: '这主角真实醉了，不会回啊',
        },
        {
            id: '',
            text: '背景音乐真好听啊',
        },
        {
            id: '',
            text: '背景音乐是***',
        },
        {
            id: '',
            text: '经费在燃烧啊',
        },
        {
            id: '',
            text: '国产良心剧',
        },
    ];
    var barrageColorArray = [
        '#0099CC', '#333333', '#009966', '#FFFF66', '#9933FF', '#FFFF99', '#CCCCFF', '#CC9933', '#FFFF66'
    ];
    var barrageTipWidth = 50; //提示语的长度

    var barrageBoxWrap = document.querySelector('.barrage-container-wrap');
    ;
    var barrageBox = document.querySelector('.barrage-container');
    var inputBox = document.querySelector('.danmuInput');
    var sendBtn = document.querySelector('.send-btn');

    //容器的宽高度
    var barrageWidth = ~~window.getComputedStyle(barrageBoxWrap).width.replace('px', '');
    var barrageHeight = ~~window.getComputedStyle(barrageBoxWrap).height.replace('px', '');

    //  //点击发送
    $(".send-btn").click(function sendMsg() {
        var inputValue = $("#danmuInput").val();
        (String)(inputValue).replace(/\ +/g, "");

        if ((String)(inputValue).length <= 0) {
            alert('请输入');
            return false;
        }

        //生成弹幕，第一个代表弹幕内容，第二个代表是刚刚发送的，第三个代表发送用户的id，第四个代表弹幕的id
        createBarrage(inputValue, true, 1, 1);
    });


    //创建弹幕,一条一条进行创建,isSendMsg代表是否是刚刚创建的
    function createBarrage(msg, isSendMsg, userid, dmid) {
        var divNode = document.createElement('div');
        var spanNode = document.createElement('span');

        divNode.innerHTML = msg;
        divNode.classList.add('barrage-item');
        barrageBox.appendChild(divNode);

        spanNode.innerHTML = '举报';
        spanNode.classList.add('barrage-tip');
        /*把当弹幕发布者的id保存在属性标签里面*/
        spanNode.setAttribute("userid", userid);
        /*把当弹幕的id保存在属性标签里面*/
        spanNode.setAttribute("dmid", dmid)
        divNode.appendChild(spanNode);

        barrageOffsetLeft = getRandom(barrageWidth, barrageWidth * 2);
        barrageOffsetLeft = isSendMsg ? barrageWidth : barrageOffsetLeft
        barrageOffsetTop = getRandom(10, barrageHeight - 10);
        barrageColor = barrageColorArray[Math.floor(Math.random() * (barrageColorArray.length))];

        //执行初始化滚动
        initBarrage.call(divNode, {
            left: barrageOffsetLeft,
            top: barrageOffsetTop,
            color: barrageColor
        });
    }

    //初始化弹幕移动(速度，延迟)
    function initBarrage(obj) {
        //初始化
        obj.top = obj.top || 0;
        obj.class = obj.color || '#fff';
        this.style.left = obj.left + 'px';
        this.style.top = obj.top + 'px';
        this.style.color = obj.color;

        //添加属性
        this.distance = 0;
        this.width = ~~window.getComputedStyle(this).width.replace('px', '');
        this.offsetLeft = obj.left;
        this.timer = null;

        //弹幕子节点
        var barrageChileNode = this.children[0];
        barrageChileNode.style.left = (this.width - barrageTipWidth) / 2 + 'px';

        //运动
        barrageAnimate(this);

        //停止
        this.onmouseenter = function () {
            barrageChileNode.style.display = 'block';
            cancelAnimationFrame(this.timer);
        };

        this.onmouseleave = function () {
            barrageChileNode.style.display = 'none';
            barrageAnimate(this);
        };

        //举报
        barrageChileNode.onclick = function () {
            /*这儿我们就可以将这个弹幕对应的id和对应的视频推送给后台，在管理端进行显示，让管理员决定是否删除该弹幕*/
            alert(this.attributes["userid"].nodeValue)
            alert('举报成功');
        }
    }

    //弹幕动画
    function barrageAnimate(obj) {
        move(obj);

        if (Math.abs(obj.distance) < obj.width + obj.offsetLeft) {
            obj.timer = requestAnimationFrame(function () {
                barrageAnimate(obj);
            });
        } else {
            cancelAnimationFrame(obj.timer);
            //删除节点
            obj.parentNode.removeChild(obj);
        }
    }

    //移动
    function move(obj) {
        obj.distance--;
        obj.style.transform = 'translateX(' + obj.distance + 'px)';
        obj.style.webkitTransform = 'translateX(' + obj.distance + 'px)';
    }

    //随机获取高度
    function getRandom(start, end) {
        return start + (Math.random() * (end - start));
    }


    /*******初始化事件**********/
    //系统数据
    barrageArray.forEach(function (item, index) {
        createBarrage(item.text, false, 1, 1);
    });


    //回车
    $("#danmuInput").keydown(function (e) {
        e = e || window.event;
        if (e.keyCode == 13) {
            send();
        }
    });
})