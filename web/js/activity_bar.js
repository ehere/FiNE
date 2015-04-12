function  draw_activityBar(){
    $( ".activity_bar").text('');
    var data = JSON.parse( $(".activity_data").html());
    var order = JSON.parse( $(".activity_order").html());
    for (var index = 0; index < order.length; index++) {      
        var activityID = order[index];
        var title;
        var classColor;
        var body = "";
        var expand = "";
        if(data[order[index]].type == 1){
            title = data[order[index]].title;
            if(title.trim() == ''){
                title = "No Title";
            }
            classColor = "bs-callout-info";
            body = data[order[index]].text;
        }
        else if(data[order[index]].type == 2){
            title = "Choice";
            classColor = "bs-callout-default";
            expand = "in";
            var alphabet = 'ABCDEFGHIGKLMNOPQRSTUVWXYZ'
            for (var c = 0; c < data[order[index]].choice.length; c++) {
                body = body+
                    '<div class="bs-callout bs-callout-success" id="choice_'+order[index]+'">'+
                    alphabet[c]+'.'+data[order[index]].choice[c].text+' => Activity '+(parseInt(data[order[index]].choice[c].nextnode)+1)+'</div>' ;  
            }
        }
        else if(data[order[index]].type == 3){
            title = "Go to Activity "+(parseInt(data[order[index]].nextnode)+1);
            classColor = "bs-callout-success";            
        }
        else if(data[order[index]].type == 4){
            title = "Go to Scene "+(data[order[index]].nextnode);
            classColor = "bs-callout-danger";             
        }
        else if(data[order[index]].type == 5){
            title = "Change Background";
            classColor = "bs-callout-warning";
            body = '<br><img src="'+ data[order[index]].url +'" style="max-width:350px;max-height:350px;" />';
        }
        else if(data[order[index]].type == 6){
            title = "Change Music";
            classColor = "bs-callout-warning";            
        }
        var button = 
            '<div class="btn-group pull-right"> '+
                '<button type="button" class="btn btn-sm btn-default btn-moveup" onclick="moveActivityUp('+order[index]+','+index+');">'+
                    '<span class="glyphicon glyphicon-arrow-up"></span>' +
                '</button>'+
                '<button type="button" class="btn btn-sm btn-default"  onclick="moveActivityDown('+order[index]+','+index+');">'+
                    '<span class="glyphicon glyphicon-arrow-down"></span>' +
                '</button>' +
                '<button type="button" onclick="previewActivity('+index+');" class="btn btn-sm btn-default">' +
                    '<span class="glyphicon glyphicon-play"></span>' +
                '</button>' +
                '<button type="button" class="btn btn-sm btn-default dropdown-toggle" data-toggle="dropdown">' +
                    '<span class="glyphicon glyphicon-cog"></span> <span class="sr-only">Toggle Dropdown</span>' +
                '</button>' +
                '<ul class="dropdown-menu" role="menu">' +
                    '<li><a href="#">Action</a></li>' +
                    '<li><a href="#">Another action</a></li>' +
                    '<li><a href="#">Something else here</a></li>' +
                    '<li class="divider"></li><li><a href="#">Separated link</a></li>' +
                '</ul>' +
            '</div>';
        var row =                 
                '<div class="panel panel-default bs-callout '+classColor+'">'+
                    '<div class="" role="tab" id="actHeading'+activityID+'">'+
                        '<h4 class="panel-title">'+
                            '<a class="truncate" data-toggle="collapse" data-parent="#scene-list" href="#actCollapse'+activityID+'" aria-expanded="true" aria-controls="actCollapse'+activityID+'">'+
                                (index+1) + ': '+title+
                            '</a>'+button+
                        '</h4>'+
                    '</div>'+
                    '<div id="actCollapse'+activityID+'" class="panel-collapse collapse '+expand+'" role="tabpanel" aria-labelledby="actHeading'+activityID+'">'+
                        '<div class="panel-body" style="padding-top: 0px;" id="actity_'+activityID+'">'+body+'</div>'+
                    '</div>'+
                '</div>';
        $(".activity_bar").append(row);
    }
}
function draw_activityBar1() {
    $( ".activity_bar").text('');
    var data = JSON.parse( $(".activity_data").html());
    var order = JSON.parse( $(".activity_order").html());
    for (var index = 0; index < order.length; index++) {
        if(data[order[index]].type == 1){
            $( ".activity_bar" ).append( 
                '<div class="bs-callout bs-callout-info" id="actity_'+order[index]+'">'+
                (index+1)+'.'+(data[order[index]].title)+'</div>' 
            );
        }
        else if(data[order[index]].type == 2){
            $( ".activity_bar" ).append( 
                '<div class="bs-callout bs-callout-default" id="actity_'+order[index]+'">'+
                (index+1)+'.Choice</div>' 
            );  
            var alphabet = 'ABCDEFGHIGKLMNOPQRSTUVWXYZ'
            for (var c = 0; c < data[order[index]].choice.length; c++) {
                if(data[order[index]].choice[c].action == 1){
                    $( "#actity_"+order[index] ).append( 
                        '<div class="bs-callout bs-callout-success" id="choice_'+order[index]+'">'+
                        alphabet[c]+'.'+data[order[index]].choice[c].text+' => Activity '+(parseInt(data[order[index]].choice[c].nextnode)+1)+'</div>' 
                    );  
                }
                else if(data[order[index]].choice[c].action == 2){
                    $( "#actity_"+order[index] ).append( 
                        '<div class="bs-callout bs-callout-danger" id="choice_'+order[index]+'">'+
                        alphabet[c]+'.'+data[order[index]].choice[c].text+' => Scene '+(data[order[index]].choice[c].nextnode)+'</div>'
                    );  
                }
            }     
        }
        else if(data[order[index]].type == 3){
            $( ".activity_bar" ).append( 
                '<div class="bs-callout bs-callout-success" id="actity_'+order[index]+'">'+
                (index+1)+'.Go to Activity '+(parseInt(data[order[index]].nextnode)+1)+'</div>' 
            );           
        }
        else if(data[order[index]].type == 4){
            $( ".activity_bar" ).append( 
                '<div class="bs-callout bs-callout-danger" id="actity_'+order[index]+'">'+
                (index+1)+'.Go to Scene '+(data[order[index]].nextnode)+'</div>' 
            );        
        }
        else if(data[order[index]].type == 5){
            $( ".activity_bar" ).append( 
                '<div class="bs-callout bs-callout-warning" id="actity_'+order[index]+'">'+
                (index+1)+'.Change Background</div>' 
            );       
        }
        else if(data[order[index]].type == 6){
            $( ".activity_bar" ).append( 
                '<div class="bs-callout bs-callout-warning" id="actity_'+order[index]+'">'+
                (index+1)+'.Change Music</div>' 
            );            
        }
        
        //add action button
        $( "#actity_"+order[index] ).html( 
            '<div class="btn-group pull-right"> \
                <button type="button" class="btn btn-sm btn-default btn-moveup" onclick="moveActivityUp('+order[index]+','+index+');">  \
                    <span class="glyphicon glyphicon-arrow-up"></span> \
                </button> \
                <button type="button" class="btn btn-sm btn-default"  onclick="moveActivityDown('+order[index]+','+index+');">  \
                    <span class="glyphicon glyphicon-arrow-down"></span> \
                </button> \
                <button type="button" onclick="previewActivity('+index+');" class="btn btn-sm btn-default"> \
                    <span class="glyphicon glyphicon-play"></span> \
                </button> \
                <button type="button" class="btn btn-sm btn-default dropdown-toggle" data-toggle="dropdown"> \
                    <span class="glyphicon glyphicon-cog"></span> <span class="sr-only">Toggle Dropdown</span> \
                </button> \
                <ul class="dropdown-menu" role="menu"> \
                    <li><a href="#">Action</a></li> \
                    <li><a href="#">Another action</a></li> \
                    <li><a href="#">Something else here</a></li> \
                    <li class="divider"></li><li><a href="#">Separated link</a></li> \
                </ul> \
            </div>'
            +$( "#actity_"+order[index] ).html()
        );
    }
}

function moveActivityUp(actity_id, index){
    var order = JSON.parse( $(".activity_order").html());
    if(index != 0){
        var temp = order[index];
        order[index] = order[index-1];
        order[index-1] = temp;
        $(".activity_order").html(JSON.stringify(order));
        draw_activityBar();
    }
}

function moveActivityDown(actity_id, index){
    var order = JSON.parse( $(".activity_order").html());
    if(index != order.length-1){
        var temp = order[index];
        order[index] = order[index+1];
        order[index+1] = temp;
        $(".activity_order").html(JSON.stringify(order));
        draw_activityBar();
    }
}

function newDialogActivity(actity_id, index){
    var newActivity = JSON.parse( $(".activity_newID").html());
    if(newActivity.length == 0){
        newActivityID = -1;
    }
    else{
        newActivityID = newActivity[newActivity.length-1]-1;
    }
    newActivity.push(newActivityID);
    $(".activity_newID").html(JSON.stringify(newActivity));

    var titleDialog = $("#titleDialog").val();
    var textDialog = $("#textDialog").val();
    var soundDialog = $("#soundDialog").val();
    
    var order = JSON.parse( $(".activity_order").html());
    order.push(newActivityID);
    $(".activity_order").html(JSON.stringify(order));
    
    var data = JSON.parse( $(".activity_data").html());
    data[newActivityID] = {"type":1, "title":titleDialog, "text":textDialog, "sound":soundDialog};
    $(".activity_data").html(JSON.stringify(data));
    
    $("#titleDialog").val("");
    $("#textDialog").val("");
    $("#soundDialog").val("");
    
    $('.activity-modal').modal('hide');
    
    draw_activityBar();
    
}

function newChoiceActivity(actity_id, index){
    /*
     "13":{"type":2, "choice":[
                                        {"text":"A.Yes","action":1,"nextnode":21},
                                        {"text":"B.No","action":2,"nextnode":3}
                                    ]}, 
    */
    
    
    var newActivity = JSON.parse( $(".activity_newID").html());
    if(newActivity.length == 0){
        newActivityID = -1;
    }
    else{
        newActivityID = newActivity[newActivity.length-1]-1;
    }
    newActivity.push(newActivityID);
    $(".activity_newID").html(JSON.stringify(newActivity));

    var text;
    var action;
    var nextnode;
    var choices = new Array();
    $('.choiceInput').each(function() {
        text =  $( this ).find(".choiceText").val();
        action = $( this ).find(".nodetype").val();
        nextnode = $( this ).find(".goid").val();
        nextnode = parseInt(nextnode, 10)-1;
        choices.push({"text": text, "action": action, "nextnode":nextnode});
        //alert(nextnode);
        $( this ).find(".choiceText").val("");
        $( this ).find(".nodetype").val("1");
        $( this ).find(".goid").val("");
        index = index + 1;
    });
    
    var order = JSON.parse( $(".activity_order").html());
    order.push(newActivityID);
    $(".activity_order").html(JSON.stringify(order));
    
    var data = JSON.parse( $(".activity_data").html());
    data[newActivityID] = {"type":2, "choice":choices};
    $(".activity_data").html(JSON.stringify(data));
    
    $('.activity-modal').modal('hide');
    
    draw_activityBar();
    
    
    
}


function newGoToActivity(actity_id, index){
    /*
    "15":{"type":3, "nextnode":"17"},
    "16":{"type":4, "nextnode":"21"}, 
    */
    var newActivity = JSON.parse( $(".activity_newID").html());
    if(newActivity.length == 0){
        newActivityID = -1;
    }
    else{
        newActivityID = newActivity[newActivity.length-1]-1;
    }
    newActivity.push(newActivityID);
    $(".activity_newID").html(JSON.stringify(newActivity));

    if($("#nodetype").val() == 1){
        var type = 3;
    }
    else{
        var type = 4;
    }
    var nextnode = $("#nextnode").val();
    
    var order = JSON.parse( $(".activity_order").html());
    order.push(newActivityID);
    $(".activity_order").html(JSON.stringify(order));
    
    var data = JSON.parse( $(".activity_data").html());
    data[newActivityID] = {"type":type, "nextnode":nextnode};
    $(".activity_data").html(JSON.stringify(data));
    
    $("#nodetype").val("1");
    $("#nextnode").val("");
    
    $('.activity-modal').modal('hide');
    
    draw_activityBar();
    
}

function newChangeBgActivity(actity_id, index){
    /*
     "17":{"type":5, "url":"http://aaa.com"} 
    */
    var newActivity = JSON.parse( $(".activity_newID").html());
    if(newActivity.length == 0){
        newActivityID = -1;
    }
    else{
        newActivityID = newActivity[newActivity.length-1]-1;
    }
    newActivity.push(newActivityID);
    $(".activity_newID").html(JSON.stringify(newActivity));

    var type = 5
    var url = $("#bgurl").val();
    
    var order = JSON.parse( $(".activity_order").html());
    order.push(newActivityID);
    $(".activity_order").html(JSON.stringify(order));
    
    var data = JSON.parse( $(".activity_data").html());
    data[newActivityID] = {"type":type, "url":url};
    $(".activity_data").html(JSON.stringify(data));
    
    $("#bgurl").val("");
    
    $('.activity-modal').modal('hide');
    
    draw_activityBar();
    
}

function newChangeMusicActivity(actity_id, index){
    /*
    "14":{"type":6, "url":"http://aaa.com"}, 
    */
    var newActivity = JSON.parse( $(".activity_newID").html());
    if(newActivity.length == 0){
        newActivityID = -1;
    }
    else{
        newActivityID = newActivity[newActivity.length-1]-1;
    }
    newActivity.push(newActivityID);
    $(".activity_newID").html(JSON.stringify(newActivity));

    var type = 6
    var url = $("#musicurl").val();
    
    var order = JSON.parse( $(".activity_order").html());
    order.push(newActivityID);
    $(".activity_order").html(JSON.stringify(order));
    
    var data = JSON.parse( $(".activity_data").html());
    data[newActivityID] = {"type":type, "url":url};
    $(".activity_data").html(JSON.stringify(data));
    
    $("#musicurl").val("");
    
    $('.activity-modal').modal('hide');
    
    draw_activityBar();
    
}


function appendChoice(){
    
    var count = $('.choice').length;
    var text = ["A", "B", "C", "D"];
    if(count < 4){
        var choiceScript = '<div class="choiceInput choice'+text[count]+'"> \
                                <div class="input-group"> \
                                    <span class="input-group-addon choice">'+text[count]+'.</span> \
                                    <input class="form-control choiceText" name="choiceText"> \
                                    <div class="row"> \
                                        <div class="col-md-4"> \
                                            <select name="nodetype[]" class="selecter_basic nodetype"> \
                                                <option value="1">Go to Activity</option> \
                                                <option value="2">Go to Scene</option> \
                                            </select> \
                                        </div> \
                                        <div class="col-md-4"> \
                                            <input type="number" class="form-control goid" name="goid[]" placeholder="Activity or Scene ID" min="0"> \
                                        </div> \
                                        <div class="col-md-4"> \
                                            <button type="button" class="btn btn-danger pull-right removebtn" tabindex="-1" onclick="removeChoice(\''+text[count]+'\');">Remove</button> \
                                        </div> \
                                    </div> \
                                </div> \
                                <br> \
                            </div> \
                            ';
    
        $("#choiceArea").append(choiceScript);
        $("select").selecter();
    }
    else{
        alert("Limit exceed!");
    }
    
    
}

function removeChoice(choice){
    //do it yourself plzzzz
    $(".choice"+choice).remove();
    var text = ["A.", "B.", "C.", "D."];
    var index = 0;
    $( ".choice" ).each(function() {
        $( this ).html(text[index]);
        index = index + 1;
    });
    var text = ["A", "B", "C", "D"];
    var index = 0;
    $( ".removebtn" ).each(function() {
        $( this ).attr("onclick","removeChoice('"+text[index]+"');");
        index = index + 1;
    });
    
    var text = ["A", "B", "C", "D"];
    var index = 0;
    $( ".choiceInput" ).each(function() {
        $( this ).attr("class","choiceInput choice"+text[index]);
        index = index + 1;
    });
}

draw_activityBar();
$("select").selecter();