package egovframework.edu.common.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("EduBbsDAO")
public class EduBbsDAO extends EgovAbstractMapper {

	public List<?> comDAO(Map<String, Object> commandMap) {
		List<?> list = selectList( (String) commandMap.get("queryId"), commandMap);
		return list;
	} 
	
	public void insertDAO(Map<String, Object> commandMap) {
		String queryname = (String) commandMap.get("queryname");
		insert(queryname, commandMap);
	}
	public void updateDAO(Map<String, Object> commandMap) {
		String queryname = (String) commandMap.get("queryname");
		update(queryname, commandMap);
	}
	public void deleteDAO(Map<String, Object> commandMap) {
		String queryname = (String) commandMap.get("queryname");
		delete(queryname, commandMap);
	}
	
}
