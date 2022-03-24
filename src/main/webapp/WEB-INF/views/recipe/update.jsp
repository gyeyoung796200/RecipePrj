<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<!-- summernote script -->
<script src="${pageContext.request.contextPath }/resources/summernote/lang/summernote-ko-KR.js"></script>
<script src="${pageCOntext.request.contextPath }/resources/summernote/summernote-lite.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/summernote/summernote-lite.css">

<style>
.recipe_row{width:100%; padding-bottom: 15px;}
  
</style>

<div class="w-100" style="margin: 0 auto; padding-top :10%; padding-left:25%; padding-right:25%; background-color: ghostwhite;">

	<form role="form" id="recipeUpdateForm" method="post" action="${pageContext.request.contextPath }/recipe/update" enctype="multipart/form-data">
	<input type="hidden" name="recipe_no" value="${cook.recipe_no }"/>
	<input type="hidden" name="recipe_image" value="${cook.recipe_image }"/>
	<input type="hidden" name="page" value="${criteria.page }"/>
	<input type="hidden" name="perPageNum" value="${criteria.perPageNum }"/>
	
	<input type="hidden" name="keyword" value="${criteria.keyword }"/>
	<input type="hidden" name="searchType" value="${criteria.searchType }"/>	
	
	<div class="row recipe_row" style="text-align: center; align-items: center;">
		<div class="col-2">
			<p style="margin:0px;">사진</p>
		</div>
		
		<div class="col-10">
			
			<div id="recipe_image_container" style="max-width: 100%; max-height: 100%;">
				<img style="width: 100%; height: 100%;" src="${cook.recipe_image }"> 
			</div>
			
			<div class="input-group">
				<div class="custom-file">
					<input type="file" class="custom-file-input" name="file" id="InputRecipeImage" aria-describedby="inputGroupFileAddon04">
					<label class="custom-file-label" for="InputRecipeImage">ADD</label>
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
			</script>
		</div>
	</div>
	
	<div class="row recipe_row" style="text-align: center; align-items: center;">
		<div class="col-2">
			<p style="margin:0px;">타이틀</p>
		</div>
		
		<div class="col-10">
			<input type="text" class="form-control" name="recipe_name" value="${cook.recipe_name }">
		</div>
	</div>
	
	<div class="row recipe_row" style="text-align: center; align-items: center;" >
		<div class="col-2">
			<p style="margin:0px;">분류</p>
		</div>
		<div class="col-10">
			<select class="custom-select form-control" name="recipe_type" id="recipe_type">
       			 <option selected value="${cook.recipe_type }">${type }</option>
       			 <option value="k">한식</option>
       			 <option value="a">양식</option>
       			 <option value="c">중식</option>
       			 <option value="j">일식</option>
     		 </select>
		</div>
	</div>
	
	<div class="row recipe_row" style="text-align: center; align-items: center;" >
		<div class="col-2">
			<p style="margin:0px;">작성자</p>
		</div>
		<div class="col-10">
			<input type="text" class="form-control" value="${cook.recipe_writer }" disabled="disabled">
		</div>
	</div>
	
	<hr/>

	<div class="row recipe_row">
		<div class="col-2" style="text-align: center; align-self: center;">
			<p>상세 설명</p>
		</div>
		<div class="col-10">
			<textarea id="summernote" name="recipe_content" style="width: 100%; height: auto;">${cook.recipe_content }</textarea>
		</div>
	</div>
	
	<hr/>
	
	<div>
		<c:if test="${cook.recipe_writer == login.member_id }">
			<button type="submit" class="btn btn-success" id="recipeModBtn">수정</button>
		</c:if>
			<button type="button" class="btn btn-primary" id="recipeList_btn">목록</button>
	</div>
	
	</form>
	
	<hr/>
</div>

<script>
		
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
	 /************************************************************************************************************************************************************************/
	 //목록으로
	 $("#recipeList_btn").click(function(){
			
		self.location = "${pageContext.request.contextPath}/recipe/listCriteria?page=${criteria.page}&perPageNum=${criteria.perPageNum}&recipe_no=${cook.recipe_no}";
			
		});
	 /************************************************************************************************************************************************************************/
	
	
</script>


