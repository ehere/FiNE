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
                            <li class="shopping-cart-items"><i class="glyphicon glyphicon-shopping-cart icon-white"></i> <a href="page-shopping-cart.html"><b>3 items</b></a></li>
                            <li>
                                <div class="dropdown choose-country">
                                    <a class="#" data-toggle="dropdown" href="#"><img src="<%= F.asset("img/flags/gb.png") %>" alt="Great Britain"> UK</a>
                                    <ul class="dropdown-menu" role="menu">
                                        <li role="menuitem"><a href="#"><img src="<%= F.asset("img/flags/us.png") %>" alt="United States"> US</a></li>
                                        <li role="menuitem"><a href="#"><img src="<%= F.asset("img/flags/de.png") %>" alt="Germany"> DE</a></li>
                                        <li role="menuitem"><a href="#"><img src="<%= F.asset("img/flags/es.png") %>" alt="Spain"> ES</a></li>
                                    </ul>
                                </div>
                            </li>
                            <% if (session.getAttribute("user") == null) { %>
                            <li><a href="<%= F.asset("/login") %>">Login</a></li>
                            <% } else { %>
                            <li>Hello, <%= ((User) session.getAttribute("user")).getFullname() %>!</li>
                            <li><a href="<%= F.asset("/login.do?action=logout") %>">Logout</a></li>
                            <% } %>
                        </ul>
                    </div>
                </div>
                <nav id="mainmenu" class="mainmenu">
                    <ul>
                        <li class="logo-wrapper"><a href="index.html"><img src="<%= F.asset("img/mPurpose-logo.png") %>" alt="Multipurpose Twitter Bootstrap Template"></a></li>
                        <li class="active">
                            <a href="index.html">Home</a>
                        </li>
                        <li>
                            <a href="features.html">Features</a>
                        </li>
                        <li class="has-submenu">
                            <a href="#">Pages +</a>
                            <div class="mainmenu-submenu">
                                <div class="mainmenu-submenu-inner"> 
                                    <div>
                                        <h4>Homepage</h4>
                                        <ul>
                                            <li><a href="index.html">Homepage (Sample 1)</a></li>
                                            <li><a href="page-homepage-sample.html">Homepage (Sample 2)</a></li>
                                        </ul>
                                        <h4>Services & Pricing</h4>
                                        <ul>
                                            <li><a href="page-services-1-column.html">Services/Features (Rows)</a></li>
                                            <li><a href="page-services-3-columns.html">Services/Features (3 Columns)</a></li>
                                            <li><a href="page-services-4-columns.html">Services/Features (4 Columns)</a></li>
                                            <li><a href="page-pricing.html">Pricing Table</a></li>
                                        </ul>
                                        <h4>Team & Open Vacancies</h4>
                                        <ul>
                                            <li><a href="page-team.html">Our Team</a></li>
                                            <li><a href="page-vacancies.html">Open Vacancies (List)</a></li>
                                            <li><a href="page-job-details.html">Open Vacancies (Job Details)</a></li>
                                        </ul>
                                    </div>
                                    <div>
                                        <h4>Our Work (Portfolio)</h4>
                                        <ul>
                                            <li><a href="page-portfolio-2-columns-1.html">Portfolio (2 Columns, Option 1)</a></li>
                                            <li><a href="page-portfolio-2-columns-2.html">Portfolio (2 Columns, Option 2)</a></li>
                                            <li><a href="page-portfolio-3-columns-1.html">Portfolio (3 Columns, Option 1)</a></li>
                                            <li><a href="page-portfolio-3-columns-2.html">Portfolio (3 Columns, Option 2)</a></li>
                                            <li><a href="page-portfolio-item.html">Portfolio Item (Project) Description</a></li>
                                        </ul>
                                        <h4>General Pages</h4>
                                        <ul>
                                            <li><a href="page-about-us.html">About Us</a></li>
                                            <li><a href="page-contact-us.html">Contact Us</a></li>
                                            <li><a href="page-faq.html">Frequently Asked Questions</a></li>
                                            <li><a href="page-testimonials-clients.html">Testimonials & Clients</a></li>
                                            <li><a href="page-events.html">Events</a></li>
                                            <li><a href="page-404.html">404 Page</a></li>
                                            <li><a href="page-sitemap.html">Sitemap</a></li>
                                            <li><a href="page-login.html">Login</a></li>
                                            <li><a href="page-register.html">Register</a></li>
                                            <li><a href="page-password-reset.html">Password Reset</a></li>
                                            <li><a href="page-terms-privacy.html">Terms & Privacy</a></li>
                                            <li><a href="page-coming-soon.html">Coming Soon</a></li>
                                        </ul>
                                    </div>
                                    <div>
                                        <h4>eShop</h4>
                                        <ul>
                                            <li><a href="page-products-3-columns.html">Products listing (3 Columns)</a></li>
                                            <li><a href="page-products-4-columns.html">Products listing (4 Columns)</a></li>
                                            <li><a href="page-products-slider.html">Products Slider</a></li>
                                            <li><a href="page-product-details.html">Product Details</a></li>
                                            <li><a href="page-shopping-cart.html">Shopping Cart</a></li>
                                        </ul>
                                        <h4>Blog</h4>
                                        <ul>
                                            <li><a href="page-blog-posts.html">Blog Posts (List)</a></li>
                                            <li><a href="page-blog-post-right-sidebar.html">Blog Single Post (Right Sidebar)</a></li>
                                            <li><a href="page-blog-post-left-sidebar.html">Blog Single Post (Left Sidebar)</a></li>
                                            <li><a href="page-news.html">Latest & Featured News</a></li>
                                        </ul>
                                    </div>
                                </div><!-- /mainmenu-submenu-inner -->
                            </div><!-- /mainmenu-submenu -->
                        </li>
                        <li>
                            <a href="credits.html">Credits</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
