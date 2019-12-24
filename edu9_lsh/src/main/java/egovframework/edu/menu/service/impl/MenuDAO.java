package egovframework.edu.menu.service.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("MenuDAO")
public class MenuDAO extends EgovAbstractMapper {

	// insert
	public void insertTopMenuParent(Map<String, Object> commandMap) {
		update("menu.insertTopMenuParent", commandMap);
	}
	public void insertMiddleMenuParent(Map<String, Object> commandMap) {
		update("menu.insertMiddleMenuParent", commandMap);
	}
	public void insertElseMenuParent(Map<String, Object> commandMap) {
		update("menu.insertElseMenuParent", commandMap);
	}
	
	// update
	public void changeTopMenuParent(Map<String, Object> commandMap) {
		update("menu.changeTopMenuParent", commandMap);
	}
	public void changeMiddleMenuParent(Map<String, Object> commandMap) {
		update("menu.changeMiddleMenuParent", commandMap);
	}
	public void changeElseMenuParent(Map<String, Object> commandMap) {
		update("menu.changeElseMenuParent", commandMap);
	}
	public void noChangeMenuParent(Map<String, Object> commandMap) {
		update("menu.noChangeMenuParent", commandMap);
	}
	
	// delete
	public void deleteTopMenu(Map<String, Object> commandMap) {
		update("menu.deleteTopMenu", commandMap);
	}
	public void deleteMiddleMenu(Map<String, Object> commandMap) {
		update("menu.deleteMiddleMenu", commandMap);
	}
	public void deleteElseMenu(Map<String, Object> commandMap) {
		update("menu.deleteElseMenu", commandMap);
	}
	
}
