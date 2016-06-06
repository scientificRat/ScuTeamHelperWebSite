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
public class DeleteTeamServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String account_name=(String) req.getSession().getAttribute("username");


        req.getSession().setAttribute("error","");

        if(account_name==null || account_name.isEmpty()){
            req.getSession().setAttribute("error","请先登录");
            resp.sendRedirect("login.jsp");
            return;
        }

        String team_id=req.getParameter("team_id");

        if(team_id==null ||team_id.isEmpty()){
            resp.getWriter().print("前端处理异常,请联系管理员");
            return;
        }

        Connection dbConnection= GeneralDataBaseQueryHelper.getDBConnection();
        PreparedStatement preparedStatement=null;
        try {
            preparedStatement=dbConnection.prepareStatement("DELETE FROM team WHERE team_id=? AND owner_user_account=?");

            preparedStatement.setInt(1,Integer.valueOf(team_id));
            preparedStatement.setString(2,account_name);
            preparedStatement.execute();
            resp.sendRedirect("createTeam.jsp");
            return;

        } catch (SQLException e) {
            e.printStackTrace();
            req.getSession().setAttribute("error","创建失败"+preparedStatement.toString());
            resp.sendRedirect("createTeam.jsp");
            return;
        }
        finally {
            try {
                dbConnection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }


    }
}
