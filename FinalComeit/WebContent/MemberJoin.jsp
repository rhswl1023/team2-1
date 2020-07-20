<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/assets/css/join.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/assets/css/studyCreate.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<script>
     $(function(){
    	 
    	 // AJAX 요청 및 응답 처리
    	 ajaxRequest();
    	 
         //모달을 전역변수로 선언
         var modalContents = $(".modal-contents");
         var modal = $("#defaultModal");
         
         $('.onlyAlphabetAndNumber').keyup(function(event){
             if (!(event.keyCode >=37 && event.keyCode<=40)) {
                 var inputVal = $(this).val();
                 $(this).val($(this).val().replace(/[^_a-z0-9]/gi,'')); //_(underscore), 영어, 숫자만 가능
             }
         });
         
         $(".onlyHangul").keyup(function(event){
             if (!(event.keyCode >=37 && event.keyCode<=40)) {
                 var inputVal = $(this).val();
                 $(this).val(inputVal.replace(/[a-z0-9]/gi,''));
             }
         });
     
         $(".onlyNumber").keyup(function(event){
             if (!(event.keyCode >=37 && event.keyCode<=40)) {
                 var inputVal = $(this).val();
                 $(this).val(inputVal.replace(/[^0-9]/gi,''));
             }
         });
         
         //------- 검사하여 상태를 class에 적용
         $('#id').keyup(function(event){
             
             var divId = $('#divId');
             
             if($('#id').val()==""){
                 divId.removeClass("has-success");
                 divId.addClass("has-error");
             }else{
                 divId.removeClass("has-error");
                 divId.addClass("has-success");
             }
         });
         
         $('#password').keyup(function(event){
             
             var divPassword = $('#divPassword');
             
             if($('#password').val()==""){
                 divPassword.removeClass("has-success");
                 divPassword.addClass("has-error");
             }else{
                 divPassword.removeClass("has-error");
                 divPassword.addClass("has-success");
             }
         });
         
         $('#passwordCheck').keyup(function(event){
             
             var passwordCheck = $('#passwordCheck').val();
             var password = $('#password').val();
             var divPasswordCheck = $('#divPasswordCheck');
             
             if((passwordCheck=="") || (password!=passwordCheck)){
                 divPasswordCheck.removeClass("has-success");
                 divPasswordCheck.addClass("has-error");
             }else{
                 divPasswordCheck.removeClass("has-error");
                 divPasswordCheck.addClass("has-success");
             }
         });
         
         $('#name').keyup(function(event){
             
             var divName = $('#divName');
             
             if($.trim($('#name').val())==""){
                 divName.removeClass("has-success");
                 divName.addClass("has-error");
             }else{
                 divName.removeClass("has-error");
                 divName.addClass("has-success");
             }
         });
         
         $('#email').keyup(function(event){
             
             var divEmail = $('#divEmail');
             
             if($.trim($('#email').val())==""){
                 divEmail.removeClass("has-success");
                 divEmail.addClass("has-error");
             }else{
                 divEmail.removeClass("has-error");
                 divEmail.addClass("has-success");
             }
         });
         
         $('#phoneNumber').keyup(function(event){
             
             var divPhoneNumber = $('#divPhoneNumber');
             
             if($.trim($('#phoneNumber').val())==""){
                 divPhoneNumber.removeClass("has-success");
                 divPhoneNumber.addClass("has-error");
             }else{
                 divPhoneNumber.removeClass("has-error");
                 divPhoneNumber.addClass("has-success");
             }
         });
         
         
         //------- validation 검사
         $( "form" ).submit(function( event ) {
             
             var provision = $('#provision');
             var memberInfo = $('#memberInfo');
             var divId = $('#divId');
             var divPassword = $('#divPassword');
             var divPasswordCheck = $('#divPasswordCheck');
             var divName = $('#divName');
             var divNickname = $('#divNickname');
             var divEmail = $('#divEmail');
             var divPhoneNumber = $('#divPhoneNumber');
             
             //회원가입약관
             if($('#provisionYn:checked').val()=="N"){
                 modalContents.text("회원가입약관에 동의하여 주시기 바랍니다."); //모달 메시지 입력
                 modal.modal('show'); //모달 띄우기
                 
                 provision.removeClass("has-success");
                 provision.addClass("has-error");
                 $('#provisionYn').focus();
                 return false;
             }else{
                 provision.removeClass("has-error");
                 provision.addClass("has-success");
             }
             
             //개인정보취급방침
             if($('#memberInfoYn:checked').val()=="N"){
                 modalContents.text("개인정보취급방침에 동의하여 주시기 바랍니다.");
                 modal.modal('show');
                 
                 memberInfo.removeClass("has-success");
                 memberInfo.addClass("has-error");
                 $('#memberInfoYn').focus();
                 return false;
             }else{
                 memberInfo.removeClass("has-error");
                 memberInfo.addClass("has-success");
             }
             
             //아이디 검사
             if($('#id').val()==""){
                 modalContents.text("아이디를 입력하여 주시기 바랍니다.");
                 modal.modal('show');
                 
                 divId.removeClass("has-success");
                 divId.addClass("has-error");
                 $('#id').focus();
                 return false;
             }else{
                 divId.removeClass("has-error");
                 divId.addClass("has-success");
             }
             
             //패스워드 검사
             if($('#password').val()==""){
                 modalContents.text("패스워드를 입력하여 주시기 바랍니다.");
                 modal.modal('show');
                 
                 divPassword.removeClass("has-success");
                 divPassword.addClass("has-error");
                 $('#password').focus();
                 return false;
             }else{
                 divPassword.removeClass("has-error");
                 divPassword.addClass("has-success");
             }
             
             //패스워드 확인
             if($('#passwordCheck').val()==""){
                 modalContents.text("패스워드 확인을 입력하여 주시기 바랍니다.");
                 modal.modal('show');
                 
                 divPasswordCheck.removeClass("has-success");
                 divPasswordCheck.addClass("has-error");
                 $('#passwordCheck').focus();
                 return false;
             }else{
                 divPasswordCheck.removeClass("has-error");
                 divPasswordCheck.addClass("has-success");
             }
             
             //패스워드 비교
             if($('#password').val()!=$('#passwordCheck').val() || $('#passwordCheck').val()==""){
                 modalContents.text("패스워드가 일치하지 않습니다.");
                 modal.modal('show');
                 
                 divPasswordCheck.removeClass("has-success");
                 divPasswordCheck.addClass("has-error");
                 $('#passwordCheck').focus();
                 return false;
             }else{
                 divPasswordCheck.removeClass("has-error");
                 divPasswordCheck.addClass("has-success");
             }
             
             //이름
             if($('#name').val()==""){
                 modalContents.text("이름을 입력하여 주시기 바랍니다.");
                 modal.modal('show');
                 
                 divName.removeClass("has-success");
                 divName.addClass("has-error");
                 $('#name').focus();
                 return false;
             }else{
                 divName.removeClass("has-error");
                 divName.addClass("has-success");
             }
             
             //이메일
             if($('#email').val()==""){
                 modalContents.text("이메일을 입력하여 주시기 바랍니다.");
                 modal.modal('show');
                 
                 divEmail.removeClass("has-success");
                 divEmail.addClass("has-error");
                 $('#email').focus();
                 return false;
             }else{
                 divEmail.removeClass("has-error");
                 divEmail.addClass("has-success");
             }
             
             //휴대폰 번호
             if($('#phoneNumber').val()==""){
                 modalContents.text("휴대폰 번호를 입력하여 주시기 바랍니다.");
                 modal.modal('show');
                 
                 divPhoneNumber.removeClass("has-success");
                 divPhoneNumber.addClass("has-error");
                 $('#phoneNumber').focus();
                 return false;
             }else{
                 divPhoneNumber.removeClass("has-error");
                 divPhoneNumber.addClass("has-success");
             }
             
         
         });
         
     });
     
 </script>
    </head>
    <body>
<div class="headerrow">
		<c:import url="header.jsp"></c:import>
</div>
        <div class="container"><!-- 좌우측의 공간 확보 -->
            <!-- 헤더 들어가는 부분 -->
            
            <div class="row">
                <p></p>
                <div class="col-md-12">
                    <small>
                    <a href="#">로그인</a> | <a href="#">메인페이지</a>
                    </small>
                </div>
            </div>
            <!--// 헤더 들어가는 부분 -->
            <!-- 모달창 -->
            <div class="modal fade" id="defaultModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title">알림</h4>
                        </div>
                        <div class="modal-body">
                            <p class="modal-contents"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            <!--// 모달창 -->
            <hr/>
            <!-- 본문 들어가는 부분 -->
                
 
 
            <form class="form-horizontal" role="form" method="post" action="javascript:alert( 'success!' );">
                <div class="form-group">
                    <label for="provision" class="col-lg-2 control-label">회원가입약관</label>
                    <div class="col-lg-10" id="provision">
                        <textarea class="form-control" rows="8" style="resize:none">약관동의
 약관내용
                        </textarea>
                        <div class="radio">
                            <label>
                                <input type="radio" id="provisionYn" name="provisionYn" value="Y" autofocus="autofocus" checked>
                                동의합니다.
                            </label>
                        </div>
                        <div class="radio">
                            <label>
                                <input type="radio" id="provisionYn" name="provisionYn" value="N">
                                동의하지 않습니다.
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group " id="divId">
                    <label for="inputId" class="col-lg-2 control-label">아이디</label>
                    <div class="col-lg-10 form-inline" >
                        <input type="text" class="form-control onlyAlphabetAndNumber" id="id" data-rule-required="true" placeholder="7~10자리 알파벳,숫자만 입력 가능합니다." maxlength="30"
                        style="width: 85%;">
                        &nbsp;
                        <button type="button" class="btn btn-primary">중복확인</button>
                    </div>
                </div>
                <div class="form-group" id="divPassword">
                    <label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
                    <div class="col-lg-10 form-inline">
                        <input type="password" class="form-control" id="password" name="excludeHangul" style="width: 85%;" data-rule-required="true" placeholder="7~10자리 알파벳, 숫자, 특수문자를 섞어 입력해야합니다." maxlength="30">
                    </div>
                </div>
                <div class="form-group" id="divPasswordCheck">
                    <label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드 확인</label>
                    <div class="col-lg-10 form-inline">
                        <input type="password" class="form-control" id="passwordCheck" data-rule-required="true" placeholder="패스워드 확인" maxlength="30" style="width: 85%;">
                    </div>
                </div>
                <div class="form-group" id="divName">
                    <label for="inputName" class="col-lg-2 control-label">이름</label>
                    <div class="col-lg-10 form-inline">
                        <input type="text" class="form-control onlyHangul" id="name" data-rule-required="true" placeholder="한글만 입력 가능합니다." maxlength="15" style="width: 85%;">
                    </div>
                </div>
                <div class="form-group" id="divEmail">
                    <label for="inputEmail" class="col-lg-2 control-label">이메일</label>
                    <div class="col-lg-10">
                        <input type="email" class="form-control form-inline" id="email" data-rule-required="true" placeholder="이메일" maxlength="40" style="width: 85%;">
                    </div>
                </div>
                
                
				<div class="form-group" id="divPosition">
				<label for="inputsinboon" class="col-lg-2 control-label">신분</label>
					<div class="col-lg-10">
					<select name="week" id="week" class="posiSel form-control" style="width: 450px;">
						<option value="0">신분 선택</option>
						<option value="1">취준생</option>
						<option value="2">대학생</option>
						<option value="3">직장인</option>
					</select>
					</div>
				</div><!-- end .position -->
					
					
				
				<div class="form-group" id="areaMemNum">
				<label for="areaMemNum" class="col-lg-2 control-label" >지역</label>	
					<div class="col-lg-10" style="float: left; width: 225px;" >
						<select name="area" id="area" class="area form-control">
							<option value="0">지역</option>
							<option value="seoul">서울</option>
							<option value="incheon">인천</option>
						</select>
					</div>
					<div class="col-lg-10" style="float: left; width: 225px;" >
						<select name="spcArea" id="spcArea" class="spcArea form-control" >
							<option value="0">상세 지역</option>
							<option value="mapogu">마포구</option>
							<option value="seogu">서구</option>
						</select>
					</div>
						<input type="button" value="등록" class="keyBtn btn btn-primary" />
				</div><!-- end .areaMemNum -->
				
				
                <div class="form-group" id="divPhoneNumber">
                    <label for="inputPhoneNumber" class="col-lg-2 control-label">휴대폰 번호</label>
                    <div class="col-lg-10 form-inline">
                        <input type="tel" class="form-control onlyNumber" id="phoneNumber" data-rule-required="true" placeholder="-를 제외하고 숫자만 입력하세요." maxlength="11" style="width: 85%;">
                        &nbsp;
                        <button type="button" class="btn btn-primary">휴대폰 인증</button>
                    </div>
                </div>
                <div class="form-group" id="divPhoneNumber">
                    <label for="inputPhoneNumber" class="col-lg-2 control-label">인증 번호</label>
                    <div class="col-lg-10 form-inline">
                        <input type="tel" class="form-control onlyNumber" id="phoneNumber" data-rule-required="true"  maxlength="11" style="width: 85%;">
                        &nbsp;
                        <button type="button" class="btn btn-primary">확인</button>
                    </div>
                </div>
                
                <div class="image form-group">
				<label for="inputPhoneNumber" class="col-lg-2 control-label">프로필 이미지</label>
                     <div class="col-lg-10 form-inline">
	                     	<input type="text" required="required" name="housing" id="aa2" class="form-control" style="width: 85%;"/>
	                		&nbsp;
	                		<button class="btn btn-primary" type="button" >등록</button>
                	 </div>
                </div>
				
				<div class="form-group">
                    <label for="inputPhoneNumber" class="col-lg-2 control-label">본인 소개</label>
                    <div class="col-lg-10 form-inline">
                    <input type="text" required="required" class="form-control" placeholder="예) 노트북 대여 가능한 스터디 카페입니다." maxlength="11" style="width: 85%;"/>
                    </div>
                </div>
                
			    <!-- 키워드 -->
			    <div class="form-group">
				<div class="stuKeyword">
					<label for="inputPhoneNumber" class="col-lg-2 control-label">관심 키워드(최대 5개까지 선택)</label>
					
				</div>
				<div class="stuKey1">
					<div class="stuKeySel">
						<div class="col-lg-10 form-inline">
							<select name="keySelect" id="keySelect" class="form-control keySelect">
								<option value="key1">java</option>
								<option value="key2">oracle</option>
								<option value="key3">jsp</option>
								<option value="key4">spring</option>
								<option value="key5">기타</option>
							</select>
							&nbsp;
							<input type="text" class="keyInput form-control" id="keyInput" 
								placeholder="관심 키워드를 입력해 주세요." style="width:30%"/>
							&nbsp;	
							<input type="button" value="추가" class="keyBtn btn btn-primary" />
							
						</div>
					</div>
					
					<br>
					
					<div>
					<div class="tagStyle">
						<span class="keyTag">
							# 자바
							<a href="" class="tag_delete">
							X
							</a>
						</span>
					</div>
					<div class="tagStyle">
						<span class="keyTag">
							# 오라클
							<a href="" class="tag_delete">
							X
							</a>
						</span>
					</div>
					<div class="tagStyle">
						<span class="keyTag">
							# 정보처리기사
							<a href="" class="tag_delete">
							X
							</a>
						</span>
					</div>
				</div><!-- end .stuKeyBox -->
					
				</div><!-- end .stuKey -->
				</div>
                <div class="form-group">
                    <div class="col-lg-offset-2 col-lg-10">
                        <button type="submit" class="btn btn-primary joinBtn">가입하기</button>
                    </div>
                </div>
            </form>
            </div>
<div class="row">
	<div class="col-md-12">
	<c:import url="footer.jsp"></c:import>
	</div>
</div>
</body>
</html>