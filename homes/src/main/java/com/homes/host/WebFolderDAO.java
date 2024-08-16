package com.homes.host;

import java.io.*;

public class WebFolderDAO {
	
		//1.실제 파일 및 폴더가 있는 절대경로
		private String homePath;
		
		//2. 사용자 아이디(폴더명)
		private String userid;
		
		//3. 총용량, 사용용량, 남은 용량
		private long totalSize,usedSize,freeSize;
		
		//4. 공통경로
		private String everypath="img/host_img/";
		
		private String imgpath="img/";
		
		
		private String roomPath;
		
		
		
		private String hostpath="img/host_img";
		
		private String imgFile="/homes/img/";
		
		//5. 사용자 현재위치
		private String crpath;
		
		public String getImgpath() {
			return imgpath;
		}

		public void setImgpath(String imgpath) {
			this.imgpath = imgpath;
		}

		public WebFolderDAO() {
			System.out.println("webFolder객체 생성됌!");
			totalSize=1024*1024*10;
			usedSize=0;
			freeSize = totalSize;
			}
		
		public String getHostpath() {
			return hostpath;
		}

		public void setHostpath(String hostpath) {
			this.hostpath = hostpath;
		}

		public String getHomePath() {
			return homePath;
		}
		public void setHomePath(String homePath) {
			this.homePath = homePath;
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
		
		public String getImgFile() {
			return imgFile;
		}

		public void setImgFile(String imgFile) {
			this.imgFile = imgFile;
		}

		public String getRoomPath() {
			return roomPath;
		}

		public void setRoomPath(String roomPath) {
			this.roomPath = roomPath;
		}

		//사용자 공간 존재 확인 및 생성 관련 메서드
		public void userFolderExists() {
			
			File f=new File(homePath+everypath+userid);
			System.out.println(homePath+everypath+userid);
			if(!f.exists()) {
				f.mkdir(); //폴더 생성
			}
			usedSize=0;
			settingSize(f);
			freeSize=totalSize-usedSize;
		}
		
		//용량계산 관련 메서드
		public void settingSize(File f) {
			
			File files[]=f.listFiles();
			for(int i=0;i<files.length;i++) {
				if(files[i].isFile()) {
					usedSize+=files[i].length();
				}else {
					settingSize(files[i]);//재귀함수 
				}
			}
		}
		
		public void found() {
			File f=new File(getHomePath()+getEverypath()+getUserid());
			File files[]=f.listFiles();
			if(files==null||files.length==0){
				
			}
		}
		
		public void checkFile(String user_name,String room_name,String img_name) {
			//\homes\img\host_img\phj9669\고산 캐빈
			//\homes\img\host_img\null\phj9669\apartment.jpg\apartment.jpg@#@#@#@#@#@#@#@#@
			File f = new File(homePath+everypath+"/"+user_name+"/"+room_name+"/"+img_name);
			System.out.println(f.getPath()+"@#@#@#@#@#@#@#@#@");
			deleteWebFolder(f);
			
		}
		
		
		
		
		public void deleteWebFolder(File f) {

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
