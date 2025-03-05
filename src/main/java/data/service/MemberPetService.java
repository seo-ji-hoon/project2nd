package data.service;

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
	
}
