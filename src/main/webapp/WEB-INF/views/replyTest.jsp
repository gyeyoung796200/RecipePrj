<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<section class="content container-fluid">
  <div class="col-lg-12">
    <div class="box box-primary">
        <div class="box-header with-border">
            <h3 class="box-title">댓글 작성</h3>
        </div>
        <div class="box-body">
            <div class="form-group">
                <label for="newReplyText">댓글 내용</label>
                <input class="form-control" id="newReplyText" name="reply_text" placeholder="댓글 내용을 입력해주세요" onchange="fn_change();">
            </div>
            <div class="form-group">
                <label for="newReplyWriter">댓글 작성자</label>
                <input class="form-control" id="newReplyWriter" name="reply_writer" value="${login.member_id }" disabled="disabled">
            </div>
        </div>
        
        <div>
        	<button type="button" id="replyAddBtn" class="btn btn-primary" disabled="disabled">댓글 등록</button>
        </div>
        
        <hr/>
        <div class="box-footer">
            <ul id="replies" style="padding-left : 0;">

            </ul>
        </div>
        <div class="box-footer">
            <div class="text-center">
                <ul class="pagination pagination-sm no-margin">

                </ul>
            </div>
        </div>
    </div>
  </div>

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
                    <input class="form-control" id="reply_text" name="reply_text" placeholder="댓글 내용을 입력해주세요">
                </div>
                <div class="form-group">
                    <label for="replyWriter">댓글 작성자</label>
                    <input class="form-control" id="reply_writer" name="reply_writer" readonly>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success modalModBtn">수정</button>
                <button type="button" class="btn btn-danger modalDelBtn">삭제</button>
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
  </div>
</section>

<script>
console.log("현재 이미지:"+ "${login.member_image}");

//현재 게시글 번호
var bno = 1;

//현재 페이지 번호
var page = 1;

//목록 페이지 번호
var replyPageNum = 1;

// 댓글 목록 호출
/* getReplies(); */


getRepliesPaging(page);

function fn_change(){
	
	if($("#newReplyText").val() == null || $("#newReplyText").val() == ""){
	
		$("#replyAddBtn").attr('disabled', true);
		alert("내용을 작성해주세요");
		return false;
	}
	else if($("#newReplyText").val() != null || $("#newReplyText").val() != ""){
		$("#replyAddBtn").attr('disabled', false);
	}
}

// 댓글 목록 출력 함수
function getReplies() {

    $.getJSON("/replies/all/" + bno, function (data) {

        console.log(data);

        var str = "";

        $(data).each(function () {
        
        	str += "<li data-reply_no='" + this.reply_no + "' class='replyLi' style='list-style:none;'>"
            
		        	+ "<div class='card border-dark mb-3' style='width:100%; height:100%;'>"
		        	
		            	+ "<div class='card-body text-dark'>"
		            		+ "<p class='card-text reply_text'>" + this.reply_text + "</p>"
		            	+"</div>"
            	
                		+ "<div class='card-header'>"
                
                    		+"<div class='row'>"
                    
		                    	+"<div class='col-3'>"
		                			+ "<img src='${login.member_image}'  class='img-fluid img-thumbnail img-rounded' style='width:100%; height:80%;'>"
		                			+"<p class='reply_writer' style='text-align:center;'>" +this.reply_writer + "</p>"
		                		+"</div>"
                		
		                	    +"<div class='col-9' style='align-self:center;'>"
		                			+"<div style='text-align:center;'>"
		                				+"<button type='button' id='modalBtn' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal' style='margin:10px;'>수정</button>"
		                			+"</div>"
		                		+"</div>"
                		
                			+"</div>" 
                	
                		+"</div>" 
                
             		 +"</div>" 
              
        		 + "</li>"
         
      			 + "<hr/>";
        });
        
        $("#replies").html(str);

    });
}

function printPageNumbers(pageMaker){
	
	var str = "";
	
	if(pageMaker.prev){
		str += "<li><a href='" + (pageMaker.startPage -1) +"'>이전</a></li>";
	}
	
	for(var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){
		
		var strClass = pageMaker.criteria.page == i ? 'class=acitve' : '';
		str += "<li "+strClass+"><a href='/reply/test/" + i +"'>"+ i +"</a></li>";
	}
	
	if(pageMaker.next){
		str += "<li>" + "<a href='" +(pageMaker.endPage +1) +"'>다음</a></li>";		
	}
	
	$(".pagination").html(str);
}

function getRepliesPaging(page){
	
	$.getJSON("/replies/"+ bno +"/" + page, function(data){
		console.log(data);
		var str = "";
		
		$(data.replies).each(function(){
			
			
			str += "<li data-reply_no='" + this.reply_no + "' class='replyLi' style='list-style:none;'>"
            
		        	+ "<div class='card border-dark mb-3' style='width:100%; height:100%;'>"
		        	
		            	+ "<div class='card-body text-dark'>"
		            		+ "<p class='card-text reply_text'>" + this.reply_text + "</p>"
		            	+"</div>"
		    	
		        		+ "<div class='card-header'>"
		        
		            		+"<div class='row'>"
		            
		                    	+"<div class='col-3'>"
		                			+ "<img src='${login.member_image}'  class='img-fluid img-thumbnail img-rounded' style='width:100%; height:80%;'>"
		                			+"<p class='reply_writer' style='text-align:center;'>" +this.reply_writer + "</p>"
		                		+"</div>"
		        		
		                	    +"<div class='col-9' style='align-self:center;'>"
		                			+"<div style='text-align:center;'>"
		                				+"<button type='button' id='modalBtn' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal' style='margin:10px;'>수정</button>"
		                			+"</div>"
		                		+"</div>"
		        		
		        			+"</div>" 
		        	
		        		+"</div>" 
		        
		     		 +"</div>" 
		      
				 + "</li>"
 
			 	 + "<hr/>";
		});
		
		printPageNumbers(data.pageMaker);
		
		$("#replies").html(str);
	});
}

$(".pagination").on("click", "li a", function(event){

	console.log(event);
	event.preEventDefault();
	replyPageNum = $(this).attr("href"); //목록 번호 추출해서 페이지 정보 알아냄
	getRepliesPaging(replyPageNum);
});

$("#replyAddBtn").click(function(){
	var replyText = $("#newReplyText");
	var replyWriter = $("#newReplyWriter");
	
	var replyTextVal = replyText.val();
	var replyWriterVal = replyWriter.val();
	
	
	if(replyTextVal == null || replyTextVal == ""){
		
		fn_change();
	}
	
	else if(replyTextVal != null || replyTextVal != ""){
		
	$.ajax({
		
		type: "post",
		url: "/replies",
		headers : {
			"Content-type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dataType : "text",
		data : JSON.stringify({
			
			bno : bno,
			reply_text : replyTextVal,
			reply_writer : replyWriterVal
		}),
		success : function(result){
			
			if(result == "regSuccess"){
				alert("등록완료");
			}
			
			getReplies();
			replyText.val("");
		}
	});
	}
});

$("#replies").on("click", ".replyLi .card .card-header .row ", function(){
	
	var reply = $(this).parent().parent().parent();
	
	var replyNo = reply.attr("data-reply_no"); 
	
	var replyText = reply.find(".reply_text").text();
	
	var replyWriter = reply.find(".reply_writer").text();
	
	$("#reply_no").val(replyNo);
	$("#reply_text").val(replyText);
	$("#reply_writer").val(replyWriter);
});

$(".modalDelBtn").click(function(){
	
	var replyNo = $("#reply_no").val();
	
	$.ajax({
		type : "delete",
		url : "/replies/" + replyNo,
		success : function(result){
		
			if(result == "delSuccess"){
				alert("삭제되었습니다");
				$("#modifyModal").modal('hide');
				getReplies();
			}
		}
	});
});

$(".modalModBtn").click(function(){

	var reply_no = $("#reply_no").val();
	var reply_text = $("#reply_text").val();
	
	$.ajax({
		
		type : "put",
		url : "/replies/" + reply_no,
		headers : {
			"Content-type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		dataType : "text",
		data : JSON.stringify({
			reply_text : reply_text
		}),
		success : function(result){
			if(result == "updateSuccess"){
				
				alert("수정되었습니다");
				$("#modifyModal").modal("hide");
				getReplies();
			}
		}
	});
});
</script>