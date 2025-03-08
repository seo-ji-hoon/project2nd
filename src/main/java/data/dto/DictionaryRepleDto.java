package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
@Alias("DictionaryRepleDto")
public class DictionaryRepleDto {
	
	private int num;          // 댓글 고유 ID
    private int diction_idx;     // 댓글이 속한 게시글 ID
    private String myid;      // 댓글 작성자의 ID
    private String message;   // 댓글 내용
    private String writer; //댓글 목록에서 작성자
	private String profilePhoto; //댓글 목록에서 작성자 프로필사진
    private String photo;     // 댓글에 첨부된 사진 (선택적)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone="Aisa/Seoul")
    private Timestamp writeday; // 댓글 작성일
    private String diction_subject; //마이페이지에서 원글 제목 가져오는 용도
}
