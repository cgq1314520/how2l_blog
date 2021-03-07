package top.how2l.util;

/**
 * 专门用于响应ajax json格式的对象
 */
public class message {
    private int state;
    private String message;

    public message(int state, String message) {
        this.state = state;
        this.message = message;
    }
}
