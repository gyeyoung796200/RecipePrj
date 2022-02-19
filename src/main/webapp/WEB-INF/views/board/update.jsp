<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <div class="container">
	<h2 class="text-center mt-2">글 수정페이지</h2>
	<div class="w-100">
		<form id="update_form"  action="${pageContext.request.contextPath }/board/update"  method="post">
		<input type="hidden" name="bno" value="${board.bno }"/>
		<input type="hidden" name="page" value="${searchCriteria.page }"/>
		<input type="hidden" name="perPageNum" value="${searchCriteria.perPageNum }"/>
		<input type="hidden" name="searchType" value="${searchCriteria.searchType }"/>
		<input type="hidden" name="keyword" value="${searchCriteria.keyword }"/>
		
			
	 	 <div class="form-group">
		    <label for="read_bno">글번호</label>
		    <input type="text" name="bno" class="form-control" value="${board.bno }" id="read_bno" disabled="disabled">
		  </div>
		  <div class="form-group">
		    <label for="read_title">제목</label>
		    <input type="text" name="title" class="form-control" value="${board.title }" id="read_title">
		  </div>
		  <div class="form-group">
		    <label for="input_writer">작성자</label>
		    <input type="text" name="writer" class="form-control" id="input_writer" value="${board.writer }" disabled="disabled">
		  </div>
		  <div class="form-group">
		    <label for="input_content">내용</label>
		    <textarea class="form-control" name="content" id="input_content" rows="5" >${board.content }</textarea>
		  </div>
		  
		  <div class="form-group">
		  	<button type="submit" class="btn btn-success" id="update_btn">수정</button>
		  	<button type="button" class="btn btn-danger" id="cancel_btn">이전</button>
		  	<button type="button" class="btn btn-primary" id="list_btn">목록</button>
		  </div>
		</form>
	</div>
</div>


<script>



$(document).ready(function(){
	
var form = $("#update_form");	

	console.log(form);
	
	
	$("#update_btn").click(function(){
		form.attr("method", "post");
		form.attr("action", "${pageContext.request.contextPath}/board/update");
		form.submit();
	});
	
	
	$("#list_btn").click(function(){
		
		form.attr("method", "get");
		form.attr("action", "${pageContext.request.contextPath}/board/search");
		form.submit();
	});
	
	$("#cancel_btn").click(function(){
		
		history.go(-1);
	});

});

</script>

