package egovframework.edu.common.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import egovframework.edu.common.common.Pager;
import egovframework.edu.common.service.EduBbsService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class EduBbsController {

	@Resource(name = "EduBbsService")
	private EduBbsService eduBbsService;
	
	@RequestMapping(value = "/comcon.do")
	public String commonController2(@RequestParam Map<String, Object> commandMap, Model model,
			@RequestParam(defaultValue = "1") int curPage) {
		
		System.out.println(commandMap);
		String ctrlName = (String) commandMap.get("ctrlName");
		
		/* 쿼리가 한개일때(default) */
		if(commandMap.containsKey("queryId")){
			List<?> service = eduBbsService.comservice(commandMap);
			model.addAttribute(ctrlName,service);
					
		/* 페이징 자료가 필요할 때 */
		} else if ("page".equals(ctrlName)){
			// 게시글 갯수 가져오기
			commandMap.put("queryId", "board.selectCountList");
			List<?> listCount = eduBbsService.comservice(commandMap);
			int count = (int) listCount.get(0);
			Pager pager = new Pager(count, curPage);
			
			// 시작번호, 끝번호
			int start = pager.getPageBegin();
			int end = pager.getPageEnd();
			
			// 모델에 담기
			model.addAttribute("start", start);
			model.addAttribute("end", end);
			model.addAttribute("pager", pager);
			model.addAttribute("curPage", curPage);
		}
		
		/* 쿼리가 한개 이상일 때 */
		if(commandMap.containsKey("jsonData")){
		    // 직렬화 시켜 가져온 오브젝트 배열을 JSONArray 형식으로 바꿔준다.
		    JSONArray array = JSONArray.fromObject(commandMap.get("jsonData"));
		    
			for(int i =0; i<array.size() ; i++){
				
				// i번째 array가져온다
				JSONObject obj = (JSONObject)array.get(i);
				
				// obj에서 queryId와 ctrlName을 가져온다
				String objqueryId = (String) obj.get("queryId");
				String objctrlName = (String) obj.get("ctrlName");
				
				// commandMap에 queryId를 담는다(dao에서 사용하기위함)
				commandMap.put("queryId", objqueryId);
				List<?> service = eduBbsService.comservice(commandMap);
				// 모델에 담는다
				model.addAttribute(objctrlName ,service);
			}
		}
		
	    return (String)commandMap.get("returnJSP");
	}
	
	@RequestMapping(value = "/comcon2.do", produces="application/ajax;charset=utf-8")
	@ResponseBody
	public String commonController3(@RequestParam Map<String, Object> commandMap) {
		
		String jsonPlace = "";
		JSONObject jsonObject = new JSONObject();
		
		if(commandMap.containsKey("jsonData")){
		    // 직렬화 시켜 가져온 오브젝트 배열을 JSONArray 형식으로 바꿔준다.
		    JSONArray array = JSONArray.fromObject(commandMap.get("jsonData"));
		    
			for(int i =0; i<array.size() ; i++){
				
				// i번째 array가져온다
				JSONObject obj = (JSONObject)array.get(i);
				
				// obj에서 queryId와 ctrlName을 가져온다
				String objqueryId = (String) obj.get("queryId");
				String objctrlName = (String) obj.get("ctrlName");
				
				// commandMap에 queryId를 담는다(dao에서 사용하기위함)
				commandMap.put("queryId", objqueryId);
				List<?> list = eduBbsService.comservice(commandMap);
				
				 //최종 완성될 JSONObject 선언(전체)
		        jsonObject.put(objctrlName, list);
				
		        Gson gson = new Gson();
		        jsonPlace = gson.toJson(jsonObject);
			}
		} else {
			//System.out.println(commandMap);
			List<?> list = eduBbsService.comservice(commandMap);
			Gson gson = new Gson();
			jsonPlace = gson.toJson(list);
		}
		System.out.println("jsonPlace : "+jsonPlace);
		return jsonPlace;
	}
	
	@RequestMapping(value = "/save.do")
	@ResponseBody
	public void saveController(@RequestParam Map<String, Object> commandMap) {
		eduBbsService.saveService(commandMap);
	
	}
}