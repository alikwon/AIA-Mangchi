package review.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jdbc.ConnectionProvider;
import review.dao.ReviewDao;
import review.model.Review;
import service.Service;

public class ReviewListViewServiceImpl implements Service {

	
	ReviewDao dao;
	
	
	@Override
	public String getViewPage(HttpServletRequest req, HttpServletResponse resp) {
	
		
		Connection conn=null;
		HttpSession session=req.getSession();
//		Member rv = (Member)session.getAttribute("loginInfo");
//		int member_idx=rv.getMember_idx;
		int member_idx = 1111;
		int a=15;
		try {
			
			conn=ConnectionProvider.getConnection();
			dao = ReviewDao.getInstance();
			
			
			
			List<Review> reviewList = null;
			float score =0;
			List<Review> writeList =null;
			
			
			
			
			reviewList = dao.getlist(conn,member_idx);
			score = dao.scoreAvg(conn, member_idx);
			writeList = dao.setlist(conn, a);
			
			
			System.out.println(reviewList);
			System.out.println(score);
			System.out.println(writeList);
			
			req.setAttribute("reviewList", reviewList);
			req.setAttribute("score", score);
			
			req.setAttribute("writerList", writeList);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		return "/WEB-INF/views/reviews/reviewListView.jsp";
		
	}

}