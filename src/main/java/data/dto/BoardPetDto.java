package data.dto;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;
import java.util.List;

@Data
@Alias("BoardPetDto") //별칭
public class BoardPetDto {
    private int idx;
    private String myid;
    private String writer;
    private String subject;
    private String content;
    private int readcount;
    private int likes;
    private int repleCount;
    private Timestamp writeday;
    private String fileName;
    private List<String> photos;
    private int repleCounting; //댓글갯수
}
