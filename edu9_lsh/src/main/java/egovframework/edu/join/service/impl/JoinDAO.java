package egovframework.edu.join.service.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("JoinDAO")
public class JoinDAO extends EgovAbstractMapper {
	
	public void insertJoin(Map<String, Object> commandMap) {
		insert("join.insertjoin", commandMap);
	}
	
	public Map<String, Object> selectCheckId(Map<String, Object> map) {
		return selectOne("join.selectCheckId", map);
	}
	
}
