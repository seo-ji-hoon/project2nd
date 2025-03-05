package data.dto;

import java.security.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("MemberPetDto")
public class MemberPetDto {
	private int num;
	private String mname;
	private String mpass;
	private String myid;
	private String mhp;
	private String maddr;
	private String mphoto;
	private Timestamp gaipday;	
}
