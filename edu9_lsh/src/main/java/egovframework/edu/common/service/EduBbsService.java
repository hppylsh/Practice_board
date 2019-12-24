package egovframework.edu.common.service;

import java.util.List;
import java.util.Map;

public interface EduBbsService {
		
	public void saveService(Map<String, Object> commandMap);

	public List<?> comservice(Map<String, Object> commandMap);
}
