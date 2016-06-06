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
 * Created by huangzhengyue on 6/5/16.
 */
public class SignUpServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.getSession().setAttribute("error","");


        String user_account_name=req.getParameter("user_account_name");
        String password=req.getParameter("password");
        String realname=req.getParameter("realname");
        String gender=req.getParameter("gender");
        String college=req.getParameter("college");
        String major=req.getParameter("major");
        String grade=req.getParameter("grade");
        String academic_background=req.getParameter("academic_background");


        Connection dbConnection= GeneralDataBaseQueryHelper.getDBConnection();
        try {

            PreparedStatement preparedStatement=dbConnection.prepareStatement("INSERT INTO user_table(user_account_name,password,realname,gender,college,major,grade,academic_background)VALUES (?,?,?,?,?,?,?,?)");

            preparedStatement.setString(1,user_account_name);
            preparedStatement.setString(2,password);
            preparedStatement.setString(3,realname);
            preparedStatement.setString(4,gender);
            preparedStatement.setString(5,college);
            preparedStatement.setString(6,major);
            preparedStatement.setString(7,grade);
            preparedStatement.setString(8,academic_background);
            try {
                preparedStatement.execute();
            }
            catch (SQLException e){
                req.getSession().setAttribute("error","注册失败");
                resp.sendRedirect("login.jsp");
                return;
            }
            finally {
                dbConnection.close();
            }

            req.getSession().setAttribute("error","注册成功,新账户:"+user_account_name);
            resp.sendRedirect("login.jsp");
            return;

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
