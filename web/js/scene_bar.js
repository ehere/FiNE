function drawSceneBar() {
    $("#scene-list").html("");
    var scenelist = JSON.parse($(".allscene-list").html());
    for (var key in scenelist) {
        var sceneID = key;
        var title = scenelist[key].title;
        var row =
                '<div class="panel panel-default bs-callout bs-callout-default scene-row" style="padding-bottom: 0px">' +
                '<div class="" role="tab" id="heading' + sceneID + '">' +
                '<h4 class="panel-title">' +
                '<a class="truncate" onclick="getDescription(' + sceneID + ',this)" data-toggle="collapse" data-parent="#scene-list" href="#collapse' + sceneID + '" aria-expanded="true" aria-controls="collapse' + sceneID + '">' +
                sceneID + ': ' + title +
                '</a>' +
                '</h4>' +
                '</div>' +
                '<div id="collapse' + sceneID + '" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading' + sceneID + '">' +
                '<div class="panel-body" style="padding-top: 0px;"></div>' +
                '</div>' +
                '</div>';
        $("#scene-list").append(row);

    }

}
function removeScene(sceneID, projectID) {
    $("#scene-list").html("Removing ...");
    $.get("/fine/author/scene/" + sceneID + "/destroy")
            .done(function (respond) {
                if (respond == "Remove Scene Success.") {
                    alert(respond);
                    getSceneList(projectID);
                    $('#sceneModal').modal('hide');
                    //clear player
                    location.reload();
                } else {
                    alert(respond);
                    getSceneList(projectID);
                }
            })
            .fail(function (jqxhr, textStatus, error) {
                alert("Something wrong.Please try again or refresh this page.");
                getSceneList(projectID);
            });
}
function newScene(projectID) {
    $('#sceneTitle').val("");
    CKEDITOR.instances['sceneDescription'].setData("");
    $('#removeSceneBtn').addClass("hidden");
    $('#saveSceneBtn').attr("onclick", "saveScene(0," + projectID + ");");
}
function editScene(sceneID, projectID) {
    $('#removeSceneBtn').removeClass("hidden");
    $('#removeSceneBtn').attr("onclick", "removeScene(" + sceneID + "," + projectID + ");");
    var scenelist = JSON.parse($(".allscene-list").html());
    $('#saveSceneBtn').attr("onclick", "saveScene(" + sceneID + "," + projectID + ");");
    var title = scenelist[sceneID].title;
    $('#sceneTitle').val(title);
    CKEDITOR.instances['sceneDescription'].setData("Loading Description...");
    $.getJSON("/fine/scene/" + sceneID)
            .done(function (respond) {
                var description = respond[sceneID].description;
                CKEDITOR.instances['sceneDescription'].setData(description);
            })
            .fail(function (jqxhr, textStatus, error) {
                alert("Something wrong.Can't load description!");
            });
}
function saveScene(sceneID, projectID) {
    var title = $('#sceneTitle').val();
    var description = CKEDITOR.instances['sceneDescription'].getData();
    if (sceneID == 0) {
        $("#scene-list").html("Creating ...");
        $.post("/fine/author/scene/create", {title: title, description: description, project: projectID})
                .done(function (data) {
                    if (data == "Create Scene Success.") {
                        alert(data);
                        getSceneList(projectID);
                        $('#sceneModal').modal('hide');
                    } else {
                        alert(data);
                        getSceneList(projectID);
                    }
                });

    } else {
        $("#scene-list").html("Updating ...");
        $.post("/fine/author/scene/" + sceneID + "/update", {title: title, description: description})
                .done(function (data) {
                    if (data == "Update Scene Success.") {
                        alert(data);
                        getSceneList(projectID);
                        $('#sceneModal').modal('hide');
                    } else {
                        alert(data);
                        getSceneList(projectID);
                    }
                });
    }
}
function getSceneList(projectID) {
    $.get("/fine/author/project/" + projectID + "/allscene")
            .done(function (respond) {
                $('.allscene-list').html(respond);
                drawSceneBar();
            })
            .fail(function (jqxhr, textStatus, error) {
                alert("Something wrong.Can't load scene list!");
            });
}

