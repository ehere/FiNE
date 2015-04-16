function  draw_activityBar() {
    $(".activity_bar").text('');
    if($(".activity_data").html().trim() == '{}'){
        $(".activity_bar").html("This scene doesn't have any activity.<br>You can insert new activity.");
    }
    $('#newActBtn').removeClass("hidden");
    var data = JSON.parse($(".activity_data").html());
    var order = JSON.parse($(".activity_order").html());
    for (var index = 0; index < order.length; index++) {
        var activityID = order[index];
        var title;
        var classColor;
        var body = "";
        var expand = "";
        if (data[order[index]].type == 1) {
            title = data[order[index]].title;
            expand = "in";
            if (title.trim() == '') {
                title = "No Title";
            }
            classColor = "bs-callout-info";
            body = data[order[index]].text;
        }
        else if (data[order[index]].type == 2) {
            title = "Choice";
            classColor = "bs-callout-default";
            expand = "in";
            var alphabet = 'ABCDEFGHIGKLMNOPQRSTUVWXYZ'
            for (var c = 0; c < data[order[index]].choice.length; c++) {
                body = body +
                        '<div class="bs-callout bs-callout-success" id="choice_' + order[index] + '">' +
                        alphabet[c] + '.' + data[order[index]].choice[c].text + ' => Activity ' + (parseInt(data[order[index]].choice[c].nextnode) + 1) + '</div>';
            }
        }
        else if (data[order[index]].type == 3) {
            title = "Go to Activity " + (parseInt(data[order[index]].nextnode) + 1);
            classColor = "bs-callout-success";
        }
        else if (data[order[index]].type == 4) {
            title = "Go to Scene " + (data[order[index]].nextnode);
            classColor = "bs-callout-danger";
        }
        else if (data[order[index]].type == 5) {
            title = "Change Background";
            classColor = "bs-callout-warning";
            body = '<br><img src="' + data[order[index]].url + '" style="max-width:350px;max-height:350px;" />';
        }
        else if (data[order[index]].type == 6) {
            title = "Change Music";
            classColor = "bs-callout-warning";
        }
        var button =
                '<div class="btn-group pull-right"> ' +
                '<button type="button" class="btn btn-sm btn-default btn-moveup" onclick="moveActivityUp(' + order[index] + ',' + index + ');">' +
                '<span class="glyphicon glyphicon-arrow-up"></span>' +
                '</button>' +
                '<button type="button" class="btn btn-sm btn-default"  onclick="moveActivityDown(' + order[index] + ',' + index + ');">' +
                '<span class="glyphicon glyphicon-arrow-down"></span>' +
                '</button>' +
                '<button type="button" onclick="previewActivity(' + index + ');" class="btn btn-sm btn-default">' +
                '<span class="glyphicon glyphicon-play"></span>' +
                '</button>' +
                '<button type="button" onclick="editActivity(' + index + ');" class="btn btn-sm btn-default">' +
                '<span class="glyphicon glyphicon-edit"></span>' +
                '</button>' +
                '<button type="button" onclick="removeActivity(' + index + ');" class="btn btn-sm btn-default">' +
                '<span class="glyphicon glyphicon-remove"></span>' +
                '</div>';
        var row =
                '<div class="panel panel-default bs-callout ' + classColor + '">' +
                '<div class="" role="tab" id="actHeading' + activityID + '">' +
                '<h4 class="panel-title">' +
                '<a class="truncate" data-toggle="collapse" data-parent="#scene-list" href="#actCollapse' + activityID + '" aria-expanded="true" aria-controls="actCollapse' + activityID + '">' +
                (index + 1) + ': ' + title +
                '</a>' + button +
                '</h4>' +
                '</div>' +
                '<div id="actCollapse' + activityID + '" class="panel-collapse collapse ' + expand + '" role="tabpanel" aria-labelledby="actHeading' + activityID + '">' +
                '<div class="panel-body" style="padding-top: 0px;" id="actity_' + activityID + '">' + body + '</div>' +
                '</div>' +
                '</div>';
        $(".activity_bar").append(row);
    }
}

function moveActivityUp(actity_id, index) {
    $('#saveActBtn').removeClass("hidden");
    var order = JSON.parse($(".activity_order").html());
    if (index != 0) {
        var temp = order[index];
        order[index] = order[index - 1];
        order[index - 1] = temp;
        $(".activity_order").html(JSON.stringify(order));
        draw_activityBar();
    }
}

function moveActivityDown(actity_id, index) {
    $('#saveActBtn').removeClass("hidden");
    var order = JSON.parse($(".activity_order").html());
    if (index != order.length - 1) {
        var temp = order[index];
        order[index] = order[index + 1];
        order[index + 1] = temp;
        $(".activity_order").html(JSON.stringify(order));
        draw_activityBar();
    }
}

function newDialogActivity(actity_id, index) {
    $('#saveActBtn').removeClass("hidden");
    var newActivity = JSON.parse($(".activity_newID").html());
    if (newActivity.length == 0) {
        newActivityID = -1;
    }
    else {
        newActivityID = newActivity[newActivity.length - 1] - 1;
    }
    newActivity.push(newActivityID);
    $(".activity_newID").html(JSON.stringify(newActivity));

    var titleDialog = $("#titleDialog").val();
    var textDialog = $("#textDialog").val();
    var soundDialog = $("#soundDialog").val();

    var order = JSON.parse($(".activity_order").html());
    order.push(newActivityID);
    $(".activity_order").html(JSON.stringify(order));

    var data = JSON.parse($(".activity_data").html());
    data[newActivityID] = {"type": 1, "title": titleDialog, "text": textDialog, "sound": soundDialog};
    $(".activity_data").html(JSON.stringify(data));

    $("#titleDialog").val("");
    $("#textDialog").val("");
    $("#soundDialog").val("");

    $('.activity-modal').modal('hide');

    draw_activityBar();

}

function newChoiceActivity(actity_id, index) {
    $('#saveActBtn').removeClass("hidden");
    /*
     "13":{"type":2, "choice":[
     {"text":"A.Yes","action":1,"nextnode":21},
     {"text":"B.No","action":2,"nextnode":3}
     ]}, 
     */


    var newActivity = JSON.parse($(".activity_newID").html());
    if (newActivity.length == 0) {
        newActivityID = -1;
    }
    else {
        newActivityID = newActivity[newActivity.length - 1] - 1;
    }
    newActivity.push(newActivityID);
    $(".activity_newID").html(JSON.stringify(newActivity));

    var text;
    var action;
    var nextnode;
    var choices = new Array();
    $('.choiceInput').each(function () {
        text = $(this).find(".choiceText").val();
        action = $(this).find(".nodetype").val();
        nextnode = $(this).find(".goid").val();
        nextnode = parseInt(nextnode, 10) - 1;
        choices.push({"text": text, "action": action, "nextnode": nextnode});
        //alert(nextnode);
        $(this).find(".choiceText").val("");
        $(this).find(".nodetype").val("1");
        $(this).find(".goid").val("");
        index = index + 1;
    });

    var order = JSON.parse($(".activity_order").html());
    order.push(newActivityID);
    $(".activity_order").html(JSON.stringify(order));

    var data = JSON.parse($(".activity_data").html());
    data[newActivityID] = {"type": 2, "choice": choices};
    $(".activity_data").html(JSON.stringify(data));

    $('.activity-modal').modal('hide');

    draw_activityBar();



}


function newGoToActivity(actity_id, index) {
    $('#saveActBtn').removeClass("hidden");
    /*
     "15":{"type":3, "nextnode":"17"},
     "16":{"type":4, "nextnode":"21"}, 
     */
    var newActivity = JSON.parse($(".activity_newID").html());
    if (newActivity.length == 0) {
        newActivityID = -1;
    }
    else {
        newActivityID = newActivity[newActivity.length - 1] - 1;
    }
    newActivity.push(newActivityID);
    $(".activity_newID").html(JSON.stringify(newActivity));

    var nextnode = -1;
    if ($("#nodetype").val() == 1) {
        var type = 3;
        nextnode = (parseInt($("#nextnode").val()) - 1);
    }
    else {
        var type = 4;
        nextnode = $("#nextnode").val();
    }


    var order = JSON.parse($(".activity_order").html());
    order.push(newActivityID);
    $(".activity_order").html(JSON.stringify(order));

    var data = JSON.parse($(".activity_data").html());
    data[newActivityID] = {"type": type, "nextnode": nextnode};
    $(".activity_data").html(JSON.stringify(data));

    $("#nodetype").val("1");
    $("#nextnode").val("");

    $('.activity-modal').modal('hide');

    draw_activityBar();

}

function newChangeBgActivity(actity_id, index) {
    $('#saveActBtn').removeClass("hidden");
    /*
     "17":{"type":5, "url":"http://aaa.com"} 
     */
    var newActivity = JSON.parse($(".activity_newID").html());
    if (newActivity.length == 0) {
        newActivityID = -1;
    }
    else {
        newActivityID = newActivity[newActivity.length - 1] - 1;
    }
    newActivity.push(newActivityID);
    $(".activity_newID").html(JSON.stringify(newActivity));

    var type = 5
    var url = $("#bgurl").val();

    var order = JSON.parse($(".activity_order").html());
    order.push(newActivityID);
    $(".activity_order").html(JSON.stringify(order));

    var data = JSON.parse($(".activity_data").html());
    data[newActivityID] = {"type": type, "url": url};
    $(".activity_data").html(JSON.stringify(data));

    $("#bgurl").val("");

    $('.activity-modal').modal('hide');

    draw_activityBar();

}

function newChangeMusicActivity(actity_id, index) {
    $('#saveActBtn').removeClass("hidden");
    /*
     "14":{"type":6, "url":"http://aaa.com"}, 
     */
    var newActivity = JSON.parse($(".activity_newID").html());
    if (newActivity.length == 0) {
        newActivityID = -1;
    }
    else {
        newActivityID = newActivity[newActivity.length - 1] - 1;
    }
    newActivity.push(newActivityID);
    $(".activity_newID").html(JSON.stringify(newActivity));

    var type = 6
    var url = $("#musicurl").val();

    var order = JSON.parse($(".activity_order").html());
    order.push(newActivityID);
    $(".activity_order").html(JSON.stringify(order));

    var data = JSON.parse($(".activity_data").html());
    data[newActivityID] = {"type": type, "url": url};
    $(".activity_data").html(JSON.stringify(data));

    $("#musicurl").val("");

    $('.activity-modal').modal('hide');

    draw_activityBar();

}


function appendChoice() {

    var count = $('.choice').length;
    var text = ["A", "B", "C", "D"];
    if (count < 4) {
        var choiceScript = '<div class="choiceInput choice' + text[count] + '"> \
                                <div class="input-group"> \
                                    <span class="input-group-addon choice">' + text[count] + '.</span> \
                                    <input class="form-control choiceText choiceText' + text[count] + '" name="choiceText"> \
                                    <div class="input-group" style="width: 100%;"> \
                                        <select name="nodetype[]" class="selecter_basic nodetype hidden"> \
                                            <option value="1">Go to Activity</option> \
                                        </select> \
                                        <span class="input-group-addon">Goto activity</span> \
                                        <input type="number" class="form-control goid goid' + text[count] + '" name="goid[]" placeholder="Activity or Scene ID" min="0"> \
                                        <span class="input-group-btn"> \
                                            <button type="button" class="btn btn-danger pull-right removebtn" tabindex="-1" onclick="removeChoice(\'' + text[count] + '\');">Remove</button> \
                                        </span> \
                                    </div> \
                                </div> \
                                <br> \
                            </div> \
                            ';

        $("#choiceArea").append(choiceScript);
        //$("select").selecter();
    }
    else {
        alert("Limit exceed!");
    }


}

function removeChoice(choice) {
    //do it yourself plzzzz
    $(".choice" + choice).remove();
    var text = ["A.", "B.", "C.", "D."];
    var index = 0;
    $(".choice").each(function () {
        $(this).html(text[index]);
        index = index + 1;
    });
    var text = ["A", "B", "C", "D"];
    var index = 0;
    $(".removebtn").each(function () {
        $(this).attr("onclick", "removeChoice('" + text[index] + "');");
        index = index + 1;
    });

    var text = ["A", "B", "C", "D"];
    var index = 0;
    $(".choiceInput").each(function () {
        $(this).attr("class", "choiceInput choice" + text[index]);
        index = index + 1;
    });
    index = 0;
    $(".choiceText").each(function () {
        $(this).attr("class", "form-control choiceText choiceText" + text[index]);
        index = index + 1;
    });
    index = 0;
    $(".goid").each(function () {
        $(this).attr("class", "form-control goid goid" + text[index]);
        index = index + 1;
    });
}

function removeActivity(index) {
    if (confirm("Are you sure to remove this activity.")) {
        $('#saveActBtn').removeClass("hidden");
        var order = JSON.parse($(".activity_order").html());
        var actity_id = order[index];
        var activityData = JSON.parse($(".activity_data").html());
        if (activityData.hasOwnProperty(actity_id)) {
            delete activityData[actity_id];
            $(".activity_data").html(JSON.stringify(activityData));
        }
        var activityOrder = JSON.parse($(".activity_order").html());
        if (activityOrder.indexOf(actity_id) >= 0) {
            activityOrder.splice(index, 1);
            //alert("Changed" + activityOrder.toString());
            $(".activity_order").html(JSON.stringify(activityOrder));
        }
        var activityNew = JSON.parse($(".activity_newID").html());
        if (activityNew.indexOf(actity_id) >= 0) {
            activityNew.splice(activityNew.indexOf(actity_id), 1);
            $(".activity_newID").html(JSON.stringify(activityNew));
        }
        $('#dubsound').attr("src","");
        $('#player_music').attr("src","");
        draw_activityBar();
        previewActivity(index);
    }

}

function editActivity(index) {
    var data = JSON.parse($(".activity_data").html());
    var order = JSON.parse($(".activity_order").html());

    if (data[order[index]].type == 1) {
        //Dialog
        changeSaveBtnToEdit("Dialog", index);
        editDialog(index);
    }
    else if (data[order[index]].type == 2) {
        //Choice
        changeSaveBtnToEdit("Choice", index);
        editChoice(index);
    }
    else if (data[order[index]].type == 3) {
        //Go to act
        changeSaveBtnToEdit("GoTo", index);
        $('#nodetype').val("1");
        $("#nodetype").selecter("destroy");
        $("#nodetype").selecter();
        editGoto(index, "act");
    }
    else if (data[order[index]].type == 4) {
        //Go to scene
        changeSaveBtnToEdit("GoTo", index);
        $('#nodetype').val("2");
        $("#nodetype").selecter("destroy");
        $("#nodetype").selecter();
        editGoto(index, "scene");
    }
    else if (data[order[index]].type == 5) {
        //Change BG img
        changeSaveBtnToEdit("ChangeBg", index);
        editBackground(index);
    }
    else if (data[order[index]].type == 6) {
        //Change music
        changeSaveBtnToEdit("ChangeMusic", index);
        editMusic(index);
    }

}

function editDialog(index) {
    var data = JSON.parse($(".activity_data").html());
    var order = JSON.parse($(".activity_order").html());
    var toEdit = data[order[index]];
    $('.activity-modal').modal('show');
    $('#activityTab a[href="#dialog"]').tab('show');
    $('#titleDialog').val(toEdit.title);
    $('#textDialog').val(toEdit.text);
    $('#soundDialog').val(toEdit.sound);

}

function editChoice(index) {
    var data = JSON.parse($(".activity_data").html());
    var order = JSON.parse($(".activity_order").html());
    var toEdit = data[order[index]];
    $('.activity-modal').modal('show');
    $('#activityTab a[href="#choice"]').tab('show');
    var text = ["A", "B", "C", "D"];
    for (var i = 0; i < 4; i++) {
        removeChoice('A');
    }
    for (var i = 0; i < toEdit.choice.length; i++) {
        appendChoice();
    }
    var x = 0;
    $.each(toEdit.choice, function (i, item) {
        var selector = '.choiceText' + text[x];
        $(selector).val(item.text);
        selector = '.goid' + text[x];
        $(selector).val(parseInt(item.nextnode) + 1);
        x = x + 1;
    });
}

function editGoto(index, type) {
    var data = JSON.parse($(".activity_data").html());
    var order = JSON.parse($(".activity_order").html());
    var toEdit = data[order[index]];
    $('.activity-modal').modal('show');
    $('#activityTab a[href="#goto"]').tab('show');
    if (type == "act") {
        $('#nodetype').val("1");
        $('#nextnode').val(parseInt(toEdit.nextnode) + 1);
    }
    else if (type == "scene") {
        $('#nodetype').val("2");
        $('#nextnode').val(toEdit.nextnode);
    }
}

function editBackground(index) {
    var data = JSON.parse($(".activity_data").html());
    var order = JSON.parse($(".activity_order").html());
    var toEdit = data[order[index]];
    $('.activity-modal').modal('show');
    $('#activityTab a[href="#background"]').tab('show');
    $('#bgurl').val(toEdit.url);
    $('#bgImg').attr("src",toEdit.url);
}

function editMusic(index) {
    var data = JSON.parse($(".activity_data").html());
    var order = JSON.parse($(".activity_order").html());
    var toEdit = data[order[index]];
    $('.activity-modal').modal('show');
    $('#activityTab a[href="#music"]').tab('show');
    $('#musicurl').val(toEdit.url);
    $('#pre_player_music').attr("src", toEdit.url);
}

function clearInput() {
    $('.activity-modal, input').val('');
    $('.activity-modal, textarea').val('');
}

function changeSaveBtnToNew() {
    $('.btn-newDialog').attr("onclick", "newDialogActivity();");
    $('.btn-newChoice').attr("onclick", "newChoiceActivity();");
    $('.btn-newGoTo').attr("onclick", "newGoToActivity();");
    $('.btn-newChangeBg').attr("onclick", "newChangeBgActivity();");
    $('.btn-newChangeMusic').attr("onclick", "newChangeMusicActivity();");
    $('#bgImg').attr("src","");
    $('#pre_player_music').attr("src","");
    $('#pre_dubsound').attr("src","");
}

function changeSaveBtnToEdit(button, idx) {
    $('.btn-new' + button + '').attr("onclick", "edit" + button + "Activity(" + idx + ");");
}

function editDialogActivity(index) {
    $('#saveActBtn').removeClass("hidden");
    var order = JSON.parse($(".activity_order").html());

    var titleDialog = $("#titleDialog").val();
    var textDialog = $("#textDialog").val();
    var soundDialog = $("#soundDialog").val();

    var data = JSON.parse($(".activity_data").html());
    data["" + order[index]] = {"type": 1, "title": titleDialog, "text": textDialog, "sound": soundDialog};
    $(".activity_data").html(JSON.stringify(data));

    $("#titleDialog").val("");
    $("#textDialog").val("");
    $("#soundDialog").val("");

    $('.activity-modal').modal('hide');

    draw_activityBar();
    previewActivity(index);
}

function editChoiceActivity(index) {
    $('#saveActBtn').removeClass("hidden");
    var text;
    var action;
    var nextnode;
    var choices = new Array();
    $('.choiceInput').each(function () {
        text = $(this).find(".choiceText").val();
        action = $(this).find(".nodetype").val();
        nextnode = $(this).find(".goid").val();
        nextnode = parseInt(nextnode, 10) - 1;
        choices.push({"text": text, "action": action, "nextnode": nextnode});
        //alert(nextnode);
        $(this).find(".choiceText").val("");
        $(this).find(".nodetype").val("1");
        $(this).find(".goid").val("");
    });

    var order = JSON.parse($(".activity_order").html());

    var data = JSON.parse($(".activity_data").html());
    data["" + order[index]] = {"type": 2, "choice": choices};
    $(".activity_data").html(JSON.stringify(data));

    $('.activity-modal').modal('hide');

    draw_activityBar();
    previewActivity(index);
}

function editGoToActivity(index) {
    $('#saveActBtn').removeClass("hidden");
    /*
     "15":{"type":3, "nextnode":"17"},
     "16":{"type":4, "nextnode":"21"}, 
     */
    var nextnode = -1;
    if ($("#nodetype").val() == 1) {
        var type = 3;
        nextnode = (parseInt($("#nextnode").val()) - 1);
    }
    else {
        var type = 4;
        nextnode = $("#nextnode").val();
    }

    var order = JSON.parse($(".activity_order").html());

    var data = JSON.parse($(".activity_data").html());
    data[order[index]] = {"type": type, "nextnode": nextnode};
    $(".activity_data").html(JSON.stringify(data));

    $("#nodetype").val("1");
    $("#nextnode").val("");

    $('.activity-modal').modal('hide');

    draw_activityBar();
    previewActivity(index);
}

function editChangeBgActivity(index) {
    $('#saveActBtn').removeClass("hidden");
    /*
     "17":{"type":5, "url":"http://aaa.com"} 
     */
    var type = 5
    var url = $("#bgurl").val();

    var order = JSON.parse($(".activity_order").html());

    var data = JSON.parse($(".activity_data").html());
    data[order[index]] = {"type": type, "url": url};
    $(".activity_data").html(JSON.stringify(data));

    $("#bgurl").val("");

    $('.activity-modal').modal('hide');

    draw_activityBar();
    previewActivity(index);
}

function editChangeMusicActivity(index) {
    $('#saveActBtn').removeClass("hidden");
    /*
     "14":{"type":6, "url":"http://aaa.com"}, 
     */
    var type = 6
    var url = $("#musicurl").val();

    var order = JSON.parse($(".activity_order").html());

    var data = JSON.parse($(".activity_data").html());
    data[order[index]] = {"type": type, "url": url};
    $(".activity_data").html(JSON.stringify(data));

    $("#musicurl").val("");

    $('.activity-modal').modal('hide');

    draw_activityBar();
    previewActivity(index);
}
function saveActivity(sceneID) {
    if (confirm("Are you sure?\nYou can't undo anything after save!")) {
        $(".activity_bar").text('Saving...');
        var data = $('.activity_data').html();
        var order = $('.activity_order').html();
        $.post("/fine/author/scene/"+sceneID+"/saveactivity", {data: data, order: order})
                .done(function (data) {
                    alert(data);
                    if(data == "Save Success.")
                    {
                        getScene(sceneID,0);
                    }
                });
    }
}
//draw_activityBar();
$("#nodetype").selecter();