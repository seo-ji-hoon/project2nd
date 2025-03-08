package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.DictionaryRepleDto;

@Mapper
public interface DictionaryRepleMapper {
	/* 마이페이지에서 내가 쓴 댓글 가져오는 용도*/
	public List<DictionaryRepleDto> getSelectRepleById(String myid);
	
	/*댓글등록*/
	public void insertDictionReple(DictionaryRepleDto dto);

	/*댓글순서*/
	public List<DictionaryRepleDto> getDictionRepleByIdx(int diction_idx);
	
	/* 모든 댓글 조회*/
	public DictionaryRepleDto getSelectData(int num);
	
	/*댓글사진*/
	public String getDictionPhoto (int num);
	
	/*댓글수정*/
	public void updateDictionReple(DictionaryRepleDto dto);

	/*댓글삭제*/
	public void deleteDictionReple(int num);

}
