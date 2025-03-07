package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("BoardPetRepleDto") //별칭
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardPetRepleDto {
	private int num;
	private int board_idx;
	private String myid;
	private String writer;
	private String profilePhoto;
	private String message;
	private String photo;
	private int regroup;
	private int relevel;
	private int restep;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm",timezone = "Asia/Seoul")
	private Timestamp writeday;
	private String board_subject; //마이페이지에서 원글 제목 가져오는 용도
}
