package data.service;

import java.util.List;

import org.springframework.stereotype.Service;

import data.dto.MemberPetDto;
import data.mapper.MemberPetMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberPetService {
	MemberPetMapper memberPetMapper;
	
	public boolean checkMyid(String myid) {
		return memberPetMapper.checkMyid(myid)==1?true:false;
	}
	public void insertMember(MemberPetDto dto)
	{
		memberPetMapper.insertMember(dto);
	}
	public boolean loginCheck(String loginid,String loginpass)
	{
		return memberPetMapper.loginCheck(loginid,loginpass)==1?true:false;
	}
	
	public MemberPetDto getSelectByMyid(String myid)
	{
		return memberPetMapper.getSelectByMyid(myid);
	}
	
	public MemberPetDto getSelectByNum(int num)
	{
		return memberPetMapper.getSelectByNum(num);
	}
	
	public void updateMember(MemberPetDto dto)
	{
		memberPetMapper.updateMember(dto);
	}
	
	public void deleteMember(int num)
	{
		memberPetMapper.deleteMember(num);
	}
	
	public List<MemberPetDto> gellAllMembers()
	{
		return memberPetMapper.getAllMembers();
	}
	
}
