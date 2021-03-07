package top.how2l.servlet.Mail;

import top.how2l.util.mailGene;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

/**
 * 用来异步处理发送邮件的servlet,第三方授权码asibpkzkttmsdehh
 * 发送消息可以按照html来设置颜色:注意需要启动redis在本地的服务端
 * 如<p style='color:green'>303258</p>
 */


public class MailServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 设置请求的编码
        request.setCharacterEncoding("UTF-8");
        // 设置响应的编码
        response.setContentType("text/html;charset=UTF-8");
        // 从前端获取收件人邮件
        String to = request.getParameter("userAccount");
        // 通过自己的邮箱作为发件人邮件
        String from = mailGene.getAccount();
        // 使用第三方授权码作为密码登录-这里使用第三方授权码，需要在qq中开启pop等服务
        String password = mailGene.password();
        // 从工具类中获取指定发送邮件的主机，这里使用的是qq的服务器
        String host = mailGene.getSendHost();
        // 从工具类获取主题-给用户发送的是一个模板
        String subject = mailGene.subjectGene();
        // 从工具类中获取生成的主体内容
        String body = mailGene.verifyGene(to);
        try {
            // 1.创建参数配置, 用于连接邮件服务器的参数配置
            Properties properties = new Properties();
            properties.setProperty("mail.transport.protocol", "smtp");
            properties.setProperty("mail.smtp.host", host);
            properties.setProperty("mail.smtp.auth", "true");

            // 2.根据配置创建会话对象，用于和邮件服务器交互
            Session session = Session.getInstance(properties);
            session.setDebug(true);

            // 3.创建一封邮件
            MimeMessage message = createSimpleMimeMessage(session, from, to, subject, body);

            // 4.根据Session获取邮件传输对象
            Transport transport = session.getTransport();

            // 5.使用邮箱账号和密码连接邮件服务器，这里认证的邮箱必须与message中的发件人邮箱一致，否则报错
            transport.connect(from, password);

            // 6.发送邮件，发到所有的收件地址，message.getAllRecipients()获取到的是在创建邮件对象时添加的所有的收件人、抄送人、密送人
            transport.sendMessage(message, message.getAllRecipients());

            // 7.关闭连接
            transport.close();
            // 前端响应
            response.getWriter().println("验证码发送成功，请注意查收!!!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        doPost(req, resp);
    }

    /**
     * 操作结果：创建一个邮件发送对象
     *
     * @param session
     * @param sendMail    发信人
     * @param receiveMail 收信人
     * @param subject     邮件主题
     * @param content     邮件内容
     * @return
     * @throws UnsupportedEncodingException
     * @throws MessagingException
     */
    public MimeMessage createSimpleMimeMessage(Session session, String sendMail, String receiveMail, String subject,
                                               String content) throws UnsupportedEncodingException, MessagingException {
        // 1.创建一封邮件
        MimeMessage mimeMessage = new MimeMessage(session);
        // 2.From：发件人
        mimeMessage.setFrom(new InternetAddress(sendMail, sendMail, "UTF-8"));
        // 3.To：收件人（可以增加多个收件人、抄送、密送）
        mimeMessage.setRecipients(MimeMessage.RecipientType.TO, new InternetAddress[]{new InternetAddress(receiveMail
                , receiveMail, "UTF-8")});
        // 4.邮件主题
        mimeMessage.setSubject(subject, "UTF-8");
        // 5.Content：邮件正文（可以用HTML标签）
        mimeMessage.setContent(content, "text/html;charset=UTF-8");
        // 6.设置发件时间
        mimeMessage.setSentDate(new Date());
        // 7.保存设置
        mimeMessage.saveChanges();

        return mimeMessage;
    }
}
