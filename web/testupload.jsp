<%@page import="help.F"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>File Upload</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="<%= F.asset("css/bootstrap.min.css") %>">
        <script src="<%= F.asset("js/jquery-2.1.3.min.js")%>">"></script>
    </head>
    <body>
        <form method="POST" enctype="multipart/form-data" >
            File:
            <input type="file" name="file" id="file" /> <br/>
            </br>
            <input type="button" value="Upload" name="upload" id="uploadCoverBtn" />
        </form>
        <progress id="progress-cover-upload" class="hidden"></progress>
    </body>
    <script>
                $('#uploadCoverBtn').click(function () {
            var formData = new FormData($('form')[0]);
            $('#progress-cover-upload').attr({value: 0, max: 1});
            $('#progress-cover-upload').removeClass("hidden");
            $.ajax({
                url: 'UploadServlet', //Server script to process data
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
                    if(data.status == 1){
                        alert(data.filename);
                    }else{
                        alert("Upload fail");
                    }
                    $('#progress-cover-upload').addClass("hidden");
                },
                error: function (x, e) {
                    $('#progress-cover-upload').addClass("hidden");
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
    </script>
</html>