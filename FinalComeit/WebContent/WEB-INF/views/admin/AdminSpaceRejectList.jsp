<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1_AdminList.jsp</title>
<style type="text/css">
#btnTbl {
	text-align: center;
}
</style>
</head>
<body>

	<!-- Begin Page Content -->
	<div class="container-fluid">

		<!-- Page Heading -->
		<h1 class="h3 mb-2 text-gray-800">업체 거부사유 목록</h1>
		<p class="mb-4">
			업체 거부사유를 볼 수 있는 페이지입니다. <a target="_blank"
				href="https://datatables.net"> official DataTables documentation</a>.
		</p>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">업체 거부사유 목록</h6>
			</div>

			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr>
								<th>요청코드</th>
								<th>업체명</th>
								<th>업체아이디</th>
								<th>거부사유</th>
								<th>거부일자</th>
								<th>처리 관리자</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>요청코드</th>
								<th>업체명</th>
								<th>업체아이디</th>
								<th>거부사유</th>
								<th>거부일자</th>
								<th>처리 관리자</th>
							</tr>
						</tfoot>
						<tbody>
							<tr>
								<td>ASR0001</td>
								<td>우리스터디 카페</td>
								<td>ABC123</td>
								<td>업체 정보가 옳바르지 않음.</td>
								<td>2020-07-11</td>
								<td>[관리자] 신재민</td>
							</tr>
							<tr>
								<td>ASR0001</td>
								<td>우리스터디 카페</td>
								<td>ABC123</td>
								<td>업체 정보가 옳바르지 않음.</td>
								<td>2020-07-11</td>
								<td>[관리자] 신재민</td>
							</tr>
							<tr>
								<td>ASR0001</td>
								<td>우리스터디 카페</td>
								<td>ABC123</td>
								<td>업체 정보가 옳바르지 않음.</td>
								<td>2020-07-11</td>
								<td>[관리자] 신재민</td>
							</tr>
							<tr>
								<td>ASR0001</td>
								<td>우리스터디 카페</td>
								<td>ABC123</td>
								<td>업체 정보가 옳바르지 않음.</td>
								<td>2020-07-11</td>
								<td>[관리자] 신재민</td>
							</tr>
							<tr>
								<td>ASR0001</td>
								<td>우리스터디 카페</td>
								<td>ABC123</td>
								<td>업체 정보가 옳바르지 않음.</td>
								<td>2020-07-11</td>
								<td>[관리자] 신재민</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>
	<!-- /.container-fluid -->



</body>

</html>