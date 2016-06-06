package servlet;

import utility.GeneralDataBaseQueryHelper;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

/**
 * Created by huangzhengyue on 6/2/16.
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String account_name=req.getParameter("account_name");
        String password=req.getParameter("password");

        req.getSession().setAttribute("error","");
        if(account_name==null || account_name==null ||account_name.isEmpty()||password.isEmpty()){
            req.getSession().setAttribute("error","请填好表单");
            resp.sendRedirect("login.jsp");
            return;
        }
        try {
            Connection dbConnection= GeneralDataBaseQueryHelper.getDBConnection();
            PreparedStatement preparedStatement=dbConnection.prepareStatement("SELECT * FROM user_table WHERE  user_account_name=? AND password=?");
            preparedStatement.setString(1,account_name);
            preparedStatement.setString(2,password);
            ResultSet resultSet=preparedStatement.executeQuery();
            dbConnection.close();
            boolean isRight=false;
            while (resultSet.next()){
                isRight=true;
                break;
            }
            if(isRight){
                req.getSession().setAttribute("username",account_name);
                resp.sendRedirect("index.jsp");
                return;
            }
            else {
                req.getSession().setAttribute("error","用户名或密码错误");
                resp.sendRedirect("login.jsp");
                return;
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }


    }


}
