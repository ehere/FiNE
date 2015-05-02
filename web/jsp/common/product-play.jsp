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
                    <div style="display: table;position: absolute; height: 100%; width: 40%;">
                        <div style="display: table-cell; vertical-align: middle;">
                            <button type="button" class="btn btn-lg btn-orange btn-block btn-menu" onclick="newGameMenu();">New Game</button>
                            <button type="button" class="btn btn-lg btn-blue btn-block btn-menu" onclick="showLoad();">Load Game</button>
                            <button type="button" class="btn btn-lg btn-blue btn-block btn-menu hidden" onclick="showSave();">Save Game</button>
                            <button type="button" class="btn btn-lg btn-green btn-block btn-menu hidden" onclick="showPlayer();">Back to Game</button>

                        </div>
                    </div>
                </div>
                <div class="hidden" id="input_name_area" style="position: relative;height: 100%; width: 100%;">
                    <div style="display: table;position: absolute; height: 100%; width: 100%;">
                        <div style="display: table-cell; vertical-align: middle;">
                            <div style="display: flex;width: 80%;margin-left: auto;margin-right: auto;" >
                                <input class="form-control" id="Name" type="text" placeholder="Enter your charactor name" value="${user.firstname}">
                                <button class="btn btn-red" type="button" onclick="newGame(this);">Play</button>
                            </div>
                            <br>
                            <div style="width: 80%;margin-left: auto;margin-right: auto;" >
                                <button class="btn btn-green" type="button" onclick="showMenu();">Back to Menu</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu_load_area" class="hidden" style="height: 100%; width: 100%;background-color: white;">
                    <div id="load_menu" class="row">
                        <div class="col-md-6 backtomenu-top" style="padding-left: 0;padding-right: 0;">
                            <button class="btn btn-blue btn-block" type="button" onclick="showMenu();">Back to Menu</button>
                        </div>
                        <div class="col-md-6 newsave-top" style="padding-left: 0;padding-right: 0;">
                            <button class="btn btn-orange btn-block" type="button" onclick="saveMemo('#typed', 0);" data-toggle="modal" data-target="#myModal">New save</button>
                        </div>
                    </div>
                    <div class="loadgame" style="overflow-y: auto;height: 100%; width: 100%;">
                        <table class="table table-save">
                            <tr style="background-color: #DCDCDC;">
                                <th width="10%"></th>
                                <th >MC Name</th>
                                <th >Memo</th>
                                <th >Save Date</th>
                                <th width="20%">Action</th>
                            </tr>
                        </table>
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
                            <span id="player_title_text"></span>
                        </div>
                        <div style="position:absolute;bottom:0em;right:0px;">
                            <button type="button" class="btn btn-sm btn-orange" onclick="showMenu();" style="border-radius: 10em;">
                                <span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
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
                    <div class="player_dialog_open">
                        <span class="dialog_textbox" id="typed"></span>
                        <a id="endtext" href="javascript:void(0);" class="">.</a>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <div style="margin-left: auto;margin-right: auto;">
            <table>
                <tr>
                    <td><b>Dialog Sound:</b></td>
                    <td>
                        <audio id="dubsound" controls>
                            <source type="audio/mp4">
                            Your browser does not support the audio element.
                        </audio>
                    </td>
                </tr>
                <tr>
                    <td><b>Background Music:&nbsp;&nbsp;&nbsp;&nbsp;</b></td>
                    <td>
                        <audio id="player_music" controls>
                            <source type="audio/mp4">
                            Your browser does not support the audio element.
                        </audio>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

<!-- Modal Save -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Enter Memo of this save.</h4>
            </div>
            <div class="modal-body">
                <textarea class="form-control" name="memo" id="memo" rows="3" placeholder="Enter memo here."></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary btn-confirmsave" onclick="save('newsave');">Save</button>
            </div>
        </div>
    </div>
</div>

<!-- -------------------- data zone --------------------------------------------------------------------
------------------------------------------------------------------------------------------------------- -->
<div class="hidden activity_data"></div>
<div class="hidden activity_order"></div>
<div class="hidden name"></div>
<div class="hidden mode">play</div>
<div class="hidden play_index"></div>


<!-- -------------------- script zone --------------------------------------------------------------------
------------------------------------------------------------------------------------------------------- -->
<script src="<%= F.asset("/js/typed.js")%>"></script>
<script src="<%= F.asset("/js/player.js")%>"></script> 
<script>
                    function newGameMenu() {
                        $('#input_name_area').removeClass("hidden");
                        $('#menu_choice_area').addClass("hidden");
                        $('#menu_load_area').addClass("hidden");
                    }
                    function newGame(element) {
                        var name = $(element).parent().find("input").val();
                        if ($.trim(name) != '') {
                            $('.name').html(name);
                            getScene(${product.first_scene_id}, 0);
                            $('#menu').addClass("hidden");
                            $('.btn-menu').removeClass("hidden");
                            showPlayer();
                        } else {
                            alert("กรุณาตั้งชื่อก่อนเล่น");
                        }
                    }
                    function showMenu() {
                        $('#menu').removeClass("hidden");
                        $('#menu_choice_area').removeClass("hidden");
                        $('#player').addClass("hidden");
                        $('#input_name_area').addClass("hidden");
                        $('#menu_load_area').addClass("hidden");
                    }
                    function showLoad() {
                        $('#menu').removeClass("hidden");
                        $('.newsave-top').addClass("hidden");
                        $('.backtomenu-top').removeClass("col-md-6").addClass("col-md-12");
                        $('#menu_load_area').removeClass("hidden");
                        $('#player').addClass("hidden");
                        $('#input_name_area').addClass("hidden");
                        $('#menu_choice_area').addClass("hidden");
                        $('.loadgame').height($('#menu_load_area').height() - $('#load_menu').height());
                        drawTableSave('load');
                    }
                    function showSave() {
                        $('#menu').removeClass("hidden");
                        $('.newsave-top').removeClass("hidden");
                        $('.backtomenu-top').removeClass("col-md-12").addClass("col-md-6");
                        $('#menu_load_area').removeClass("hidden");
                        $('#player').addClass("hidden");
                        $('#input_name_area').addClass("hidden");
                        $('#menu_choice_area').addClass("hidden");
                        $('.loadgame').height($('#menu_load_area').height() - $('#load_menu').height());
                        drawTableSave('save');
                    }
                    function showPlayer() {
                        $('#menu').addClass("hidden");
                        $('#player').removeClass("hidden");
                    }
                    function tooltip(element) {
                        $(element).tooltip({content: 'asdasd'});
                    }
                    function saveMemo(element, id) {
                        if (element.indexOf("memo") !== -1) {
                            $('#memo').val($(element).html());
                            $('.btn-confirmsave').attr('onclick', "save('replace'," + id + ");");
                        } else {
                            $('#memo').val($('#typed').html());
                            $('.btn-confirmsave').attr('onclick', "save('newsave',0);");
                        }

                    }
                    function save(action, id) {
                        var memo = $('#memo').val();
                        var bg = $('#player').css('background-image');
                        bg = bg.replace('url(', '').replace(')', '');
                        var music = ($('#player_music').attr('src'));
                        var nowindex = $('.play_index').html();
                        var name = $('.name').html();
                        if (nowindex > 0) {
                            nowindex = nowindex - 1;
                        }
                        var activity = JSON.parse($('.activity_order').html())[nowindex];
                        $.getJSON("<%= F.asset("/save")%>", {memo: memo, bg: bg, music: music, activity: activity, name: name, action: action, id: id})
                                .done(function (respond) {
                                    $('#myModal').modal('hide');
                                    drawTableSave('save');
                                })
                                .fail(function (jqxhr, textStatus, error) {
                                    alert("Something wrong.Please try again or refresh this page.");
                                });
                    }
                    function removeSave(id) {
                        if (confirm("Are you sure to remove this save?")) {
                            $.getJSON("<%= F.asset("/save")%>", {action: "remove", id: id})
                                    .done(function (respond) {
                                        drawTableSave('save');
                                    })
                                    .fail(function (jqxhr, textStatus, error) {
                                        alert("Something wrong.Please try again or refresh this page.");
                                    });
                        }

                    }
                    function drawTableSave(action) {
                        $('.row-save').remove();
                        $('.table-save').append('<tr class="loading" style="text-align: center;"><td colspan="5">Loading</td></tr>');
                        $.getJSON("<%= F.asset("/save")%>", {project: ${product.id}, action: "view"})
                                .done(function (respond) {
                                    $('.loading').remove();
                                    if (respond.status) {
                                        $.each(respond.data, function (index, obj) {
                                            $('.table-save').append(
                                                    '<tr class="row-save">'
                                                    + '<td><a href="#" data-geo="" img="' + obj.bg + '">Saved Image</a></td>'
                                                    + '<td>' + obj.name + '</td>'
                                                    + '<td id="memo' + obj.save_id + '">' + obj.memo + '</td>'
                                                    + '<td>' + obj.created_at + '</td>'
                                                    + '<td>'
                                                    + '<button class="btn btn-orange btn-sm btn-loadsave" type="button" onclick="loadGame(' + obj.scene + ',' + obj.order + ',\'' + obj.bg + '\',\'' + obj.music + '\',\'' + obj.name + '\');">Load</button>'
                                                    + '<button class="btn btn-green btn-sm btn-newsave" type="button" onclick="saveMemo(\'#memo' + obj.save_id + '\',' + obj.save_id + ');" data-toggle="modal" data-target="#myModal">Save</button>'
                                                    + '<button class="btn btn-grey btn-sm btn-removesave" type="button" onclick="removeSave(' + obj.save_id + ')">Remove</button>'
                                                    + '</td>'
                                                    + '</tr>');
                                        });
                                    }
                                    else {
                                        $('.table-save').append('<tr class="loading" style="text-align: center;"><td colspan="5">No Saved data</td></tr>');
                                    }
                                    if (action === 'load') {
                                        $('.btn-newsave').addClass("hidden");
                                        $('.btn-loadsave').removeClass("hidden");
                                    }
                                    else {
                                        $('.btn-loadsave').addClass("hidden");
                                        $('.btn-newsave').removeClass("hidden");
                                    }
                                })
                                .fail(function (jqxhr, textStatus, error) {
                                    alert("Something wrong.Please try again or refresh this page.");
                                });
                    }
                    function loadGame(sceneID, order, bg, music, name) {
                        $('.name').html(name);
                        if (order > 0) {
                            order = order - 1;
                        }
                        getScene(sceneID, order);
                        $('#player').animate({
                            opacity: 0.5
                        }, 'fast', function () {
                            $(this)
                                    .css({
                                        'background-image': 'url(' + bg + ')'
                                    })
                                    .animate({
                                        opacity: 1
                                    });
                        });
                        playSound("player_music", music);
                        showPlayer();
                        $('.btn-menu').removeClass("hidden");
                    }

                    $(".btn-menu").hover(
                            function () {
                                $(this).outerWidth('120%');
                            }, function () {
                        $(this).outerWidth('100%');
                    }
                    );
</script>
<script>
    $(function () {
        $(document).tooltip({
            items: "[data-geo]",
            content: function () {
                var element = $(this);
                if (element.is("[data-geo]")) {
                    var img = element.attr('img');
                    //alert(text);
                    return "<img style='max-width:250px' alt='" + img +
                            "' src='" + img + "' >";
                }
            }
        });
    });
</script>
<jsp:include page="footer.jsp" />