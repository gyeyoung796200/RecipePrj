<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<h2 class="text-center mt-2">회원정보 수정페이지</h2>

<form action="${pageContext.request.contextPath }/member/modify" method="post" enctype="multipart/form-data">
<input type="hidden" name="member_id" value="${member.member_id }"/>



<div class="card align-self-center mt-5" style="background-color: ghostwhite;">
	<div class="align-self-center mt-3" id="img_container" style="border:1px solid blue; width:500px; height:300px;">
		<img src="${member.member_image }" class="img-responsive" style="width:100%; height:100%;">
	</div>
		<input type="file" class="form-control" name="file" id="InputImage">
		
		<script>
		
		$("#InputImage").change(function(){
			
			if(this.files && this.files[0]){
				
				var reader = new FileReader();
				
				reader.onload = function(data){
					
					$("#img_container img").attr("src", data.target.result);
				}
				reader.readAsDataURL(this.files[0]);
			}
		});	
		</script>

	<div class="card-body align-self-center">
	
		<div class="row mb-2">
			<div class="col-4 align-self-center">아이디</div>
			<div class="col-8">
				<input type="text" class="form-control" value="${member.member_id }" readonly="readonly">
			</div>
		</div>
	
		<div class="row mb-2">
			<div class="col-4 align-self-center">성별</div>
			<div class="col-8">
				<input type="text" class="form-control" value="${member.member_gender }" readonly="readonly">
			</div>
		</div>
		
		<hr/>
	
		<div class="text-center">
			<input type="submit" class="btn btn-primary" value="확인" />
		</div>
	</div>
</div>
</form>