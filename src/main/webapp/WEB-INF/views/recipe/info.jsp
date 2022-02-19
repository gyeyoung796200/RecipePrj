<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<!-- ckeditor script -->
<%-- <script src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script> --%>

<!-- handlebars 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>


<!-- summernote script -->
<script src="${pageContext.request.contextPath }/resources/summernote/lang/summernote-ko-KR.js"></script>
<script src="${pageCOntext.request.contextPath }/resources/summernote/summernote-lite.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/summernote/summernote-lite.css">

<style>
.recipe_row{width:100%; padding-bottom: 15px;}

 .star_rating {font-size:0; letter-spacing:-4px;}
 .star_rating a {
      font-size:22px;
      letter-spacing:0;
      display:inline-block;
      margin-left:5px;
      color:#ccc;
      text-decoration:none;
  }
  .star_rating a:first-child {margin-left:0;}
  .star_rating a.on {color:#777;}
  
</style>

<div class="w-100" style="margin: 0 auto; padding-left: 25%; padding-right: 25%; background-color: ghostwhite;">

	<form role="form" id="recipeInfoForm">
	<input type="hidden" name="recipe_no" value="${cook.recipe_no }"/>
	<input type="hidden" name="page" value="${criteria.page }"/>
	<input type="hidden" name="perPageNum" value="${criteria.perPageNum }"/> 
	
	<div class="row recipe_row" style="text-align: center; align-items: center; margin: 0 auto;">
		<div class="col-12" style="width:100%; height:auto; margin:0 auto; padding-top:5%; ">
			<div id="recipe_image_container" style="width:100%; height:100%; border:1px solid red;">
				<img src="${cook.recipe_image }" style="width: 100%; height: 100%; border : 1px solid blue;"> 
			</div>
		</div>
	</div>
	
	<div class="row recipe_row" style="text-align: center; align-items: center;">
		<div class="col-12">
			<h2>${cook.recipe_name }</h2>
		</div>
	</div>
	
	<div class="row recipe_row" style="text-align: center; align-items: center;" >
		<div class="col-2">
			<p style="margin:0px;">분류</p>
		</div>
		<div class="col-10">
			<%-- <input type="text" class="form-control" name="recipe_type" id="recipe_type" value="${cook.recipe_type }" disabled="disabled"> --%>
			<input type="text" class="form-control" value="${type }" disabled="disabled">
		</div>
	</div>
	
	<hr/>

	<div class="row recipe_row">
		<div class="col-2" style="text-align: center; align-self: center;">
			<p>상세 설명</p>
		</div>
		<div class="col-10">
				<!-- ckeditor 창 -->
				<%-- <textarea id="ckeditor" name="recipe_content" disabled="disabled">${cook.recipe_content }</textarea> --%>
				
				<!-- summernote 창 -->
				<textarea id="summernote" name="recipe_content" style="width: 100%; height: auto;">${cook.recipe_content }</textarea>
		</div>
	</div>
	
	<hr/>
	
	<div>
		<c:if test="${cook.recipe_writer == login.member_id }">
			<button type="button" class="btn btn-success">수정</button>
		</c:if>
			<button type="button" class="btn btn-primary" id="recipeList_btn">목록</button>
	</div>
	
	</form>
	
	<hr/>
	
		<!-- 댓글 입력 -->
		<c:if test="${not empty login}">
		<div class="box box-warning">
		    <div class="box-body">
		        <form class="form-horizontal">
		        
		        	<div class="form-group margin row">
						<p class="star_rating">
						    <a href="#" id="1">★</a>
						    <a href="#" id="2">★</a>
						    <a href="#" id="3">★</a>
						    <a href="#" id="4">★</a>
						    <a href="#" id="5">★</a>
						    <input type="hidden" id="reply_rating" name="reply_rating" value="0">
						</p>		        	
					</div>
		        
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
			
		<div class="box box-success collapsed-box">
			<div class="box header with-border">
				<a href="" class="link-blank text-lg"><i class="fa fa-comments-o margin-r-5 replyCount"></i></a>
				<div class="box-tools">
					<button type="button" class="btn btn-box-tool" data-widget="collapse">
						<i class="fa fa-plus"></i>
					</button>
				</div>			
			</div>
			
			<!-- 댓글 목록 -->
			<div class="box-footer">
				<ul id="replies">
				
				</ul>
			</div>
		
			<%--댓글 페이징--%>
			<div class="box-footer">
				<div class="text-center">
					<ul class="pagination pagination-sm no-margin"><!-- 페이징 데이터 --></ul>
				</div>
			</div>
		</div>
		
		
		<!-- 댓글 수정시 팝업 -->
		<div class="modal fade" id="modifyModal" role="dialog">
		  <div class="modal-dialog">
		      <div class="modal-content">
		          <div class="modal-header">
		              <h4 class="modal-title">댓글 수정창</h4>
		          </div>
		          
		          <div class="modal-body">
		              <div class="form-group">
		                  <label for="replyNo">댓글 번호</label>
		                  <input class="form-control" id="replyNo" name="replyNo" readonly>
		              </div>
		              
		              <div class="form-group row .recipe_row" style="text-align:center; align-items: center;">
		              
						<div class="col-2">
		              		<label for="replyNo" style="margin-bottom:0px;">별점</label>
		              	</div>
		              	
		                  <div class="col-5">
		                  	<p id="reply_ratingStar" style="margin-bottom:0px;"> </p> 
		                  </div>
		                  	
						  <div class="col-5">
								<p class="star_rating" style="margin-bottom:0px;">
								    <a href="#" id="1">★</a>
								    <a href="#" id="2">★</a>
								    <a href="#" id="3">★</a>
								    <a href="#" id="4">★</a>
								    <a href="#" id="5">★</a>
								    <input type="hidden" id="reply_rating" name="reply_rating" value="0">
								</p>
							</div>
		              </div>
		              
		              <div class="form-group">
		                  <label for="replyText">댓글 내용</label>
		                  <input class="form-control" id="replyText" name="replyText" placeholder="댓글 내용을 입력해주세요">
		              </div>
		              <div class="form-group">
		                  <label for="replyWriter">댓글 작성자</label>
		                  <input class="form-control" id="replyWriter" name="replyWriter" readonly>
		              </div>
		          </div>
		          
		          <div class="modal-footer">
		              <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
		              <button type="button" class="btn btn-success" id="modalModBtn">수정</button>
		              <button type="button" class="btn btn-danger" id="modalDelBtn">삭제</button>
		          </div>
		      </div>
		  </div>
		</div>
	
</div>


<script>
	//ckeditor 불러오기
	/* CKEDITOR.replace("ckeditor"); */
		
	$('#summernote').summernote({
	  disableDragAndDrop:true,
	});
	
	$('#summernote').summernote('disable');
	
	//summernote 불러오기
	 $('#summernote').summernote({
		  
		  height : 600,
		  minHeight : null,
		  maxHeight : null,
		  focus : true,
		  lang : "ko-KR",
		  popover: {
	           image: [
	           	['imageResize', ['resizeFull', 'resizeHalf', 'resizeQuarter', 'resizeNone']],
	               ['float', ['floatLeft', 'floatRight', 'floatNone']],
	               ['remove', ['removeMedia']],
	               ['custom', ['imageTitle']],
	           ],
	       },
		  toolbar: [
				    // [groupName, [list of button]]
				    ['fontname', ['fontname']],
				    ['fontsize', ['fontsize']],
				    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
				    ['color', ['forecolor','color']],
				    ['table', ['table']],
				    ['para', ['ul', 'ol', 'paragraph']],
				    ['height', ['height']],
				    ['insert',['picture','link','video']],
				    ['view', ['fullscreen', 'help']]
				  ],
		  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
		  fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
	  });
	
	 /************************************************************************************************************************************************************************/
	 //목록으로
	 $("#recipeList_btn").click(function(){
			
		self.location = "${pageContext.request.contextPath}/recipe/listCriteria?page=${criteria.page}&perPageNum=${criteria.perPageNum}&recipe_no=${cook.recipe_no}";
			
		});
	 /************************************************************************************************************************************************************************/

	var recipe_no = ${cook.recipe_no};
		
	/* getRecipe_replies(); */
	
	var starRate = 0;
	
	var replyPageNum = 1;
	
	getRecipe_repliesPaing(1);
	
	$(".pagination").on("click", "li a", function(event){
		
		event.preventDefault();
		
		replyPageNum = $(this).attr('href');
		
		getRecipe_repliesPaing(replyPageNum);
	});
	 
	/************************************************************************************************************************************************************************/
	//벌점 주는 js
	 $( ".star_rating a" ).click(function() {
			$(this).parent().children("a").removeClass("on");
			$(this).addClass("on").prevAll("a").addClass("on");
			 starRate = $(this).attr('id');
			$("#reply_rating").val(starRate);
			
			return false;
	});
	 /************************************************************************************************************************************************************************/
	 
	 
	 /************************************************************************************************************************************************************************/
	//댓글 목록
	function getRecipe_replies(){
		
		$.getJSON("/recipe_replies/all/"+recipe_no, function(data){
			
			console.log(data);
			
			var str ="";
			
			$(data).each(function(){
				
				if(this.reply_rating == 1){
					this.reply_rating = "★";
				}
				else if(this.reply_rating == 2){
					this.reply_rating = "★★";
				}
				else if(this.reply_rating == 3){
					this.reply_rating = "★★★";
				}
				else if(this.reply_rating == 4){
					this.reply_rating = "★★★★";
				}
				else if(this.reply_rating == 5){
					this.reply_rating = "★★★★★";
				}
				else if(this.reply_rating == 0){
					this.reply_rating = "ZERO";					
				}
				
			 	str += "<li data-reply_no='" + this.reply_no + "' class='replyLi'>"
					+	"<p class='reply_text'>" + this.reply_text + "</p>"
					+	"<p class='reply_writer'>" + this.reply_writer + "</p>"
					+	"<p class='reply_rating'>" + this.reply_rating + "</p>"
					+	"<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>수정</button>"
					+	"</li>"
					+	"<hr/>";
			});
			
			$("#replies").html(str);
		});		
	}	 
	/************************************************************************************************************************************************************************/
	
	/************************************************************************************************************************************************************************/ 
	//댓글 추가
	$("#replyAddBtn").click(function(){
		
		var replyText = $("#newReplyText");
		var replyWriter = $("#newReplyWriter");
		
		var replyTextVal = replyText.val();
		var replyWriterVal = replyWriter.val();
		
		var replyRating = $("#reply_rating").val(starRate);
		
		$.ajax({
			type : "post",
			url : "/recipe_replies",
			headers : {
				"Content-type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : "text",
			data : JSON.stringify({
				
				recipe_no : recipe_no,
				reply_text : replyTextVal,
				reply_writer : replyWriterVal,
				reply_rating : starRate
			}),
			success : function(result){
				
				if(result == "regSuccess"){
					alert("등록완료");
				}
				replyText.val("");
				getRecipe_replies();
			}
		});
	});	 
	/************************************************************************************************************************************************************************/
	
	/************************************************************************************************************************************************************************/
	//댓글 수정시 선택한 글의 데이터 가져오기
	$("#replies").on("click", ".replyLi button", function(){

		var reply = $(this).parent();
		
		var replyNo = reply.attr("data-reply_no");
		var replyText = reply.find(".reply_text").text();
		var replyWriter = reply.find(".reply_writer").text();
		var replyRating = reply.find(".reply_rating").text();
		
		$("#replyNo").val(replyNo);
		$("#replyText").val(replyText);
		$("#replyWriter").val(replyWriter);
		/* $("#reply_ratingStar").text(replyRating); */
		
		$("#reply_ratingStar").html(replyRating);
		
		console.log("별점의 값:"+ replyRating);
	});
	/************************************************************************************************************************************************************************/
	
	/************************************************************************************************************************************************************************/
	//댓글 팝업에서 수정시
	$("#modalModBtn").on("click", function () {

    // 댓글 선택자
    var reply = $(this).parent().parent();
    // 댓글번호
    var replyNo = reply.find("#replyNo").val();
    // 수정한 댓글내용
    var replyText = reply.find("#replyText").val();
    
    var replyRating = reply.find("#reply_rating").val(starRate);
    

    // AJAX통신 : PUT
    $.ajax({
        type : "put",
        url : "/recipe_replies/" + replyNo,
        headers : {
            "Content-type" : "application/json",
            "X-HTTP-Method-Override" : "PUT"
        },
        data : JSON.stringify(
            {reply_text : replyText,
             reply_rating : starRate
            }
        ),
        dataType : "text",
        success : function (result) {
            console.log("result : " + result);
            if (result == "modSuccess") {
                alert("댓글 수정 완료!");
                $("#modifyModal").modal("hide"); // Modal 닫기
                getRecipe_replies();
            	}
        	}
   		});
	});
	/************************************************************************************************************************************************************************/
	
	
	/************************************************************************************************************************************************************************/
	//댓글 팝업에서 삭제시
	$("#modalDelBtn").on("click", function(){
		
		var replyNo = $(this).parent().parent().find("#replyNo").val();
		
		$.ajax({
			type : "delete",
			url  : "/recipe_replies/" +	replyNo,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : "text",
			success : function(result){
				
				if(result == "delSuccess"){
					alert("삭제성공");
				}
				
				$("#modifyModal").modal('hide');
				getRecipe_replies();			
			}
		});
	});	
	/************************************************************************************************************************************************************************/
	
	//페이징 번호 출력 함수
	function printPageNumber(pageMaker){
		
		var str = "";
		
		if(pageMaker.prev){
			 str += "<li><a href='"+(pageMaker.startPage-1)+"'>이전</a></li>";
		}
		
		for(var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){
			
			 var strCalss = pageMaker.criteria.page == i ? 'class=active' : '';
		     str += "<li "+strCalss+"><a href='"+i+"'>"+i+"</a></li>";
		}
		
		if(pageMaker.next){
			str += "<li><a href='"+(pageMaker.endPage + 1)+"'>다음</a></li>";
		}
		
		
		$(".pagination-sm").html(str);
		
	}
	
	//댓글 목록 페이징
	function getRecipe_repliesPaing(page){
		
		$.getJSON("/recipe_replies/all/"+ recipe_no+"/"+ page, function(data){
			
			console.log("paging data:"+ data);
			
			var str = "";
			
			$(data.replies).each(function(){
				
				if(this.reply_rating == 1){
					this.reply_rating = "★";
				}
				else if(this.reply_rating == 2){
					this.reply_rating = "★★";
				}
				else if(this.reply_rating == 3){
					this.reply_rating = "★★★";
				}
				else if(this.reply_rating == 4){
					this.reply_rating = "★★★★";
				}
				else if(this.reply_rating == 5){
					this.reply_rating = "★★★★★";
				}
				else if(this.reply_rating == 0){
					this.reply_rating = "ZERO";					
				}
				
			 	str += "<li data-reply_no='" + this.reply_no + "' class='replyLi'>"
					+	"<p class='reply_text'>" + this.reply_text + "</p>"
					+	"<p class='reply_writer'>" + this.reply_writer + "</p>"
					+	"<p class='reply_rating'>" + this.reply_rating + "</p>"
					+	"<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>수정</button>"
					+	"</li>"
					+	"<hr/>";
			});
			
			$("#replies").html(str);
			
			//페이징 번호 출력
			printPageNumber(data.pageMaker);
		});
	}
	
	
	
	
	
</script>


