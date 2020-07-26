package com.sys.comeit;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sys.comeit.util.MyUtil;

@Controller
public class LectureController
{
	@Autowired
	private SqlSession sqlSession;

	// 강의 등록 FORM에서 지역, 기간, 요일 리스트 던져주기
	@RequestMapping(value = "/lecturecreate.action", method =
	{ RequestMethod.GET, RequestMethod.POST })
	public String lectureCreate(Model model)
	{
		String view = null;

		IAreaDAO areaDao = sqlSession.getMapper(IAreaDAO.class);
		IIntTagDAO intTagDao = sqlSession.getMapper(IIntTagDAO.class);

		model.addAttribute("area", areaDao.areaList());
		model.addAttribute("intTag", intTagDao.intTagList());

		view = "WEB-INF/views/lecture/LectureCreate.jsp";

		return view;
	}

	@RequestMapping(value = "/lectureinsert.action", method =
	{ RequestMethod.GET, RequestMethod.POST })
	public String lectureInsert(Model model, HttpServletRequest request)
	{
		ILectureDAO lectureDao = sqlSession.getMapper(ILectureDAO.class);

		String view = "";

		// String lec_cd = request.getParameter("id");
		String prof_cd = "PROF1001"; //
		String spc_area_cd = request.getParameter("spcArea");
		String lec_term_cd = request.getParameter("lecTerm");
		String lec_name = request.getParameter("lecName"); //
		String str_date = request.getParameter("start"); //
		int lec_fee = Integer.parseInt(request.getParameter("lecFee"));
		String lec_intro = request.getParameter("lecIntro"); //
		String min_mem = request.getParameter("minMem");
		String max_mem = request.getParameter("maxMem");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");

		LectureDTO dto = new LectureDTO();

		dto.setLec_name(lec_name);
		dto.setProf_cd(prof_cd);
		dto.setSpc_area_cd(spc_area_cd);
		dto.setLec_term_cd(lec_term_cd);
		dto.setLec_name(lec_name);
		dto.setStr_date(str_date);
		dto.setLec_fee(lec_fee);
		dto.setLec_intro(lec_intro);
		dto.setMin_mem(min_mem);
		dto.setMax_mem(max_mem);
		dto.setStr_hrs(startTime);
		dto.setEnd_hrs(endTime);

		lectureDao.lectureInsert(dto);

		String lec_cd = dto.getLec_cd();
		System.out.println(lec_cd);

		String[] dayTagList = request.getParameterValues("dayTagList");		
		String[] intTagList = {};
		String[] etcTagList = {};
		
		if(request.getParameterValues("intTagList")!=null)
		{
			intTagList = request.getParameterValues("intTagList"); // 선택한 모든 관심 키워드 배열에 넣기
		}
		
		if(request.getParameterValues("etcTagList")!=null)
		{
			etcTagList = request.getParameterValues("etcTagList"); // 선택한 모든 관심 기타 키워드 배열에 넣기
		}
		System.out.println("그냥 관심 : " + intTagList.length);
		System.out.println("기타 관심 : " + etcTagList.length);
		
		// 관심키워드 DB INSERT
		if (lec_cd != null)
		{
			// 관심키워드가 존재할 때 INSERT
			if (intTagList.length > 0)
			{
				for (int i = 0; i < intTagList.length; i++)
				{
					dto.setInt_tag_cd(intTagList[i]);

					System.out.println("각 관심 : " + intTagList[i]);

					lectureDao.insertIntTag(dto);
				}
			}
			// 기타 키워드가 존재할 때 INSERT
			if (etcTagList.length > 0)
			{
				for (int i = 0; i < etcTagList.length; i++)
				{
					dto.setEtc_tag(etcTagList[i]);
					System.out.println("각 기타 키워드 : " + etcTagList[i]);

					lectureDao.insertEtcTag(dto); // 기타 키워드 INSERT

					int etcTagCount = lectureDao.etcTagCount(etcTagList[i]);

					if (etcTagCount == 10)
						lectureDao.addTagName(etcTagList[i]);

				}
			}

			// 강의 진행 일시 INSERT
			if (dayTagList.length > 0)
			{
				for (int i = 0; i < dayTagList.length; i++)
				{
					dto.setDay_cd(dayTagList[i]);
					lectureDao.addLecturePrgTime(dto);	
				}
			}

		}

		return view;
	}
	
	
	// 강의 리스트 화면 노출하기
	@RequestMapping(value = "/lecturelist.action", method = {RequestMethod.GET, RequestMethod.POST})
	public String memberJoin(Model model, HttpServletRequest request) throws UnsupportedEncodingException
	{
		String view = null;
		
		IAreaDAO areaDao = sqlSession.getMapper(IAreaDAO.class); // 지역
		ILectureDAO lecDao = sqlSession.getMapper(ILectureDAO.class); // 스터디 정보
		
		
		//String lec_cd = 
		//System.out.println(lec_cd);
		
		model.addAttribute("area", areaDao.areaList());

		model.addAttribute("lec", lecDao.lecList()); // 실제 스터디 리스트
		model.addAttribute("count", lecDao.lecCount());
		
		
		model.addAttribute("lecTags", lecDao.lecTagList()); // 하나의 스터디의 모든 키워드
		model.addAttribute("lecHrDays", lecDao.lecHrDaySearch());  // 하나의 스터디의 요일, 시간
		
		// 페이징 처리 --------------------------------------

		MyUtil util = new MyUtil();

		String pageNum = request.getParameter("pageNum"); // 페이지 번호? 왜 삭제 버튼에서..?

		int currentPage = 1;
		if (pageNum != null && pageNum.length() != 0)
		{
			currentPage = Integer.parseInt(pageNum);
		}

		String searchKey = null;
		String searchValue = null;

		searchKey = request.getParameter("searchKey");
		searchValue = request.getParameter("searchValue");

		if (searchKey == null)
		{
			searchKey = "int_tag_name";
			searchValue = "";
		}

		if (request.getMethod().equalsIgnoreCase("GET"))
		{
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}

		LectureDTO dto = new LectureDTO();

		dto.setSearchKey(searchKey);
		dto.setSearchValue(searchValue);

		// 전체 데이터 개수
		int dataCount = lecDao.lecSearchCount(dto); // 검색 완료된 데이터 개수

		// 전체 페이지 수 구하기
		int numPerPage = 10;
		int totalPage = util.getPageCount(numPerPage, dataCount);

		// 전체 페이지 수 보다 현재 표시할 페이지가 큰 경우
		if (totalPage < currentPage)
		{
			currentPage = totalPage;
		}

		// 테이블에서 가져올 리스트들의 시작과 끝 위치
		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;

		System.out.println("start : " + start);
		System.out.println("end : " + end);

		dto.setStart(start);
		dto.setEnd(end);

		// 테이블에서 리스트를 출력할 데이터 가져오기
		List<LectureDTO> lecture = lecDao.getListData(dto);

		String params = "";
		if (searchValue != null && searchValue.length() != 0)
		{
			searchValue = URLEncoder.encode(searchKey, "UTF-8");
			params = "searchKey=" + searchKey + "&searchValue=" + searchValue;
		}

		String cp = request.getContextPath();

		// 페이징 처리
		String listUrl = cp + "/lecturelist.action";
		if (params.length() != 0)
		{
			listUrl += "?" + params;
		}

		String pageIndexList = util.pageIndexList(currentPage, totalPage, listUrl);

		// 포워딩할 studylist.jsp 에 넘겨준다.
		request.setAttribute("lecture", lecture);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("dataCount", dataCount);
		

		view = "WEB-INF/views/lecture/LectureList.jsp";

		return view;
	}

	// 강의 리스트에서 강의 클릭 시 비밀번호 확인 AJAX 처리
	@ResponseBody
	@RequestMapping(value = "/lecscrtcheck.action", method =
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

}
