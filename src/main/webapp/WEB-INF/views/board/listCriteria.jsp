<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container" style="flex-wrap: wrap;">
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
	      <td>
	      	<a href="${pageContext.request.contextPath }/board/read${pageMaker.makeSearch(pageMaker.criteria.page)}&bno=${board.bno}">${board.title }</a>
	      	<span class="badge bg-teal"><i class="fa fa-comment-o"></i> + ${board.replyCnt}</span>
	      </td>
	      <td>${board.writer }</td>
	      <td><fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd HH:mm"/></td>
	      <td>${board.viewCnt }</td>
	    </tr>
	   </c:forEach>
	   </c:if>
	  </tbody>
	</table>
	
	 <div class="w-100 justify-content-center">
	 
	 <div class="row">
	 
	 	<div class="col-2">
			<select class="form-control" name="searchType" id="searchType">
	            <option value="n" <c:out value="${searchCriteria.searchType == null ? 'selected' : ''}"/>>선택</option>
	            <option value="tcw" <c:out value="${searchCriteria.searchType eq 'tcw' ? 'selected' : ''}"/>>전체</option>
	            <option value="t" <c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
	            <option value="c" <c:out value="${searchCriteria.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
	            <option value="w" <c:out value="${searchCriteria.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
	        </select>
	 	</div>
	 	
	 	
	 	<div class="col-3">
	 		<div class="input-group">
		 		<input type="text" class="form-control" name="keyword" id="keywordInput" value="${searchCriteria.keyword }" placeholder="입력">
		 		<span>
		 			<button type="button" class="btn btn-primary btn-flat" id="searchBoard_Btn">검색</button>
		 		</span>
	 		</div> 
	 	</div>
	 	
	 	
	 	<div class="col-5 align-self-center">
	 		<nav aria-label="Page navigation example">
		 	 	<ul class="pagination justify-content-center" style="margin-bottom:0px;">
		            <c:if test="${pageMaker.prev}">
		                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/board/search${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
		            </c:if>
		            <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		                <li class="page-item" <c:out value="${pageMaker.criteria.page == idx ? 'class=active' : ''}"/>>
		                    <a class="page-link" href="${pageContext.request.contextPath}/board/search${pageMaker.makeSearch(idx)}">${idx}</a>
		                </li>
		            </c:forEach>
		            <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/board/search${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
		            </c:if>
	        	</ul>
	        </nav>
	 	</div>
	 	
		<div class="col-2">
			<button type="button" class="btn btn-primary" id="write_btn">글작성</button>
		</div>
		
		</div>
	 </div>
	
</div>


<script>

	$("#write_btn").click(function(){
		
		location.href= "${pageContext.request.contextPath}/board/write";
	});
	
	console.log($("#searchType option:selected").val());
	
	
	if($("#searchType option:selected").val() == 'n'){
		$("#searchBtn").attr("disabled", true);
	}
	
	
	$("#searchType").click(function(){
		
		if($("#searchType option:selected").val() == 'n'){
			$("#searchBtn").attr("disabled", true);
		}
		else if($("#searchType option:selected").val() != 'n'){
			
			$("#searchBtn").attr("disabled", false);
	
		}	
	});


    $("#searchBoard_Btn").on("click", function (event) {
        self.location =
            "${pageContext.request.contextPath}/board/search${pageMaker.makeQuery(1)}"
            + "&searchType=" + $("#searchType option:selected").val()
            + "&keyword=" + encodeURIComponent($("#keywordInput").val());
    });
</script>
