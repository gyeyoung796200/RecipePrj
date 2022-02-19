<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/index.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/bootstrap/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>


<script>
	if(${msg == 'success'}){
		alert("가입성공");
	}

</script>
	 <div class="d-flex" id="wrapper">

        <!-- sidebar-->
        <div class="border-end bg-white" id="sidebar-wrapper">
            <div class="sidebar-heading p-3 border-bottom bg-light">Start Bootstrap</div>
            <div class="list-group list-group-flush">
                <a href="#" class="list-group-item list-group-item-action list-group-item-light p-3">소개</a>
                <a href="#" class="list-group-item list-group-item-action list-group-item-light p-3">레시피종류</a>
                <a href="#" class="list-group-item list-group-item-action list-group-item-light p-3">레시피등록</a>
                <a href="#" class="list-group-item list-group-item-action list-group-item-light p-3">게시판</a>
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
                                        <form action="${pageContext.request.contextPath}/member/insert" method="post">
                                        	<div class="modal-body">
                                                <div class="form-group">
                                                    <label for="InputImage">프로필이미지</label>
                                                    <div id="image_container" style="border: 1px solid; width: 465px; height: 250px;"></div>
                                                    <input type="file" class="form-control" name="member_image" id="InputImage" onchange="setThumbnail(event)">
                                                    <script>
                                                        function setThumbnail(event){
                                                            
                                                            var reader = new FileReader();

                                                            reader.onload = function(event){

                                                                var img = document.createElement("img");
                                                                img.setAttribute("src", event.target.result);
                                                                img.setAttribute("width", 100+'%');
                                                                img.setAttribute("height", 100+'%');

                                                                document.querySelector("div#image_container").appendChild(img);
                                                            };

                                                            reader.readAsDataURL(event.target.files[0]);
                                                         }
                                                    </script>
                                                </div>

                                                <div class="form-group">
                                                <label for="Input_ID">아이디</label>
                                                <input type="text" class="form-control" name="member_id" id="InputID" onchange="idChk()">
                                                </div>
                                                
                                                <div class="alert alert-success" id="id_true" role="alert" style="display: none;">사용가능한 아이디입니다</div>
                                               	<div class="alert alert-danger" id="id_false" role="alert" style="display: none">이미 사용중인 아이디입니다</div>
                                       
                                                
                                                <div class="form-group">
                                                <label for="Input_Password">비밀번호</label>
                                                <input type="password" class="form-control" name="member_pw" id="InputPassword">
                                                </div>
                                                <div class="form-group">
                                                    <label for="InputPassword_chk_label">비밀번호확인</label>
                                                    <input type="password" class="form-control" onchange="pwChk()" id="InputPassword_chk">
                                                </div>
                                                
                                                <div class="alert alert-success" id="pw_true" role="alert" style="display: none;">비밀번호가 일치합니다</div>
                                               	<div class="alert alert-danger" id="pw_false" role="alert" style="display: none;">비밀번호가 일치하지않습니다</div>
                                                
                                                <div class="form-group">
                                                    <label for="InputName">이름</label>
                                                    <input type="text" class="form-control" name="member_name" id="InputName">
                                                </div>
                                                
                                                
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
                                      				
                                      				//비밀번호 중복체크	
                                      				function pwChk(){
	                                      				
                                      					var member_pw = $("#InputPassword").val();
                                          				var member_pw_chk = $("#InputPassword_chk").val();
	                                      				
	                                      				if(member_pw == member_pw_chk){
	                                      					
	                                      					$("#pw_true").css("display", "block");
	                                      					$("#pw_false").css("display", "none");
	                                      					$("#btn_join").attr("disabled", false);
	                                      				}
	                                      				
	                                      				else if(member_pw != member_pw_chk){
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
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                        </div>
                                        
                                        <form action="${pageContext.request.contextPath }/member/login" method="post">
                                        <div class="modal-body">
                                                <div class="form-group">
                                                <label for="InputID">ID</label>
                                                <input type="text" class="form-control" name="member_id" id="InputID" aria-describedby="emailHelp">
                                                </div>

                                                <div class="form-group">
                                                <label for="InputPassword">Password</label>
                                                <input type="password" class="form-control" name="member_pw" id="InputPassword">
                                                </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary">로그인</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                                        </div>
                                        </form>
                                        
                                    </div>
                                    </div>
                                </div>
                                
                            </li>
                            
                         </c:if>

						
						<c:if test="${!empty login }">
                            <li class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown"></a>
                                <div class="dropdown-menu">
                                    <a href="#" class="dropdown-item">회원정보 ${login.member_name }</a>
                                    <a href="#" class="dropdown-item">로그아웃</a>
                                </div>
                            </li>
                        </c:if>

                     </ul>

                   </div>
                </div>
            </nav>

            <!-- Content-->
            <div class="container-fluid">
            
            	<c:choose>
            		<c:when test="${mainContent == null }">
            			안녕하세요 홈페이지입니다
            		</c:when>
            	

					<c:when test="${mainContent =! null }">
						<c:import url="${mainContent }"/>
					</c:when>
            	
            	</c:choose>
            
  

            </div>

        </div>
    



    </div>
</body>
</html>