<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <!-- Footer -->
        <div class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-footer col-md-3 col-xs-6">
                        <h3>ผลงานแนะนำล่าสุด</h3>
                        <div class="portfolio-item">
                            <div class="portfolio-image">
                                <a href="page-portfolio-item.html"><img src="<%= F.asset("img/portfolio6.jpg") %>" alt="Project Name"></a>
                            </div>
                        </div>
                    </div>
                    <div class="col-footer col-md-3 col-xs-6">
                        <h3>การนำทาง</h3>
                        <ul class="no-list-style footer-navigate-section">
                            <li><a href="<%= F.asset("/") %>">Home</a></li>
                            <li><a href="<%= F.asset("/product") %>">FiNE Store</a></li>
                            <li><a href="<%= F.asset("/items") %>">Your Items</a></li>
                            <li><a href="<%= F.asset("/about") %>">About Us</a></li>
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
        
        <script src="<%= F.asset("js/bootstrap.min.js") %>"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
        <script src="http://cdn.leafletjs.com/leaflet-0.5.1/leaflet.js"></script>
        <script src="<%= F.asset("js/jquery.fitvids.js") %>"></script>
        <script src="<%= F.asset("js/jquery.sequence-min.js") %>"></script>
        <script src="<%= F.asset("js/jquery.bxslider.js") %>"></script>
        <script src="<%= F.asset("js/main-menu.js") %>"></script>
        <script src="<%= F.asset("js/template.js") %>"></script>

    </body>
</html>