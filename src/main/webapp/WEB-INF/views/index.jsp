<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/index.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>

<title>Insert title here</title>
</head>
<body>

<script>
	if(${msg == 'success'}){
		alert("가입성공");
	}
	
	if (${msg == 'loginFail'}) {
		alert("아이디와 비밀번호를 확인하세요");
		
	}
	
	if(${msg == 'loginSuccess'}){
		alert("로그인성공");
	}
</script>

<div class="d-flex" id="wrapper">

        <!-- sidebar-->
        <div class="border-end bg-white" id="sidebar-wrapper">
            <div class="sidebar-heading p-3 border-bottom bg-light"><a href="${pageContext.request.contextPath }/"><h1>Recipe</h1></a></div>
            <div class="list-group list-group-flush">
                <a href="#" class="list-group-item list-group-item-action list-group-item-light p-3">소개</a>
                <a href="${pageContext.request.contextPath }/recipe/list" class="list-group-item list-group-item-action list-group-item-light p-3">레시피종류</a>
                <a href="${pageContext.request.contextPath }/recipe/listCriteria" class="list-group-item list-group-item-action list-group-item-light p-3">레시피종류(페이징)</a>
                <a href="${pageContext.request.contextPath }/recipe/add" class="list-group-item list-group-item-action list-group-item-light p-3">레시피등록(ckeditor)</a>
                <a href="${pageContext.request.contextPath }/recipe/add2" class="list-group-item list-group-item-action list-group-item-light p-3">레시피등록(summernote)</a>
                <a href="${pageContext.request.contextPath }/board/listCriteria" class="list-group-item list-group-item-action list-group-item-light p-3">게시판</a>
                <a href="#" class="list-group-item list-group-item-action list-group-item-light p-3">QnA</a>
            </div>
        </div>
        
        <!-- Page Content Wrapper-->
        <div id="page-content-wrapper">

            <!-- Top navigation-->
            <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                <div class="container-fluid">
                    <button class="btn btn-primary" id="sidebarToggle">Toggle Menu</button>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                    <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
                        <ul class="navbar-nav ms-auto mt-2 mt-lg-0">

						<c:if test="${empty login }">                            
                            <li class="nav-item active">
                                <a href="#" class="nav-link" data-toggle="modal" data-target="#joinModal">Join</a>
                                <div class="modal fade" id="joinModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                        <h5 class="modal-title" id="joinModalLabel">회원가입</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        </div>
                                        <form action="${pageContext.request.contextPath}/member/insert" method="post" enctype="multipart/form-data">
                                         
                                        	<div class="modal-body">
                                                <div class="form-group">
                                                    <label for="InputImage">프로필이미지</label>
                                              		<div id="image_container" style="border: 1px solid; width: 465px; height: 250px;">
                                              			<img style="width: 100%; height: 100%;"> 
                                              		</div>
                                                    <!-- <input type="file" class="form-control" name="file" id="InputImage"> -->
                                                    
                                                    <div class="input-group">
													  <div class="custom-file">
													    <input type="file" class="custom-file-input" name="file" id="InputImage" aria-describedby="inputGroupFileAddon04">
													    <label class="custom-file-label" for="InputImage">이미지선택</label>
													  </div>
													</div>
                                                    
                                                    
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
                                                    
                                                    <%= request.getRealPath("/") %>
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
                                      				
                                      				<script>
                                      				//비밀번호 중복체크	
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
                                        
                                        <div class="modal-footer">
                                            <button type="submit" id="btn_join" class="btn btn-primary" disabled="disabled">회원가입</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                                        </div>
                                        </form>
                                    </div>
                                    </div>
                                </div>
                            </li>
                            
                            <li class="nav-item">
                                <a href="#" class="nav-link" data-toggle="modal" data-target="#loginModal">Login</a>
                                <!-- Modal -->
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
                                            <!-- <button type="submit" class="btn btn-primary" onclick="loginChk()">로그인</button> -->
                                        	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                                        </div>
                                        
                                        <script type="text/javascript">
                                        
                                        function loginChk(){
                                        
	                                        var member_id = $("#login_id").val();
	                                    	var member_pw = $("#login_pw").val();
	                                    	
	                                    	console.log("입력된 아이디는:"+member_id);
	                                    	console.log("입력된 비밀번호는:"+member_pw);
	                                    	
	                                    	$("#loginForm").attr("action", "${pageContext.request.contextPath}/member/login");
	                                    	$("#loginForm").attr("method", "post");
	                                    	$("#loginForm").submit();
                                        }
                                        </script>
                                        
                                        </form>
                                    </div>
                                    </div>
                                </div>
                                
                            </li>
                         </c:if>
						
						<c:if test="${!empty login }">
						
						<div class="dropdown">
						  <a class="btn btn-secondary dropdown-toggle" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						    ${login.member_id }
						  </a>
						
						  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink" style="left: -70%">
						    <a class="dropdown-item" href="${pageContext.request.contextPath }/member/info?member_id=${login.member_id}">회원정보</a>
						    <a class="dropdown-item" href="${pageContext.request.contextPath }/member/logout">로그아웃</a>
						   	<a class="dropdown-item" data-toggle="modal" data-target="#deleteModal" href="${pageContext.request.contextPath }/member/delete">회원탈퇴</a>
						  </div>
						</div>
						
                        </c:if>

                     </ul>

                   </div>
                </div>
            </nav>
            
            					<!-- delete Modal -->
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
                                        
                                        <script type="text/javascript">
                                        
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
                                        
                                        </form>
                                    </div>
                                    </div>
                                </div>

            <!-- Content-->
            <div class="container-fluid d-flex">
            	<c:if test="${mainData == null }">안녕하세요 홈페이지입니다</c:if>
            
            	<c:if test="${mainData != null }"><c:import url="${mainData }"></c:import></c:if> 
            </div>

        </div>

    </div>
</body>
</html>