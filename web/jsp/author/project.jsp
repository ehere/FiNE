<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header-project-edit.jsp" >
    <jsp:param name="projectTitle" value="${requestScope.project.title}" />
</jsp:include>


<div class="row menu-panel" style="padding: 0px;margin: 0px;width: 100%;">
    <div class="col-md-2" style="height: 100%;padding: 0px;margin: 0px;">
        <div class="panel panel-success">
            <div class="panel-heading menu-panel-list-heading" style="border-radius: 0px;">
                Scene
                <span style="position: absolute;right: 0;top: 0;">
                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#sceneModal" onclick="newScene(${requestScope.project.id});">New Scene</button>
                </span>

            </div>
            <div class="menu-panel-list" style="height: 100%;overflow-y: auto;overflow-x: hidden;">
                <!---   ---->
                <div class="panel-group" id="scene-list" role="tablist" aria-multiselectable="true">

                </div>
            </div>
        </div>
    </div>
    <!-- ----------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------- -->

    <div class="col-md-7" style="height: 100%;padding: 0px;margin: 0px;">
        <div style="width:100%;height: 100%;">
            <br><br>
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
                <span  style="position: absolute;right: 0;top: 0;">
                    <button id="saveActBtn" type="button" class="btn btn-default hidden" onclick="">Save Change</button>
                    <button id="newActBtn" type="button" class="btn btn-warning hidden" data-toggle="modal" data-target=".activity-modal" onclick="clearInput();
                            changeSaveBtnToNew();">New Activity</button>
                </span>

            </div>
            <div class="panel-body activity_bar menu-panel-list">

            </div>
        </div>
    </div>
</div>
<!-------------------------------Activity Modal Zone ----------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------- -->

<div class="modal fade activity-modal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Select Your activity</h4>
            </div>
            <div class="modal-body">
                <div class="panel">
                    <div class="tabbable tabs-left clearfix">
                        <ul id="activityTab" class="nav nav-tabs nav-justified">
                            <li class="active"><a href="#dialog" data-toggle="tab">Dialog</a>
                            </li>
                            <li class=""><a href="#choice" data-toggle="tab">Choice</a>
                            </li>
                            <li class=""><a href="#goto" data-toggle="tab">Go to</a>
                            </li>
                            <li class=""><a href="#background" data-toggle="tab">Background</a>
                            </li>
                            <li class=""><a href="#music" data-toggle="tab">Music</a>
                            </li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade active in" id="dialog">
                                <br>
                                <br>
                                <br>
                                <div class="input-group">
                                    <span class="input-group-addon">Title Box&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                    <input class="form-control" id="titleDialog">
                                </div>
                                <br>
                                <div class="input-group">
                                    <span class="input-group-addon">Dialog Box</span>
                                    <textarea class="form-control" rows="5" style="resize: none;" id="textDialog"></textarea>
                                </div>
                                <br>
                                <div class="input-group">
                                    <input class="form-control" type="file">
                                    <div class="input-group-btn">
                                        <button type="submit" name="submit" class="btn btn-primary" tabindex="-1">Upload Dubsound</button>
                                    </div>
                                </div>
                                <br> OR
                                <br>
                                <br>
                                <div class="input-group">
                                    <span class="input-group-addon">Sound URL</span>
                                    <input class="form-control" id="soundDialog">
                                </div>
                                <br>
                                <div class="pull-right">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary btn-newDialog" onclick="newDialogActivity();">Save changes</button>
                                </div>
                                <br>
                                <br>
                            </div>
                            <div class="tab-pane fade" id="choice">
                                <br>
                                <br>
                                <br>
                                <button type="button" class="btn btn-success" onclick="appendChoice();">New Choice</button>
                                <br>
                                <br>
                                <div id="choiceArea">
                                    <div class="choiceInput choiceA">
                                        <div class="input-group">
                                            <span class="input-group-addon choice">A.</span>
                                            <input class="form-control choiceText" name="choiceText[]">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <select name="nodetype[]" class="selecter_basic nodetype">
                                                        <option value="1">Go to Activity</option>
                                                        <option value="2">Go to Scene</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-4">
                                                    <input type="number" class="form-control goid" name="goid[]" placeholder="Activity or Scene ID" min="0">
                                                </div>
                                                <div class="col-md-4">
                                                    <button type="button" class="btn btn-danger pull-right removebtn" tabindex="-1" onclick="removeChoice('A');">Remove</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br>
                                </div>
                                <div class="pull-right">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary btn-newChoice" onclick="newChoiceActivity();">Save changes</button>
                                </div>
                                <br>
                                <br>
                            </div>
                            <div class="tab-pane fade" id="goto">
                                <br>
                                <br>
                                <br>
                                <div class="col-md-4">
                                    <select name="nodetype" id="nodetype" class="selecter_basict">
                                        <option value="1">Go to Activity</option>
                                        <option value="2">Go to Scene</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <input type="number" class="form-control" name="nextnode" id="nextnode" placeholder="Activity or Scene ID" min="0">
                                </div>
                                <br>
                                <br>
                                <br>
                                <div class="pull-right">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary btn-newGoTo" onclick="newGoToActivity();">Save changes</button>
                                </div>
                                <br>
                                <br>
                            </div>
                            <div class="tab-pane fade" id="background">
                                <br>
                                <br>
                                <br>
                                <!-- <div class="input-group">
                                    <input class="form-control" type="file">
                                    <div class="input-group-btn">
                                        <button type="submit" name="submit" class="btn btn-primary" tabindex="-1">Upload Background</button>
                                    </div>
                                </div>
                                <br>
                                OR
                                <br>
                                <br> -->
                                <div class="input-group">
                                    <span class="input-group-addon">Background URL</span>
                                    <input class="form-control" name="bgurl" id="bgurl">
                                </div>
                                <br>
                                <div class="pull-right">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary btn-newChangeBg" onclick="newChangeBgActivity();">Save changes</button>
                                </div>
                                <br>
                                <br>
                            </div>
                            <div class="tab-pane fade" id="music">
                                <br>
                                <br>
                                <br>
                                <!-- <div class="input-group">
                                    <input class="form-control" type="file">
                                    <div class="input-group-btn">
                                        <button type="submit" name="submit" class="btn btn-primary" tabindex="-1">Upload Music</button>
                                    </div>
                                </div>
                                <br>
                                OR
                                <br>
                                <br> -->
                                <div class="input-group">
                                    <span class="input-group-addon">Music URL</span>
                                    <input class="form-control" name="musicurl" id="musicurl">
                                </div>
                                <br>
                                <div class="pull-right">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary btn-newChangeMusic" onclick="newChangeMusicActivity();">Save changes</button>
                                </div>
                                <br>
                                <br>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-------------------------------Scene Modal Zone ----------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------- -->
<div class="modal fade" id="sceneModal" tabindex="-1" role="dialog" aria-labelledby="sceneModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Scene</h4>
            </div>
            <div class="modal-body">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">Title</span>
                    <input id="sceneTitle" type="text" class="form-control" placeholder="Scene Title" >
                </div>
                <br>
                <textarea id="sceneDescription"></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button id="removeSceneBtn" type="button" class="btn btn-danger" onclick="">Remove</button>
                <button id="saveSceneBtn" type="button" class="btn btn-primary" onclick="">Save</button>
            </div>
        </div>
    </div>
</div>

<!-------------------------------Project Modal Zone ----------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------- -->
<div class="modal fade" id="projectModal" tabindex="-1" role="dialog" aria-labelledby="projectModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Project</h4>
            </div>
            <div class="modal-body">
                <div class="input-group">
                    <span class="input-group-addon" id="basic-addon1">Title</span>
                    <input id="projectTitleInput" type="text" class="form-control" placeholder="Project Title" value="${requestScope.project.title}">
                </div><br>
                <textarea id="projectDescription"></textarea><br>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1">Price</span>
                            <input id="projectPrice" type="text" class="form-control" placeholder="Project Price" value="${requestScope.project.price}">
                        </div>
                        <br>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1">Rate</span>
                            <input id="projectRate" type="text" class="form-control" placeholder="Project Rate" value="${requestScope.project.rate}">
                        </div>
                        <br>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1">First Scene</span>
                            <input id="projectFirstScene" type="text" class="form-control" placeholder="Project First Scene" value="${requestScope.project.first_scene_id}">
                        </div>
                        <br>
                    </div>
                </div>
                <form method="POST" enctype="multipart/form-data" >
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">Cover</span>
                        <input id="projectCoverInput" type="file" name="file" class="form-control">
                        <span class="input-group-btn">
                            <button class="btn btn-danger" type="button" id="uploadCoverBtn">Upload</button>
                        </span>
                    </div><br>
                </form>
                <input id="projectCover" type="hidden" value="${requestScope.project.getCoverName()}">
                <strong>Preview Image:</strong><br>
                <progress id="progress-cover-upload" class="hidden"></progress>
                <img class="thumbnail" id="coverImg" src ="${requestScope.project.cover}" style="max-height: 350px;max-width: 350px;">
                <img class="thumbnail hidden" id="loading-uploade-cover" src ="<%= F.asset("/img/loading.gif")%>" style="max-height: 350px;max-width: 350px;">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="updateProject(${requestScope.project.id});">Save</button>
            </div>
        </div>
    </div>
</div>

<!-- -------------------- data zone --------------------------------------------------------------------
------------------------------------------------------------------------------------------------------- -->
<div class="hidden activity_data"></div>
<div class="hidden activity_order"></div>
<div class="hidden activity_newID">[]</div>    
<div class="hidden play_index"></div>
<div class="hidden allscene-list"></div>
<div class="hidden project-description">${requestScope.project.description}</div>
<div class="hidden name">MC_NAME</div>
<div class="hidden mode">edit</div>

<script src="<%= F.asset("/js/typed.js")%>"></script>
<script src="<%= F.asset("/js/player.js")%>"></script> 
<script src="<%= F.asset("/js/activity_bar.js")%>"></script>
<script src="<%= F.asset("/js/scene_bar.js")%>"></script>
<script type="text/javascript" src="<%= F.asset("ckeditor/ckeditor.js")%>"></script>
<script type="text/javascript"></script>
<script type="text/javascript"></script>

<script>
                    CKEDITOR.replace("sceneDescription");
                    CKEDITOR.replace("projectDescription");
                    CKEDITOR.instances['projectDescription'].setData($('.project-description').html());
                    $('.menu-panel').outerHeight($('html').outerHeight() - $('.mainmenu-wrapper').outerHeight());
                    $('.menu-panel-list').outerHeight($('.menu-panel').outerHeight() - $('.menu-panel-list-heading').outerHeight());
</script>
<script>
    function updateProject(projectID) {
        var title = $('#projectTitleInput').val();
        var description = CKEDITOR.instances['projectDescription'].getData();
        var price = $('#projectPrice').val();
        var price = $('#projectPrice').val();
        var rate = $('#projectRate').val();
        var cover = $('#projectCover').val();
        var firstscene = $('#projectFirstScene').val();
        $.post("/fine/author/project/" + projectID + "/update", {title: title, description: description, price: price, rate: rate, cover: cover, firstscene: firstscene})
                .done(function (respond) {
                    if(respond == "Update project success."){
                        $('#projectTitle').html(title);
                        $('#projectModal').modal("hide");
                    }
                    alert(respond);
                })
                .fail(function (jqxhr, textStatus, error) {
                    alert("Something wrong.Please try again or refresh this page.");
                });
    }
    function toggleProjectVisible(element, projectID) {
        $('#loading-project-status').removeClass("hidden");
        $.get("/fine/author/project/" + projectID + "/togglevisible")
                .done(function (respond) {
                    $('#loading-project-status').addClass("hidden");
                    if (respond == "toggle visible success.") {
                        if ($(element).html().indexOf("Publish Now") != -1) {
                            $(element).html('<i class="glyphicon glyphicon-ok"></i> Published');
                        } else {
                            $(element).html('<i class="glyphicon glyphicon-share"></i> Publish Now');
                        }
                    } else {
                        alert(respond);
                    }
                })
                .fail(function (jqxhr, textStatus, error) {
                    $('#loading-project-status').addClass("hidden");
                    alert("Something wrong.Please try again or refresh this page.");
                });
    }
    function getDescription(sceneID, element) {
        $('#collapse' + sceneID).html("Loading...");
        $.getJSON("/fine/scene/" + sceneID)
                .done(function (respond) {
                    var description = respond[sceneID].description;
                    var body =
                            '<div class="panel-body" style="padding-top: 0px;">' +
                            description + '<br><br>' +
                            '<button type="button" class="btn btn-default" onclick="editScene(' + sceneID + ',' + ${requestScope.project.id}
                    + ')" data-toggle="modal" data-target="#sceneModal"><i class="glyphicon glyphicon-pencil"></i> Edit Scene</button>' +
                            '<button type="button" class="btn btn-default" onclick="getScene(' + sceneID + ',0)"><i class="glyphicon glyphicon-blackboard"></i> Edit Activity</button>' +
                            '</div>';
                    $('#collapse' + sceneID).html(body);
                })
                .fail(function (jqxhr, textStatus, error) {
                    alert("Something wrong.Please try again or refresh this page.");
                });
    }

    $('#uploadCoverBtn').click(function () {
        var formData = new FormData($('form')[0]);
        $('#loading-uploade-cover').removeClass("hidden");
        $('#coverImg').addClass("hidden");
        $('#progress-cover-upload').attr({value: 0, max: 1});
        $('#progress-cover-upload').removeClass("hidden");
        $.ajax({
            url: '/fine/UploadServlet?action=cover', //Server script to process data
            type: 'POST',
            xhr: function () {  // Custom XMLHttpRequest
                var myXhr = $.ajaxSettings.xhr();
                if (myXhr.upload) { // Check if upload property exists
                    myXhr.upload.addEventListener('progress', progressHandlingFunction, true); // For handling the progress of the upload
                }
                return myXhr;
            },
            //Ajax events
            //beforeSend: beforeSendHandler,
            success: function (respond) {
                var data = $.parseJSON(respond);
                if (data.status == 1) {
                    $('#coverImg').attr("src","/fine/img/cover/"+data.filename);
                    $('#projectCover').val(data.filename);
                } else {
                    alert(data.message);
                }
                $('#progress-cover-upload').addClass("hidden");
                $('#loading-uploade-cover').addClass("hidden");
                $('#coverImg').removeClass("hidden");
            },
            error: function (x, e) {
                $('#progress-cover-upload').addClass("hidden");
                $('#loading-uploade-cover').addClass("hidden");
                $('#coverImg').removeClass("hidden");
                if (x.status == 0) {
                    alert('Connection Abort.');
                } else if (x.status == 404) {
                    alert('Requested URL not found.');
                } else if (x.status == 500) {
                    alert('Internel Server Error.');
                } else if (e == 'parsererror') {
                    alert('Error.\nParsing JSON Request failed.');
                } else if (e == 'timeout') {
                    alert('Request Time out.');
                } else {
                    alert('Unknow Error.\n' + x.responseText);
                }
            },
            // Form data
            data: formData,
            //Options to tell jQuery not to process data or worry about content-type.
            cache: false,
            contentType: false,
            processData: false
        });
    });
    function progressHandlingFunction(e) {
        if (e.lengthComputable) {
            $('#progress-cover-upload').attr({value: e.loaded, max: e.total});
        }
    }
    getSceneList(${requestScope.project.id});
</script>
<jsp:include page="footer.jsp" />