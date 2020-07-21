/*
package com.sys.comeit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class LoginController
{
   @Autowired
   private SqlSession sqlSession;
   
   @RequestMapping(value = "/memberlogin.action", method = RequestMethod.GET)
   public String memberLogin(Model model)
   {
      String view = null;
      
      view = "/WEB-INF/views/member/MemberLogin.jsp";
      
      return view;
   }
   
   @RequestMapping(value = "/login.action", method = RequestMethod.POST)
   public String memberLoginCheck(HttpServletRequest request)
   {
         
      String result = null;
      
      IMemberDAO memDao = sqlSession.getMapper(IMemberDAO.class);
      ISpaDAO spaDao = sqlSession.getMapper(ISpaDAO.class);
      IAdminDAO admDao = sqlSession.getMapper(IAdminDAO.class);
      
      String id = request.getParameter("formUsername");
      String pwd = request.getParameter("formPassword");
      String loginType = request.getParameter("loginType");
      String name = null;
      int stopCount = 0;
      
      
      // 로그인 정보 확인 및 정지 여부 조회
      //! loginType = "0" 일반 회원 로그인, "1" 업체 회원 로그인 , "2" 관리자 로그인
      if (loginType.equals("0")) 
      {
         MemberDTO dto = new MemberDTO();

          dto.setId(id);
          dto.setPwd(pwd);  
          
          name = memDao.memberLogin(dto);
          stopCount = memDao.stopSearch(id);
      }
      else if(loginType.equals("1")) 
      {
         SpaDTO dto = new SpaDTO();
         
         dto.setSpa_id(id);
         dto.setPwd(pwd);
         
         name = spaDao.spaLogin(dto);
      }
      else if(loginType.equals("2"))
      {
         AdminDTO dto = new AdminDTO();
         
         dto.setAdmin_cd(id);
         dto.setPwd(pwd);
         
         name = admDao.adminLogin(dto);
      }
      
     
      // 로그인 실패시
      if (name == null||name=="" ) 
      {
         request.setAttribute("msg", "아이디와 패스워드가 일치하지 않습니다.");
         result = "redirect:memberlogin.action";
      }
      else if(stopCount != 0)      // 정지된 내역이 있을시
      {
         
         result = "/WEB-INF/views/header.jsp";
      }
      else          // 로그인 성공시
      {
         HttpSession session = request.getSession();
         
         session.setAttribute("name", name);
         session.setAttribute("id", id);
         session.setAttribute("pwd", pwd);     
         session.setAttribute("loginType", loginType);
         
         if (loginType.equals("2"))                   // 관리자 로그인
            result = "";
         else                                     // 업체 및 회원 로그인
            result = "/WEB-INF/views/MainPage.jsp";
      }
      
      // 테스트
      //System.out.println(name+id+pwd+loginType); 
      
      return result;
      
   }
}
*/