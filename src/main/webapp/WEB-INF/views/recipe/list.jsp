<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container" style="">
	<div class="row">
		<div class="col-md-12" style="display:flex; justify-content: center;">
			<nav aria-label="Page navigation example">
			  <ul class="pagination" style="margin-bottom: 0px;">
			  
				<c:if test="${pageMaker.prev }">
				    <li class="page-item">
				      <%-- <a class="page-link" href="${pageContext.request.contextPath }/?page=${pageMaker.criteria.page -1}" aria-label="Previous"> --%>
				      <a class="page-link" href="${pageContext.request.contextPath }/${pageMaker.makeSearch(pageMaker.criteria.page-1)}" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
				</c:if>
			    
				<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
			    	<li class="page-item" <c:out value="${pageMaker.criteria.page == idx ? 'class=active' : '' }"/>> 
			    		<a class="page-link" href="${pageContext.request.contextPath }/recipe/search${pageMaker.makeSearch(idx)}">${idx }</a>
			    	</li>
			    </c:forEach>
			    
			    
			    <c:if test="${pageMaker.next }">
				    <li class="page-item">
				      <%-- <a class="page-link" href="${pageContext.request.contextPath }/?page=${pageMaker.criteria.page + 1}" aria-label="Next"> --%>
				      <a class="page-link" href="${pageContext.request.contextPath }/${pageMaker.makeSearch(pageMaker.criteria.page + 1)}" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
			    </c:if>
			  </ul>
			</nav>
		</div>
	</div>	
</div> 
	
<hr/>

<div class="album bg-light">
	<div class="container">
		<div class="row">
			<c:forEach var="cook" items="${recipe }">
			<div class="col-md-3">
				<div class="card mb-4 shadow-sm">
	              	<img alt="" src="${cook.recipe_image }">
	                <div class="card-body">
						<p class="card-text" style="text-align: center;"><a style="text-decoration: none;" href="${pageContext.request.contextPath }/recipe/info${pageMaker.makeSearch(pageMaker.criteria.page)}&recipe_no=${cook.recipe_no}">${cook.recipe_name }</a></p>
	                </div>
	                <div class="card-footer" style="text-align: center;">${cook.recipe_writer }</div>
				</div>
			</div>	
			</c:forEach>
			
		</div>
	</div>
</div>