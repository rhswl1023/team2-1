/*========================
	ISpcAreaDAO.java
	- 인터페이스
========================*/

package com.sys.comeit;

import java.util.ArrayList;

public interface ISpcAreaDAO
{
	public ArrayList<SpcAreaDTO> spcAreaList(String area_cd);	// 세부지역 리스트
}
