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
public class PublishNewTeamServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String account_name=(String) req.getSession().getAttribute("username");
        req.getSession().setAttribute("error","");

        if(account_name==null || account_name.isEmpty()){
            req.getSession().setAttribute("error","请先登录");
            resp.sendRedirect("login.jsp");
            return;
        }
        String team_name=req.getParameter("team_name");
        String email=req.getParameter("email");
        String qq=req.getParameter("qq");
        String introduction=req.getParameter("introduction");
        String competition_name=req.getParameter("competition_name");
        String errorInfo="";
        if(team_name==null ||team_name.isEmpty()){
            errorInfo="请填写队伍名";
        }
        else if(email==null ||email.isEmpty() ){
            errorInfo="请填写email";
        }
        else if(qq==null || qq.isEmpty()){
            errorInfo="请填写qq";
        }
        else if(introduction==null || introduction.isEmpty()){
            errorInfo="请填写介绍";
        }
        else if(competition_name==null || competition_name.isEmpty()){
            errorInfo="请填写参与比赛名";
        }
        if(!errorInfo.isEmpty()){
            req.getSession().setAttribute("error","请将表单填写完整后提交!"+errorInfo);
            resp.sendRedirect("publishPersonalInfo.jsp");
            return;
        }

        Connection dbConnection= GeneralDataBaseQueryHelper.getDBConnection();

        try {
            PreparedStatement preparedStatement1=dbConnection.prepareStatement("INSERT INTO team (owner_user_account,team_name,competition_name,email,qq,team_introduction) VALUES (?,?,?,?,?,?)");
            preparedStatement1.setString(1,account_name);
            preparedStatement1.setString(2,team_name);
            preparedStatement1.setString(3,competition_name);
            preparedStatement1.setString(4,email);
            preparedStatement1.setString(5,qq);
            preparedStatement1.setString(6,introduction);
            try {
                preparedStatement1.execute();
            }
            catch (SQLException e){
                e.printStackTrace();
                req.getSession().setAttribute("error","发布失败,可能是欠费,请联系管理员"+preparedStatement1.toString());
                resp.sendRedirect("publishPersonalInfo.jsp");
                return;
            }
            finally {
                dbConnection.close();
            }
            resp.sendRedirect("index.jsp");
            return;


        } catch (SQLException e) {
            e.printStackTrace();
        }


    }
}
