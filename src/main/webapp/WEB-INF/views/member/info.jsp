<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="container">
<h2 class="text-center mt-2">회원정보</h2>

<form action="${pageContext.request.contextPath }/member/modify" method="get">
<input type="hidden" name="member_id" value="${member.member_id }"/>

<div class="card align-self-center mt-3" style="background-color: ghostwhite;">
	
	<div class="row">
		<div class="col-2"></div>
		<div class="col-8 align-self-center mt-3" style="width:100%; height:auto;">
			<img src="${member.member_image }" class="img-responsive" style="width:100%; height:100%;">
		</div>
		<div class="col-2"></div>
	</div>

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
		

		<div class="row mb-2">
			<div class="col-4 align-self-center">가입일</div>
			<div class="col-8">
			
				
				<input type="text" class="form-control" value="<fmt:formatDate value="${member.member_regdate }" pattern="yyyy-MM-dd HH:mm"/>" readonly="readonly">
			</div>
		</div>
		
		<div class="row mb-2">
			<div class="col-4 align-self-center">최근수정일</div>
			<div class="col-8">
				<input type="text" class="form-control" value="<fmt:formatDate value="${member.member_updatedate }" pattern="yyyy-MM-dd HH:mm"/>" readonly="readonly">
			</div>
		</div>		
		
		<hr/>
	
		<div class="text-center">
			<button type="submit" class="btn btn-primary">프로필수정</button>
			<button class="btn btn-danger">뒤로</button>
		</div>
	</div>
</div>

</form>
</div>