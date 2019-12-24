package egovframework.edu.loginOut.web;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.edu.loginOut.dto.UserVO;
import egovframework.edu.loginOut.service.LoginOutService;

@Controller
public class LoginOutController {

	@Resource(name = "LoginOutService")
	private LoginOutService loginOutService;
	
	// 로그인
	@RequestMapping(value = "/loginPost.do", method = RequestMethod.POST)
	public String loginiPOST(UserVO dto, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();

		String returnURL = "";
		if (session.getAttribute("login") != null) {
			// 기존에 login이란 세션 값이 존재한다면
			session.removeAttribute("login"); // 기존값을 제거해 준다.
		}

		// 로그인이 성공하면 UserVO 객체를 반환함.
		UserVO vo = loginOutService.login(dto);
	
		if (vo != null) { // 로그인 성공
			session.setAttribute("login", vo); // 세션에 login인이란 이름으로 UserVO 객체를 저장해 놈.
			returnURL = "redirect:/comcon.do?returnJSP=common/V_header&login=ok"; // 로그인 성공시 게시글 목록페이지로 바로 이동하도록 하고
		} else { // 로그인에 실패한 경우
			returnURL = "redirect:/comcon.do?returnJSP=common/V_header&login=nook"; // 로그인 폼으로 다시 가도록 함
		}

		return returnURL; // 위에서 설정한 returnURL 을 반환해서 이동시킴
	}

	// 로그아웃 하는 부분
	@RequestMapping(value = "/logout.do")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate(); // 세션 전체를 날려버림
		return "redirect:/comcon.do?returnJSP=common/V_header"; // 로그아웃 후 게시글 목록으로 이동하도록...함
	}
	

}