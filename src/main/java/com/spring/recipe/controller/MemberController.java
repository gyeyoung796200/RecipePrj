package com.spring.recipe.controller;

import java.io.File;
import java.util.Date;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.spring.recipe.commons.util.UploadFileUtils;
import com.spring.recipe.domain.LoginDTO;
import com.spring.recipe.domain.MemberVO;
import com.spring.recipe.service.MemberService;


@Controller
@RequestMapping("/member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	
	@Inject
	private MemberService service;
	
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	
	@RequestMapping("/insert")
	@PostMapping
	public ModelAndView insertMember(MemberVO memberVO, RedirectAttributes rttr, MultipartFile file) throws Exception{
		
		
		logger.info("post insertMember log");
		logger.info("가입정보 : "+memberVO);
		
//		logger.info("file name :"+ file.getOriginalFilename());
//		logger.info("업로드 경로:"+uploadPath);
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload"; // 이미지를 업로드 할 폴더를 설정 = /uploadPath/imgUpload
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath); //위의 폴더를 기준으로 연월일 폴더를 생성
		String fileName = null; //기본경로와 별개로 작성되는 경로 + 파일이름

				
		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			
			//원본파일 경로 + 파일명 저장
			memberVO.setMember_image(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			
		}
		else {
			fileName = File.separator + "images" + File.separator + "none.png";
			
			memberVO.setMember_image(fileName);
		}
		
		String hashPw = BCrypt.hashpw(memberVO.getMember_pw(), BCrypt.gensalt());
		
		memberVO.setMember_pw(hashPw);
		
		service.insertMember(memberVO);
		
		rttr.addFlashAttribute("msg", "success");
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("index");
//		mav.setViewName("redirect:/");
		return mav;
	}
	
	
	@RequestMapping("/login")
	@PostMapping
	public ModelAndView loginMember(LoginDTO loginDTO, HttpSession httpSession, Model model, RedirectAttributes rttr) throws Exception{
		
		logger.info("post login log");
		logger.info("아이디:"+loginDTO.getMember_id()+", 비밀번호:"+loginDTO.getMember_pw());
		
		MemberVO memberVO = service.loginMember(loginDTO);
		
		ModelAndView mav = new ModelAndView();
		
		if(memberVO == null || !BCrypt.checkpw(loginDTO.getMember_pw(), memberVO.getMember_pw())) {
			
			logger.info("일치하지 않아 로그인되지 않습니다");
			rttr.addFlashAttribute("msg", "loginFail");
			mav.setViewName("redirect:/");
		}
		
		else if(memberVO != null || BCrypt.checkpw(loginDTO.getMember_pw(), memberVO.getMember_pw())) {
			
			logger.info("로그인 정보가 일치합니다");
			
			model.addAttribute("member", memberVO);
			mav.setViewName("/member/login");
		}
		
		//로그인유지 클릭하면
		if(loginDTO.isUseCookie()) {
			
			int amount = 60 * 60 * 24 * 7;
			
			Date sessionLimit = new Date(System.currentTimeMillis()+ (1000 * amount));
			
			service.keepLogin(memberVO.getMember_id(),httpSession.getId(), sessionLimit);
		}
		
		return mav;
	}
	
	
	@RequestMapping("/logout")
	@GetMapping
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		Object object = session.getAttribute("login");
		
		if(object != null) {
			
			MemberVO member = (MemberVO) object;
			
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) {
				
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				
				service.keepLogin(member.getMember_id(), "none", new Date());
			}
		}
		
		return "member/logout";
	}
	
	
	//아이디 중복검사
	@RequestMapping("/idChk")
	@ResponseBody
	@PostMapping
	public int memberIdChk(@RequestParam("member_id") String member_id) throws Exception{
		
		logger.info("아이디정보 :"+ member_id);
		
		int cnt = service.idChk(member_id);
		
		if(member_id == "") {
			
			cnt = 2;
		}
		
		logger.info("중복 결과:"+cnt);
		
		return cnt;
	}
	
	//회원정보
	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public ModelAndView memberInfo(MemberVO member, RedirectAttributes rttr) throws Exception{
		
		logger.info("get member Info");
		
		ModelAndView mav = new ModelAndView();
		

		mav.addObject("subtitle", "회원정보");
		mav.addObject("mainData", "member/info.jsp");
		mav.addObject("member", service.infoMember(member));
		mav.setViewName("index");
		return mav;
	}
	
	//회원정보 수정화면
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public ModelAndView modifyMember(MemberVO member) throws Exception{
		
		logger.info("get modify Member");
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("mainData", "member/modify.jsp");
		
		member.setMember_updatedate(new Date());
		
		mav.addObject("member", service.infoMember(member));
		
		mav.setViewName("index");
		
		return mav;
	}
	
	//회원정보 수정처리
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public ModelAndView modifyMemberPost(MemberVO member, MultipartFile file, HttpServletRequest req) throws Exception{
		
		
		logger.info("modify Member post");
		
		
		
		ModelAndView mav = new ModelAndView();
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload"; // 이미지를 업로드 할 폴더를 설정 = /uploadPath/imgUpload
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath); //위의 폴더를 기준으로 연월일 폴더를 생성
		String fileName = null; //기본경로와 별개로 작성되는 경로 + 파일이름

				
		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			
			//원본파일 경로 + 파일명 저장
			member.setMember_image(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			
		}
		else {
			fileName = File.separator + "images" + File.separator + "none.png";
			
			member.setMember_image(fileName);
		}
		
		service.modifyMember(member);

		mav.addObject("mainData", "member/info.jsp");
		mav.addObject("member", service.infoMember(member));
			
		mav.setViewName("index");
			
		return mav;
	}
	
	//회원탈퇴 처리
	@RequestMapping(value = "deleteMember", method = RequestMethod.POST)
	public ModelAndView deleteMember(MemberVO memberVO) throws Exception{
		
		logger.info("delete member");
		
		
		service.deleteMember(memberVO);
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("redirect:/");
		
		return mav;
		
	}
	
	
	
	
	
	
	

}
