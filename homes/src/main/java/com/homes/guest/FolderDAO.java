package com.homes.guest;

import java.io.*;
import java.util.*;

public class FolderDAO {
	//1.실제 파일 및 폴더가 있는 절대 경로
	private String homePath;
	//1-1.공통경로
	private String commonPath="guest/upload/";
	
	//2.사용자 아이디(폴더명)
	private String userid;
	
	//사용자의 현재 위치
	private String crpath;

	public String getHomePath() {
		return homePath;
	}

	public void setHomePath(String homePath) {
		this.homePath = homePath;
	}

	public String getCommonPath() {
		return commonPath;
	}

	public void setCommonPath(String commonPath) {
		this.commonPath = commonPath;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getCrpath() {
		return crpath;
	}

	public void setCrpath(String crpath) {
		this.crpath = crpath;
	}

	
}
