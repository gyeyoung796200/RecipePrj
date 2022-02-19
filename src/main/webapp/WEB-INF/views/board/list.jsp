<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="d-flex w-100" style="flex-wrap: wrap;">
	<table class="table table-hover text-center">
	  <thead>
	    <tr>
	      <th width="10%" scope="col">No</th>
	      <th width="40%" scope="col">글제목</th>
	      <th width="15%" scope="col">작성자</th>
	      <th width="25%" scope="col">작성일</th>
	      <th width="10%" scope="col">조회수</th>
	    </tr>
	  </thead>
	  <tbody>
	  
	  <c:if test="${boardCount == 0 }">
	  	<tr>
			<td colspan="5">작성된 글이 없습니다</td>	  		
	  	</tr>
	  </c:if>
	  
	  <c:if test="${boardCount == 1}">
	  	
	  <c:forEach items="${board }" var="board">
	    <tr>
	      <th scope="row">${board.bno }</th>
	      <td><a href="${pageContext.request.contextPath }/board/read?bno=${board.bno }">${board.title }</a></td>
	      <td>${board.writer }</td>
	      <td><fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd HH:mm"/></td>
	      <td>${board.viewCnt }</td>
	    </tr>
	   </c:forEach>
	   </c:if>
	  </tbody>
	</table>
	
	<button type="button" class="btn btn-primary" id="write_btn">글작성</button>
</div>


<script>

$("#write_btn").click(function(){
	
	location.href= "${pageContext.request.contextPath}/board/write";
});
</script>
