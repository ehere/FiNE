<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <button class="btn btn-orange pull-right" data-toggle="modal" data-target="#projectModal"><i class="glyphicon glyphicon-plus"></i> New Project</button>
                <h1>My Project</h1>
            </div>
        </div>
    </div>
</div>

<div class="eshop-section section">
    <div class="container">
        <c:if test="${requestScope.totalpage == 0}">
            <h2>Oh oh! Look like you don't have any project.</h2>
            <br>
            <h4>Why not create new one?</h4>
            <br>
            <button class="btn btn-orange"  data-toggle="modal" data-target="#projectModal"><i class="glyphicon glyphicon-plus"></i> New Project</button>
        </c:if>
        <div class="row">
            <c:forEach var="product" items="${list}">
                <div class="col-md-3 col-sm-6">
                    <div class="shop-item">
                        <div class="shop-item-image" style="text-align: center;">
                            <a href="<%= F.asset("/product")%>/${product.id}/view"><img src="${product.cover}" style="height: 150px" alt="${product.title}"></a>
                        </div>
                        <div class="title">
                            <h3><a href="<%= F.asset("/product")%>/${product.id}/view" style="font-size: 1.5em;">${product.title}</a></h3>
                        </div>
                        <div class="price" style="font-size: 1.3em;">
                            <i class="glyphicon glyphicon-bitcoin icon-white"></i>${product.price}
                        </div>
                        <div class="actions">
                            <a href="<%= F.asset("/author/project")%>/${product.id}" class="btn btn-grey"><i class="glyphicon glyphicon-pencil icon-white"></i> Edit</a>
                            or 
                            <a href="javascript:;" onclick="confirmRemove(${product.id},'${product.title}')">Remove</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="pagination-wrapper ">
            <ul class="pagination pagination-lg">
                <c:if test="${requestScope.currentpage > 1}">
                    <li><a href="<%= F.asset("/product?page=")%>${requestScope.currentpage-1}">Previous</a></li>
                </c:if>
                <c:forEach begin="1" end="${requestScope.totalpage}" step="1" var="i">
                    <c:choose>
                        <c:when test="${requestScope.currentpage == i}">
                        <li class="active"><a href="#">${i}</a></li>
                        </c:when>
                        <c:otherwise>
                        <li><a href="<%= F.asset("/product?page=")%>${i}<c:if test="${searchKey != null}">&search=${searchKey}</c:if>">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${requestScope.currentpage < requestScope.totalpage}">
                    <c:if test="${requestScope.totalpage != 0}">
                    <li><a href="<%= F.asset("/product?page=")%>${requestScope.currentpage+1}<c:if test="${searchKey != null}">&search=${searchKey}</c:if>">Next</a></li>
                    </c:if>
                </c:if>
            </ul>
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
                    <input id="projectTitleInput" type="text" class="form-control" placeholder="Project Title">
                </div><br>
                <b>Description:</b>
                <textarea id="projectDescription"></textarea><br>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1">Price</span>
                            <input id="projectPrice" type="text" class="form-control" placeholder="Project Price">
                        </div>
                        <br>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1">Rate</span>
                            <input id="projectRate" type="text" class="form-control" placeholder="How old is age of player require to play this project">
                        </div>
                        <br>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1">First Scene</span>
                            <input id="projectFirstScene" type="text" class="form-control" placeholder="Please set fisrt scene after you create project" disabled="">
                        </div>
                        <br>
                    </div>
                </div>
                <form method="POST" enctype="multipart/form-data" id="form-upload-cover">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">Cover</span>
                        <input id="projectCoverInput" type="file" name="file" class="form-control">
                        <span class="input-group-btn">
                            <button class="btn btn-danger" type="button" id="uploadCoverBtn">Upload</button>
                        </span>
                    </div><br>
                </form>
                <input id="projectCover" type="hidden" value="">
                <strong>Preview Image:</strong><br>
                <progress id="progress-cover-upload" class="hidden"></progress>
                <img class="thumbnail" id="coverImg" src ="" style="max-height: 350px;max-width: 350px;">
                <img class="thumbnail hidden" id="loading-upload-cover" src ="<%= F.asset("/img/loading.gif")%>" style="max-height: 350px;max-width: 350px;">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="addProject();">Save</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="<%= F.asset("ckeditor/ckeditor.js")%>"></script>
<script>
    CKEDITOR.replace("projectDescription");
    $('#uploadCoverBtn').click(function () {
        var formData = new FormData($('#form-upload-cover')[0]);
        $('#loading-upload-cover').removeClass("hidden");
        $('#coverImg').addClass("hidden");
        $('#progress-cover-upload').attr({value: 0, max: 1});
        $('#progress-cover-upload').removeClass("hidden");
        $.ajax({
            url: '/fine/UploadServlet?action=cover', //Server script to process data
            type: 'POST',
            xhr: function () {  // Custom XMLHttpRequest
                var myXhr = $.ajaxSettings.xhr();
                if (myXhr.upload) { // Check if upload property exists
                    myXhr.upload.addEventListener('progress', progressCoverHandling, true); // For handling the progress of the upload
                }
                return myXhr;
            },
            //Ajax events
            //beforeSend: beforeSendHandler,
            success: function (respond) {
                var data = $.parseJSON(respond);
                if (data.status == 1) {
                    $('#coverImg').attr("src", "/fine/img/cover/" + data.filename);
                    $('#projectCover').val(data.filename);
                } else {
                    alert(data.message);
                }
                $('#progress-cover-upload').addClass("hidden");
                $('#loading-upload-cover').addClass("hidden");
                $('#coverImg').removeClass("hidden");
            },
            error: function (x, e) {
                $('#progress-cover-upload').addClass("hidden");
                $('#loading-upload-cover').addClass("hidden");
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
    function progressCoverHandling(e) {
        if (e.lengthComputable) {
            $('#progress-cover-upload').attr({value: e.loaded, max: e.total});
        }
    }
    function addProject() {
        var title = $('#projectTitleInput').val();
        var description = CKEDITOR.instances['projectDescription'].getData();
        var price = $('#projectPrice').val();
        var price = $('#projectPrice').val();
        var rate = $('#projectRate').val();
        var cover = $('#projectCover').val();
        $.post("/fine/author/project/create", {title: title, description: description, price: price, rate: rate, cover: cover})
                .done(function (respond) {
                    if (respond.indexOf("Create project success.") != -1) {
                        var projectID = respond.split('|')[1];
                        $('#projectTitle').html(title);
                        $('#projectModal').modal("hide");
                        window.location="/fine/author/project/"+projectID;
                    }else{
                        alert(respond);
                    }
                })
                .fail(function (jqxhr, textStatus, error) {
                    alert("Something wrong.Please try again or refresh this page.");
                });
    }
    function confirmRemove(projectID,title){
        var text = prompt("Please enter your project name to confirm", ""); 
        text = text.toLowerCase();
        title = title.toLowerCase();
        if (text == title) {
            window.location="/fine/author/project/"+projectID+"/destroy";
        }else{
            alert("Wrong project name!");
        }
    }
</script>
<jsp:include page="footer.jsp" />