package egovframework.edu.loginOut.service.impl;


import org.springframework.stereotype.Repository;

import egovframework.edu.loginOut.dto.UserVO;
import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("LoginOutDAO")
public class LoginOutDAO extends EgovAbstractMapper {

	public UserVO login(UserVO dto) {
        return selectOne("login.logincheck", dto);
    }
	
}
