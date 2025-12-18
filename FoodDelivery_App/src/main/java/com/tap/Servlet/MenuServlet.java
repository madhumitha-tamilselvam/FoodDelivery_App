package com.tap.Servlet;

import com.tap.dao.MenuDAO;
import com.tap.daoimp.MenuDAOImpl;
import com.tap.model.Menu;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));

        MenuDAO menuDao = new MenuDAOImpl();
        List<Menu> menuList = menuDao.getMenuByRestaurantId(restaurantId);

        request.setAttribute("menuList", menuList);
        request.setAttribute("restaurantId", restaurantId);

        RequestDispatcher rd = request.getRequestDispatcher("Menu.jsp");
        rd.forward(request, response);
    }
}
