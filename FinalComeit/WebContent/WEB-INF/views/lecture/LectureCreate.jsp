<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LectureCreate.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=cp%>/assets/css/blog-post.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/assets/css/lectureCreate.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/assets/css/join.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">

	.ui-datepicker-trigger { position:relative; height:25px; width:25px; }

</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>

<script type="text/javascript">
	var keyArray = new Array();
	var dayArray = new Array();
	var minMem = 0;
	var maxMem = 0;

	$(function() {
		// AJAX 요청 및 응답 처리
		ajaxSpcAreaRequest();
		
		// submit 하기 전에 입력폼 유효성 검사
		$("#insertBtn").click(function() 
		{	
			if ($("#lecName").val() == "" || $("#lecIntro").val() == "" || $("#lecFee").val() == ""
				|| $("#spcArea").val() == 0 || $("#minMem").val() == 0 || $("#maxMem").val() == 100
				|| $("#startTime").val() == -1 || $("#endTime") == -1)
            {
             	$("#err").html("필수 입력 항목이 누락되었습니다.");
             	$("#err").css("display", "inline");
             	return;
            }
			
			if($(".stuKeyBox").children().length == 0)
            {
			   alert($("#stuKeyBox").children().length);
               $("#err").html("관심 키워드는 최소 한 개 이상 선택해야 합니다.");
               $("#err").css("display", "inline");
               return;
            }
			
			if($(".weekBox").children().length == 0)
			{
				$("#err").html("모임 지정요일은 최소 한 개 이상 선택해야 합니다.");
	            $("#err").css("display", "inline");
	            return;
			}
			
			$("#joinForm").submit();
		});
		
		// datePicker
		$("#start").datepicker(
		{
			showOn: "both",
			buttonImage: "<%=cp%>/assets/images/calendar.PNG",
			buttonImageOnly: true,
			buttonText: "Select date",
			dateFormat: 'yy-mm-dd'
		});
		
		// 숫자만 입력할 수 있도록 하는 처리
		$(".onlyNumber").keyup(function(event) {
			if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^0-9]/gi, ''));
			}
		});

		//------- 검사하여 상태를 class에 적용
		$('#id').keyup(function(event) {

			var divId = $('#divId');

			if ($('#id').val() == "") {
				divId.removeClass("has-success");
				divId.addClass("has-error");
			} else {
				divId.removeClass("has-error");
				divId.addClass("has-success");
			}
		});

		// 지역명이 바뀌면 상세지역 ajax 호출
		$("#area").change(function() {
			ajaxSpcAreaRequest();

		});

		// 관심 키워드 추가 버튼
		$("#keyAddBtn")
				.click(
						function() {
							var tmpHtml = "";
							var selectedKey = "";
							var keyInput = "";

							tmpHtml = tmpHtml + "";

							selectedText = $("#keySelect option:checked")
									.text();
							selectedValue = $("#keySelect option:checked")
									.val();
							keyInput = $("#keyInput").val();
							elementCount = $(".stuKeyTag").length;

							if (selectedValue == 'INT1057') {
								selectedText = keyInput;
							}

							for (var i = 0; i < keyArray.length; i++) {
								if (selectedText == keyArray[i]) {
									alert(selectedText)
									alert("중복된 키워드는 입력 할 수 없습니다.");
									return;
								}
							}
							if (selectedText.trim() == "") {
								alert("공백은 입력할 수 없습니다.");
								return;
							}

							// 키워드 개수 제한
							if (elementCount == 5) {
								alert("키워드는 최대 5개 까지 선택 할 수 있습니다.")
								return;
							}

							keyArray.push(selectedText);

							if (selectedValue == 'INT1057') {

								$(".stuKeyBox")
										.append(
												"<div class='tagStyle'><span class='stuKeyTag'>"
														+ selectedText
														+ "<input type='hidden' name='etcTagList' value='"+ selectedText + "'></span></div>");
							}
							// 관심키워드 일 때...
							else {
								$(".stuKeyBox")
										.append(
												"<div class='tagStyle'><span class='stuKeyTag'>"
														+ selectedText
														+ "<input type='hidden' name='intTagList' value='"+ selectedValue + "'></span></div>");
							}

						});

		// 요일 추가 버튼
		$("#dayAddBtn")
				.click(
						function() {
							var tmpHtml = "";
							var selectedDay = "";
							var selectedValue = "";

							tmpHtml = tmpHtml + "";

							selectedText = $("#week option:checked").text();
							selectedValue = $("#week option:checked").val();
							elementCount = $(".dayTag").length;
							
							// 기본 설정값("요일")이 들어가지 않도록 필터링
							if(selectedValue == 0)
							{
								alert("요일을 추가해 주세요.");
								return;
							}
							

							for (var i = 0; i < dayArray.length; i++) {
								if (selectedValue == dayArray[i]) {
									alert(selectedValue);
									alert("중복된 요일은 입력 할 수 없습니다.");
									return;
								}
							}

							// 키워드 개수 제한
							if (elementCount == 5) {
								alert("키워드는 최대 5개 까지 선택 할 수 있습니다.")
								return;
							}

							dayArray.push(selectedValue);

							$(".weekBox")
									.append(
											"<div class='tagStyle'><span class='dayTag'>"
													+ selectedText
													+ "<input type='hidden' name='dayTagList' value='"+ selectedValue + "'></span></div>");

						});

		$("#keySelect").change(function() {
			var selectedValue = "";
			// alert("셀렉트값 변경");

			selectedValue = $("#keySelect option:checked").val();

			if (selectedValue == "INT1057") {
				$("#keyInput").attr("readonly", false);
			} else {
				$("#keyInput").attr("readonly", true);
			}
		});

		// 관심 키워드 삭제 버튼
		$("#keyResetBtn").click(function() {
			$(".stuKeyBox").empty();
			keyArray = [];
		});
		
		// 요일 삭제 버튼
		$("#dayResetBtn").click(function() {
			$(".weekBox").empty();
			dayArray = [];
		});

		// 최소 인원, 모집 인원이 변할 때, 인원 유효성 체크
		$("#minMem").change(function() {
			
			minMem = $("#minMem").val();
			maxMem = $("#maxMem").val();
			
			alert("최소인원 : " + minMem);
			alert("최대인원 : " + maxMem);
			
			if (minMem > maxMem) 
			{
				alert("최대인원이 최소인원보다 적습니다.1");
				
				$("#minMem").val($("#minMem option:first").val());
				$("#maxMem").val($("#maxMem option:first").val());
				
				/* $("#minMem").find('option:first').attr('selected', 'selected');
				$("#maxMem").find('option:first').attr('selected', 'selected'); */
				/* $("#minMem").val(previousMin).prop("selected", true);
				$("#maxMem").val(previousMax).prop("selected", true); */
			}
		});

		// 최소 인원, 모집 인원이 변할 때, 인원 유효성 체크
		$("#maxMem").change(function() {
			
			minMem = $("#minMem").val();
			maxMem = $("#maxMem").val();
			
			alert("최소인원 : " + minMem);
			alert("최대인원 : " + maxMem);
			
			if (minMem > maxMem) 
			{
				alert("최대인원이 최소인원보다 적습니다.2");
				
				$("#minMem").val($("#minMem option:first").val());
				$("#maxMem").val($("#maxMem option:first").val());
				
				/* $("#minMem").find('option:first').attr('selected', 'selected');
				$("#maxMem").find('option:first').attr('selected', 'selected'); */
				/* $("#minMem").val(previousMin).prop("selected", true);
				$("#maxMem").val(previousMax).prop("selected", true); */
			}
		});
		
	});

	function ajaxSpcAreaRequest() {

		$.post("areaajax.action", {
			area_cd : $("#area").children("option:selected").val()
		}, function(data) {
			//alert(data);
			$("#spcAreaDiv").html(data);
			$("#spcArea").removeAttr("disabled");
		});
	}
</script>

</head>
<body class="paading">
	<!-- 헤더 -->
	<div class="row">
		<div class="col-md-12">
			<%-- <c:import url="WEB-INF/views/header.jsp"></c:import> --%>
		</div>
	</div>
	<!-- row -->

	<div class="container-fluid">

		<!-- 스터디 개설 문구 -->
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div class="boardName">
					<h1>강의 개설</h1>
					<hr />
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
		
		<form id="joinForm" class="form-horizontal" role="form" method="post" action="lectureinsert.action">
		<!-- 리스트 -->
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<!-- 스터디방 제목 -->
				<div class="stuTitle">
					<h4>
						제목<span class="ePoint">*</span>
					</h4>
				</div>
				<div class="stuTitle">
					<input type="text" class="studyTitle form-control" id="lecName"
						name = "lecName" placeholder="강의 제목을 입력해 주세요." /> <span class="titleErr">
						제목은 필수 입력항목입니다. </span>
				</div>
				<!-- 스터디방 상세 내용 -->
				<div class="stuContent form-inline">
					<h4>
						강의소개<span class="ePoint">*</span>
					</h4>
				</div>
				<div class="stuContent">
					<textarea id="lecIntro" name="lecIntro" class="form-control" rows="8"
						placeholder="강의를 소개해주세요. "></textarea>
					<span class="contentErr"> 상세 커리큘럼은 필수 입력항목입니다. </span>
				</div>
				<!-- 키워드 -->
				<div class="stuKeyword">
					<h4>
						관심 키워드<span class="ePoint">*</span>
					</h4>
					<span class="check">최대 5개</span>
				</div>
				<div class="stuKey">
					<div class="stuKeySel">
						<select name="keySelect" id="keySelect"
							class="form-control keySelect">
							<option value="0">관심 키워드</option>
							<c:forEach var="intTag" items="${intTag }">
								<option value="${intTag.int_tag_cd }">${intTag.int_tag }</option>
							</c:forEach>
						</select>
					</div>
					<div class="stuKeyInput">
						<input type="text" class="keyInput form-control" id="keyInput"
							readonly = "readonly" placeholder="관심 키워드를 입력해 주세요." />
					</div>
					<div class="stuKeyBtn">
						<input type="button" value="추가" id="keyAddBtn"
							class="keyBtn btn btn-primary" /> <input type="button"
							id="keyResetBtn" value="초기화" class="keyBtn btn btn-primary" />
					</div>
					<div class="stuKeyBox"></div>
					<!-- end .stuKeyBox -->
				</div>
				<!-- end .stuKey -->
				<div class="areaMemNum" style="width: 990px;">
					<h4>
						활동지역<span class="ePoint">*</span>
					</h4>

					<div>
						<select name="area" id="area" class="area form-control" style="display: inline;">
							<option value="0">지역</option>
							<c:forEach var="areas" items="${area }">
								<option value="${areas.area_cd }"
									${areas.area_cd == spcArea.area_cd ? "selected= \"selected\"" : ""}>
									${areas.area_name }</option>
							</c:forEach>
						</select>

						<!-- div 안에있는 select 문은 AjaxJoinSpcArea.jsp에서 가져온다 -->
						<div id="spcAreaDiv"></div>
					</div>

					<!-- <select name="spcArea" id="spcArea" class="spcArea form-control">
						<option value="0">상세 지역</option>
						<option value="mapogu">마포구</option>
						<option value="seogu">서구</option>
					</select> -->
				</div>
				<div class="areaMemNum" style="width: 990px;">
					<h4 style="display: inline;">
						최소인원<span class="ePoint">*</span>
					</h4>
					<select class="form-control" id="minMem" name="minMem"
						style="width: 50px; padding: 0px; display: inline;">
						<option value="00">최소인원</option>
						<option value="01">1</option>
						<option value="02">2</option>
						<option value="03">3</option>
						<option value="04">4</option>
						<option value="05">5</option>
						<option value="06">6</option>
						<option value="07">7</option>
						<option value="08">8</option>
						<option value="09">9</option>
						<option value="10">10</option>
					</select> <span class="m">명</span> <br>
					<h4>
						최대인원<span class="ePoint">*</span>
					</h4>
					<select class="form-control"
						style="width: 50px; padding: 0px; display: inline;" id="maxMem"
						name="maxMem">
						<option value="99">최대인원</option>
						<option value="01">1</option>
						<option value="02">2</option>
						<option value="03">3</option>
						<option value="04">4</option>
						<option value="05">5</option>
						<option value="06">6</option>
						<option value="07">7</option>
						<option value="08">8</option>
						<option value="09">9</option>
						<option value="10">10</option>
					</select> <span class="m">명</span>

				</div>
				<!-- end .areaMemNum -->

				<div class="period">
					<h4>
						시작날짜<span class="ePoint">*</span>
					</h4>
					<input type="text" class="start form-control" id="start" name="start"
						placeholder="ex) 시작날짜를 선택하세요." readonly="readonly"/>

					<h4>
						기간<span class="ePoint">*</span>
					</h4>
					<select name="lecTerm" id="lecTerm" class="termSel form-control">
						<option value="0">강의기간</option>
						<option value="LECTE1001">1개월</option>
						<option value="LECTE1002">3개월</option>
						<option value="LECTE1003">6개월</option>
						<option value="LECTE1004">12개월</option>
					</select>
				</div>
				<!-- end . period -->
				<div class="time">
					<h4>
						강의시작시간<span class="ePoint">*</span>
					</h4>
					<select name="startTime" id="startTime" class="termSel form-control">
						<option value="-1">시간</option>
						<option value="0">0시</option>
						<option value="1">1시</option>
						<option value="2">2시</option>
						<option value="3">3시</option>
						<option value="4">4시</option>
						<option value="5">5시</option>
						<option value="6">6시</option>
						<option value="7">7시</option>
						<option value="8">8시</option>
						<option value="9">9시</option>
						<option value="10">10시</option>
						<option value="11">11시</option>
						<option value="12">12시</option>
						<option value="13">13시</option>
						<option value="14">14시</option>
						<option value="15">15시</option>
						<option value="16">16시</option>
						<option value="17">17시</option>
						<option value="18">18시</option>
						<option value="19">19시</option>
						<option value="20">20시</option>
						<option value="21">21시</option>
						<option value="22">22시</option>
						<option value="23">23시</option>
					</select>
					
					<h4>
						강의종료시간<span class="ePoint">*</span>
					</h4>
					<select name="endTime" id="endTime" class="termSel form-control">
						<option value="-1">시간</option>
						<option value="0">0시</option>
						<option value="1">1시</option>
						<option value="2">2시</option>
						<option value="3">3시</option>
						<option value="4">4시</option>
						<option value="5">5시</option>
						<option value="6">6시</option>
						<option value="7">7시</option>
						<option value="8">8시</option>
						<option value="9">9시</option>
						<option value="10">10시</option>
						<option value="11">11시</option>
						<option value="12">12시</option>
						<option value="13">13시</option>
						<option value="14">14시</option>
						<option value="15">15시</option>
						<option value="16">16시</option>
						<option value="17">17시</option>
						<option value="18">18시</option>
						<option value="19">19시</option>
						<option value="20">20시</option>
						<option value="21">21시</option>
						<option value="22">22시</option>
						<option value="23">23시</option>
					</select>
				</div>
				
				<div class="money">
					<h4>
						수강료<span class="ePoint">*</span>
					</h4>
					<input type="text" class="lecmoney form-control onlyNumber"
						id="lecFee" name="lecFee" placeholder="수강료를 입력하세요."
						style="display: inline;" />
				</div>

				<div class="weekTitle">
					<h4>
						모임 지정 요일<span class="ePoint">*</span>
					</h4>
				</div>
				<!-- end .weekTitle -->
				<div class="weekDay">
					<select name="week" id="week" class="weekSel form-control">
						<option value="0">요일</option>
						<option value="DAY1002">월요일</option>
						<option value="DAY1003">화요일</option>
						<option value="DAY1004">수요일</option>
						<option value="DAY1005">목요일</option>
						<option value="DAY1006">금요일</option>
						<option value="DAY1007">토요일</option>
						<option value="DAY1008">일요일</option>
						<option value="DAY1010">매일</option>
						<option value="DAY1008">주말</option>
						<option value="DAY1009">주중</option>
					</select> <input type="button" value="추가" class="weekBtn btn btn-primary"
						id="dayAddBtn" readonly="readonly" /> <input type="button" value="초기화"
						class="weekBtn btn btn-primary" id="dayResetBtn" />

					<div>
						<div class="weekBox"></div>
						<!-- end .weekBox -->
					</div>

				</div>
				<!-- end .weekDay -->

				<div class="button">
					<div class="cancel">
						<input type="button" name="cancelBtn" id="cancelBtn" value="취소" class="btn btn-default" />
					</div>
					<!-- end .cancel -->
					<div class="upload">
						<input type="button" name="insertBtn" id="insertBtn" value="개설" class="btn btn-primary" />
					</div>
					
					<div class="errMsg">
                          <span id="err"></span>
                    </div>
					<!-- end .upload -->
				</div>
				<!-- end .button -->


			</div>
			<!-- end .col-md-8 -->
			<div class="col-md-2"></div>
		</div>
		</form>
	</div>
	<!-- end .container-fluid -->

	<!-- 푸터 -->
	<div class="row">
		<div class="col-md-12">
			<%-- <c:import url="WEB-INF/views/footer.jsp"></c:import> --%>
		</div>
	</div>
</body>
</html>