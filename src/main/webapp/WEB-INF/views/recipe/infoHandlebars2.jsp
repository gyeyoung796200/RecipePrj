<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

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
  .star_rating a.on {color:red;}
  
  #star{
  	color : red;
  }
  
  
  input{background : #f5f5f5;}

#img{margin-left: 10px; border: 1px solid black;}
  
</style>

<div class="w-100" style="margin: 0 auto; padding-left: 15%; padding-right: 15%; background-color: ghostwhite;">

	<form role="form" id="recipeInfoForm" action="${pageContext.request.contextPath }/recipe/update" method="get">
	<input type="hidden" name="recipe_no" value="${cook.recipe_no }"/>
	<input type="hidden" name="page" value="${criteria.page }"/>
	<input type="hidden" name="perPageNum" value="${criteria.perPageNum }"/> 
	<input type="hidden" name="recipe_type" value="${cook.recipe_type }"/>
	<input type="hidden" name="recipe_writer" value="${cook.recipe_writer }"/>
	<input type="hidden" name="recipe_image" value="${cook.recipe_image }" />
	
	
	<div class="title w-100" style="padding-top:5px;"><h2>${cook.recipe_name }</h2></div>
 
	<hr/>
	
	
	<div class="row" style="text-align: center; align-items: center; margin: 0px; padding: 0px;">
            <div class="col-12">				
                <div id="recipe_image_container" style="max-width: 100%; max-height: 100%;">
                    <img style="width: 100%; height: 100%;" name="" src="${cook.recipe_image }" onclick="mainImage()"> 
                </div>
            </div>
	</div>

	<div class="row" style="text-align: center; align-items: center; margin: 0px; padding: 0px;">
            <div class="col-5" style="padding:5%;">
                <div style="display: flex; flex-direction: column; justify-content: space-around;">
					<div class="row w-100">
						<div class="col-12">
							<input type="text" class="form-control" name="recipe_name" value="${cook.recipe_name }" placeholder="제목" disabled="disabled">
						</div>
                    </div>
                        
					<hr/>
                    
					<div class="row w-100">
						<div class="col-12">
							<input type="text" class="form-control" name="recipe_type" value="${type }" disabled="disabled">
                        </div>
                    </div>
                        
                    <hr/>
                    
					<div class="row w-100">
						<div class="col-12">
							<input type="text" class="form-control" name="recipe_writer" value="${login.member_id }" disabled="disabled">
						</div>
					</div>                
                </div>   
			</div>
	</div>
	
	<hr/>
	
	<div class="row w-100" style="text-align : center; align-items: center;">
			<div class="col-12 d-flex w-100" style="justify-content: space-around;">
				<div class="row" style="align-items: center;">
					<div class="col-4"><p style="margin:0px;">인분</p></div>
					<div class="col-8">
						<input type="text" class="form-control" name="cook_amount" value="${cook.cook_amount }" disabled="disabled">
					</div>
				</div>
                    
				<div class="row" style="align-items: center;">
					<div class="col-4"><p style="margin:0px;">시간</p></div>
					<div class="col-8">
						<input type="text" class="form-control" name="cook_time" value="${cook.cook_time }" disabled="disabled">
					</div>
				</div>
                    

                    
				<div class="row" style="align-items: center;">
					<div class="col-5"><p style="margin:0px;">Level</p></div>
                    <div class="col-7">
                    	<input type="text" class="form-control" name="cook_level" value="${cook.cook_level }" disabled="disabled">
					</div>
				</div>
			</div>
		</div>
		
		<hr/>
		
		
		
		<div class="addContent" style="width: 100%;">
			<div style="text-align:left;"><h5>재료</h5></div>
			
			
			
			
			<c:forEach varStatus="status" var="material_name" items="${material_name_list }">
				
				
				<div class="row w-100" style="text-align: center; align-items: center; margin-bottom: 10px;">
					<div class="col-2"><span id="order">${status.count }</span></div>
					<div class="col-5"><input type="text" name="material_name" class="form-control" value="${material_name }" disabled="disabled"></div>
					<div class="col-5"><input type="text" name="material_amount" class="form-control" value="${material_amount_list[status.index] }" disabled="disabled"></div>
				</div>
			
			</c:forEach>
			
		
		</div>
		
		<hr/>
	
	

	<div class="row recipe_row">
		<div class="col-12">
				<textarea id="summernote" name="recipe_content" style="width: 100%; height: 100%;">${cook.recipe_content }</textarea>
		</div>
	</div>
	
	<hr/>
	
	<div>
		<c:if test="${cook.recipe_writer == login.member_id }">
			<button type="submit" class="btn btn-success">수정</button>
		</c:if>
			<button type="button" class="btn btn-primary" id="recipeList_btn">목록</button>
	</div>
	
	</form>
	
	<hr/>
	
		<!-------------------------------- 댓글 입력, 사용자 구분 -------------------------------------------------------------------------------------------->
		<c:if test="${not empty login}">
		<div class="box box-warning">
		    <div class="box-body">
		        <form class="form-horizontal">
		        
		        	<div class="form-group margin">
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
		<!-- ----------------------------------------------------------------------댓글 입력 end ------------------------------------------------------------------------>
		
		<hr/>
		
			
			<a href="javascript:doDisplay();" class="link-black text-lg"><i class="fa fa-comments-o margin-r-5 replyCount"></i></a>
			<div id="toggleDisplay" style="display: none;">
				<!------------------------------ 댓글 목록 ------------------------------------------>
				
				<div class="box-footer">
					<ul id="replies" style="padding:0px; overflow: auto;">
					
					</ul>
				</div>
			
				<%----------------------------- 댓글 페이징 ------------------------------------------%>
				<div class="box-footer">
					<div class="text-center">
						<ul class="pagination pagination-sm no-margin">
							<!-- 페이징 데이터 -->
						</ul>
					</div>
				</div>
			</div>
			
			
		<!------------------------------- 댓글 수정시 팝업 ----------------------------------------------->
		<div class="modal fade" id="modifyModal" role="dialog">
		  <div class="modal-dialog">
		      <div class="modal-content">
		          <div class="modal-header">
		              <h4 class="modal-title">댓글 수정창</h4>
		          </div>
		          
		          <div class="modal-body">
		              <div class="form-group">
		                  <label for="replyNo">댓글 번호</label>
		                  <input class="form-control" id="replyNo" name="reply_no" readonly>
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
		                  <input class="form-control" id="reply_text" name="reply_text" placeholder="댓글 내용을 입력해주세요">
		              </div>
		              <div class="form-group">
		                  <label for="replyWriter">댓글 작성자</label>
		                  <input class="form-control" id="reply_writer" name="reply_writer" readonly>
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
		<!-- --------------------------- end ----------------------------------------------------------------------------------------->		
	
</div>

<!-- handlebars 템플릿 댓글목록 구현 -->
<script id="replyTemplate" type="text/x-handlebars-template">
    {{#each.}}
    <div class="post replyDiv d-flex row" data-reply_no={{reply_no}} style="text-align:center;">
			
			<div class="col-2" class="starRating">
				<p id="star" class="reply_rating">{{prettifyStar reply_rating}}</p>
            </div>

			<div class="col-5">
				<div class="reply_text">{{{escape reply_text}}}</div>
            </div>
			
			<div class="col-1">   
				<a href="#" class="reply_writer">{{reply_writer}}</a>
			</div>

			<div class="col-3">
				<p class="regdate">{{prettifyDate reply_regdate}}</p>
        	</div>
			
		
			{{#eqReplyWriter reply_writer}}
			<div class="col-1">
				<a href="#" class="pull-right btn-box-tool replyModBtn" data-toggle="modal" data-target="#modifyModal"><i class="fa fa-edit"></i></a>
				<a href="#" class="pull-right btn-box-tool replyDelBtn" data-toggle="modal" data-target="#delModal"><i class="fa fa-times"></i></a>
			</div>
			{{/eqReplyWriter}}

    </div>
	<hr/>
    {{/each}}
</script>


<script>
	//레시피 번호
	var recipe_no = ${cook.recipe_no};  
	
	//별 기본점수
	var starRate = 0; 

	//댓글 목록 페이지 처음 표시될 번호
	var replyPageNum = 1; 
	
	//댓글 목록 함수 호출
	getReplies("/recipe_replies/"+ recipe_no + "/" + replyPageNum );
	
	/*******************************/
	//Handlebars 스크립트 처리
	//댓글 내용 : 줄바꿈, 공백처리
	Handlebars.registerHelper("escape", function(reply_text){
		
		var text = Handlebars.Utils.escapeExpression(reply_text);
		text = text.replace(/(\r\n|\n\r)/gm, "<br/>");
		text = text.replace(/( )/gm, "&nbsp;");
		return new Handlebars.SafeString(text);
	});
	
	//댓글 등록일자: 날짜/시간 
	Handlebars.registerHelper("prettifyDate", function(reply_regdate){
		
		var dateObj = new Date(reply_regdate);
		var year = dateObj.getFullYear().toString();
		var month = dateObj.getMonth() +1;
		var date = dateObj.getDate();
		var hours = dateObj.getHours();
		var minutes = dateObj.getMinutes();
		
		//2자리 변환
		var yearStr = year.substring(2);
		month < 10? month = '0'+month : month;
		date < 10? date = '0'+date : date;
		hours < 10? hours = '0'+hours : hours;
		minutes < 10? minutes = '0'+minutes : minutes;
		
		return yearStr + "/" + month + "/" + date + " " + hours + ":" +minutes;
	});
	
	//댓글 별점 수정
	Handlebars.registerHelper("prettifyStar", function(reply_rating){
		
		var star = reply_rating;
		
		var str = "";
		
		if(star == 0){
			str = "ZERO";
		}
		else if(star != 0){
			for(var i = 1; i <= star; i++){
				
				str += "★";
			}
		}
		return str;
	});
	
	
	//사용자 구분
	Handlebars.registerHelper("eqReplyWriter", function(reply_writer, block){
		
		var accum = "";
		
		v2 = "${login.member_id}";
		
		if(reply_writer == v2){
			
			console.log(reply_writer + "=" + v2 +"같다");
			accum += block.fn();
		}
		return accum;
	});
	
	
	/*********************************/
	
	//댓글 목록 함수
	function getReplies(repliesUri){
		$.getJSON(repliesUri, function(data){
			printReplyCount(data.pageMaker.totalCount);
			printReplies(data.replies, $("#replies"), $("#replyTemplate"));
			printReplyPaging(data.pageMaker, $(".pagination-sm"));			
		});	
	}
	
	//댓글 개수 출력 함수
	function printReplyCount(totalCount){
		
		var replyCount = $(".replyCount");
		
		//댓글이 없으면
		if(totalCount == 0){
			replyCount.html("댓글이 없습니다");
			return;
		}
		//댓글이 존재하면
		replyCount.html("댓글목록("+ totalCount +")");
	}
	
	//댓글 목록 출력 함수
	function printReplies(replyArr, targetArea, templateObj){
		
		var replytemplate = Handlebars.compile(templateObj.html());
		var  html = replytemplate(replyArr);
		
		$(".replyDiv").remove();
		
		targetArea.html(html);
	}
	
	// 댓글 페이징 출력 함수
    function printReplyPaging(pageMaker, targetArea) {
        var str = "";
        if (pageMaker.prev) {
            str += "<li><a href='" + (pageMaker.startPage - 1) + "'>이전</a></li>";
        }
        for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
            var strClass = pageMaker.criteria.page == i ? "class=active" : "";
            str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
        }
        if (pageMaker.next) {
            str += "<li><a href='" + (pageMaker.endPage + 1) + "'>다음</a></li>";
        }
        targetArea.html(str);
    }
	
	$(".pagination").on("click", "li a", function(event){
		
		event.preventDefault();
		replyPageNum = $(this).attr("href");
		
		getReplies("/recipe_replies/"+ recipe_no + "/" + replyPageNum );
	});
	
	
	function doDisplay(){
		var con = $("#toggleDisplay");
		
		if(con.css('display') == 'block'){
			con.css('display', 'none');
		}
		else{
			con.css('display', 'block');
		}
	}
	
	/*********************************/
	//웹 에디터
	$('#summernote').summernote({
	  disableDragAndDrop:true,
	});
	
	$('#summernote').summernote('disable');
	
	//summernote 불러오기
	 $('#summernote').summernote({
		  
		  height : 1000,
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
				    ['groupName', ['list of button']]
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
				getReplies("/recipe_replies/"+ recipe_no + "/" + replyPageNum );
			}
		});
	});	 
	/************************************************************************************************************************************************************************/
	
	/************************************************************************************************************************************************************************/
	//댓글 수정시 선택한 글의 데이터 가져오기
	$("#replies").on("click", ".replyDiv .replyModBtn", function(){

		var reply = $(this).parent().parent();
		
		var replyNo = reply.attr("data-reply_no");
		var replyText = reply.find(".reply_text").text();
		var replyWriter = reply.find(".reply_writer").text();
		var replyRating = reply.find(".reply_rating").text();
		
		$("#replyNo").val(replyNo);
		$("#reply_text").val(replyText);
		$("#reply_writer").val(replyWriter);
		/* $("#reply_ratingStar").text(replyRating); */
		
		$("#reply_ratingStar").html(replyRating);
		
		console.log("글번호 : "+ replyNo);
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
    var replyText = reply.find("#reply_text").val();
    
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
            {
            	reply_no : replyNo,
				reply_text : replyText,
				reply_rating : starRate
            }
        ),
        dataType : "text",
        success : function (result) {
            console.log("result : " + result);
            if (result == "modSuccess") {
                alert("댓글 수정 완료!");
            	}
            $("#modifyModal").modal("hide"); // Modal 닫기
            getReplies("/recipe_replies/"+ recipe_no + "/" + replyPageNum );
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
				getReplies("/recipe_replies/"+ recipe_no + "/" + replyPageNum );
			}
		});
	});	
	/************************************************************************************************************************************************************************/
	
	
	
	
</script>


