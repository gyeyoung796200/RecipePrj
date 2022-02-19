package com.spring.recipe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.recipe.commons.paging.Criteria;
import com.spring.recipe.commons.paging.PageMaker;
import com.spring.recipe.domain.ReplyJoinMemberVO;
import com.spring.recipe.domain.ReplyVO;
import com.spring.recipe.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	@Inject
	private ReplyService service;
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> insert(@RequestBody ReplyVO replyVO){
		
		ResponseEntity<String> entity = null;
		
		try {
			
			service.insert(replyVO);
			
			entity = new ResponseEntity<String>("regSuccess", HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/all/{bno}", method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("bno") int bno){
		
		ResponseEntity<List<ReplyVO>> entity = null;
		
		try {
			
			
			entity = new ResponseEntity<List<ReplyVO>>(service.list(bno), HttpStatus.OK);
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ReplyVO>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{reply_no}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> update(@PathVariable("reply_no") int reply_no, @RequestBody ReplyVO replyVO){
		
		ResponseEntity<String> entity = null;
		
		try {
			replyVO.setReply_no(reply_no);
			service.update(replyVO);
			
			entity = new ResponseEntity<String>("updateSuccess", HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "{reply_no}", method = RequestMethod.DELETE)
	public ResponseEntity<String> delete(@PathVariable("reply_no") int reply_no){
		
		ResponseEntity<String> entity = null;
		
		try {
			
			service.delete(reply_no);
			entity = new ResponseEntity<String>("delSuccess", HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value = "/{bno}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPaging(@PathVariable("bno") int bno, @PathVariable("page") int page){
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		try {
			
			Criteria cri = new Criteria();
			
			cri.setPage(page);
			
			List<ReplyVO> replies = service.pagingList(bno, cri);

			PageMaker pageMaker = new PageMaker();
			
			pageMaker.setCriteria(cri);
			pageMaker.setTotalCount(service.countReply(bno));
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("pageMaker", pageMaker);
			map.put("replies", replies);
			
			entity = new ResponseEntity<>(map, HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	

}
