package com.spring.recipe;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class MysqlConnectionTest {

	
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/recipe?useSSL=false&serverTimezone=Asia/Seoul";
	private static final String USER = "root";
	private static final String PW = "1234";
	
	
	@Test
	public void testConnection() throws Exception{
		
		Class.forName(DRIVER);
		try(Connection conn = DriverManager.getConnection(URL, USER, PW)){
			
			System.out.println(conn);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}
