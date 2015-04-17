<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>เกี่ยวกับเรา</h1>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2>เกี่ยวกับเรา</h2>
                <p>บริษัท International Multimedia Group ประเทศไทย จำกัด เป็นผู้ผลิตและจัดจำหน่ายสิ่งบันเทิงมากมายหลายรูปแบบ เช่น นิยาย การ์ตูน หนัง หรือละครซึ่งคอยให้ความบันเทิงแก่ผู้คน ซึ่งแต่ละอย่างมีความแตกต่างของตัวเอง โดย ณ ปัจจุบัน มีสิ่งบันเทิงรูปแบบใหม่เกิดขึ้นมา นั่นคือ Visual Novel หรือ นิยายหรือเกมที่ผู้เล่นมีส่วนร่วม ซึ่งมีรูปแบบเหมือนผู้เล่นได้เข้าไปอยู่ในเนื้อเรื่อง ซึ่งทุกการกระทำจะเป็นตัวกำหนดทิศทางการดำเนินเรื่อง ซึ่งทำให้ผู้เล่นรู้สึกสนุกสนาน และมีอารมณ์ร่วมไปกับการเล่น</p>
                <p>ทางบริษัทได้ทำการจับตามอง Visual Novel มาตั้งแต่แรกเริ่ม และพบว่า Visual Novel กำลังเริ่มได้รับความนิยมเพิ่มขึ้นอย่างต่อเนื่อง จึงทำให้บริษัทของเราเล็งเห็นความสามารถในการขยายตัวของตลาดด้านนี้ว่ามีสูง และมีฐานลูกค้าที่จำนวนมากพอที่จะเริ่มทำการขยายการลงทุนเข้าไปทำธุรกิจในส่วนนี้ แต่เนื่องจาก Visual Novel เป็นสิ่งที่เพิ่งจะเกิดขึ้นใหม่ทำให้บริษัทยังขาดระบบที่ไว้ใช้สำหรับสร้าง จัดการ และเผยแพร่ ทำให้บริษัทตัดสินใจสร้างระบบการสร้าง จัดจำหน่าย และเผยแพร่นิยายหรือเกมที่ผู้เล่นมีส่วนร่วมขึ้นมา</p>
                <p>ระบบการสร้าง จัดจำหน่าย และเผยแพร่นิยายหรือเกมที่ผู้เล่นมีส่วนร่วม จะเป็นระบบที่สามารถใช้ได้ผ่านอินเตอร์เน็ต ซึ่งจะทำให้สามารถเข้าใช้ได้ง่ายและช่วยอำนวยความสะดวกในการสร้าง จัดการและเผยแพร่นิยายหรือเกมที่ผู้เล่นมีส่วนร่วม และยังจะทำให้ Visual Novel เป็นที่รู้จักกว้างขวางออกไปมากขึ้น</p>
                <hr />
                <h2>ทีมพัฒนา</h2>
                <div class="section">
                    <div class="container">
                        <div class="row">
                            <!-- Team Member -->
                            <div class="col-md-4 col-sm-6">
                                <div class="team-member">
                                    <!-- Team Member Photo -->
                                    <div class="team-member-image"><img src="<%= F.asset("img/team-tj.jpg") %>"  alt="Name Surname"></div>
                                    <div class="team-member-info">
                                        <ul>
                                            <!-- Team Member Info & Social Links -->
                                            <li class="team-member-name">
                                                นายธนกฤต  จุลวานิช
                                            </li>
                                            <li>Web Developer</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- End Team Member -->
                            <div class="col-md-4 col-sm-6">
                                <div class="team-member">
                                    <div class="team-member-image"><img src="<%= F.asset("img/team2.jpg") %>" alt="Name Surname"></div>
                                    <div class="team-member-info">
                                        <ul>
                                            <li class="team-member-name">
                                                นายธนดล  ดียิ่ง
                                            </li>
                                            <li>Web Designer</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-6">
                                <div class="team-member">
                                    <div class="team-member-image"><img src="<%= F.asset("img/team-tp.jpg") %>" alt="Name Surname"></div>
                                    <div class="team-member-info">
                                        <ul>
                                            <li class="team-member-name">
                                                นายธนทรัพย์  เพิ่มพูล
                                            </li>
                                            <li>Web Developer</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-6">
                                <div class="team-member">
                                    <div class="team-member-image"><img src="<%= F.asset("img/team4.jpg") %>" alt="Name Surname"></div>
                                    <div class="team-member-info">
                                        <ul>
                                            <li class="team-member-name">
                                                นายสหัชภัค  ภูริวิลาส
                                            </li>
                                            <li>Web Designer</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-6">
                                <div class="team-member">
                                    <div class="team-member-image"><img src="<%= F.asset("img/team5.jpg") %>" alt="Name Surname"></div>
                                    <div class="team-member-info">
                                        <ul>
                                            <li class="team-member-name">
                                                นายอัษฎาวุธ  เชี่ยวชาญ
                                            </li>
                                            <li>Web Designer</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />