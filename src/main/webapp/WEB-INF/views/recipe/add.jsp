<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="${pageContext.request.contextPath }/resources/summernote/lang/summernote-ko-KR.js"></script>
<script src="${pageCOntext.request.contextPath }/resources/summernote/summernote-lite.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/summernote/summernote-lite.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<title>Insert title here</title>
<style type="text/css">

	.recipe_row{width:100%; padding-bottom: 15px;}

	input{background : #f5f5f5;}

	#img{margin-left: 10px; border: 1px solid black;}

	#imageContainer label{display : inline-block; color : #999;}

	#imageContainer input[type='file']{width: 1px; height: 1px; overflow: hidden;}
</style>
</head>
<body>
<div class="w-100" style="padding-left: 15%; padding-right: 15%; border: 1px solid black;">

	<form role="form" action="${pageContext.request.contextPath }/recipe/add" method="post" enctype="multipart/form-data">
        <input type="hidden" name="recipe_writer" value="${login.member_id }"/>
        
        <div class="row" style="text-align: center; align-items: center; margin: 0px; padding: 0px;">
            <div class="col-4">				
                <div id="recipe_image_container" style="max-width: 100%; max-height: 100%;">
                    <img style="width: 100%; height: 100%;" src="https://recipe1.ezmember.co.kr/img/pic_none4.gif"> 
                </div>
                    
                <div class="input-group">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" name="file" id="InputRecipeImage" aria-describedby="inputGroupFileAddon04">
                        <label class="custom-file-label" for="InputRecipeImage">대표사진등록</label>
                    </div>
                </div>                                      
            </div>

            <div class="col-8" style="padding:15%;">
                <div style="display: flex; flex-direction: column; justify-content: space-around;">
					<div class="row w-100">
						<div class="col-12">
							<input type="text" class="form-control" name="recipe_name" placeholder="제목">
						</div>
                    </div>
                        
					<hr/>
                    
					<div class="row w-100">
						<div class="col-12">
							<select class="custom-select form-control" name="recipe_type" id="recipe_type" required>
								<option selected disabled value="">분류</option>
								<option value="k">한식</option>
								<option value="a">양식</option>
								<option value="c">중식</option>
								<option value="j">일식</option>
							</select>
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
			<div class="col-2">
				<p style="margin: 0px;">완성 사진(최대 4장까지 등록가능합니다)</p>
				<button type="button" class="btn btn-primary" onclick="addImage();">사진추가</button>  
			</div>

			<div class="col-10" id="imageContainer" style="display: flex;">
			
					<div id="upload_1" style="position: relative; width: 150px; height:150px;">
                        <img id="preImg1" src="https://recipe1.ezmember.co.kr/img/pic_none3.gif" style="width: 140px; height:140px;">
                        <label for="ex_file1" style="position:absolute; left :0px; right : 0px; top:50%; opacity: 0;">완성사진</label>
                        <input type="file" name="mfile" id="ex_file1" onsubmit="return false;">
                    </div>
                    
                    
				
			</div>
		</div>

		<hr/>

		<div class="row w-100" style="text-align : center; align-items: center;">
			<div class="col-12 d-flex w-100" style="justify-content: space-around;">
				<div class="row" style="align-items: center;">
					<div class="col-4"><p style="margin:0px;">인분</p></div>
					<div class="col-8">
						<select class="custom-select form-control" name="cook_amount" id="cook_amount" required>
							<option selected disabled value="">선택</option>
							<option value="1인분">1인분</option>
							<option value="2인분">2인분</option>
							<option value="3인분">3인분</option>
							<option value="4인분">4인분</option>
							<option value="5인분">5인분이상</option>
						</select>
					</div>
				</div>
                    
				<div class="row" style="align-items: center;">
					<div class="col-4"><p style="margin:0px;">시간</p></div>
					<div class="col-8">
						<select class="custom-select form-control" name="cook_time" id="cook_time" required>
							<option selected disabled value="">선택</option>
							<option value="15분">15분이내</option>
							<option value="30분">30분이내</option>
							<option value="1시간">1시간이내</option>
							<option value="2시간">2시간이내</option>
							<option value="2시간이상">2시간이상</option>
						</select>
					</div>
				</div>
                    

                    
				<div class="row" style="align-items: center;">
					<div class="col-5"><p style="margin:0px;">Level</p></div>
                    <div class="col-7">
                    	<select class="custom-select form-control" name="cook_level" id="cook_level" required>
							<option selected disabled value="">선택</option>
							<option value="초급">초급</option>
							<option value="중급">중급</option>
							<option value="고급">고급</option>
						</select>
					</div>
				</div>
			</div>
		</div>
            
		<hr/>

		<div class="addContent" style="width: 100%;">
			<div style="text-align:left;">
			<h5>재료</h5>
			<span style="margin-left: 20px;">
				<button class="btn btn-primary" id="recipe_add">추가</button>
				<button class="btn btn-primary" id="recipe_minus">삭제</button>
			</span>
			</div>
			
			<div class="row w-100" style="text-align: center; align-items: center; margin-bottom: 10px;">
				<div class="col-2"><span id="order">1</span></div>
				<div class="col-5"><input type="text" name="material_name" class="form-control" placeholder="예)돼지고기"></div>
				<div class="col-5"><input type="text" name="material_amount" class="form-control" placeholder="예)100g"></div>
			</div>
		</div>
             
		<hr/>

		<div class="row recipe_row">
			<div id="ck_content" class="col-12">
				<textarea id="summernote" name="recipe_content" style="width: 100%; height: 100%;"></textarea>
            </div>
		</div>
        
		<hr/>
        
		<div><button type="submit" class="btn btn-success">등록</button></div>
            
	</form>
    </div>

        <!---------------------------------------------------------------------------------------------------------------------------------------------------------------->
<script>
$(document).ready(function(){
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
	
	
	$("#InputRecipeImage").change(function(){
		if(this.files && this.files[0]){
			var reader = new FileReader();
				reader.onload = function(data){
					$("div #recipe_image_container img").attr("src", data.target.result);                                            					
				}
				reader.readAsDataURL(this.files[0]);
		}
	});	 
	
	const $order = document.querySelector('#order');   //순서
	const $addContent = document.querySelector('.addContent'); //태그 내용 추가
	const $recipe_add = document.querySelector('#recipe_add'); //추가 버튼
	const $recipe_minus = document.querySelector('#recipe_minus'); //삭제 버튼

	let order = $order.textContent;  //순서 값
	
	$recipe_add.addEventListener('click', function(event){
		
		event.preventDefault();
		
		const newDiv = document.createElement('div'); // div태그 생성
		
		newDiv.className = 'row w-100 newDiv';
		newDiv.style.textAlign = 'center';
		newDiv.style.alignItems = 'center';
		newDiv.style.marginBottom = 10 + 'px';

		order++;

		newDiv.innerHTML = "<div class='col-2'>"
							+"<span id='order'>"+ order + "</span>"
							+"</div>"
							+"<div class='col-5'><input type='text' name='material_name' class='form-control' placeholder='예)돼지고기'>"
							+"</div>"                    
							+"<div class='col-5'>"
								+"<input type='text' name='material_amount' class='form-control' placeholder='예)100g'>"
							+"</div>";

		$addContent.appendChild(newDiv);
	});

	$recipe_minus.addEventListener('click', function(event){
		
		event.preventDefault();
		
		if(order > 1){
			$addContent.removeChild($addContent.lastChild);
			order--;
		}
		else{alert('삭제할수없습니다');}
	});
	
   	
    
    
    
    
  
    
    

    
	
	
	
                  
});


// 이미지 컨테이너
const $imageContainer = document.querySelector('#imageContainer');

//파일등록 태그
const $ex_file1 = document.querySelector('#ex_file1');

	//파일등록 클릭대신해주는거
const $label = document.querySelector('label');

	


	//완성 사진 타겟설정
$ex_file1.addEventListener('change', function(e){

    console.log('메서드 타겟 부모의 자식으로 설정:'+ e.target.parentNode.getAttribute('id'));
    imgAttr(e.target); 
});



//이미지 미리보기 함수
function imgAttr(input){

    var $previewImg; //img 변수 영

    if(input.getAttribute('id') === "ex_file1"){

        $previewImg = document.querySelector('#preImg1');
    }
    else if(input.getAttribute('id') === "ex_file2"){

        $previewImg = document.querySelector('#preImg2');
    }
    else if(input.getAttribute('id') === "ex_file3"){

        $previewImg = document.querySelector('#preImg3');
    }
    else if(input.getAttribute('id') === "ex_file4"){

        $previewImg = document.querySelector('#preImg4');
    }

    if(input.files && input.files[0]){

        $imageContainer.style.width = 130 + 'px';
        $imageContainer.style.heigth = 130 + 'px';
        
        $label.style.display = "none";

        const reader = new FileReader();

        reader.onload = function(e){

            $previewImg.setAttribute('src', e.target.result);
            $previewImg.style.paddingRight = 10 + 'px';
            $previewImg.style.width = 100 + '%';
            $previewImg.style.height = 100 + '%';
            
        }
        reader.readAsDataURL(input.files[0]);
    }
};


var upload_order = 1;


function addImage(){

    upload_order++;

    const newDiv = document.createElement('div');
    newDiv.id = 'upload_' + upload_order;
    newDiv.style.position = 'relative';
	newDiv.style.width = 150 + 'px';
	newDiv.style.height = 150 + 'px';
    
    newDiv.innerHTML = "<img id='preImg"+upload_order+"' src='https://recipe1.ezmember.co.kr/img/pic_none3.gif' style='width: 140px; height:140px;'>"
                    +   "<label for='ex_file"+upload_order+"' style='position:absolute; left :0px; right : 0px; top:50%; opacity: 0;'>완성사진</label>"
                    +   "<input type='file' name='mfile' id='ex_file"+upload_order+"'>";


    if(upload_order <= 4){

        $imageContainer.appendChild(newDiv);
        if(newDiv.getAttribute("id") == "upload_2"){

            const $ex_file2 = document.querySelector('#ex_file2');
            var $previewImg = document.querySelector('#preImg2');

            $ex_file2.addEventListener('change', function(e){

            console.log('메서드 타겟 부모의 자식으로 설정:'+ e.target.parentNode.getAttribute('id'));
                imgAttr(e.target); 
            });
        }

        if(newDiv.getAttribute("id") == "upload_3"){

            const $ex_file3 = document.querySelector('#ex_file3');
            var $previewImg = document.querySelector('#preImg3');

            $ex_file3.addEventListener('change', function(e){

            console.log('메서드 타겟 부모의 자식으로 설정:'+ e.target.parentNode.getAttribute('id'));
                imgAttr(e.target); 
            });
        }

        if(newDiv.getAttribute("id") == "upload_4"){

            const $ex_file4 = document.querySelector('#ex_file4');
            var $previewImg = document.querySelector('#preImg4');

            $ex_file4.addEventListener('change', function(e){

            console.log('메서드 타겟 부모의 자식으로 설정:'+ e.target.parentNode.getAttribute('id'));
                imgAttr(e.target); 
            });
        }

    }
    if(upload_order > 5){

        alert('더이상 추가 할수 없습니다');
        
        return false;
    }
};

            
</script>
</body>
</html>