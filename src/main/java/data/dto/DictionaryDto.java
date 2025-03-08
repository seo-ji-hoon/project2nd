package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("DictionaryDto")
public class DictionaryDto {
	private int num;  //  댓글 테이블과 일치하도록 추가
	private int diction_idx;     // 댓글이 속한 게시글 ID
	
	private int idx;
	private String myid;
	private String writer;
	private String subject;
	private String content;
	private int readcount;
	private Timestamp writeday;
	private int replecount;//댓글 갯수 저장
}
