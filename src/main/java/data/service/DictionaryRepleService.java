package data.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.DictionaryRepleDto;
import data.mapper.DictionaryRepleMapper;

@Service
public class DictionaryRepleService {
	
	@Autowired
	DictionaryRepleMapper dictionaryRepleMapper;
	
	/* 마이페이지에서 내가 쓴 댓글 가져오는 용도*/
	public List<DictionaryRepleDto> getSelectRepleById(String myid)
	{
		return dictionaryRepleMapper.getSelectRepleById(myid);
	}
	
	/*댓글등록*/
	public void insertDictionReple(DictionaryRepleDto dto)
	{
		dictionaryRepleMapper.insertDictionReple(dto);
	}

	/*댓글순서*/
	public List<DictionaryRepleDto> getDictionRepleByIdx (int diction_idx)
	{
		return dictionaryRepleMapper.getDictionRepleByIdx(diction_idx);
	}

	/*댓글사진*/
	public String getDictionPhoto (int num)
	{
		return dictionaryRepleMapper.getDictionPhoto(num);
	}
	
	public DictionaryRepleDto getSelectData(int num)
	{
		return dictionaryRepleMapper.getSelectData(num);
	}
	
	/*댓글수정*/
	public void updateDictionReple(DictionaryRepleDto dto) 
	{
		dictionaryRepleMapper.updateDictionReple(dto);
	}

	/*댓글삭제*/
	public void deleteDictionReple(int num) 
	{
		dictionaryRepleMapper.deleteDictionReple(num);
	}
}
