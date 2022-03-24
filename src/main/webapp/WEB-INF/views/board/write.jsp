<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>글 작성 페이지</title>


<div class="container" style="display: flex; justify-content: center;">
	<div class="col-6 card">
		<form id="write_form" role="form" action="${pageContext.request.contextPath }/board/write" method="post">
		<input type="hidden" name="writer" value="${login.member_id }"/>
		  <div class="form-group">
		    <label for="input_title">제목</label>
		    <input type="text" name="title" class="form-control" id="input_title">
		  </div>
		  <div class="form-group">
		    <label for="input_writer">작성자</label>
		    <input type="text" name="writer" class="form-control" id="input_writer" value="${login.member_id }" disabled="disabled">
		  </div>
		  <div class="form-group">
		    <label for="input_content">내용</label>
		    <textarea class="form-control" name="content" id="input_content" rows="3"></textarea>
		  </div>
		  
		    <div class="form-group">
		    	<label for="input_b_pwd">비밀번호</label>
		    	<input type="password" name="b_pwd" id="b_pwd" class="form-control">
		   </div>
		   
		   <div class="form-group">
		    	<label for="input_b_pwd">비밀번호체크</label>
		    	<input type="password" id="b_pwdChk" class="form-control">
		   </div>
		  
		  
		  
		  <div class="form-group">
		  	<button type="button" class="btn btn-primary" id="write_btn" onclick="write_chk()" >등록</button>
		  	<button type="button" class="btn btn-danger">목록</button>
		  </div>
		</form>
	</div>
</div>


<script>



function write_chk(){
	
	pwd = $("#b_pwd").val();
	pwd_chk = $("#b_pwdChk").val();

	
	if(pwd == pwd_chk){
		
		$("#write_form").submit();
	}
	else if(pwd != pwd_chk){
		alert("비밀번호가 일치하지 않습니다");
		return false;
	}
}
</script>