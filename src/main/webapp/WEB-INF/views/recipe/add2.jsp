<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="${pageContext.request.contextPath }/resources/summernote/lang/summernote-ko-KR.js"></script>
<script src="${pageCOntext.request.contextPath }/resources/summernote/summernote-lite.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/summernote/summernote-lite.css">

<style>
.recipe_row{width:100%; padding-bottom: 15px;}

input{
	background : #f5f5f5;
}
</style>

<div class="w-100" style="padding-left: 10%; padding-right: 10%; border: 1px solid black;">

	<form role="form" action="${pageContext.request.contextPath }/recipe/add2" method="post" enctype="multipart/form-data">
	<input type="hidden" name="recipe_writer" value="${login.member_id }"/>
	<div class="title w-100" style="padding-top:5px;">
		<h2>레시피 등록</h2>
	</div>

	<hr/>
	
	<div class="row recipe_row" style="text-align: center; align-items: center;">
			<!-- <div class="col-2">
				<p style="margin:0px;">대표사진</p>
			</div> -->
			
		<div class="col-4">				
			<div id="recipe_image_container" style="max-width: 100%; max-height: 100%;">
				<img style="width: 100%; height: 100%;" src="https://recipe1.ezmember.co.kr/img/pic_none4.gif" onclick="mainImage()"> 
			</div>
				
			<div class="input-group">
				<div class="custom-file">
					<input type="file" class="custom-file-input" name="file" id="InputRecipeImage" aria-describedby="inputGroupFileAddon04">
					<label class="custom-file-label" for="InputRecipeImage">대표사진등록</label>
				</div>
			</div>                                      
				
		</div>
	</div>
	
	                                         
<script>
	$("#InputRecipeImage").change(function(){
		if(this.files && this.files[0]){
			var reader = new FileReader();
				reader.onload = function(data){
					$("div #recipe_image_container img").attr("src", data.target.result);                                            					
				}
				reader.readAsDataURL(this.files[0]);
			}
	});	 
	<%-- <%= request.getRealPath("/") %> --%>
</script>
	
	
	
	
	
	
	
	
		<div class="row recipe_row" style="text-align: center; align-items: center;">
		
		
			<div class="col-2">
				<p style="margin:0px;">레시피 제목</p>
			</div>
			
			<div class="col-4">
				<input type="text" class="form-control" name="recipe_name">
			</div>
		</div>
	
		<div class="row recipe_row" style="text-align:center; align-items: center;" >
			<div class="col-2">
				<p style="margin:0px;">카테고리</p>
			</div>
			<div class="col-4">
				 <select class="custom-select form-control" name="recipe_type" id="recipe_type" required>
	       			 <option selected disabled value="">선택</option>
	       			 <option value="k">한식</option>
	       			 <option value="a">양식</option>
	       			 <option value="c">중식</option>
	       			 <option value="j">일식</option>
	     		 </select>
			</div>
		</div>
		
		<div class="row recipe_row" style="text-align: center; align-items: center;">
			<div class="col-2">
				<p style="margin:0px;">작성자</p>
			</div>
			
			<div class="col-4">
				<input type="text" class="form-control" name="recipe_writer" value="${login.member_id }" disabled="disabled">
			</div>
		</div>
	
	

	
	
		<div class="row recipe_row">
			<div class="col-2" style="text-align: center; align-self: center;">
				<p>상세 설명</p>
			</div>
			
			<div id="ck_content" class="col-10">
				<textarea id="summernote" name="recipe_content" style="width: 100%; height: 100%;"></textarea>
			</div>
		</div>
	
	
		<hr/>
	
		<div>
			<button type="submit" class="btn btn-success">등록</button>
		</div>
		
		</form>
	
	</div>

<script>
$(function(){
		
	  $('#summernote').summernote({
		  
		  height : 1000,
		  minHeight : null,
		  maxHeight : null,
		  focus : true,
		  lang : "ko-KR",
		  placeholder : "내용을 입력하세요",
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
		  
		  callbacks: {
				onImageUpload: function(files, editor, welEditable) {
		            for (var i = files.length - 1; i >= 0; i--) {
		            	sendFile(files[i], this);
		            }
		        }
			}
	       
	       
	  });
	  
});

function sendFile(file, el) {
	var data = new FormData();
  	data.append('file', file);
  	$.ajax({
    	data: data,
    	type: "POST",
    	url: '/recipe/imageUpload2',
    	cache: false,
    	contentType: false,
    	enctype: 'multipart/form-data',
    	processData: false,
    	success: function(data) {
      		$(el).summernote('editor.insertImage', data.url);
    	}
  	});
}

</script>






























