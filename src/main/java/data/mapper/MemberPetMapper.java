package data.mapper;

import org.apache.ibatis.annotations.Mapper;

import data.dto.MemberPetDto;

@Mapper
public interface MemberPetMapper {
	public int checkMyid(String myid);
	public void insertMember(MemberPetDto dto);
	public int loginCheck(String loginid,String loginpass);
	public MemberPetDto getSelectByMyid(String myid);
}
