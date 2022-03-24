package com.spring.recipe.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.support.AbstractMultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.PageMaker;
import com.spring.recipe.commons.paging.SearchCriteria;
import com.spring.recipe.commons.util.UploadFileUtils;
import com.spring.recipe.domain.RecipeVO;
import com.spring.recipe.service.RecipeService;

@Controller
@RequestMapping("/recipe")
public class RecipeController {

	private static final Logger logger = LoggerFactory.getLogger(RecipeController.class);

	@Inject
	private RecipeService service;

	@Resource(name = "uploadPath")
	private String uploadPath;

	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public ModelAndView getRecipeAdd4() throws Exception {

		logger.info("get Recipe add");

		ModelAndView mav = new ModelAndView();
		
		mav.addObject("subtitle", "레시피 등록");
		mav.addObject("mainData", "recipe/add.jsp");
		mav.setViewName("index");

		return mav;
	}

	// summernote post 페이지 수정
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public ModelAndView postRecipeAdd4(RecipeVO recipeVO, RedirectAttributes rttr, MultipartFile file,
			MultipartHttpServletRequest mfile) throws Exception {

		logger.info("post Recipe add");

		String recipeUploadPath = uploadPath + File.separator + "recipeUpload";
		String ymdPath = UploadFileUtils.calcPath(recipeUploadPath); // 위의 폴더를 기준으로 연월일 폴더를 생성
		String fileName = null; // 기본경로와 별개로 작성되는 경로 + 파일이름

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {

			fileName = UploadFileUtils.fileUpload(recipeUploadPath, file.getOriginalFilename(), file.getBytes(),
					ymdPath);

			recipeVO.setRecipe_image(File.separator + "recipeUpload" + ymdPath + File.separator + fileName);
		}

		List<MultipartFile> fileList = mfile.getFiles("mfile");

		String fileNames = null;

		String imgFileNames = null;

		String str = "";

		for (MultipartFile multiFile : fileList) {

			logger.info("추가 이미지 사진 :" + multiFile.getOriginalFilename());

			if (multiFile.getOriginalFilename() != null && multiFile.getOriginalFilename() != "") {

				fileNames = UploadFileUtils.fileUpload(recipeUploadPath, multiFile.getOriginalFilename(),
						multiFile.getBytes(), ymdPath);

//							recipeVO.setRecipe_completeImg(File.separator + "recipeUpload" + ymdPath + File.separator + fileNames );

				imgFileNames = File.separator + "recipeUpload" + ymdPath + File.separator + fileNames;

				str += imgFileNames + ",";

				recipeVO.setRecipe_completeImg(str);
			}
		}

		service.addRecipe(recipeVO);

		ModelAndView mav = new ModelAndView();
		
		mav.addObject("mainData", "recipe/list.jsp");
//		mav.setViewName("redirect:/recipe/list");
		mav.setViewName("redirect:/");

		return mav;
	}

	/*
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView getRecipeListCriteria(@ModelAttribute("criteria") Criteria cri) throws Exception {

		logger.info("get Recipe listCriteria");

		cri.setPerPageNum(12);

		logger.info("크리테리아 정보: " + cri.toString());

		PageMaker pageMaker = new PageMaker();

		pageMaker.setCriteria(cri);
		pageMaker.setTotalCount(service.totalCount());

		logger.info("페이지 메이커 정보: " + pageMaker.toString());

		ModelAndView mav = new ModelAndView();

		mav.addObject("mainData", "recipe/list.jsp");
		mav.addObject("pageMaker", pageMaker);
		mav.addObject("recipe", service.listCirteriaRecipe(cri));

		mav.setViewName("index");

		return mav;
	}
	*/
	
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView getRecipeListCriteria(@ModelAttribute("criteria") SearchCriteria cri) throws Exception {

		logger.info("get Recipe listCriteria");

		cri.setPerPageNum(12);

		logger.info("크리테리아 정보: " + cri.toString());

		PageMaker pageMaker = new PageMaker();

		pageMaker.setCriteria(cri);
		pageMaker.setTotalCount(service.totalCount());
		
		

		logger.info("페이지 메이커 정보: " + pageMaker.toString());

		ModelAndView mav = new ModelAndView();

		mav.addObject("mainData", "recipe/list.jsp");
		mav.addObject("pageMaker", pageMaker);
		mav.addObject("recipe", service.listCirteriaRecipe(cri));

		mav.setViewName("index");

		return mav;
	}


	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public ModelAndView getRecipeInfoHandlebars(int recipe_no, @ModelAttribute("criteria") SearchCriteria cri,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("get Recipe info");

		ModelAndView mav = new ModelAndView();

		RecipeVO recipe = service.info(recipe_no);
		
		
		String loginId = session.getId(); // 현재 값
		
		logger.info("loginId:"+ loginId);
		
		Cookie newCookie = null;
		
		mav.addObject("type", "한식");
		//요청한 쿠키정보를 가져와 cookie배열에 담는다
		Cookie[] cookies = request.getCookies();
		
		logger.info("request cookie :" + request.getCookies());
		
		
		
		

		if (recipe.getRecipe_type().equals("k")) {

		} else if (recipe.getRecipe_type().equals("c")) {
                   
			mav.addObject("type", "중식")	;
		} else if (recipe.getRecipe_type().equals("a")) {

			mav.addObject("type", "양식");
		} else if (recipe.getRecipe_type().equals("j")) {

			mav.addObject("type", "일식");
		}

		int val = recipe.getMaterial_name().split(",").length;

		String[] material_name_val = recipe.getMaterial_name().split(",");

		String[] material_amount_val = recipe.getMaterial_amount().split(",");

		List<String> material_name_list = new ArrayList<String>();

		List<String> material_amount_list = new ArrayList<String>();

		for (int i = 0; i < val; i++) {

			String str = material_amount_val[i];

			str.split(",");

			material_amount_list.add(str);
		}

		for (int i = 0; i < val; i++) {

			String str = material_name_val[i];

			str.split(",");

			material_name_list.add(str);
		}

		mav.addObject("material_name_list", material_name_list);
		mav.addObject("material_amount_list", material_amount_list);
		mav.addObject("mainData", "recipe/info.jsp");
		mav.addObject("cook", recipe);

		mav.setViewName("index");

		return mav;
	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView getRecipeUpdate(int recipe_no, @ModelAttribute("criteria") SearchCriteria cri) throws Exception {

		logger.info("get recipe update");
		ModelAndView mav = new ModelAndView();

		RecipeVO recipe = service.info(recipe_no);

		if (recipe.getRecipe_type().equals("k")) {

			mav.addObject("type", "한식");
		} else if (recipe.getRecipe_type().equals("c")) {

			mav.addObject("type", "중식");
		} else if (recipe.getRecipe_type().equals("a")) {

			mav.addObject("type", "양식");
		} else if (recipe.getRecipe_type().equals("j")) {

			mav.addObject("type", "일식");
		}

		mav.addObject("cook", service.info(recipe_no));
		mav.addObject("mainData", "recipe/update.jsp");

		mav.setViewName("index");

		return mav;
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public ModelAndView postRecipeUpdate(RecipeVO recipeVO, MultipartFile file, @ModelAttribute("criteria") SearchCriteria cri, RedirectAttributes rttr) throws Exception {

		logger.info("post recipe update");

		logger.info("파일 이름:" + file.getOriginalFilename());

		ModelAndView mav = new ModelAndView();

		String recipeUploadPath = uploadPath + File.separator + "recipeUpload";
		String ymdPath = UploadFileUtils.calcPath(recipeUploadPath); // 위의 폴더를 기준으로 연월일 폴더를 생성
		String fileName = null; // 기본경로와 별개로 작성되는 경로 + 파일이름

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {

			fileName = UploadFileUtils.fileUpload(recipeUploadPath, file.getOriginalFilename(), file.getBytes(),
					ymdPath);

			recipeVO.setRecipe_image(File.separator + "recipeUpload" + ymdPath + File.separator + fileName);
		}

		if (recipeVO.getRecipe_type().equals("k")) {

			mav.addObject("type", "한식");
		} else if (recipeVO.getRecipe_type().equals("c")) {

			mav.addObject("type", "중식");
		} else if (recipeVO.getRecipe_type().equals("a")) {

			mav.addObject("type", "양식");
		} else if (recipeVO.getRecipe_type().equals("j")) {

			mav.addObject("type", "일식");
		}

		service.update(recipeVO);

		mav.addObject("mainData", "recipe/info.jsp");
		mav.addObject("cook", service.info(recipeVO.getRecipe_no()));
		mav.setViewName("index");

		return mav;
	}

	@RequestMapping(value = "/imageUpload", method = RequestMethod.POST)
	@ResponseBody
	public void imageUpload(HttpServletRequest req, HttpServletResponse resp, @RequestParam MultipartFile upload)
			throws Exception {

		// 랜던 문자 생성
		UUID uid = UUID.randomUUID();

		// 받는 형태 설정
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");

		OutputStream out = null; // 출력스트림
		PrintWriter printWriter = null; // 기록

		try {

			String fileName = upload.getOriginalFilename(); // 업로드한 파일 이름
			byte[] bytes = upload.getBytes(); // 파일을 바이트 배열로

			String ckUploadPath = uploadPath + File.separator + "recipeUpload" + File.separator + uid + "_" + fileName;

			out = new FileOutputStream(new File(ckUploadPath));
			out.write(bytes); // 배포 경로에 바이트 파일이 저장됨
			out.flush(); // 비워준다

			String callback = req.getParameter("CKEditorFuncNum");
			printWriter = resp.getWriter();

			String fileUrl = "/recipeUpload/" + uid + "_" + fileName; // 작성화면

			logger.info("fileUrl :" + fileUrl);

			// 업로드 메시지 출력
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\": 1,\"url\":\"" + fileUrl + "\"}");

			printWriter.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {

			try {
				if (out != null)
					out.close();
				if (printWriter != null)
					printWriter.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return;
	}

	// summernote 이미지 업로드 ajax
	@RequestMapping(value = "/imageUpload2", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
			HttpServletRequest request) {
		JsonObject jsonObject = new JsonObject();

		// 내부경로로 저장
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot + "resources/recipeUpload/";

		String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
		String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명

		File targetFile = new File(fileRoot + savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장
			jsonObject.addProperty("url", "/resources/recipeUpload/" + savedFileName); // contextroot + resources + 저장할
																						// 내부 폴더명
			jsonObject.addProperty("responseCode", "success");

		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // 저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}
	
	
	//레시피 삭제
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public ModelAndView deleteRecipe(int recipe_no, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		
		logger.info("post delete recipe");
		
		
		service.delete(recipe_no);
		
		ModelAndView mav = new ModelAndView();
		
		//RedirectAttributes 주소창에 전달되는 인자들을 가려준다
		rttr.addFlashAttribute("page", cri.getPage());
		rttr.addFlashAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("searchType", cri.getSearchType());
		rttr.addFlashAttribute("msg", "delSuccess");
		
		mav.setViewName("redirect:/");
		
		return mav;
	}
	
	
	//레시피 검색
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView searchRecipe(@ModelAttribute("criteria")SearchCriteria cri) throws Exception{
		
		logger.info("get search recipe");
		
		logger.info("search recipe data :" + cri.toString());
		
//		cri.setPage(1);
//		cri.setPerPageNum(12);
		
		ModelAndView mav = new ModelAndView();
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCriteria(cri);
		

		
		
		
		
		mav.addObject("pageMaker", pageMaker);
		
		mav.addObject("mainData", "recipe/list.jsp");
		
		if(cri.getRecipeType() == null || cri.getRecipeType() == "") {
			
			logger.info("제목, 작성자 타입 검색");
			logger.info("검색 개수:"+ service.searchCount(cri));
			
			pageMaker.setTotalCount(service.searchCount(cri));
			mav.addObject("recipe", service.searchList(cri));
		}
		
		else if(cri.getRecipeType() != null || cri.getRecipeType() != "") {
			
			logger.info("레시피 타입검색");
			logger.info("검색 개수:" + service.searchRecipeCount(cri));
			
			pageMaker.setTotalCount(service.searchRecipeCount(cri));
			mav.addObject("recipe", service.searchRecipeList(cri));
		}
		
		
		mav.setViewName("index");
		
		return mav;
	}
	
	//레시피 타입검색
	@RequestMapping(value = "/recipeType", method = RequestMethod.GET)
	public ModelAndView searchRecipeType(@ModelAttribute("criteria")SearchCriteria cri) throws Exception{
		
		logger.info("get search recipe type");
		
		logger.info("타입정보:"+ cri.toString());
		logger.info("개수:"+ service.searchRecipeCount(cri));
		
		ModelAndView mav = new ModelAndView();
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCriteria(cri);
		
		pageMaker.setTotalCount(service.searchRecipeCount(cri));
		
		mav.addObject("pageMaker", pageMaker);
		
		mav.addObject("mainData", "recipe/list.jsp");
		mav.addObject("recipe", service.searchRecipeList(cri));
		
		mav.setViewName("index");
		
		return mav;
		
		
		
	}
	
	
	
	
}
