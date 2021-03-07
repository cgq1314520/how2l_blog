package top.how2l.servlet.blog;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import top.how2l.pojo.user;
import top.how2l.util.imageUpLoad;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.List;
import java.util.Random;

/**
 * 上传图片的servlet
 */
public class upLoadFileServlet extends HttpServlet {
    /*登录用户的id*/
    user user;
    Long pk_uid;
    /*先生成文件夹路径*/
    String fileDir;
    /*最后生成的文件名字*/
    String fileNameEnd;


    /**
     * 下面的这个变量最后删了
     */
    String filename1;


    /*只要服务器不重启，图片就不会消失，因为服务器重启时就会将桌面上的原本项目加载到tomcat的根目录中，所以我们在此其实是将图片存储在了
     * tomcat的root目录下项目的imgaes目录下，所以重启就会导致从c重新加载，所以原本上传的图片就不见了，所以如果想要图片不消失，则必须将war包
     * 直接放到tomcat里面才行，所以为了图片还不丢失，我将下面的项目路径，改成一个固定的路径，具体放入tomcat时重新改过来即可
     * 也即http:local...请求的是tomcat目录下的图片，所以我们在这里即要在原本的目录里面存储图片同时也要在tomcat里面存储图片，这就是
     * 项目没有直接放在tomcat里面的弊端；所以在此先将文件保存两份，也即项目加载后的目录和原本 项目所在的目录*/
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        /*获取用户id*/
        user = (user) req.getSession().getAttribute("user");
        pk_uid = user.getPk_uid();
        /*先生成文件夹路径*/
        fileDir = getServletContext().getRealPath("/static/images") + "\\" + pk_uid;
/*
        fileDir="C:\\Users\\Administrator\\Desktop\\project-prictise\\blog\\src\\main\\webapp\\static\\images"+"\\"+pk_uid;
*/
        /*获取图片的信息并保存，并将生成的路径返回，保存的目录为本身用户id所在的目录*/
        /*通过文件上传包进行文件的上传*/
        DiskFileItemFactory factory = new DiskFileItemFactory();

        // 设置文件大小的阈值
        factory.setSizeThreshold(1024 * 1024 * 10);
        ServletContext servletContext = this.getServletConfig().getServletContext();
        File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
        factory.setRepository(repository);

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);

        // 设置上传文件大小的最大值
        upload.setSizeMax(1024 * 1024 * 30 * 1024);

        // 解析request
        List<FileItem> items;
        try {
            items = upload.parseRequest(req);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String name = item.getFieldName();
                    String value = item.getString();
                } else {
                    String fieldName = item.getFieldName();
                    String fileName = item.getName();
                    String contentType = item.getContentType();
                    boolean isInMemory = item.isInMemory();
                    long sizeInBytes = item.getSize();
                    /*获取生成离线版文件的文件名*/
                    fileName = getFileName(fileName);
                    System.out.println("文件名为:" + fileName);
                    /*利用输入流进行文件的上传*/
                    InputStream in = item.getInputStream();
                    byte[] arr = new byte[1024];
                    int len;
                    File file = new File(fileName);
                    if (!file.exists()) {
                        file.createNewFile();
                    }
                    FileOutputStream out = new FileOutputStream(file);


                    /**
                     * 将文件同时保存到离线版的项目images目录里面，后面的最后时可以删了
                     */
                    File file1 = new File(filename1);
                    FileOutputStream out2 = new FileOutputStream(file1);





                    /*开始保存文件*/
                    while ((len = in.read(arr)) != -1) {
                        out.write(arr, 0, len);
                        /**
                         * 下面的这个最后删了
                         */
                        out2.write(arr, 0, len);


                    }
                    in.close();
                    out.close();
                    /*获取输入流，响应返回数据给浏览器*/
                    response.setContentType("application/json;charset=utf-8");

                    //通过response对象获得输出流。
                    PrintWriter out1 = response.getWriter();

                    //构建 对象 转 json 类
                    ObjectMapper mapper = new ObjectMapper();
                    imageUpLoad result = new imageUpLoad(1, "上传成功", "http://localhost:8080/static/images/" + pk_uid + "/" + fileNameEnd);

                    //把 对象转为 json 字符串
                    String json = mapper.writeValueAsString(result);
                    //把数据写到response对象上。
                    // 注： Servlet容器会将response对象上存放的 数据取出来
                    //，打一个包（响应数据包）， 然后发送给浏览器。
                    out1.println(json);
                    //如果没有调用out.close，则容器会自动 关闭out。
                    out1.close();
                }
            }
        } catch (FileUploadException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 在tomcat的目录里面生成一个在线版的文件
     *
     * @param fileName
     * @return
     */
    private String getFileName(String fileName) {
        Random random = new Random();
        int number = random.nextInt(1000);
        String path = getServletContext().getRealPath("/");
        /*开始判断该文件夹是否存在如果存在，则不用管，否则新建*/
        File file = new File(fileDir);

        //如果文件夹不存在则创建
        if (!file.exists() && !file.isDirectory()) {
            System.out.println("文件夹不存在，创建");
            file.mkdir();
        }
        fileNameEnd = System.currentTimeMillis() + number + fileName;

        /**
         * 下面的变量删除最后
         */
        filename1 = "C:\\Users\\Administrator\\Desktop\\project-prictise\\blog\\src\\main\\webapp\\static\\images" + "\\" + pk_uid + "\\" + fileNameEnd;



        /*然后在当前用户目录下生成文件名字，并创建，下面语句的意思就是在当前项目下的/static/images目录的全路径,然后加上用户的id生成的目录从而生成文件名*/
        return getServletContext().getRealPath("/static/images") + "\\" + pk_uid + "\\" + fileNameEnd;
    }

}
