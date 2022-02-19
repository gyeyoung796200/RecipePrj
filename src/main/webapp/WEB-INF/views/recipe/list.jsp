<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="row w-100" style=" margin: 20px auto;">

		<div class="d-flex w-100" style="margin-bottom: 20px;" >
			<div class="col-1" style="text-align: center; align-self: center; padding:0px;">
				<p style="margin:0px;">분류</p>
			</div>
			
			<div class="col-2">
				<select class="custom-select form-control" name="recipe_type" id="recipe_type" required>
		       		<option selected disabled value="">선택</option>
		       		<option value="k">한식</option>
		       		<option value="a">양식</option>
		       		<option value="c">중식</option>
		       		<option value="j">일식</option>
	     		</select>
	     	</div>
	     	
	     	<div class="col-1" style="align-self: center;">
	     		<button type="button" class="btn btn-success">확인</button>
			</div>
		</div>	
	<hr/>

	<c:forEach var="cook" items="${recipe }">
	
	<div class="col-3 mb-3">
	
		<div class="card" style="width: 100%; height: 200px; overflow: hidden;">
			<a href="${pageContext.request.contextPath }/recipe/info?recipe_no=${cook.recipe_no}"><img src="${cook.recipe_image }" class="card-img-top" style="width: 100%; height:auto;"></a>
		</div>
		
		<div class="card-body text-center">
			<p class="card-text text-center">${cook.recipe_name }</p>
		</div>
		
	 </div>
	</c:forEach>
</div> 


