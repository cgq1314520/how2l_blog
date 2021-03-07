package top.how2l.pojo.blog;


import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 *
 * </p>
 *
 * @author 小帆远航
 * @since 2020-11-23
 */
@Data
public class AskComment implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer pkAid;

    private String content;

    private Integer uid;

    private Date gmtCreate;


}
