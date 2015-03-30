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
    $("#"+element).attr("src", soundfile);
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
        $("#player_title_text").hide().html(data[actity_id].title).fadeIn('slow');
        $("#typed").typed('reset');
        $("#typed").typed({
            strings: [data[actity_id].text],
            typeSpeed: 0,
            backDelay: 500,
            loop: false,
            contentType: 'html', // or text
            // defaults to false for infinite loop
            loopCount: false,
            callback: function(){ $("#btn_toggle_dialog").show(); },
        });
        
        playSound("dubsound", data[actity_id].sound);
        
        if(current_order < order.length){
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
        if(current_order < order.length){
            play();
        }
    }
    else if (data[actity_id].type == 4) {
        $('#player_choice_area').hide();
        $("#btn-play").show();
        $("#btn_toggle_dialog").show();
        alert("Go to Scene "+data[actity_id].nextnode);
        getScene(data[actity_id].nextnode);
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
                'background-image': 'url('+data[actity_id].url+')'
            })
                .animate({
                opacity: 1
            });
        });
        if(current_order < order.length){
            $(".play_index").html(current_order + 1);
            blinking($("#btn-play"));
        }
    } 
    else if (data[actity_id].type == 6) {
        $('#player_choice_area').hide();
        $("#btn-play").show();
        $("#btn_toggle_dialog").show();
        playSound("player_music", data[actity_id].url);
        if(current_order < order.length){
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
    if (data[actity_id].choice[index].action == 1) {
        $(".play_index").html(data[actity_id].choice[index].nextnode);
        play();
    }
    else {
        alert("Go to Scene " + data[actity_id].choice[index].nextnode);
    }

}
function previewActivity(index){
    $(".play_index").html(index);
    play();
}


function clearBlink(elm){
    clearInterval(timer);
    elm.css('opacity',1);
    elm.removeClass("btn-warning").addClass("btn-default");
    
}


function blinking(elm) {
    timer = setInterval(blink, 10);
    elm.removeClass("btn-default").addClass("btn-warning");
    function blink() {
        elm.fadeOut(400, function() {
           elm.fadeIn(400);
        });
    }
}
var timer;