package com.sys.comeit;

import java.util.ArrayList;

public interface ISpaDAO
{
	public int spaAdd(SpaDTO dto);	// 실제 회원 가입 insert
	public int spaCount();				// 회원 수
	public ArrayList<SpaDTO> spaList();	// 회원 리스트
	
	public int spaModify(SpaDTO dto);	// 업체 회원이 자기 정보 수정 update
	public int spaRemove(int sid); 		// 업체 회원탈퇴요청
	public SpaDTO spaLogin(SpaDTO dto); //로그인
}
