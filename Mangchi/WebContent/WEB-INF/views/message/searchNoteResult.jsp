<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.0.1">
<title>M A N G C H | 쪽지함</title>

<link rel="canonical"
	href="https://getbootstrap.com/docs/4.5/examples/carousel/">

<!-- Bootstrap core CSS -->
<link rel='stylesheet'
	href='<c:url value="/assets/dist/css/bootstrap.css"/>'>
<link rel='stylesheet' href='<c:url value="/css/default.css"/>'>
<!-- Custom styles for this template -->
<link href='<c:url value="/css/carousel.css"/>' rel="stylesheet">
<style>
div.wrap {
	margin: 100px;
	height: 500px;
}

div.noteBox {
	height: 450px;
}

div.SendNoteArea {
	display: none;
}

div.contentsArea {
	height: 450px;
	overflow: auto;
}

table.box {
	width: 800px;
	color: #AAAAAA;
}

.check_ok {
	color: green;
}

.check_not {
	color: red;
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>
	function messageListDel(idx) {
		if (confirm('해당 메시지를 정말로 삭제하시겠습니까?')) {
			location.href = 'messageDelete.do?idx=' + idx;
		}
	}

	function messageDel(idx) {
		if (confirm('해당 메시지를 정말로 삭제하시겠습니까?\n삭제된 메시지는 복구할 수 없습니다.')) {
			location.href = 'messageDelete.do?idx=' + idx;
		}
	}

	$(document).ready(function() {

		$('#reBox').click(function() {
			$('div.ReNoteArea').css('display', 'block');
			$('div.SendNoteArea').css('display', 'none');

		});

		$('#seBox').click(function() {
			$('div.ReNoteArea').css('display', 'none');
			$('div.SendNoteArea').css('display', 'block');
		});

		$('.msgcheck').click(function() {
			$('.onlycheck').attr('checked');

		});

		$('.sendmsgcheck').click(function() {
			$('.sendonlycheck').attr('checked');
		});

		$('a.view').click(function() {

			$.ajax({
				url : 'readCheck.do',
				data : {
					idx : $(this).param()
				},
				success : function(data) {
					if (data = 'Y') {
						$('#checkmsg').text("읽음");
						$('#checkmsg').addClass('check_ok');
					} else {
						$('#checkmsg').text("읽지않음");
						$('#checkmsg').addClass('check_not');
					}
				}
			});
		});

	});
</script>
</head>
<body>
	<c:if test="${loginInfo==null}">
		<script>
			alert('쪽지는 로그인을 해야 이용이 가능합니다.');
			location.href = '<c:url value="/member/loginForm.do"/>';
		</script>
	</c:if>
	<%@ include file="/WEB-INF/views/include/header.jsp"%>
	<div class="wrap">

		<div class="boxarea" id="noteBoxArea">
			<button class="btn btn-outline-success my-2 my-sm-0" id="reBox"
				type="button"><a href="<c:url value="/message/messageBox.do"/>">쪽지함으로 돌아가기</a></button>

		</div>
		<hr>
		<div class="contentsArea">
			<div class="noteBox ReNoteArea">
				<c:if test="${searchNoteList.messageList != null}">
					<table class="table table-hover">
						<tr>
							<th scope="col"><input type="checkbox" name="msgCheck"
								class="msgcheck allcheck" id="msgAllCheck"></th>
							<th scope="col">받은이</th>
							<th scope="col">보낸이</th>
							<th scope="col">제목</th>
							<th scope="col">날짜</th>
							<th scope="col">삭제</th>
						</tr>
						<c:forEach items="${searchNoteList.messageList}" var="notes">
							<c:if test="${loginInfo.member_id eq notes.msg_receiver}">
								<tr>
									<th scope="row"><input type="checkbox" name="msgCheck"
										class="msgcheck onlycheck" id="msg${notes.msg_idx}Check"></th>
									<td>${notes.msg_receiver}</td>
									<td>${notes.msg_writerId}</td>
									<td><a class="view"
										href="/message/noteview.do?idx=${notes.msg_idx}">${notes.msg_title}</a>
									</td>
									<td>${notes.msg_date}</td>
									<td><a href="javascript:messageDel(${notes.msg_idx})">
											<svg width="1em" height="1em" viewBox="0 0 16 16"
												class="bi bi-trash" fill="currentColor"
												xmlns="http://www.w3.org/2000/svg">
  <path
													d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z" />
  <path fill-rule="evenodd"
													d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z" />
</svg>
									</a></td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
				</c:if>

				<c:if test="${searchNoteList.messageList==null}">

					<h3>검색 결과가 존재하지 않습니다.</h3>

				</c:if>
				<div class="paging">
					<c:forEach begin="1" end="${noteList.pageTotalCount}" var="num">
						<a href="messageList.do?page=${num}"
							${noteList.currentPageNumber eq num ? 'class="currentPage"' : '' }>[${num}]</a>
					</c:forEach>
				</div>


			</div>

		</div>
	</div>



	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script>
	window.jQuery
			|| document
					.write('<script src="<c:url value='/assets/js/vendor/jquery.slim.min.js'/>"><\/script>')
</script>
<script src="<c:url value='/assets/dist/js/bootstrap.bundle.js'/>"></script>
</body>