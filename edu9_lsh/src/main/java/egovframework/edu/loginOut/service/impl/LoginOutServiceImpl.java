package egovframework.edu.loginOut.service.impl;


import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.edu.loginOut.dto.UserVO;
import egovframework.edu.loginOut.service.LoginOutService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("LoginOutService")
public class LoginOutServiceImpl extends EgovAbstractServiceImpl implements LoginOutService {
	protected Logger logger = LoggerFactory.getLogger(LoginOutServiceImpl.class);
	
	@Resource(name="LoginOutDAO")
	private LoginOutDAO dao;
	
	public UserVO login(UserVO dto) {
        return dao.login(dto);
	}
	
}


