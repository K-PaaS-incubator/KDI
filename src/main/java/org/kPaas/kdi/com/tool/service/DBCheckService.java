package org.kPaas.kdi.com.tool.service;

public interface DBCheckService {
	boolean isExists(final String tableName);
	
	public void createTableKDI_LINK_SERVICE();
	public void createTableKDI_LINK_DETAIL();
	public void createTableKDI_LINK_TABLE();

}
