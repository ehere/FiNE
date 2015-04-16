<%@page import="model.User"%>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>FiNE - Fine is Novel Engine</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <link rel="stylesheet" href="<%= F.asset("css/bootstrap.min.css") %>">
        <link rel="stylesheet" href="<%= F.asset("css/icomoon-social.css") %>">
        <!-- <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,600,800' rel='stylesheet' type='text/css'> -->
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

        <link rel="stylesheet" href="<%= F.asset("css/leaflet.css") %>" />
        <!--[if lte IE 8]>
            <link rel="stylesheet" href="<%= F.asset("css/leaflet.ie.css") %>" />
        <![endif]-->
        <link rel="stylesheet" href="<%= F.asset("css/main.css") %>">
        <link rel="stylesheet" href="//cdn.datatables.net/1.10.6/css/jquery.dataTables.min.css" />
        
        <link rel="stylesheet" href="<%= F.asset("css/bootstrap-switch.min.css") %>">

        <script src="<%= F.asset("js/modernizr-2.6.2-respond-1.1.0.min.js") %>"></script>
        <script src="<%= F.asset("js/jquery-2.1.3.min.js") %>">"></script>
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->


        <!-- Navigation & Logo-->
        <div class="mainmenu-wrapper">
            <div class="container">
                <div class="menuextras">
                    <div class="extras">
                        <ul>
                            <% if (session.getAttribute("user") == null) { %>
                            <li><a href="<%= F.asset("/register") %>"><i class="glyphicon glyphicon-pencil icon-white"></i> สมัครสมาชิก</a></li>
                            <li><a href="<%= F.asset("/login") %>"><i class="glyphicon glyphicon-log-in icon-white"></i> เข้าสู่ระบบ</a></li>
                            <% } else { %>
                            <li class="shopping-cart-items"><i class="glyphicon glyphicon-shopping-cart icon-white"></i> <a href="<%= F.asset("/cart") %>"><b><%= ((model.Cart) session.getAttribute("cart")).getItemsSize() %> รายการ</b></a></li>
                            <li>สวัสดี! <%= ((User) session.getAttribute("user")).getFullname() %></li>
                            <li><i class="glyphicon glyphicon-bitcoin icon-white"></i> <%= ((User) session.getAttribute("user")).getCredit()%> เครดิต</li>
                            <li><a href="<%= F.asset("/") %>"><i class="glyphicon glyphicon-cog icon-white"></i> กลับสู่โหมดปกติ</a></li>
                            <li><a href="<%= F.asset("/login.do?action=logout") %>"><i class="glyphicon glyphicon-log-out icon-white"></i> ออกจากกระบบ</a></li>
                            <% } %>
                        </ul>
                    </div>
                </div>
                <nav id="mainmenu" class="mainmenu">
                    <ul>
                        <li class="logo-wrapper"><a href="index.html"><img src="<%= F.asset("img/fine-logo.png") %>" alt="Multipurpose Twitter Bootstrap Template"></a></li>
                        <li class="active">
                            <a href="<%= F.asset("/") %>">Home</a>
                        </li>
                        <li>
                            <a href="<%= F.asset("/admin/user") %>">User Management</a>
                        </li>
                        <li>
                            <a href="<%= F.asset("/admin/product") %>">Product Management</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
                        <%= F.getMessage(session) %>