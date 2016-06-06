package servlet;

import utility.GeneralDataBaseQueryHelper;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Created by huangzhengyue on 6/6/16.
 */
public class AddCommentsServlet extends HttpServlet {

    private void addPersonalPageComments(String sent_user_account_name,String content,String master_account_name)throws ServletException, IOException{

        Connection dbConnection= GeneralDataBaseQueryHelper.getDBConnection();
        try {
            PreparedStatement comments_insert=dbConnection.prepareStatement("INSERT INTO personal_comments(master_account_name,sent_user_account_name,content,sent_time) VALUES (?,?,?,CURRENT_TIMESTAMP )");
            comments_insert.setString(1,master_account_name);
            comments_insert.setString(2,sent_user_account_name);
            comments_insert.setString(3,content);
            comments_insert.execute();
            //关闭链接
            dbConnection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

    private void addTeamPageComments(String sent_user_account_name,String content,String team_id)throws ServletException, IOException{

        Connection dbConnection= GeneralDataBaseQueryHelper.getDBConnection();
        try {
            PreparedStatement comments_insert=dbConnection.prepareStatement("INSERT INTO team_comments(team_id,sent_user_account_name,content,sent_time) VALUES (?,?,?,CURRENT_TIMESTAMP )");
            comments_insert.setInt(1,Integer.valueOf(team_id));
            comments_insert.setString(2,sent_user_account_name);
            comments_insert.setString(3,content);
            comments_insert.execute();
            //关闭链接
            dbConnection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String sent_account_name=(String) req.getSession().getAttribute("username");
        req.getSession().setAttribute("error","");
        if(sent_account_name==null || sent_account_name.isEmpty()){
            req.getSession().setAttribute("error","请先登录");
            resp.sendRedirect("login.jsp");
            return;
        }
        String lastAccessUrl = req.getParameter("last_url");
        String team_id=req.getParameter("team_id");
        String master_account_name=req.getParameter("master_account_name");
        String content=req.getParameter("content");
        //如果全空
        boolean notTeam= team_id==null||team_id.isEmpty();
        boolean notPersonal= master_account_name==null||master_account_name.isEmpty();

        if(notTeam && notPersonal){
            resp.sendError(404);
            return;
        }
        else if(!notTeam){
            if(content==null||content.isEmpty()){
                req.getSession().setAttribute("error","评论不能为空!");
                resp.sendRedirect(lastAccessUrl);
                return;
            }
            addTeamPageComments(sent_account_name,content,team_id);
            resp.sendRedirect(lastAccessUrl);
            return;

        }
        else {
            if(content==null||content.isEmpty()){
                req.getSession().setAttribute("error","评论不能为空!");
                resp.sendRedirect(lastAccessUrl);
                return;
            }
            addPersonalPageComments(sent_account_name,content,master_account_name);
            resp.sendRedirect(lastAccessUrl);
            return;

        }


    }
}
