<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp"/>

<style type="text/css">
    body {
        font: 10pt sans;
    }
    #mynetwork {
        width: 100%;
        height: 700px;
    }
</style>

<script type="text/javascript" src="<%= F.asset("/js/vis.min.js")%>"></script>
<link href="<%= F.asset("/css/vis.min.css")%>" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    var network = null;
    var layoutMethod = "hubsize";

    function destroy() {
        if (network !== null) {
            network.destroy();
            network = null;
        }
    }

    function draw() {
        $.getJSON("/fine/author/project/${project.id}/relation")
                .done(function (relationship) {
                    destroy();

                    var nodes = [];
                    var edges = [];

                    //var relationship = $.parseJSON($('#relationship').html());
                    $.each(relationship, function (scene, value) {
                        nodes.push({
                            id: parseInt(scene),
                            label: value.title
                        });
                        edges.push({
                            from: parseInt(scene),
                            to: parseInt(value.nextnode)
                        });
                    });

                    // create a network
                    var container = document.getElementById('mynetwork');
                    var data = {
                        nodes: nodes,
                        edges: edges
                    };

                    var options = {
                        hierarchicalLayout: {
                            layout: layoutMethod
                        },
                        edges: {style: "arrow"},
                        smoothCurves: false
                    };
                    network = new vis.Network(container, data, options);

                    // add event listeners
                    network.on('select', function (params) {
                        document.getElementById('selection').innerHTML = 'Selection scene: ' + params.nodes;
                    });
                })
                .fail(function (jqxhr, textStatus, error) {
                    var err = textStatus + ", " + error;
                    console.log("Request Failed: " + err);
                });

    }
        $(document).ready(function () {
            draw();
        });
</script>
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>Relationship in ${project.id}. ${project.title}</h1>
            </div>
        </div>
    </div>
</div>
<div id="mynetwork"></div>

<p id="selection"></p>
<jsp:include page="footer.jsp" />