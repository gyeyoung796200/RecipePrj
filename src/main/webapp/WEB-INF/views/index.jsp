<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/index.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<title>레시피 프로젝트</title>

<style>
</style>
</head>
<body>

<!-- msg 변환 -->
<script>
	if(${msg == "delSuccess"}){alert('삭제 성공');}

</script>

<!-- header menu-->
<header style="margin-bottom: 50px;">
	<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
		<a class="navbar-brand" href="/">RecipePrj</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        	<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarCollapse" style="justify-content: space-between;">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/recipe/add">레시피추가</a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath }/board/listCriteria">게시판</a></li>
			</ul>

			<c:if test="${empty login }">
	        	<ul class="navbar-nav"> 
	            	<li class="nav-item"><a class="nav-link" href="#" data-toggle="modal" data-target="#joinModal">Join</a></li>
	            	<li class="nav-item"><a class="nav-link" href="#" data-toggle="modal" data-target="#loginModal">Login</a></li>
				</ul>
			</c:if>
			
			<c:if test="${!empty login }">
				<div class="dropdown">
					<button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="border: none; box-shadow: none; color: white;">${login.member_id }</button>
					<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="right:50%;">
						<a class="dropdown-item" href="${pageContext.request.contextPath }/member/info?member_id=${login.member_id}">회원정보</a>
				    	<a class="dropdown-item" href="${pageContext.request.contextPath }/member/logout">로그아웃</a>
				    	<a class="dropdown-item" data-toggle="modal" data-target="#deleteModal" href="${pageContext.request.contextPath }/member/delete">회원탈퇴</a>
					</div>
				</div>
			</c:if>
			
    	</div>
    </nav>
</header>
<!-- header menu end-->

<!-- main -->
<main role="main">
    <!-- section-->
	<section class="jumbotron text-center">
		<div class="container">
			<c:if test="${subtitle == null }">
				<h1>다양한 레시피를 만들어보세요</h1>
				<p class="lead text-muted">Show off your dishes with a variety of recipes</p>
          	
				<!-- 레시피 검색 -->          	
				<form id="selectForm" class="form-inline mt-2 mt-md-0" style="justify-content: center;">
					<select class="form-control" name="searchType" id="searchType" onchange="createSelectBox(this.value)">
			            <option value="" <c:out value="${searchCriteria.searchType == null ? 'selected' : ''}"/>>전체</option>
			            <option value="t" <c:out value="${searchCriteria.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
			            <option value="w" <c:out value="${searchCriteria.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
			            <option value="ch" >종류선택</option>
			       	</select>
			         
					<input class="form-control" type="text" name="keyword" id="keywordInput" value="${criteria.keyword }" aria-label="Search">
					<button class="btn btn-outline-success my-2 my-sm-0" id="searchBtn" type="button">검색</button>
				</form>
			</c:if>
			
			<c:if test="${subtitle != null }">
				<h1>${subtitle }</h1>
			</c:if>
		</div>
	</section>
    <!-- section end-->
    
    <!-- content -->
<c:import url="${mainData }"/>            	 
      <!--content end-->
</main>
<!-- main end-->

<!-- 회원가입 팝업창 -->
<div class="modal fade" id="joinModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="joinModalLabel">회원가입</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
			
			<form action="${pageContext.request.contextPath}/member/insert" method="post" enctype="multipart/form-data">
				<div class="modal-body">
					<div class="form-group">
						<label for="InputImage">프로필이미지</label>
						<div id="image_container" style="border: 1px solid; width: 465px; height: 250px;">
							<img style="width: 100%; height: 100%;"> 
						</div>
                                                    
						<div class="input-group">
							<div class="custom-file">
								<input type="file" class="custom-file-input" name="file" id="InputImage" aria-describedby="inputGroupFileAddon04">
								<label class="custom-file-label" for="InputImage">이미지선택</label>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="Input_ID">아이디</label>
						<input type="text" class="form-control" name="member_id" id="InputID" onchange="idChk()">
					</div>

					<div class="alert alert-success" id="id_true" role="alert" style="display: none;">사용가능한 아이디입니다</div>
					<div class="alert alert-danger" id="id_false" role="alert" style="display: none">이미 사용중인 아이디입니다</div>
                                                
					<div class="form-group">
						<label for="Input_Password">비밀번호</label>
						<input type="password" class="form-control" name="member_pw" id="insert_pw">
					</div>
					
					<div class="form-group">
						<label for="InputPassword_chk_label">비밀번호확인</label>
						<input type="password" class="form-control" onchange="pwChk()" id="insert_pwChk">
					</div>
                                                
					<div class="alert alert-success" id="pw_true" role="alert" style="display: none;">비밀번호가 일치합니다</div>
					<div class="alert alert-danger" id="pw_false" role="alert" style="display: none;">비밀번호가 일치하지않습니다</div>
                                                
					<div class="form-group">
						<label for="InputGender">성별</label>
						<select name="member_gender" id="InputGender" class="form-control">
							<option value="">선택</option>
							<option value="M">남</option>
							<option value="F">여</option>
						</select>
					</div>
				</div>
                                        
				<div class="modal-footer">
					<button type="submit" id="btn_join" class="btn btn-primary" disabled="disabled">회원가입</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 회원가입 팝업 end -->

<!-- 로그인 팝업 -->
<div class="modal fade" id="loginModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="loginModalLabel">로그인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
                                        
			<form id="loginForm">
				<div class="modal-body">
					<div class="form-group">
						<label for="Input_ID">ID</label>
						<input type="text" class="form-control" name="member_id" id="login_id" aria-describedby="emailHelp">
					</div>

					<div class="form-group">
						<label for="Input_Password">Password</label>
						<input type="password" class="form-control" name="member_pw" id="login_pw">
					</div>

					<div class="form-group">
						<label><input type="checkbox" name="useCookie"> 로그인 유지</label>
					</div>
					
					<div class="alert alert-danger" id="login_false" role="alert" style="display: none;">로그인정보가 일치하지않습니다</div>
				</div>
                                        
				<div class="modal-footer">
					<a class="btn btn-primary" onclick="loginChk()">로그인</a>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 로그인 팝업 end -->

<!-- 회원탈퇴 팝업 -->
<div class="modal fade" id="deleteModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="deleteModalLabel">회원탈퇴</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			</div>
			
			<form id="deleteForm">
			<input type="hidden" name="member_id" value="${login.member_id }"/>
			<div class="modal-body">
				<p>회원탈퇴를 위한 비밀번호를 입력해주세요</p>
				<div class="form-group">
					<label for="input_pw">비밀번호</label>
					<input type="password" class="form-control" name="member_pw" id="delete_member_pw" aria-describedby="emailHelp">
				</div>
                                              
				<div class="form-group">
					<label for="input_pw">비밀번호 확인</label>
					<input type="password" class="form-control" id="delete_member_pwChk" aria-describedby="emailHelp">
				</div>
			</div>
                                        
			<div class="alert alert-success" id="delete_true" role="alert" style="display: none;">비밀번호 일치 탈퇴를 진행해주세요</div>
			<div class="alert alert-danger" id="delete_false" role="alert" style="display: none;">비밀번호가 일치 하지 않습니다</div>
                                        
			<div class="modal-footer">
				<a class="btn btn-primary" id="btn_delete" onclick="delete_pwChk()">확인</a>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
			</form>
		</div>
	</div>
</div>
<!-- 회원탈퇴 팝업 end -->

<!--  script -->

	<!-- 회원가입 이미지 추가시 화면에 보여줌 -->
	<script>
	$("#InputImage").change(function(){
		if(this.files && this.files[0]){
			var reader = new FileReader();                                            				
			reader.onload = function(data){
				$("div #image_container img").attr("src", data.target.result);                                            					
			}
			reader.readAsDataURL(this.files[0]);
		}
	});	 
	</script>
	<!-- end -->
	
	<!-- 회원가입 체크 -->
		
		<!-- 아이디 -->
		<script>
		function idChk(){
			var member_id = $("#InputID").val();	
			console.log("아이디:"+member_id);
			
			$.ajax({
				url : "/member/idChk",
				type : "post",
				data : { member_id : member_id },
				success : function(cnt){
					if(cnt == 1){
						$("#id_false").css("display", "block");
						$("#id_true").css("display", "none");
						$("#btn_join").attr("disabled", true);
					}
					else if(cnt == 0){
						$("#id_true").css("display", "block");
						$("#id_false").css("display", "none");
						$("#btn_join").attr("disabled", false);
					}
					else if(cnt == 2){
						$("#id_true").css("display", "none");
						$("#id_false").css("display", "none");
						$("#btn_join").attr("disabled", true);
					}
				}
			})
		}
		</script>
		<!-- 아이디 end -->
		
		<!-- 비밀번호 -->	
		<script>
		function pwChk(){
			console.log("비밀번호 체크");
			var insert_pw = $("#insert_pw").val();
			var insert_pwChk = $("#insert_pwChk").val();
			if(insert_pw == insert_pwChk){
				$("#pw_true").css("display", "block");
				$("#pw_false").css("display", "none");
				$("#btn_join").attr("disabled", false);
			}
			else if(insert_pw != insert_pwChk){
				$("#pw_true").css("display", "none");
				$("#pw_false").css("display", "block");
				$("#btn_join").attr("disabled", true);
			}
		}
		</script>
		<!-- 비밀번호 end  -->
	
	<!-- 회원가입 체크 -->	
	
	<!-- 로그인 체크 -->
	<script>
	function loginChk(){
		var member_id = $("#login_id").val();
		var member_pw = $("#login_pw").val();
	                                    	
		$("#loginForm").attr("action", "${pageContext.request.contextPath}/member/login");
		$("#loginForm").attr("method", "post");
		$("#loginForm").submit();
	}
	</script>
	<!-- 로그인 체크 end -->
	
	<!-- 회원 탈퇴 체크 -->
	<script>
	function delete_pwChk(){
		var member_pw = $("#delete_member_pw").val();
		var member_pwChk = $("#delete_member_pwChk").val();
	                                    	
		if(member_pw == member_pwChk){
			$("#delete_true").css("display", "none");
			$("#delete_false").css("display", "none");
			$("#btn_delete").attr("disabled", false);
	                                    		
			$("#deleteForm").attr("action", "${pageContext.request.contextPath}/member/deleteMember");
			$("#deleteForm").attr("method", "post");
			$("#deleteForm").submit();
		}
		else if((member_pw == null || member_pwChk == null) || member_pw != member_pwChk ){
			$("#delete_true").css("display", "none");
			$("#delete_false").css("display", "block");
			$("#btn_delete").attr("disabled", true);
			return false;
		}
	}
	</script>
	<!-- 회원탈퇴 체크 end -->
	
	
	<!--  검색기능 -->
	<script>
	
	var $searchBtn = document.querySelector('#searchBtn');
	var $searchType = document.querySelector('#searchType');
	
	var $searchTypeOptions = document.querySelector('#searchType option');
	
	var $optionValue = document.querySelector('#searchType').options.selectedIndex;
	var $keywordValue = document.querySelector('#keywordInput').value;
	
	var $recipType;

		//타입선택시 keyword 활성화
		/*
		$searchType.addEventListener('click', function(event){
			
			console.log('비활성화 해제');
			document.querySelector('#keywordInput').disabled = false;
			document.querySelector('#keywordInput').value = "";
		});
		*/
		
		var $selectForm = document.querySelector('#selectForm');
		
		function createSelectBox(ch){
			
			if(ch == 'ch'){
				
				
				document.querySelector('#keywordInput').disabled = true;			
				document.querySelector('#keywordInput').value = "입력이 불가능합니다";
				
				var $select = document.createElement('select');
				
				$select.id = "recipeType";
				$select.name = "recipeType";
				$select.className = "form-control";
				
				
				$recipeType = $select;
				
				
				
				var $option1 = document.createElement('option');
				$option1.value = 'k';
				$option1.text = '한식';
				
				var $option2 = document.createElement('option');
				$option2.value = 'a';
				$option2.text = '양식';
				
				var $option3 = document.createElement('option');
				$option3.value = 'c';
				$option3.text = '중식';

				var $option4 = document.createElement('option');
				$option4.value = 'j';
				$option4.text = '일식';
				
				$recipeType.appendChild($option1);
				$recipeType.appendChild($option2);
				$recipeType.appendChild($option3);
				$recipeType.appendChild($option4);
				
				$searchType.after($recipeType);
				
				$searchBtn.addEventListener('click', function(event){
					
					location.href = "${pageContext.request.contextPath}/recipe/search${pageMaker.makeQuery(1)}"
									+ "&searchType=" + $searchType.options[$searchType.selectedIndex].value
									+ "&keyword=" + encodeURIComponent(document.querySelector('#keywordInput').value)
									+ "&recipeType=" + $recipeType.options[$recipeType.selectedIndex].value;
				});
			}
			else if(ch != 'ch'){
				
				document.querySelector('#recipeType').style.display = "none";
				document.querySelector('#keywordInput').disabled = false;
				document.querySelector('#keywordInput').value = "";
			}
		}
		
		$searchBtn.addEventListener('click', function(event){
			
			location.href = "${pageContext.request.contextPath}/recipe/search${pageMaker.makeQuery(1)}"
							+ "&searchType=" + $searchType.options[$searchType.selectedIndex].value
							+ "&keyword=" + encodeURIComponent(document.querySelector('#keywordInput').value);
		});
	</script>
</body>
</html>