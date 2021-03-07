package top.how2l.pojo.blog;

import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 *
 * </p>
 *
 * @author 小帆远航
 * @since 2020-11-23
 */
@Data
public class ResComment implements Serializable {

    private static final long serialVersionUID = 1L;


    private Integer pkRid;


    private Integer askComid;


    private Integer reComid;


    private String content;


    private Integer fromUid;

    private Integer toUid;


}
