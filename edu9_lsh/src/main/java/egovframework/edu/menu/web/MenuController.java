package egovframework.edu.menu.web;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.edu.menu.service.MenuService;

@Controller
public class MenuController {

	@Resource(name = "MenuService")
	private MenuService menuService;
	
	@RequestMapping(value = "/menusave.do")
	@ResponseBody
	public void menuSaveController(@RequestParam Map<String, Object> commandMap) {
		menuService.menuSaveService(commandMap);
	}
}