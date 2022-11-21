package kr.co.seoulit.insa.commsvc.systemmgmt.to;

import java.util.List;

// 70기도 어노테이션을 쓰지 않아서 안썼음
public class ListFormTO {
		private int				endrow=1;		//보여지는 화면의 끝줄
		private int 			pagenum=1;		//현재페이지번호
		private int 			rowsize;	    //화면에 보여질 줄갯수*/
		private int 			endpage=1;		//끝페이지
		private int				pagesize=2;		//화면에 보여질 페이지갯수
		private int 			pagecount;		//총페이지갯수
		private int 			dbcount;		//총레코드갯수	
		private List<?> 	    list;

		public void setPagenum(int pagenum){
			this.pagenum=pagenum;
		}
		
		public void setDbcount(int dbcount){
			this.dbcount=dbcount;
		}
		
		public void setRowsize(int rowsize){
			this.rowsize=rowsize;
		}
		public int getPagenum(){
			return pagenum;
		}
		public int getStartrow(){
			return (getPagenum()-1)*getRowsize()+1;
		}
		public int getEndrow(){
			endrow= getStartrow()+getRowsize()-1;   
			
			if(endrow>getDbcount())
				endrow = getDbcount();
			return endrow;
		}
		public int getRowsize(){
			return rowsize;
		}
	
		public int getDbcount(){
			return dbcount;
		}
		public int getStartpage(){
			return getPagenum()-((getPagenum()-1)%getPagesize());
		}
		public int getEndpage(){
			endpage= getStartpage()+getPagesize()-1;
			if(endpage>getPagecount())
				endpage = getPagecount();
			return endpage;
		}
		public int getPagesize(){
			return pagesize;
		}
		public int getPagecount(){
			pagecount=(getDbcount()-1)/getRowsize()+1;
			return pagecount;	
		}
		public boolean isPrevious(){
			if(getStartpage()-getPagesize()>0) {
				return true;
			}else {
				return false;
			}
		}
		public boolean isNext(){
			if(getStartpage()+getPagesize()<=getPagecount()) {
				return true;
			}else {
				return false;
			}
		}
		public void setList(List<?> list){
			this.list=list;
		}
		public List<?> getList(){
			return list;
		}
	}

