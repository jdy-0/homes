package com.homes.wf;
import java.io.*;

public class WebFolderDAO {

	//1. 실제 파일 및 폴더가 있는 절대경로 값
	private String hongPath;
	//2. 사용자 아이디(폴더명)
	private String userid;
	//3. 총용량, 사용용량, 남은용량
	private long totalSize, usedSize, freeSize;
	//4. 공통 경로
	private String everypath="webFolder/upload/";
	//5. 사용자 현재 위치
	private String crpath;
	
	public WebFolderDAO() {
		System.out.println("webFolder 객체 생성됨!");
		System.out.println("webFolder객체 생성됨");
		totalSize=1024*1024*10;
		usedSize=0;
		freeSize=0;
	}
	
	
	public String getHongPath() {
		return hongPath;
	}


	public void setHongPath(String hongPath) {
		this.hongPath = hongPath;
	}


	public String getUserid() {
		return userid;
	}


	public void setUserid(String userid) {
		this.userid = userid;
	}


	public long getTotalSize() {
		return totalSize;
	}


	public void setTotalSize(long totalSize) {
		this.totalSize = totalSize;
	}


	public long getUsedSize() {
		return usedSize;
	}


	public void setUsedSize(long usedSize) {
		this.usedSize = usedSize;
	}


	public long getFreeSize() {
		return freeSize;
	}


	public void setFreeSize(long freeSize) {
		this.freeSize = freeSize;
	}


	
	public String getEverypath() {
		return everypath;
	}


	public void setEverypath(String everypath) {
		this.everypath = everypath;
	}

	

	public String getCrpath() {
		return crpath;
	}


	public void setCrpath(String crpath) {
		this.crpath = crpath;
	}


	//사용자 공간 존재 확인 및 생성 관련 메서드
	public void userFolderExists() {
		usedSize=0;
		freeSize=0;
		File f = new File(hongPath+everypath+userid);
		if(!f.exists()) {
			f.mkdir();
		}
		
		settingSize(f);
		freeSize = totalSize-usedSize;
	}


	public void settingSize(File f) {
		File[] files = f.listFiles();
		
		for(int i=0; i<files.length; i++) {
			
			if(files[i].isFile()) {
				usedSize+=files[i].length();
			} else {
				settingSize(files[i]);
			}
		}
	}
	
	
	public void makeDir(String name) {
		File f = new File(hongPath+everypath+crpath+"/"+name);
		f.mkdir();
	}
	
	public void checkFile(String name) {
		
		File f = new File(hongPath+everypath+crpath+"/"+name);
		deleteWebFolder(f);
		
	}
	
	public void deleteWebFolder(File f) {

//		if(f.isDirectory()) {
//			File files[] = f.listFiles();
//			if(files.length==0 || files==null) {
//				f.delete();
//			} else {
//				for(int i=0; i<files.length; i++) {
//					System.out.println("intothe");
//					deleteWebFolder(files[i]);
//				}
//			}
//		} else {
//			f.delete();
//			
//		}
		if(f.isDirectory()) {
	        File[] files = f.listFiles();
	        if(files != null) { // null 체크를 먼저 수행해야 함
	            for(File file : files) {
	                deleteWebFolder(file); // 재귀적으로 모든 파일 및 폴더 삭제
	            }
	        }
	    }
	    f.delete();
		
	}
	
	
	
	
}
