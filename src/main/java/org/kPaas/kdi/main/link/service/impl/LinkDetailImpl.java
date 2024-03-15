package org.kPaas.kdi.main.link.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.kPaas.kdi.main.datasource.vo.DatasourceVo;
import org.kPaas.kdi.main.link.mapper.LinkDetailMapper;
import org.kPaas.kdi.main.link.service.LinkDetailService;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class LinkDetailImpl implements LinkDetailService {

	@Resource
	private LinkDetailMapper mapper;

	@Override
	public LinkServiceVo getLinkService(String svc_nm) {
		return mapper.getLinkService(svc_nm);
	}
	
	public List<String> connectLinkDs(String svc_nm) {
		List<String> schemaNm = new ArrayList<>();
		DatasourceVo datasource_vo = mapper.connectLinkDs(svc_nm);
		String ds_url = datasource_vo.getDs_url();
		String ds_usr_nm = datasource_vo.getDs_usr_nm();
		String ds_usr_pw = datasource_vo.getDs_usr_pw();
		try (Connection conn = DriverManager.getConnection(ds_url, ds_usr_nm, ds_usr_pw)) {
			String sql = String.format("		SELECT username \n"
					+ "		FROM dba_users\n"
					+ "		WHERE username NOT IN ('APEX_040200', 'DVF', 'MDDATA', 'LBACSYS','SYS', 'SYSTEM', 'SYSDG', 'SYSBACKUP', 'SYSKM', 'SYSRAC', 'DBSNMP', 'OUTLN', 'AUDSYS', 'GSMADMIN_INTERNAL', 'GSMCATUSER', 'GSMUSER', 'DIP', 'REMOTE_SCHEDULER_AGENT', 'XS$NULL', 'ORACLE_OCM', 'WMSYS', 'APPQOSSYS', 'OJVMSYS', 'ORDDATA', 'ORDPLUGINS', 'ORDSYS', 'SI_INFORMTN_SCHEMA', 'MDSYS', 'CTXSYS', 'ANONYMOUS', 'XDB', 'APEX_040000', 'APEX_050000', 'APEX_060000', 'FLOWS_FILES', 'APEX_PUBLIC_USER', 'SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR', 'OLAPSYS', 'EXFSYS', 'BI', 'GSMROOTUSER', 'DVSYS', 'DBSFWUSER', 'ORACLE_SCRIPT', 'APEX_LISTENER', 'APEX_REST_PUBLIC_USER', 'APEX_INSTANCE_ADMIN_USER')\n"
					+ "		ORDER BY username");
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				schemaNm.add(rs.getString(1));
			}
			return schemaNm;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
		
	
}
