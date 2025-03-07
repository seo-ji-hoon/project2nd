package data.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@Alias("BoardPetRepleDto")
public class BoardPetRepleDto {
    private int idx;          // 댓글 고유 ID
    private int board_idx;     // 댓글이 속한 게시글 ID
    private String myid;      // 댓글 작성자의 ID
    private String message;   // 댓글 내용
    private String photo;     // 댓글에 첨부된 사진 (선택적)
    private int regroup;      // 댓글 그룹 번호 (답글을 묶는 그룹)
    private int relevel;      // 댓글의 깊이 (0: 원댓글, 1: 대댓글, 2: 대대댓글 ...)
    private int restep;       // 같은 그룹 내 정렬 순서
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone="Aisa/Seoul")
    private Timestamp writeday; // 댓글 작성일
    private String board_subject; //마이페이지에서 원글 제목 가져오는 용도
}
