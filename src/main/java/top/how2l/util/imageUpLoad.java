package top.how2l.util;

/**
 * 图片上传成功时，返回的json格式内容
 */
public class imageUpLoad {
    /*必须公有才能被json化*/
    public int success;
    public String message;
    public String url;

    public imageUpLoad(int success, String message, String url) {
        this.success = success;
        this.message = message;
        this.url = url;
    }

   /* @Override
    public String toString() {
        return "[{"+this.success+","+this.message+","+this.url+"}]";
    }*/
}
