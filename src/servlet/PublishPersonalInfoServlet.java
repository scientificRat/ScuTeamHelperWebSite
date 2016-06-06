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
public class PublishPersonalInfoServlet extends HttpServlet {
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

        String email=req.getParameter("email");
        String qq=req.getParameter("qq");
        String[] abilities=req.getParameterValues("ability");
        String introduction=req.getParameter("introduction");
        String errorInfo="";
        if(email==null ||email.isEmpty() ){
            errorInfo="请填写email";
        }

        if(qq==null || qq.isEmpty()){
            errorInfo="请填写qq";
        }

        if(introduction==null || introduction.isEmpty()){
            errorInfo="请填写介绍";
        }

        if(!errorInfo.isEmpty()){
            req.getSession().setAttribute("error","请将表单填写完整后提交!"+errorInfo);
            resp.sendRedirect("publishPersonalInfo.jsp");
            return;
        }

        Connection dbConnection=GeneralDataBaseQueryHelper.getDBConnection();
        try {
            PreparedStatement preparedStatement1=dbConnection.prepareStatement("INSERT INTO personal_introduction (user_account_name,email,qq,introduction) VALUES (?,?,?,?)");
            preparedStatement1.setString(1,account_name);
            preparedStatement1.setString(2,email);
            preparedStatement1.setString(3,qq);
            preparedStatement1.setString(4,introduction);
            PreparedStatement preparedStatement2=dbConnection.prepareStatement("INSERT INTO team_finder(user_account_name)VALUES (?)");
            preparedStatement2.setString(1,account_name);
            try {
                preparedStatement1.execute();
                preparedStatement2.execute();
                PreparedStatement preparedStatement3=dbConnection.prepareStatement("INSERT INTO has_ability(user_account_name,ability_name)VALUES(?,?)");
                for (int i = 0; i <abilities.length ; i++) {
                    preparedStatement3.setString(1, account_name);
                    preparedStatement3.setString(2, abilities[i]);
                    preparedStatement3.execute();
                }


            }
            catch (SQLException e){
                e.printStackTrace();
                req.getSession().setAttribute("error","发布失败,可能是已发布过信息,请联系管理员"+preparedStatement1.toString());
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
