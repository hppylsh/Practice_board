package egovframework.edu.menu.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.edu.menu.service.MenuService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service("MenuService")
public class MenuServiceImpl extends EgovAbstractServiceImpl implements MenuService {
	protected Logger logger = LoggerFactory.getLogger(MenuServiceImpl.class);
	
	@Resource(name="MenuDAO")
	private MenuDAO dao;

	@SuppressWarnings("unchecked")
	public void menuSaveService(Map<String, Object> commandMap) {
		
		System.out.println("commandMap : "+commandMap);
		
		// 직렬화 시켜 가져온 오브젝트 배열을 JSONArray 형식으로 바꿔준다.
		JSONArray array = JSONArray.fromObject(commandMap.get("jsonData"));
		
		//System.out.println("array : "+array);
		
		for(int i =0; i<array.size() ; i++) {
			
			// i번째 array가져온다
			JSONObject obj = (JSONObject)array.get(i);
			
			System.out.println("obj : "+obj);
			
			String querytype = (String) obj.get("querytype");
			
			// menu 부모id 가 바뀌었는지 확인하는 flag 매개변수
			String changeMenuParent = (String) obj.get("changeMenuParent");
			// 부모id
			String menuParent = (String) obj.get("menuParent");
		
			if (querytype.equals("insert")) {
				if(menuParent.contains("MENU_000000")) {		
					dao.insertTopMenuParent(obj);		//부모id가 최상위일때
				}else if(menuParent.contains("0000")) {
					dao.insertMiddleMenuParent(obj);	//부모id가 대분류일때
				}else {					
					dao.insertElseMenuParent(obj);		//부모id가 중분류일때
				}
			} else if (querytype.equals("update")) {
				//부모id를 변경했을때
				if (changeMenuParent.contains("y")){
					if(menuParent.contains("MENU_000000")) {		
						dao.changeTopMenuParent(obj);		//부모id가 최상위일때
					}else if(menuParent.contains("0000")) {
						dao.changeMiddleMenuParent(obj);	//부모id가 대분류일때
					}else {					
						dao.changeElseMenuParent(obj);		//부모id가 중분류일때
					}
				//부모 id를 변경하지 않았을 때
				}else {
					dao.noChangeMenuParent(obj);
				}
			} else if (querytype.equals("delete")) {
				if(menuParent.contains("MENU_000000")) {		
					dao.deleteTopMenu(obj);		//부모id가 최상위일때
				}else if(menuParent.contains("0000")) {
					dao.deleteMiddleMenu(obj);	//부모id가 대분류일때
				}else {					
					dao.deleteElseMenu(obj);	//부모id가 중분류일때
				}
			}
		}
	
	}
}


