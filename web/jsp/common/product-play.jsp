<%@page import="model.Project"%>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="header.jsp" />
<link rel="stylesheet" href="<%= F.asset("/css/style.css")%>">
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>คุณกำลังเล่น: ${product.title}</h1>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <div class="container">
        <div class="player_wrapper" style="background-image: url(https://placehold.it/1280x720/E3E3E3/ffffff&text=FiNE);margin-left: auto;margin-right: auto;background-size: 100% auto;overflow:hidden;">
            <div id="menu" style="background-image: url(https://placehold.it/1280x720/E3E3E3/ffffff&text=FiNE);width: 100%;height: 100%;background-size: 100% auto;overflow:hidden;">
                <div id="menu_choice_area" style="position: relative;height: 100%; width: 100%;">
                    <div style="display: table;position: absolute; height: 100%; max-width: 100%;">
                        <div style="display: table-cell; vertical-align: middle;">
                            <button type="button" class="btn btn-lg btn-default btn-block" onclick="newGame();">New Game</button>
                            <button type="button" class="btn btn-lg btn-default btn-block" >Load Game</button>
                            <button type="button" class="btn btn-lg btn-default btn-block" >Save Game</button>
                            <button type="button" class="btn btn-lg btn-default btn-block" onclick="showPlayer();">Back to Game</button>
                        </div>
                    </div>
                </div>
                <div class="hidden" id="input_name_area" style="position: relative;height: 100%; width: 100%;">
                    <div style="display: table;position: absolute; height: 100%; width: 100%;">
                        <div style="display: table-cell; vertical-align: middle;">
                            <div style="display: flex;width: 80%;margin-left: auto;margin-right: auto;" >
                                <input class="form-control" id="Name" type="text" placeholder="Enter your charactor name">
                                <button class="btn btn-default" type="button" >Play</button>
                            </div>
                            <div style="width: 80%;margin-left: auto;margin-right: auto;" >
                                <button class="btn btn-default" type="button" onclick="showMenu();">Back to Menu</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hidden" id="player" style="background-image: url(https://placehold.it/1280x720/E3E3E3/ffffff&text=FiNE);width: 100%;height: 100%;background-size: 100% auto;overflow:hidden;">
                <div class="player_show">
                    <div id="player_choice_area" style="display: none; position: absolute; height: 100%; width: 100%;">
                        <div id="player_choice" style="display: table-cell; vertical-align: middle;"></div>
                    </div>
                    <div style="height: 15%;width:100%;position:absolute;bottom:0.3em;">
                        <div class="player_title">
                            <span id="player_title_text" style="font-weight: bold;font-size: 1.5em;color: black;"></span>
                        </div>
                        <div style="position:absolute;bottom:0em;right:0px;">
                            <button type="button" class="btn btn-sm btn-orange" onclick="showMenu();" style="border-radius: 10em;">
                                <span class="glyphicon glyphicon-circle-arrow-down" aria-hidden="true"></span>
                                Menu
                            </button>
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
                    <div class="player_dialog_open" style="font-size: 1.5em;color: black;">
                        <span class="dialog_textbox" id="typed"></span>
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
</div>
<!-- -------------------- data zone --------------------------------------------------------------------
------------------------------------------------------------------------------------------------------- -->
<div class="hidden activity_data"></div>
<div class="hidden activity_order"></div>
<div class="hidden name"></div>

<div class="hidden play_index"></div>
<script src="<%= F.asset("/js/typed.js")%>"></script>
<script src="<%= F.asset("/js/player.js")%>"></script>                
<script>
                                $('.player_wrapper').height(($('.player_wrapper').width() * 9 / 16));
                                function getScene(sceneID) {
                                    $.getJSON("<%= F.asset("/scene/")%>" + "/" + sceneID, function (data, status) {
                                        $('.activity_data').html(data.data);
                                        $('.activity_order').html(data.order);
                                        $('.play_index').html(0);
                                        play();
                                    });

                                }
                                function newGame() {
                                    $('#input_name_area').removeClass("hidden");
                                    $('#menu_choice_area').addClass("hidden");
                                    $('#menu_choice_area').addClass("hidden");
                                    //getScene(${product.first_scene_id});
                                    //$('#menu').addClass("hidden");
                                    //$('#player').removeClass("hidden");

                                }
                                function showMenu() {
                                    $('#menu').removeClass("hidden");
                                    $('#menu_choice_area').removeClass("hidden");
                                    $('#player').addClass("hidden");
                                    $('#input_name_area').addClass("hidden");
                                    ;

                                    //getScene(${product.first_scene_id});
                                    //$('#menu').addClass("hidden");
                                    //$('#player').removeClass("hidden");

                                }
                                function showPlayer() {
                                    $('#menu').addClass("hidden");
                                    $('#player').removeClass("hidden");
                                    ;

                                    //getScene(${product.first_scene_id});
                                    //$('#menu').addClass("hidden");
                                    //$('#player').removeClass("hidden");

                                }
</script>
<jsp:include page="footer.jsp" />