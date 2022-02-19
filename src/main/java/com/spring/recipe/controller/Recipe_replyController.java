package com.spring.recipe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.PageMaker;
import com.spring.recipe.domain.Recipe_replyVO;
import com.spring.recipe.service.Recipe_replyService;

@RestController
@RequestMapping("/recipe_replies")
public class Recipe_replyController {
	
	
	@Inject
	private Recipe_replyService service;
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> insert(@RequestBody Recipe_replyVO vo) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		try {
			
			service.insert(vo);
			
			entity = new ResponseEntity<String>("regSuccess", HttpStatus.OK);
			
		}catch (Exception e) {
			
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
			
		}
		return entity;
	}
	
	
	//페이징 하기전 리스트
	@RequestMapping(value = "/all/{recipe_no}", method = RequestMethod.GET)
	public ResponseEntity<List<Recipe_replyVO>> list(@PathVariable("recipe_no") int recipe_no) throws Exception{
		
		ResponseEntity<List<Recipe_replyVO>> entity = null;
		
		try {
			
			entity = new ResponseEntity<List<Recipe_replyVO>>(service.list(recipe_no), HttpStatus.OK);
			
		}catch (Exception e) {

			e.printStackTrace();
			entity = new ResponseEntity<List<Recipe_replyVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//페이징하고 난후 리스트
	@RequestMapping(value = "/all/{recipe_no}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPaing(@PathVariable("recipe_no") int recipe_no, @PathVariable("page") int page) throws Exception{
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		
		try {
			
			Criteria cri = new Criteria();
			cri.setPage(page);
			
			List<Recipe_replyVO> repliesList = service.listPaging(recipe_no, cri);
			
			PageMaker pageMaker = new PageMaker();
			
			pageMaker.setCriteria(cri);
			pageMaker.setTotalCount(service.countReply(recipe_no));
			
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("replies", repliesList);
			map.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}
		catch (Exception e) {
			e.getStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	//페이징하고 난후 리스트
	@RequestMapping(value = "/{recipe_no}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPaing2(@PathVariable("recipe_no") int recipe_no, @PathVariable("page") int page) throws Exception{
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		
		try {
			
			Criteria cri = new Criteria();
			cri.setPage(page);
			
			List<Recipe_replyVO> repliesList = service.listPaging(recipe_no, cri);
			
			PageMaker pageMaker = new PageMaker();
			
			pageMaker.setCriteria(cri);
			pageMaker.setTotalCount(service.countReply(recipe_no));
			
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("replies", repliesList);
			map.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		}
		catch (Exception e) {
			e.getStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value = "/{reply_no}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> update(@PathVariable("reply_no") int reply_no, @RequestBody Recipe_replyVO vo) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		try {
			
			vo.setReply_no(reply_no);
			service.update(vo);
			
			entity = new ResponseEntity<String>("modSuccess", HttpStatus.OK);
			
		}catch (Exception e) {
			
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{reply_no}", method = RequestMethod.DELETE)
	public ResponseEntity<String> delete(@PathVariable("reply_no")int reply_no) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		try {
			
			service.delete(reply_no);
			entity = new ResponseEntity<String>("delSuccess", HttpStatus.OK);
			
		}catch (Exception e) {
			
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	

}
