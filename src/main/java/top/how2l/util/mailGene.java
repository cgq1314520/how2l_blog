package top.how2l.util;

import java.util.Random;

/**
 * 此工具用于发送邮件时，主题和正文内容的生成
 */
public class mailGene {
    public static final String subject = "how2l网页验证码通知";

    public static String subjectGene() {
        return subject;
    }

    /*获取发送发邮件服务器*/
    public static String getSendHost() {
        return "smtp.qq.com";
    }

    /*获取发送方账号，也即自己的邮箱账号*/
    public static String getAccount() {
        return "你的邮箱账号";
    }

    /*第三方授权码*/
    public static String password() {
        return "你的第三方授权码可在qq邮箱设置中得到";
    }

    /*生成主体的内容，同时生成一个6位的随机数，作为验证码发送给用
    户邮箱，还需要将用户邮箱和验证码保存在redis中*/
    public static String verifyGene(String userAccount) {
        String s = verifyNumbersGene();
        /*开始生成主体的内容了*/
        String content = "<b>尊敬的用户,您好！<br/><br/></b><b>您正在进行<a href='http://how2l.top' style='color:skyblue'>how2l</a>网站用户的注册功能，请在验证码框中输入:<u style='color:deepskyblue;font-size:18px;'>" + s + "</u>,以完成操作，" +
                "该验证码5分钟内有效!!!</b>";
        /*将用户验证信息保存到redis中，有效时间5分钟，即300s*/
        redisUtils.setx(userAccount, 300, s);
        /*返回主体内容*/
        return content;
    }

    /*6位验证码生成静态类*/
    public static String verifyNumbersGene() {
        StringBuffer flag = new StringBuffer();
        String sources = "0123456789abcdefghijk"; // 加上一些字母，就可以生成pc站的验证码了
        Random rand = new Random();
        for (int j = 0; j < 6; j++) {
            flag.append(sources.charAt(rand.nextInt(20)) + "");
        }
        return flag.toString();
    }
}
