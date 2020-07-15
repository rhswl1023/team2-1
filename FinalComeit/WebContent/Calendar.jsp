<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%@page import="java.util.Calendar"%>

<%
  // 오늘 날짜로 달력 취득
  Calendar currentCal = Calendar.getInstance();
  Calendar todayCheck_currentCal = Calendar.getInstance();

  // request 객체로 부터 넘어온 값이 있으면 처리
  if(request.getParameter("year") != null){
   currentCal.set(Calendar.YEAR, Integer.parseInt(request.getParameter("year")));
  }
  if(request.getParameter("month") != null){
   currentCal.set(Calendar.MONTH, Integer.parseInt(request.getParameter("month")));
  }
    
  // 날을 1일로 셋팅
  currentCal.set(Calendar.DATE, 1);
  
  // 1일의 '요일'을 취득
  int oneDayNum = currentCal.get(Calendar.DAY_OF_WEEK);
  // 현재달의 최대 일 수
  int monthMaxNum = currentCal.getActualMaximum(Calendar.DAY_OF_MONTH);
  // 현재달의 주 수
  int weekSize = currentCal.getActualMaximum(Calendar.WEEK_OF_MONTH);
  // 현재 '년'을 취득
  int year = currentCal.get(Calendar.YEAR);
  // 현재 '월'을 취득(0월 부터 11월 까지)
  int month = currentCal.get(Calendar.MONTH);
  // 현재 '일'을 취득
  int day = currentCal.get(Calendar.DATE);
  //int day = currentCal.get(Calendar.DAY_OF_MONTH);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calendar.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<script language="javascript">
 function goCalendar(){
  var form = document.calendarTextBoxForm;

  if( (form.year.value == "") ) {
   alert("'년'을 입력 주세요");
   return;
  }
  if( form.year.value < 1970 ){
   alert("1970년 1월 1일 이후로 검색해 주세요.");
   return;
  }
  if( (form.month.value == "") ) {
   alert("'월'을 입력 주세요");
   return;
  }
  if( (form.month.value < 1) || form.month.value > 12) {
   alert("'월'을 올바르게 입력 주세요");
   return;
  }
  form.month.value = form.month.value - 1;
  form.action="Calendar.jsp";
  form.target = "_self";
  form.submit();
 }

 function goMonth(month){
  var form = document.calendarHiddenForm;

  if( (<%=year%> <= 1970) && (month == -1) ){
   alert("1970년 1월 1일 이후로 검색해 주세요.");
   return;
  }
  if(month==-1){
   form.year.value = <%=year-1%>;
   form.month.value = 11;
  }else if(month==12) {
   form.year.value = <%=year+1%>;
   form.month.value = 0;
  }else{
   form.year.value = <%=year%>;
   form.month.value = month;
  }

  form.action="Calendar.jsp";
  form.target = "_self";
  form.submit();
 }
</script>
</head>
<body>

<table border="0">
 <tr height="30">
  <td width="30" align="center"> <a href="javascript:goMonth(<%=month-1%>);">◀</a> </td>
  <td width="150" align="center"> <%=year %> 년 <%=month+1 %> 월 </td>
  <td width="30" align="center"> <a href="javascript:goMonth(<%=month+1%>);">▶</a></td>
 </tr> 
</table>


<table border="0" cellpadding="0" cellspacing="0">
 <tr height="30" bgcolor="#dcdcdc">
  <td width="30" align="center">일</td>
  <td width="30" align="center">월</td>
  <td width="30" align="center">화</td>
  <td width="30" align="center">수</td>
  <td width="30" align="center">목</td>
  <td width="30" align="center">금</td>
  <td width="30" align="center">토</td>
 </tr>
 
 <%

  //int dayNum = 1;
  boolean dayCheck = false;

  // 현재 달의 주 수만큰 반복
  for(int i=0; weekSize > i;i++){
   out.println("<tr height='25'>");
   
   // 일주일이 7일 이니 7번 반복
   for(int j=0; (7 > j); j++){
    out.println("<td align='center'>");
    
    // 현재 달의 1을의 요일에 해당하는 곳부터 출력하기위함
    if(oneDayNum == j+1 || dayCheck){
     // 현재 달의 최대 일수일경우
     if(monthMaxNum >= day ){
      /// 일요일의 경우 글자색 '빨강'
      if(currentCal.get(Calendar.DAY_OF_WEEK) == 1){
       // 일요일이면서 오늘일 경우 글자색은 '빨강', 글자 진하게 아니면 글자색만 '빨강'
       if(todayCheck_currentCal.equals(currentCal)){
        out.println("<font color='red'><b>" + day + "</b></font>");
       }else{
        out.println("<font color='red'>" + day + "</font>");
       }
       currentCal.set(Calendar.DATE, ++day);
       dayCheck = true;
      // 토요일의 경우 글자색 '파랑'
      }else if(currentCal.get(Calendar.DAY_OF_WEEK) == 7){
       // 토요일이면서 오늘일 경우 글자색은 '파랑', 글자 진하게 아니면 글자색만 '파랑'
       if(todayCheck_currentCal.equals(currentCal)){
        out.println("<font color='blue'><b>" + day + "</b></font>");
       }else{
        out.println("<font color='blue'>" + day + "</font>");
       }
       currentCal.set(Calendar.DATE, ++day);
       dayCheck = true;
      // 일요일도 아니고 토요일도 아니면 기본속성 글자출력 
      }else {
       //  일요일도 아니고 토요일도 아닌데 오늘이면 글자진하게
       if(todayCheck_currentCal.equals(currentCal)){
       out.println("<b>" + day + "</b>");
       }else{
        out.println(day);
       }
       currentCal.set(Calendar.DATE, ++day);
       dayCheck = true;
      }
       
     }else{
      out.println("&nbsp;");
     }
    }else{
     out.println("&nbsp;");
    }
    
    out.println("</td>");
    
   }
   out.println("</tr>");
  }

 %>
 
</table>

<!-- ◀ / ▶ 에 해당하는 폼 -->
<form name="calendarHiddenForm" method="post">
 <input type="hidden" name="year" value="" />
 <input type="hidden" name="month" value="" />
</form>

<!-- TextBox 에 해당하는 폼 -->
<form name="calendarTextBoxForm" method="post">
 <input type="text" name="year" size="5" value="" maxlength="4" /> 년
 <input type="text" name="month"size="3" value="" maxlength="2" /> 월
 <input type="button" onclick="javascript:goCalendar();" value="이동" />
</form>
  

</body>
</html>