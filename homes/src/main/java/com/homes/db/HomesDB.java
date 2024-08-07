package com.homes.db;

import javax.naming.*;
import javax.sql.*;
import java.sql.*;

public class HomesDB {

	//static 맴버변수가 아니면 static 블럭(혹은 메소드)에서 사용할 수 없다
	static DataSource ds;
	
	//{} 익명블럭
	//static {} static블럭 => 서버 기동시, 메모리에 올림
	static {
		try {
			Context	initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public static Connection getConn() throws Exception {
		return ds.getConnection();
	}
	
}