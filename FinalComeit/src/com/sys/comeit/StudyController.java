package com.sys.comeit;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class StudyController
{
	@Autowired
	private SqlSession sqlSession;

	// 기혜
	// ---------------------------------------------------------------------------------
	// 스터디방 Bf 페이지 요청
	// ★
	// 1. 후에 list랑 연결되면 GET 방식에서 POST 방식으로 바꾸기!
	// 2. 사진 경로 가져오기(진짜 사진 등록되면)
	@RequestMapping(value = "/studydetail.action", method =
	{ RequestMethod.GET, RequestMethod.POST })
	public String studyBfInfo(Model model, HttpServletRequest request)
	{
		String view = null;

		IStudyDAO studyDao = sqlSession.getMapper(IStudyDAO.class);

		String stu_cd = "STU1002"; // 임시 스터디 개설 코드

		// 스터디방 정보
		model.addAttribute("studyInfo", studyDao.studyInfoSearch(stu_cd));
		// 스터디방 관심태그
		model.addAttribute("intTag", studyDao.studyIntTagSearch(stu_cd));
		// 스터디방 기타 관심 태그
		model.addAttribute("etcTag", studyDao.studyEtcTagSearch(stu_cd));
		// 스터디방 진행 요일
		model.addAttribute("dayName", studyDao.studyDaySearch(stu_cd));
		// 스터디장 이름
		model.addAttribute("leaderName", studyDao.studyLeaderSearch(stu_cd));
		// 스터디원 이름
		model.addAttribute("joinName", studyDao.studyJoinName(stu_cd));
		// 스터디 참여자 이미지
		model.addAttribute("memImg", studyDao.memImgSearch(stu_cd));

		view = "/WEB-INF/views/study/StudyBfDetail.jsp";

		return view;
	}
	/*
	 * // 스터디방 Af 페이지 요청
	 * 
	 * @RequestMapping(value = "/studyafdetail.action", method = {RequestMethod.GET,
	 * RequestMethod.POST}) public String studyAfInfo(Model model,
	 * HttpServletRequest request) { String view = null;
	 * 
	 * IStudyDAO studyDao = sqlSession.getMapper(IStudyDAO.class);
	 * 
	 * String stu_cd = "STU1002"; // 임시 스터디 개설 코드
	 * 
	 * // 스터디방 정보 model.addAttribute("studyInfo", studyDao.studyInfoSearch(stu_cd));
	 * // 스터디방 관심태그 model.addAttribute("intTag",
	 * studyDao.studyIntTagSearch(stu_cd)); // 스터디방 기타 관심 태그
	 * model.addAttribute("etcTag", studyDao.studyEtcTagSearch(stu_cd)); // 스터디방 진행
	 * 요일 model.addAttribute("dayName", studyDao.studyDaySearch(stu_cd)); // 스터디장 이름
	 * model.addAttribute("leaderName", studyDao.studyLeaderSearch(stu_cd)); // 스터디원
	 * 이름 model.addAttribute("joinName", studyDao.studyJoinName(stu_cd)); // 스터디 참여자
	 * 이미지 model.addAttribute("memImg", studyDao.memImgSearch(stu_cd));
	 * 
	 * view = "/WEB-INF/views/study/StudyAfDetail.jsp";
	 * 
	 * return view; }
	 */

	// 스터디장 모달창 정보 leaderMemCd
	@RequestMapping(value = "/leaderinfomodal.action", method =
	{ RequestMethod.GET, RequestMethod.POST })
	public String leaderInfoModal(Model model, HttpServletRequest request)
	{
		String view = null;

		IMemberDAO memberDao = sqlSession.getMapper(IMemberDAO.class);

		MemberDTO dto = new MemberDTO();

		dto = memberDao.memModalList(request.getParameter("leaderMemCd"));
		ArrayList<MemberDTO> intTagSearch = memberDao.memIntTagSearch(request.getParameter("leaderMemCd"));
		ArrayList<MemberDTO> stuTitle = memberDao.modalStudyList(request.getParameter("leaderMemCd"));

		String name = dto.getName();
		String idntt = dto.getIdntt();
		String memContent = dto.getMem_content();
		String intTag = "/";
		String joinStudy = "";

		for (int i = 0; i < intTagSearch.size(); i++)
		{
			intTag += intTagSearch.get(i).getInt_tag();
			intTag += "/";
		}

		if (!stuTitle.isEmpty())
		{
			joinStudy = "/";

			for (int i = 0; i < stuTitle.size(); i++)
			{
				joinStudy += stuTitle.get(i).getJoin_stu_title();
				joinStudy += "/";
			}
		} else
		{
			joinStudy += "없음";
		}
		// 테스트
		// System.out.println(intTag);

		model.addAttribute("name", name);
		model.addAttribute("idntt", idntt);
		model.addAttribute("memContent", memContent);
		model.addAttribute("intTag", intTag);
		model.addAttribute("joinStudy", joinStudy);

		view = "/WEB-INF/views/member/AjaxMemModal.jsp";

		return view;
	}

	// 스터디원 모달창 정보
	@RequestMapping(value = "/meminfomodal.action", method =
	{ RequestMethod.GET, RequestMethod.POST })
	public String memInfoModal(Model model, HttpServletRequest request)
	{
		String view = null;

		IMemberDAO memberDao = sqlSession.getMapper(IMemberDAO.class);

		MemberDTO dto = new MemberDTO();

		dto = memberDao.memModalList(request.getParameter("joinMemCd"));
		ArrayList<MemberDTO> intTagSearch = memberDao.memIntTagSearch(request.getParameter("joinMemCd"));
		ArrayList<MemberDTO> stuTitle = memberDao.modalStudyList(request.getParameter("joinMemCd"));

		String name = dto.getName();
		String idntt = dto.getIdntt();
		String memContent = dto.getMem_content();
		String intTag = "/";
		String joinStudy = "";

		for (int i = 0; i < intTagSearch.size(); i++)
		{
			intTag += intTagSearch.get(i).getInt_tag();
			intTag += "/";
		}

		if (!stuTitle.isEmpty())
		{
			joinStudy = "/";

			for (int i = 0; i < stuTitle.size(); i++)
			{
				joinStudy += stuTitle.get(i).getJoin_stu_title();
				joinStudy += "/";
			}
		} else
		{
			joinStudy += "없음";
		}
		// 테스트
		// System.out.println(intTag);

		model.addAttribute("name", name);
		model.addAttribute("idntt", idntt);
		model.addAttribute("memContent", memContent);
		model.addAttribute("intTag", intTag);
		model.addAttribute("joinStudy", joinStudy);

		view = "/WEB-INF/views/member/AjaxMemModal.jsp";

		return view;

	}

	// 수진
	// ---------------------------------------------------------------------------------

	// 스터디 리스트 화면 노출하기
	@RequestMapping(value = "/studylist.action", method = RequestMethod.GET)
	public String memberJoin(Model model, HttpServletRequest request)
	{
		String view = null;

		IStuCatDAO stuCatDao = sqlSession.getMapper(IStuCatDAO.class); // 스터디 카테고리
		IAreaDAO areaDao = sqlSession.getMapper(IAreaDAO.class); // 지역
		ILevelDAO levelDao = sqlSession.getMapper(ILevelDAO.class); // 레벨

		IStudyDAO studyDao = sqlSession.getMapper(IStudyDAO.class); // 스터디 정보

		model.addAttribute("stuCat", stuCatDao.stuCatList());
		model.addAttribute("area", areaDao.areaList());
		model.addAttribute("level", levelDao.levelList());

		model.addAttribute("study", studyDao.studyList());
		model.addAttribute("count", studyDao.studyCount());

		model.addAttribute("studyTags", studyDao.studyTagList()); // 모든 스터디의 모든 키워드

		view = "WEB-INF/views/study/StudyList.jsp";

		return view;
	}

	// 스터디 리스트에서 스터디 클릭 시 비밀번호 확인 AJAX 처리
	@ResponseBody
	@RequestMapping(value = "/stuscrtcheck.action", method =
	{ RequestMethod.GET, RequestMethod.POST })
	public String checkSpaIdAjax(HttpServletRequest request, Model model)
	{

		IStudyDAO studyDao = sqlSession.getMapper(IStudyDAO.class); // 스터디 정보

		String stu_cd = request.getParameter("stu_cd");
		System.out.println("스터디코드 : " + stu_cd);

		String scrt_num = studyDao.studyScrt(request.getParameter("stu_cd"));
		System.out.println("비밀번호 : " + scrt_num);

		return String.valueOf(scrt_num);

	}

	// 스터디방 개설 페이지에서 지역, 레벨, 신분, 요일, 관심키워드, 기간 리스트 던져주기
	@RequestMapping(value = "/studycreate.action", method = RequestMethod.GET)
	public String studyCreate(Model model)
	{
		String view = null;

		IAreaDAO areaDao = sqlSession.getMapper(IAreaDAO.class); // 지역
		ILevelDAO levelDao = sqlSession.getMapper(ILevelDAO.class); // 레벨
		IIdnttDAO idnttDao = sqlSession.getMapper(IIdnttDAO.class); // 신분
		IDayDAO dayDao = sqlSession.getMapper(IDayDAO.class); // 요일
		IIntTagDAO intTagDao = sqlSession.getMapper(IIntTagDAO.class); // 관심키워드
		IMeetTermDAO meetTermDao = sqlSession.getMapper(IMeetTermDAO.class); // 기간
		IStuCatDAO stuCatDao = sqlSession.getMapper(IStuCatDAO.class); // 카테고리

		model.addAttribute("area", areaDao.areaList()); // 지역
		model.addAttribute("level", levelDao.levelList()); // 레벨
		model.addAttribute("idntt", idnttDao.idnttList()); // 신분
		model.addAttribute("day", dayDao.dayList()); // 요일
		model.addAttribute("intTag", intTagDao.intTagList()); // 관심키워드
		model.addAttribute("meetTerm", meetTermDao.meetTermList()); // 기간
		model.addAttribute("stuCat", stuCatDao.stuCatList()); // 카테고리

		view = "WEB-INF/views/study/StudyCreate.jsp";

		return view;
	}

	// 스터디방 개설하기 → 프로시저 호출 및 관련 테이블 insert
	@RequestMapping(value = "/studycreate.action", method =
	{ RequestMethod.GET, RequestMethod.POST })
	public String studyCreate(Model model, HttpServletRequest request)
	{
		String view = null;

		IStudyDAO studyDao = sqlSession.getMapper(IStudyDAO.class);

		// 필수 항목
		HttpSession session = request.getSession();

		// 세션에 있는 회원코드 받아내기
		String mem_cd = (String)session.getAttribute("mem_cd"); // 개설자의 회원코드

		// 필수 항목
		String spc_area_cd = request.getParameter("spcArea"); // 세부지역코드
		String meet_term_cd = request.getParameter("term"); // 모임 기간 코드
		String idntt_cd = request.getParameter("Idntt"); // 신분 코드
		String lv_cd = request.getParameter("level"); // 레벨 코드
		String stu_cat_cd = request.getParameter("stuCat"); // 스터디 카테고리 코드
		String title = request.getParameter("title"); // 제목
		String str_date = request.getParameter("start"); // 시작날짜
		int mem_num = Integer.parseInt(request.getParameter("stuNum")); // 인원 수
		String content = request.getParameter("content"); // 상세 설명
		// 선택 항목
		String img_url = request.getParameter("okFile"); // 대표 이미지
		String scrt_num = request.getParameter("scrt"); // 비밀방 번호

		if (scrt_num == "") // 비밀번호가 없다면 null
			scrt_num = null;

		if (img_url == "") // 대표 이미지가 없다면 null
			img_url = null;

		System.out.println("파라미터 값");
		System.out.println(mem_cd);		// null
		System.out.println(spc_area_cd);
		System.out.println(meet_term_cd);	// null
		System.out.println(idntt_cd);
		System.out.println(lv_cd);		
		System.out.println(stu_cat_cd);		// null
		System.out.println(title);
		System.out.println(str_date);
		System.out.println(mem_num);
		System.out.println(content);
		System.out.println(img_url);
		System.out.println(scrt_num);
		System.out.println("파라미터 끝");

		StudyDTO dto = new StudyDTO();

		dto.setCrt_mem_cd(mem_cd);
		dto.setSpc_area_cd(spc_area_cd);
		dto.setMeet_term_cd(meet_term_cd);
		dto.setIdntt_cd(idntt_cd);
		dto.setLv_cd(lv_cd);
		dto.setStu_cat_cd(stu_cat_cd);
		dto.setTitle(title);
		dto.setStr_date(str_date);
		dto.setMem_num(mem_num);
		dto.setContent(content);
		dto.setImg_url(img_url);
		dto.setScrt_num(scrt_num);

		studyDao.studyInsert(dto); // 실제 스터디 개설 프로시저 호출

		String stu_cd = dto.getStu_cd(); // out 변수인 pk 담기

		String[] intTagList = request.getParameterValues("intTagList"); // 선택한 모든 관심 키워드 배열에 넣기
		String[] etcTagList = request.getParameterValues("etcTagList"); // 선택한 모든 관심 기타 키워드 배열에 넣기

		String[] dayList = request.getParameterValues("dayList"); // 선택한 모든 요일

		System.out.println("그냥 관심 : " + intTagList.length);
		System.out.println("기타 관심 : " + etcTagList.length);
		System.out.println("요일 : " + dayList.length);

		if (stu_cd != null)
		{
			if (intTagList.length > 0)
			{
				for (int i = 0; i < intTagList.length; i++) // 선택한 모든 관심 키워드 중에
				{
					dto.setInt_tag_cd(intTagList[i]); // 자바를 키워드에 세팅하고

					System.out.println("각 관심 : " + intTagList[i]);

					studyDao.studyIntTagInsert(dto); // 회원관심 키워드 insert 실행시키기
				}
			}
			if (etcTagList.length > 0)
			{
				for (int i = 0; i < etcTagList.length; i++) // 선택한 모든 관심 기타 키워드 중에
				{
					// value에 따른 코드 뽑아내는 dao 호출

					dto.setEtc_tag_cd(etcTagList[i]); // 기타태그를 키워드에 세팅하고
					System.out.println("각 기타 : " + etcTagList[i]);

					studyDao.studyEtcTagInsert(dto); // 기타 키워드 insert 실행시키기

					int etcTagCount = studyDao.studyEtcTagCount(etcTagList[i]);

					if (etcTagCount == 10) // 회원 관심 기타 키워드 테이블 호출해서 10개일 경우
						studyDao.addTagName(etcTagList[i]); // 그냥 관심키워드 테이블에 insert 시키기

				}
			}
			if (dayList.length > 0)
			{
				for (int i = 0; i < dayList.length; i++)
				{
					dto.setStu_day_cd(dayList[i]);
					System.out.println("각 요일 : " + dayList[i]);

					studyDao.studyDayInsert(dto); // 진행 요일에 insert 시키기
				}
			}

			view = "redirect:studylist.action"; // 스터디 리스트 페이지로 이동

		}
		else
		{
			view = "redirect:studycreate.action"; // 스터디 개설 페이지 다시 요청
		}

		view = "redirect:studylist.action"; // 스터디 리스트 페이지로 이동

		return view;
	}

}
