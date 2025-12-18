package com.tap.Servlet;

import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.dao.MenuDAO;
import com.tap.daoimp.MenuDAOImpl;
import com.tap.model.Menu;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
        }

        String action = request.getParameter("action");
        MenuDAO menuDao = new MenuDAOImpl();

        /* --------------------------------------------------
           CASE 1 : BULK ADD (from Proceed button in Menu.jsp)
        -------------------------------------------------- */
        if ("bulkAdd".equalsIgnoreCase(action)) {

            int size = Integer.parseInt(request.getParameter("size")); // number of items sent

            for (int i = 0; i < size; i++) {

                int menuId = Integer.parseInt(request.getParameter("menuId" + i));
                int quantity = Integer.parseInt(request.getParameter("quantity" + i));

                Menu menu = menuDao.getMenu(menuId);

                CartItem item = new CartItem(
                        menuId,
                        menu.getItemName(),
                        menu.getPrice(),
                        quantity
                );

                cart.addItem(item);
            }

            session.setAttribute("cart", cart);
            response.sendRedirect("Cart.jsp");
            return;
        }

        /* --------------------------------------------------
           CASE 2 : ADD / UPDATE / REMOVE (normal operations)
        -------------------------------------------------- */

        int menuId = Integer.parseInt(request.getParameter("menuId"));
        int quantity = 1;

        if (request.getParameter("quantity") != null) {
            quantity = Integer.parseInt(request.getParameter("quantity"));
        }

        Menu menu = menuDao.getMenu(menuId);

        if ("add".equalsIgnoreCase(action)) {

            CartItem item = new CartItem(
                    menu.getMenuId(),
                    menu.getItemName(),
                    menu.getPrice(),
                    quantity
            );
            cart.addItem(item);

        } else if ("update".equalsIgnoreCase(action)) {

            cart.updateItem(menuId, quantity);

        } else if ("remove".equalsIgnoreCase(action)) {

            cart.removeItem(menuId);
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("Cart.jsp");
    }
}
