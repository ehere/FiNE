<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <!-- Footer -->
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-footer col-md-3 col-xs-6">
                        <h3>Our Latest Work</h3>
                        <div class="portfolio-item">
                            <div class="portfolio-image">
                                <a href="page-portfolio-item.html"><img src="<%= F.asset("img/portfolio6.jpg") %>" alt="Project Name"></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-footer col-md-3 col-xs-6">
                        <h3>Navigate</h3>
                        <ul class="no-list-style footer-navigate-section">
                            <li><a href="page-blog-posts.html">Blog</a></li>
                            <li><a href="page-portfolio-3-columns-2.html">Portfolio</a></li>
                            <li><a href="page-products-3-columns.html">eShop</a></li>
                            <li><a href="page-services-3-columns.html">Services</a></li>
                            <li><a href="page-pricing.html">Pricing</a></li>
                            <li><a href="page-faq.html">FAQ</a></li>
                        </ul>
                    </div>

                    <div class="col-footer col-md-4 col-xs-6">
                        <h3>ข้อมูลการติดต่อ</h3>
                        <p class="contact-us-details">
                            <b>ที่อยู่:</b> บริษัท International Multimedia Group ประเทศไทย จำกัด แขวงลาดกระบัง เขตลาดกระบัง กรุงเทพมหานคร<br/>
                            <b>โทรศัพท์:</b> +66 123 456 789<br/>
                            <b>โทรสาร:</b> +66 987 654 32<br/>
                            <b>อีเมล:</b> <a href="mailto:contract@fine.com">contact@fine.com</a>
                        </p>
                    </div>
                    <div class="col-footer col-md-2 col-xs-6">
                        <h3>ติดตาม FiNE ได้ที่...</h3>
                        <ul class="footer-stay-connected no-list-style">
                            <li><a href="#" class="facebook"></a></li>
                            <li><a href="#" class="twitter"></a></li>
                            <li><a href="#" class="googleplus"></a></li>
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="footer-copyright">&copy; 2015 International Multimedia Group (Thailand) Co., Ltd. All rights reserved.</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Javascripts -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/jquery-1.9.1.min.js"><\/script>');</script>
        <script src="<%= F.asset("js/bootstrap.min.js") %>"></script>
        <script src="http://cdn.leafletjs.com/leaflet-0.5.1/leaflet.js"></script>
        <script src="<%= F.asset("js/jquery.fitvids.js") %>"></script>
        <script src="<%= F.asset("js/jquery.sequence-min.js") %>"></script>
        <script src="<%= F.asset("js/jquery.bxslider.js") %>"></script>
        <script src="<%= F.asset("js/main-menu.js") %>"></script>
        <script src="<%= F.asset("js/template.js") %>"></script>
        <script src="//cdn.datatables.net/1.10.6/js/jquery.dataTables.min.js"></script>
        <script src="<%= F.asset("js/bootstrap-switch.min.js") %>"></script>

    </body>
</html>