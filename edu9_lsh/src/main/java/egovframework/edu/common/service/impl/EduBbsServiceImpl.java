package egovframework.edu.common.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.edu.common.service.EduBbsService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service("EduBbsService")
public class EduBbsServiceImpl extends EgovAbstractServiceImpl implements EduBbsService {
	protected Logger logger = LoggerFactory.getLogger(EduBbsServiceImpl.class);
	
	@Resource(name="EduBbsDAO")
	private EduBbsDAO dao;

	public List<?> comservice(Map<String, Object> commandMap) {
		return dao.comDAO(commandMap);
	}
	
	@SuppressWarnings("unchecked")
	public void saveService(Map<String, Object> commandMap) {
		
		System.out.println("commandMap : "+commandMap);
		
		if(commandMap.containsKey("jsonData")) {
		    // 직렬화 시켜 가져온 오브젝트 배열을 JSONArray 형식으로 바꿔준다.
		    JSONArray array = JSONArray.fromObject(commandMap.get("jsonData"));
		    
		    //System.out.println("array : "+array);
		    
			for(int i =0; i<array.size() ; i++) {
				// i번째 array가져온다
				JSONObject obj = (JSONObject)array.get(i);
				
				System.out.println("obj : "+obj);
				
			    String querytype = (String) obj.get("querytype");
			
			    if (querytype.equals("insert")) {
					dao.insertDAO(obj);
				} else if (querytype.equals("update")) {
					dao.updateDAO(obj);
				} else if (querytype.equals("delete")) {
					dao.deleteDAO(obj);
				}
			}
		} else {
			String querytype = (String) commandMap.get("querytype");
			if (querytype.equals("insert")) {
				dao.insertDAO(commandMap);
			} else if (querytype.equals("update")) {
				dao.updateDAO(commandMap);
			} else if (querytype.equals("delete")) {
				dao.deleteDAO(commandMap);
			}
			
		}
	
	}
}


