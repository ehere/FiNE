<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />


<div class="row menu-panel" style="padding: 0px;margin: 0px;width: 100%;">
    <div class="col-md-2" style="height: 100%;padding: 0px;margin: 0px;">
        <div class="panel panel-success">
            <div class="panel-heading menu-panel-list-heading" style="border-radius: 0px;">
                Scene
                <span style="position: absolute;right: 0;top: 0;">
                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target=".activity-modal">New</button>
                </span>

            </div>
            <div class="menu-panel-list" style="height: 100%;overflow: auto;">
                <!---   ---->
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                    <c:forEach begin="1" end="10" step="1" var="i">
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="heading${i}">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse${i}" aria-expanded="true" aria-controls="collapse${i}">
                                    Collapsible Group Item #${i}
                                </a>
                            </h4>
                        </div>
                        <div id="collapse${i}" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading${i}">
                            <div class="panel-body">
                                Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
                
            </div>
        </div>
    </div>
    <!-- ----------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------- -->

    <div class="col-md-7" style="height: 100%;padding: 0px;margin: 0px;">
        <div style="width:100%;height: 100%;padding-top: 5%;">
            <div id="player" class="player_wrapper" style="background-image: url(https://placehold.it/1280x720/E3E3E3/ffffff&text=FiNE);width:80%;height: 59.8%;margin-left: auto;margin-right: auto;background-size: 100% auto;;overflow:hidden;">
                <div class="player_show">
                    <div id="player_choice_area" style="display: none; position: absolute; height: 100%; width: 100%;">
                        <div id="player_choice" style="display: table-cell; vertical-align: middle;"></div>
                    </div>
                    <div style="height: 15%;width:100%;position:absolute;bottom:0.3em;">
                        <div class="player_title">
                            <span id="player_title_text"></span>
                        </div>
                        <div style="position:absolute;bottom:0em;right:0px;">
                            <button id="btn_toggle_dialog" type="button" class="btn btn-sm btn-default" onclick="toggleDialog();" style="border-radius: 10em;">
                                <span class="glyphicon glyphicon-circle-arrow-down" aria-hidden="true"></span>
                                Hide
                            </button>
                            <button id="btn-play" type="button" class="btn btn-sm btn-default" style="border-radius: 10em;" onclick="play();">
                                Next <span class="glyphicon glyphicon-play" aria-hidden="true"></span>
                            </button>
                        </div>
                    </div>
                </div>
                <div style="width:80%;height: 35%;margin-left: auto;margin-right: auto;">
                    <div class="player_dialog_open">
                        <span class="dialog_textbox" id="typed" onclick="play();"></span>
                        <a id="endtext" href="#" class="">.</a>
                    </div>
                </div>
            </div>
            <audio id="dubsound">
                <source type="audio/mp4">
                Your browser does not support the audio element.
            </audio>
            <audio id="player_music">
                <source type="audio/mp4">
                Your browser does not support the audio element.
            </audio>
        </div>
    </div>
    <!-- ----------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------- -->
    <div class="col-md-3" style="height: 100%;padding: 0px;margin: 0px;">
        <div class="panel panel-success">
            <div class="panel-heading menu-panel-list-heading" style="border-radius: 0px;">
                Activity
                <span style="position: absolute;right: 0;top: 0;">
                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target=".activity-modal">New</button>
                </span>

            </div>
            <div class="panel-body activity_bar menu-panel-list">
                #activity here
            </div>
        </div>
    </div>
</div>

<!-- -------------------- data zone --------------------------------------------------------------------
------------------------------------------------------------------------------------------------------- -->
<div class="hidden activity_data">
    { 
    "10":{"type":5, "url":"/fine/img/bg/bg-ex4.jpg"}, 
    "11":{"type":1, "title":"Title1", "text":"สวัสดี<br>สวัสดี<br>สวัสดี<br>สวัสดี<br>สวัสดี<br>สวัสดี<br>สวัสดี<br>สวัสดี", "sound":"./sound/Ring02.wav"},
    "12":{"type":1, "title":"Title2", "text":"Text1<br>Text2<br>Text3", "sound":"./sound/Ring03.wav"}, 
    "13":{"type":2, "choice":[
    {"text":"Yes","action":1,"nextnode":4},
    {"text":"No","action":2,"nextnode":3},
    {"text":"Later<br>OK","action":1,"nextnode":6}
    ]}, 
    "15":{"type":3, "nextnode":"8"},
    "21":{"type":1, "title":"Title3", "text":"Dialog Text3", "sound":"http://aaa.com/aaa.mp4"}, 
    "16":{"type":4, "nextnode":"21"}, 
    "14":{"type":6, "url":"./music/Tell Your World(Seksun feat.).mp3"}, 
    "17":{"type":5, "url":"/fine/img/bg/bg-ex3.jpg"} 
    }
</div>
<div class="hidden activity_order">
    [10,11,12,13,21,15,14,16,17]
</div>
<div class="hidden activity_newID">
    []
</div>    
<div class="hidden play_index">
    0
</div>
<div class="hidden name">MC_NAME</div>

<script src="<%= F.asset("/js/typed.js")%>"></script>
<script src="<%= F.asset("/js/player.js")%>"></script> 
<script src="<%= F.asset("/js/activity_bar.js")%>"></script>
<script>
                            $('.menu-panel').outerHeight($('html').outerHeight() - $('.mainmenu-wrapper').outerHeight());
                            $('.menu-panel-list').outerHeight($('.menu-panel').outerHeight() - $('.menu-panel-list-heading').outerHeight());
</script>
<jsp:include page="footer.jsp" />