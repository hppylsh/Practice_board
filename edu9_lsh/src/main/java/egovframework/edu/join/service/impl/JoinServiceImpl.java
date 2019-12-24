package egovframework.edu.join.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.edu.join.service.JoinService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("JoinService")
public class JoinServiceImpl extends EgovAbstractServiceImpl implements JoinService {
	protected Logger logger = LoggerFactory.getLogger(JoinServiceImpl.class);
	
	@Resource(name="JoinDAO")
	private JoinDAO dao;

	public void insertjoin(Map<String, Object> commandMap) {
		dao.insertJoin(commandMap);
	}
	
	// 회원가입 아이디 체크
	public Map<String, Object> selectCheckId(Map<String, Object> map) {
		return dao.selectCheckId(map);
		
	}

}


