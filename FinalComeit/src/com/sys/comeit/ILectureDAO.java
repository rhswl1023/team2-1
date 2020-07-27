package com.sys.comeit;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface ILectureDAO
{
	// 강의 개설 메소드
	public String lectureInsert(LectureDTO dto); // 강의 inserT
	
	public int insertIntTag(LectureDTO dto);
	public int insertEtcTag(LectureDTO dto);
	public int etcTagCount(String etcTag);
	public int addTagName(String etcTag);
	public int addLecturePrgTime(LectureDTO dto);
	public int checkProfcd(@Param("lec_cd") String lec_cd, @Param("mem_cd") String mem_cd);
	public String findMemcd(String lec_cd);
	
	public ArrayList<LectureDTO> lecIntTagSearch(String lec_cd);	// 한 강의의 관심키워드 뿌려주기
	
	public LectureDTO lectureInfo(String lec_cd); // 강의 상세페이지 정보 뿌려주기
	
	public ArrayList<LectureDTO> lecList();			// 강의 리스트
	public ArrayList<LectureDTO> lecTagList();		// 모든 강의 키워드들
	
	public int lecCount();						// 강의방 개수 조회
	
	public int lecSearchCount(LectureDTO dto);	// 검색완료된 스터디방 개수
	
	public List<LectureDTO> getListData(LectureDTO dto);	// 검색완료된 스터디방
	
	public ArrayList<LectureDTO> lecHrDaySearch();	// 모든 요일 빼오는 리스트
	
}
