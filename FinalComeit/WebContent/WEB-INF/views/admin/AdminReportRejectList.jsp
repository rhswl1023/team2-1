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
<title>1_AdminReportRejectList.jsp</title>
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
		<h1 class="h3 mb-2 text-gray-800">신고 거부사유 목록</h1>
		<p class="mb-4">
			신고 거부 사유 목록을 볼 수 있는 페이지 입니다. <a target="_blank"
				href="https://datatables.net"> official DataTables documentation</a>.
		</p>

		<!-- DataTales Example -->
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">신고 거부 사유 목록</h6>
			</div>

			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr>
								<th>신고코드</th>
								<th>거부날짜</th>
								<th>거부사유</th>
								<th>신고 아이디</th>
								<th>신고유형</th>
								<th>관리자</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>신고코드</th>
								<th>거부날짜</th>
								<th>거부사유</th>
								<th>신고 아이디</th>
								<th>신고유형</th>
								<th>관리자</th>
							</tr>
						</tfoot>
						<tbody>
							<tr>
								<td>REP0001</td>
								<td>2020-06-12</td>
								<td>신고 사유가 적절하지 않습니다.</td>
								<td>abc123</td>
								<td>영리목적</td>
								<td>[관리자]신재민</td>
							</tr>
							<tr>
								<td>REP0001</td>
								<td>2020-06-12</td>
								<td>신고 사유가 적절하지 않습니다.</td>
								<td>abc123</td>
								<td>영리목적</td>
								<td>[관리자]신재민</td>
							</tr>
							<tr>
								<td>REP0001</td>
								<td>2020-06-12</td>
								<td>신고 사유가 적절하지 않습니다.</td>
								<td>abc123</td>
								<td>영리목적</td>
								<td>[관리자]신재민</td>
							</tr>
							<tr>
								<td>REP0001</td>
								<td>2020-06-12</td>
								<td>신고 사유가 적절하지 않습니다.</td>
								<td>abc123</td>
								<td>영리목적</td>
								<td>[관리자]신재민</td>
							</tr>
							<tr>
								<td>REP0001</td>
								<td>2020-06-12</td>
								<td>신고 사유가 적절하지 않습니다.</td>
								<td>abc123</td>
								<td>영리목적</td>
								<td>[관리자]신재민</td>
							</tr>
							<tr>
								<td>REP0001</td>
								<td>2020-06-12</td>
								<td>신고 사유가 적절하지 않습니다.</td>
								<td>abc123</td>
								<td>영리목적</td>
								<td>[관리자]신재민</td>
							</tr>
							<tr>
								<td>REP0001</td>
								<td>2020-06-12</td>
								<td>신고 사유가 적절하지 않습니다.</td>
								<td>abc123</td>
								<td>영리목적</td>
								<td>[관리자]신재민</td>
							</tr>
							<tr>
								<td>REP0001</td>
								<td>2020-06-12</td>
								<td>신고 사유가 적절하지 않습니다.</td>
								<td>abc123</td>
								<td>영리목적</td>
								<td>[관리자]신재민</td>
							</tr>
							<tr>
								<td>REP0001</td>
								<td>2020-06-12</td>
								<td>신고 사유가 적절하지 않습니다.</td>
								<td>abc123</td>
								<td>영리목적</td>
								<td>[관리자]신재민</td>
							</tr>
							<tr>
								<td>REP0001</td>
								<td>2020-06-12</td>
								<td>신고 사유가 적절하지 않습니다.</td>
								<td>abc123</td>
								<td>영리목적</td>
								<td>[관리자]신재민</td>
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