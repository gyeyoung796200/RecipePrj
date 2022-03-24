<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container" style="display: flex; justify-content: center;">
	<div class="col-5 card" style="border-right: 1px solid gray;">
		<form role="form" id="read_form" action="${pageContext.request.contextPath }/board/update" method="get">
		<input type="hidden" name="bno" value="${board.bno }"/>
		<input type="hidden" name="page" value="${searchCriteria.page }"/>
		<input type="hidden" name="perPageNum" value="${searchCriteria.perPageNum }"/>
		<input type="hidden" name="searchType" value="${searchCriteria.searchType }"/>
		<input type="hidden" name="keyword" value="${searchCriteria.keyword }"/>
		
		  <div class="form-group row">
		  	<div class="col-12"><label for="read_title">제목 : ${board.title }</label></div>
		  </div>
		  
		  <div class="form-group">
		    <label for="read_content">내용</label>
		    <textarea class="form-control" name="content" id="read_content" rows="3" disabled="disabled">${board.content }</textarea>
		  </div>
		  
		  <div class="form-group">
		    <label for="read_writer">작성자</label>
		    <div class="row">
		    	<div class="col-3">
		    		<div class="img-box" style="width: 100px; height: 100px; position: relative;">
		    			<img alt="" src="${board.member_image }" class="img-fluid" style="width:100%; height:100%; position: absolute; top:0; left:0; right:0; bottom:0; border-radius: 50%;">
		    		</div>
					<p style="text-align: center;">${board.writer }</p>		    		
		    		<%-- <input type="text" style="text-align:center;" name="writer" class="form-control" id="read_writer" value="${board.writer }" disabled="disabled"> --%>
		    	</div>
				<div class="col-9">
					<div class="form-group">
					    <label for="read_regdate">등록일:</label>
					    <fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd HH:mm"/>
					    <br/>
					    <label for="read_updatedate">수정일:</label>
					    <fmt:formatDate value="${board.updatedate }" pattern="yyyy-MM-dd HH:mm"/>
					    <br/>
					    <label for="read_viewCnt">조회수:${board.viewCnt }</label>
					    <br/>
					    
					    <c:if test="${login.member_id == board.writer }">
						  	<button type="submit" class="btn btn-success" id="update_btn">수정</button>
						  	<button type="button" class="btn btn-danger" id="delete_btn" data-toggle="modal" data-target="#delete_btn_Modal">삭제</button>
						</c:if>
					  	<button type="button" class="btn btn-primary" id="list_btn">목록</button>
					    
					</div>
				</div>
		    </div>
		  </div>
		  
		</form>
		
		<hr/>
		
		<!-- 댓글 입력 -->
		<c:if test="${not empty login}">
		<div class="box box-warning">
		    <div class="box-body">
		        <form class="form-horizontal">
		            <div class="form-group margin row">
		                
		                <div class="col-10">
		                    <textarea class="form-control" id="newReplyText" name="reply_text" rows="3" placeholder="댓글내용" style="resize: none"></textarea>
		                </div>
		                
		                	<div class="col-2">
		                		<input class="form-control" id="newReplyWriter" type="text" value="${login.member_id }" style="text-align:center;" disabled="disabled">
		                		<button type="button" class="btn btn-primary btn-block" id="replyAddBtn" style="margin-top:10px;">저장</button>
		                	</div>
		            
		            </div>
		        </form>
		    </div>
		</div>
		</c:if>
		
		<c:if test="${empty login }">
			  <p class="btn btn-default btn-block" role="button">
                <i class="fa fa-edit"></i> 로그인 한 사용자만 댓글 등록이 가능합니다.
              </p>
		</c:if>
		
		<hr/>
		<!-- 댓글 입력 end -->
		
		
		
	</div>
	
	
	<div class="col-7 card">
	
	<!-- 댓글목록 -->
		
		<a href="" class="link-black text-lg" data-toggle="collapse" data-target="#repliesData"><i class="fa fa-comments-o margin-r-5 replyCount"></i></a>
		
		
		<%--댓글 유무 / 댓글 갯수 / 댓글 펼치기, 접기--%>
		<div class="box box-success collapsed-box collapse" id="repliesData">
		    
		    <div class="box-header with-border">
				<div class="box-tools">
					<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i></button>
				</div>
			</div>
			    
			    <%--댓글 목록--%>
			    <div class="box-body repliesDiv"><!-- 댓글 데이터 --></div>
			    
			    <%--댓글 페이징--%>
			    <div class="box-footer">
			        <div class="text-center">
			            <ul class="pagination pagination-sm no-margin"><!-- 페이징 데이터 --></ul>
			        </div>
			    </div>
			</div>
			
	</div>		
	<!-- 댓글목록 end -->
	
	
	
</div>


<!-- modify Modal -->
<div class="modal fade" id="modifyModal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">댓글 수정</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="replyNo">댓글 번호</label>
                    <input class="form-control" id="reply_no" name="reply_no" readonly>
                </div>
                <div class="form-group">
                    <label for="replyText">댓글 내용</label>
                    <textarea class="form-control" id="reply_text" name="reply_text" rows="3" style="resize: none;"></textarea>
                </div>
                <div class="form-group">
                    <label for="replyWriter">댓글 작성자</label>
                    <input class="form-control" id="reply_writer" name="reply_writer" readonly>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="modalModBtn">수정</button>
                <button type="button" class="btn btn-danger" id="modalDelBtn">삭제</button>
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
  </div>


<!-- delete Modal -->
<div class="modal fade" id="delete_btn_Modal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
	        <div class="modal-header">
        		<h5 class="modal-title" id="deleteModalLabel">댓글삭제</h5>
        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        	</div>
        
        	<div class="modal-body">
               <p style="vertical-align:middle;">댓글을 삭제하시겠습니까?</p>
             </div>
        
          	<div class="modal-footer">
            	<a class="btn btn-primary" id="modal_reply_delBtn">삭제</a>
        		<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        	</div>	
        	
       	</div>
   	   </div>
	</div>

<script id="replyTemplate" type="text/x-handlebars-template">
{{#each.}}
	<li data-reply_no = {{reply_no}} class="replyLi" style="list-style:none;">
		
	<div>
		<div class=" row">
			
			<div class="col-2">

				<div style="width:50px; height:50px; position:relative;">

					<div style="position:absolute; top:0; left:0; right:0; bottom:0;">
						<img src="{{member_image}}" class="" style="width:100%; height:100%;  border-radius:50%;">
						<p class="reply_writer">{{reply_writer}}</p>
					</div>
				</div>
				<br/>
			</div>
 
  			<div class=" col-10">
				<textarea class="text-justify reply_text" rows="2" disabled="disabled" style="resize:none; width:100%;">{{escape reply_text}}</textarea>
  			</div>

		</div>
	</div>
						
	<p>{{prettifyDate reply_regdate }}
		{{#eqReplyWriter reply_writer}}
		<span>
			<button type="button" id="modalBtn" class="btn btn-sm btn-success" data-toggle="modal" data-target="#modifyModal">수정</button>
			<button type="button" id="delBtn" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#delete_btn_Modal">삭제</button>
		</span>
		{{/eqReplyWriter}}
	</p>
		

  </li>
<hr/>
{{/each}}
</script>

<script type="text/javascript">
$(document).ready(function(){

	var data = $("#replyTemplate").html();
	
	var template = Handlebars.compile(data);
	
	/* console.log(dummy); */
	
	
	//사용자가 다를 버튼 활성유무 조건
	Handlebars.registerHelper("eqReplyWriter", function(reply_writer, block){
		
		var accum = "";		
		v2 = "${login.member_id}";
		
		if(reply_writer === v2){
			
			console.log(reply_writer+"="+v2+"같다");
			accum += block.fn(); 
		}
		
		return accum;
		
	});
	
	//댓글 내용 : 줄바꿈 / 공백 처리
	Handlebars.registerHelper("escape", function(reply_text){
		
		var text = Handlebars.Utils.escapeExpression(reply_text);
		
		text = text.replace(/(\r\n|\r)/gm, "<br/>");
		text = text.replace(/( )/gm, "&nbsp;");
		
		return new Handlebars.SafeString(text);
	});
	
	//댓글 등록일자 : 날짜/시간 2자리로 맞추기
	Handlebars.registerHelper("prettifyDate", function(timeValue){
		
		var dateObj = new Date(timeValue);
		
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		var hours = dateObj.getHours();
		var minutes = dateObj.getMinutes();
		
		//2자리 숫자로 변환
		month < 10 ? month = '0'+ month : month;
		date < 10 ? date = '0'+ date : date;
		hours < 10 ? hours= '0'+ hours : hours;
		minutes < 10 ? minutes= '0'+minutes : minutes;
		
		return year + "-" + month + "-" + date + " " + hours + ":" + minutes;
	});
	
	
	var bno = ${board.bno}; //현재 게시글 번호
	var replyPageNum = 1; //댓글 페이지 번호 초기화
	
	//댓글 목록 함수 호출
	getReplies("${pageContext.request.contextPath}/replies/" + bno + "/" + replyPageNum);
	
	//댓글 목록 함수
	function getReplies(repliesUri){
		
		$.getJSON(repliesUri, function(data){
			
			printReplyCount(data.pageMaker.totalCount);
			printReplies(data.replies, $(".repliesDiv"), $("#replyTemplate"));
			printReplyPaging(data.pageMaker, $(".pagination"));
		});
	};
	
	//댓글 개수 출력 함수
	function printReplyCount(totalCount){
		
		var replyCount = $(".replyCount");
		var collapsedBox = $(".collapsed-box");
		
		//댓글이 없으면
		if(totalCount == 0){
			
			replyCount.html("댓글이 없습니다");
			collapsedBox.find(".btn-box-tool").remove();
			return;
		}
		
		//댓글이 존재하면
		replyCount.html("댓글 목록 (" + totalCount +")");
		collapsedBox.find(".box-tools").html(
				"<button type='button' class='btn btn-box-tool' data-widget='collapse'></button>"
		);
	};
	
	//댓글 목록 출력 함수
	function printReplies(replyArr, targetArea, templateObj){
		
		var replyTemplate = Handlebars.compile(templateObj.html());
		var html = replyTemplate(replyArr);
		$(".replyLi").remove();
		targetArea.html(html);
	};
	
	//댓글 페이징 출력 함수
	function printReplyPaging(pageMaker, targetArea){
	
		var str = "";
		if(pageMaker.prev){
			str += "<li><a href='" + (pageMaker.startPage -1) + "'>이전</a></li>";
		}
		
		for(var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){
			
			var strClass = pageMaker.criteria.page == i ? 'class=active' : "";
			
			str += "<li " + strClass +"><a href='" + i +"'>" + i + "</a></li>";
		}
		
		if(pageMaker.next){
			str += "<li><a href='" + (pageMaker.endPage + 1) +"'>다음</a></li>";
		}
		
		targetArea.html(str);
	};
	
	//댓글 페이지 번호 클릭 이벤트
	$(".pagination").on("click", "li a", function(event){
		
		event.preventDefault();
		
		replyPageNum = $(this).attr("href");
		
		getReplies("/replies/" + bno + "/" + replyPageNum);
	});
	
	
	//댓글 수정 클릭시 데이터 가져오기
	$(".repliesDiv").on("click",".replyLi", function(event){
		
		var reply = $(this);
		
		$("#reply_no").val(reply.attr("data-reply_no"));
		
		$("#reply_text").val(reply.find(".reply_text").text());
		
		$("#reply_writer").val(reply.find(".reply_writer").text());
		
		var modifyBtn = reply.find("#modalModBtn");
	});
	
	//댓글 삭제 
	$("#modal_reply_delBtn").on("click", function(){
		
		var replyNo = $("#reply_no").val();
		console.log("삭제될 번호:"+ replyNo);
		
		
		$.ajax({
			type : "delete",
			url : "/replies/" + replyNo,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : "text",
			success : function(result){

				if(result == "delSuccess"){
					
					alert("댓글이 삭제되었습니다");
					
					$("#delete_btn_Modal").modal("hide");
					
					getReplies("${pageContext.request.contextPath}/replies/" + bno + "/" + replyPageNum);
				}
			}
		});
	});
		
	
	//모달 페이지에서 수정 버튼 클릭시
	$("#modalModBtn").on("click", function(){
		
		var replyNo = $("#reply_no").val();
		var replyText = $("#reply_text").val();
		var replyWriter = $("#reply_writer").val();
		
		console.log(replyNo+"," +replyText + "," +replyWriter);
		
		
		console.log("replyWriter :"+replyWriter);
		console.log("newReplyWriter : "+$("#newReplyWriter").val());
		
		$.ajax({
			
			type : "put",
			url : "/replies/" + replyNo,
			headers : {
				
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"
			},
			dataType : "text",
			data : JSON.stringify({
				
				reply_no : replyNo,
				reply_text : replyText,
				reply_writer : replyWriter
			}),
			
			success : function(result){
				
				console.log("result :" + result);
				
				if(result == "updateSuccess"){
					
					alert("댓글이 수정되었습니다");
					
					$("#modifyModal").modal("hide");
					
					getReplies("${pageContext.request.contextPath}/replies/" + bno + "/" + replyPageNum);
				}
			}
		});
		
		
	});
	
	
	//댓글 저장 버튼 클릭 이벤트
	$("#replyAddBtn").on("click", function(){
		
		
		//입력폼 선택자
		var replyWriterObj = $("#newReplyWriter");
		var replyTextObj = $("#newReplyText");
		
		var replyWriter = replyWriterObj.val();
		var replyText = replyTextObj.val();
		
		$.ajax({
			
			type : "post",
			url : "/replies",
			dataType : "text",
			headers : {
	            "Content-Type" : "application/json",
	            "X-HTTP-Method-Override" : "POST"
	        },
			data : JSON.stringify({
				bno : bno,
				reply_text : replyText,
				reply_writer : replyWriter
			}),
			
			success : function(result){
				
				console.log(result);
				
				if(result == "regSuccess"){
					
					alert("댓글이 등록되었습니다");
					
					//댓글 등록하고서 1페이지로 초기화
					replyPageNum = 1;
					
					//댓글 목록 함수 호출
					getReplies("/replies/" + bno + "/" + replyPageNum);
					
					replyTextObj.val("");
				}
			}
		});
	});
	
})
</script>


<script>
function del_board(){
		
		var b_pwd = $("#delete_board_pw").val();
		
		var form = $("#delete_board");
		
		var bno = ${board.bno};
		
		$.ajax({
			url : "/board/findPassword",
			type : "post",
			data : { bno : bno },
			success : function(pwd){
				
				console.log("ajax 결과 비밀번호는:"+pwd);
				
				if(pwd == b_pwd){
					
					alert("비밀번호가 일치하여 삭제됩니다");
					form.submit();
				}
				else if(pwd != b_pwd){
					alert("비밀번호가 일치하지않습니다");
					return false;
				}
			}
		})
	}
	
	var form = $("#read_form");
	
	$("#list_btn").click(function(){
		form.attr("method", "get");
		form.attr("action", "${pageContext.request.contextPath}/board/search");
		form.submit();
	});
	
	$("#update_btn").click(function(){
		form.attr("method", "get");
		form.attr("action", "${pageContext.request.contextPath}/board/update");
		form.submit();
		
	});		
</script>