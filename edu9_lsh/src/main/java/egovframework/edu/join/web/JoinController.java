package egovframework.edu.join.web;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.edu.join.service.JoinService;

@Controller
public class JoinController {

	@Resource(name = "JoinService")
	private JoinService joinService;
	
	// 회원가입
	@RequestMapping(value = "/join.do")
	@ResponseBody
	public void join(@RequestParam Map<String, Object> commandMap) throws Exception {
		joinService.insertjoin(commandMap);

	}
	
	// 회원가입 아이디 체크
	@RequestMapping(value = "/joincheckid.do", method = RequestMethod.POST)
	@ResponseBody
	public String joinidCheck(@RequestParam Map<String, Object> commandMap) throws Exception {
		String idCheck = null;

		if (joinService.selectCheckId(commandMap) != null) {
			idCheck = "OVERLAP";
		} else {
			idCheck = "SUCCESS";
		}
		return idCheck;
	}

}