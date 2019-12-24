package egovframework.edu.join.service;

import java.util.Map;


public interface JoinService {

	public void insertjoin(Map<String, Object> commandMap);
	
	// 아이디체크
	public Map<String, Object> selectCheckId(Map<String, Object> map);
		

}
