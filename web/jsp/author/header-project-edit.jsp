<%@page import="model.User"%>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" style="height:100%;overflow:hidden;"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" style="height:100%;overflow:hidden;"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" style="height:100%;overflow:hidden;"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" style="height:100%;overflow:hidden;"> <!--<![endif]-->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>FiNE - Fine is Novel Engine</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <link rel="icon" href="<%= F.asset("/img//favicon.ico")%>" type="image/x-icon">
        <link rel="stylesheet" href="<%= F.asset("css/main.css")%>">
        <link rel="stylesheet" href="<%= F.asset("css/bootstrap.min.css")%>">
        <link rel="stylesheet" href="<%= F.asset("css/icomoon-social.css")%>">
        <link rel="stylesheet" href="<%= F.asset("css/bootflat.min.css")%>">
        <!-- <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,600,800' rel='stylesheet' type='text/css'> -->
        <link rel="stylesheet" href="<%= F.asset("css/jquery-ui.css")%>">

        <link rel="stylesheet" href="<%= F.asset("css/leaflet.css")%>" />
        <!--[if lte IE 8]>
            <link rel="stylesheet" href="<%= F.asset("css/leaflet.ie.css")%>" />
        <![endif]-->
        <link rel="stylesheet" href="<%= F.asset("css/style.css")%>">

        <script src="<%= F.asset("js/modernizr-2.6.2-respond-1.1.0.min.js")%>"></script>
        <script src="<%= F.asset("js/jquery-2.1.3.min.js")%>">"></script>
        <link rel="stylesheet" href="<%= F.asset("css/search.css")%>">
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
        <![endif]-->


        <!-- Navigation & Logo-->
        <div class="mainmenu-wrapper">
            <nav class="mainmenu">
                <ul>
                    <li class="logo-wrapper">
                        <a href="<%= F.asset("/")%>">
                            &nbsp;&nbsp;&nbsp;<img src="<%= F.asset("img/fine-logo.png")%>"/>
                        </a>
                    </li>
                    <li class="active">
                        <a id="projectTitle">${param.projectTitle}</a>
                        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#projectModal">
                            <i class="glyphicon glyphicon-pencil"></i> Setting
                        </button>
                    </li>
                    <li class="pull-right">
                        <img id="loading-project-status" src="<%= F.asset("/img/loading.gif")%>" style="max-height: 30px;" class="hidden"/>
                        <a href="javascript:;" onclick="toggleProjectVisible(this,${requestScope.project.id});">
                            <c:choose>
                                <c:when test="${project.getVisible() > 1}">  
                                    <i class="glyphicon glyphicon-ban-circle"></i> Banned
                                </c:when>
                                <c:when test="${project.isVisible()}">  
                                    <i class="glyphicon glyphicon-ok"></i> Published
                                </c:when>
                                <c:otherwise>
                                    <i class="glyphicon glyphicon-share"></i> Publish Now
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </li>
                    <li class="pull-right">
                        <a href="<%= F.asset("/project")%>/${project.id}/play" target="_blank"><i class="glyphicon glyphicon-play"></i> Preview</a>
                    </li>
                    <li class="pull-right">
                        <a href="<%= F.asset("/author/project")%>/${project.id}/viewrelation" target="_blank"><i class="glyphicon glyphicon-retweet"></i> Generate Relation</a>
                    </li>
                    <li class="pull-right <c:if test="${!requestScope.project.isVisible()}">hidden</c:if>" id="share">
                            <a style="padding-bottom: 0px;">
                                <form action="" class="search-form">
                                    <div class="form-group has-feedback" style="margin-bottom: 0px;">
                                        <label for="search" class="sr-only">Share</label>
                                        <input onclick="shareLink(this);" class="form-control" style="cursor: pointer;" name="search"  placeholder="share link" value="http://${pageContext.request.serverName}:${pageContext.request.serverPort}<%= F.asset("/product")%>/${project.id}/view">
                                    <span class="glyphicon glyphicon-share form-control-feedback"></span>
                                </div>
                            </form>
                        </a>
                    </li>
                </ul>
            </nav>
            <script>
                function shareLink(element) {
                    window.prompt("Copy to clipboard: Ctrl+C, Enter", $(element).val());
                }
            </script>
        </div>
        <%= F.getMessage(session)%>
