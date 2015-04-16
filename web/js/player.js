function toggleDialog() {
    clearBlink($('#btn-play'));
    if ($("#btn_toggle_dialog").html().search("Hide") != -1) {
        hideDialog();
    }
    else {
        showDialog();
    }

    blinking($('#btn-play'));
}

function hideDialog() {
    if ($("#btn_toggle_dialog").html().search("Show") == -1) {
        $('.player_show').html($('.player_show').html().replace("Hide", "Show").replace("down", "up"));
        $('.player_show').removeClass('player_show').addClass('player_hide');
    }
}

function showDialog() {
    if ($("#btn_toggle_dialog").html().search("Hide") == -1) {
        $('.player_hide').html($('.player_hide').html().replace("Show", "Hide").replace("up", "down"));
        $('.player_hide').removeClass('player_hide').addClass('player_show');
    }
}

function playSound(element, soundfile) {
    var sound = document.getElementById(element);
    $("#" + element).attr("src", soundfile);
    sound.play();
}

function play() {
    var current_order = parseInt($(".play_index").html());
    var order = JSON.parse($(".activity_order").html());
    var actity_id = order[current_order];
    var data = JSON.parse($(".activity_data").html());
    clearBlink($("#btn-play"));
    $("#btn-play").removeClass("btn-warning").addClass("btn-default");
    if (data[actity_id].type == 1) {
        showDialog();
        $('#player_choice_area').hide();
        $("#btn-play").show();
        $("#btn_toggle_dialog").hide();
        $("#player_title_text").hide().html(data[actity_id].title.replace("MC_NAME", $('.name').html())).fadeIn('slow');
        var text = data[actity_id].text.replace("MC_NAME", $('.name').html());
        $("#typed").typed('reset');
        $("#typed").typed({
            strings: [text],
            typeSpeed: 0,
            backDelay: 500,
            loop: false,
            contentType: 'html', // or text
            // defaults to false for infinite loop
            loopCount: false,
            callback: function () {
                $("#btn_toggle_dialog").show();
            },
        });

        playSound("dubsound", data[actity_id].sound);

        if (current_order < order.length) {
            $(".play_index").html(current_order + 1);
        }

    }
    else if (data[actity_id].type == 2) {
        $("#typed").typed('reset');
        hideDialog();
        $("#btn-play").hide();
        $("#btn_toggle_dialog").hide();
        $('#player_choice').html('');
        for (var c = 0; c < data[actity_id].choice.length; c++) {
            $('#player_choice').append('<button type="button" class="btn btn-lg btn-default btn-block" onclick="choiceClick(' + c + ');">' + data[actity_id].choice[c].text + '</button>')
        }
        $('#player_choice_area').css('display', 'table').hide().fadeIn();


    }
    else if (data[actity_id].type == 3) {
        $('#player_choice_area').hide();
        $("#btn-play").show();
        $("#btn_toggle_dialog").show();
        $(".play_index").html(data[actity_id].nextnode);
        if (current_order < order.length) {
            play();
        }
    }
    else if (data[actity_id].type == 4) {
        $('#player_choice_area').hide();
        $("#btn-play").show();
        $("#btn_toggle_dialog").show();
        if ($(".mode").html() === 'edit') {
            alert("Go to Scene " + data[actity_id].nextnode);
        } else {
            getScene(data[actity_id].nextnode, 0);
        }
    }
    else if (data[actity_id].type == 5) {
        $('#player_choice_area').hide();
        $("#btn-play").show();
        $("#btn_toggle_dialog").show();
        $('#player').animate({
            opacity: 0.5
        }, 'fast', function () {
            $(this)
                    .css({
                        'background-image': 'url(' + data[actity_id].url + ')'
                    })
                    .animate({
                        opacity: 1
                    });
        });
        if (current_order < order.length) {
            $(".play_index").html(current_order + 1);
            blinking($("#btn-play"));
        }
    }
    else if (data[actity_id].type == 6) {
        $('#player_choice_area').hide();
        $("#btn-play").show();
        $("#btn_toggle_dialog").show();
        playSound("player_music", data[actity_id].url);
        if (current_order < order.length) {
            $(".play_index").html(current_order + 1);
            blinking($("#btn-play"));
        }
    }

}

function choiceClick(index) {
    var current_order = parseInt($(".play_index").html());
    var order = JSON.parse($(".activity_order").html());
    var actity_id = order[current_order];
    var data = JSON.parse($(".activity_data").html());
    $('#player_choice_area').hide();
    //if (data[actity_id].choice[index].action == 1) {
    $(".play_index").html(data[actity_id].choice[index].nextnode);
    play();
    //}
    //else {
    //    alert("Go to Scene " + data[actity_id].choice[index].nextnode);
    //}

}
function previewActivity(index) {
    $(".play_index").html(index);
    play();
}


function clearBlink(elm) {
    clearInterval(timer);
    elm.css('opacity', 1);
    elm.removeClass("btn-warning").addClass("btn-default");

}


function blinking(elm) {
    timer = setInterval(blink, 10);
    elm.removeClass("btn-default").addClass("btn-warning");
    function blink() {
        elm.fadeOut(400, function () {
            elm.fadeIn(400);
        });
    }
}
function getScene(sceneID, index) {
    if ($('.mode').html() == 'edit') {
        $('.activity_bar').html("Loading...");
    }
    $.getJSON("/fine/scene/" + sceneID + "/activity")
            .done(function (data) {
                if ($('.mode').html() == 'edit') {
                    $('#player').animate({
                        opacity: 0.5
                    }, 'fast', function () {
                        $(this)
                                .css({
                                    'background-image': 'url(https://placehold.it/1280x720/E3E3E3/ffffff&text=FiNE)'
                                })
                                .animate({
                                    opacity: 1
                                });
                    });
                }
                if (data.data.indexOf("{") !== -1 ) {
                    $('.activity_data').html(data.data);
                    $('.activity_order').html(data.order);
                    $("#typed").typed('reset');
                    $("#player_title_text").html('');
                    if($.trim(data.data) != '{}'){
                        previewActivity(index);
                    }
                }
                else {
                    //no next scene
                    alert(data.data);
                }
                if ($('.mode').html() == 'edit') {
                    $('#saveActBtn').attr("onclick", "saveActivity(" + sceneID + ");");
                    draw_activityBar();
                    $('.scene-row').removeClass('bs-callout-warning').addClass("bs-callout-default");
                    $('#heading' + sceneID).parent().removeClass('bs-callout-default').addClass("bs-callout-warning");
                    $('#saveActBtn').addClass("hidden");
                    $('.activity_newID').html('[]');
                }
            })
            .fail(function (jqxhr, textStatus, error) {
                alert("Something wrong.Please try again or refresh this page.");
            });
}
var timer;
$('.player_wrapper').height(($('.player_wrapper').width() * 9 / 16));