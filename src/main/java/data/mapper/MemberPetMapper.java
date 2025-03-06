package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.MemberPetDto;

@Mapper
public interface MemberPetMapper {
	public int checkMyid(String myid);
	public void insertMember(MemberPetDto dto);
	public int loginCheck(String loginid,String loginpass);
	public MemberPetDto getSelectByMyid(String myid);
	public MemberPetDto getSelectByNum(int num);
	public void updateMember(MemberPetDto dto);
	public void deleteMember(int num);
	public List<MemberPetDto> getAllMembers();
}
