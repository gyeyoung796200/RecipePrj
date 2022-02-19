<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="${pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<script src="${pageContext.request.contextPath }/resources/ckeditor/plugins/imageresize/plugin.js"></script>

<style>
.recipe_row{width:100%; padding-bottom: 15px;}

div#ck_content img{
	max-width : 100%;
	height: auto;
}
</style>

<div class="w-100">

	<form role="form" action="${pageContext.request.contextPath }/recipe/add" method="post" enctype="multipart/form-data">
	<div class="title" style="margin : 5%;">
		<h2>레시피 추가</h2>
	</div>

	<hr/>
	
	<div class="row recipe_row" style="text-align: center; align-items: center;" >
		<div class="col-3">
			<p style="margin:0px;">분류</p>
		</div>
		<div class="col-5">
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
		<div class="col-3">
			<p style="margin:0px;">이름</p>
		</div>
		
		<div class="col-5">
			<input type="text" class="form-control" name="recipe_name">
		</div>
	</div>

	<div class="row recipe_row" style="text-align: center; align-items: center;">
		<div class="col-3">
			<p style="margin:0px;">사진</p>
		</div>
		
		<div class="col-5">
			
			<div id="recipe_image_container" style="max-width: 50%; max-height: 50%;">
				<img style="width: 100%; height: 100%;"> 
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
                                                    
			<%= request.getRealPath("/") %>
		</div>
	</div>
	
	<div class="row recipe_row">
		<div class="col-3" style="text-align: center; align-self: center;">
			<p>상세 설명</p>
		</div>
		
		<div id="ck_content"class="col-9">
			<textarea id="ckeditor" name="recipe_content" style="width: 100%; height: auto;"></textarea>
		</div>
	</div>
	
	
	<hr/>
	
	<div>
		<button type="submit" class="btn btn-success">등록</button>
	</div>
	
	
	</form>
	
</div>




<script>
$(document).ready(function(){
	
	CKEDITOR.replace("ckeditor",{
		
		filebrowserUploadUrl : "${pageContext.request.contextPath}/recipe/imageUpload",
		/* extraPlugins : 'imageresize', */
		disallowedContent : 'img{border*,margin*}; table[border]{*}'
			
		
		
	});
	
})

</script>