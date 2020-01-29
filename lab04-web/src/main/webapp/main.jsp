<%@page contentType="text/html" pageEncoding="UTF-8" %>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
          crossorigin="anonymous">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lab03</title>
</head>
<body>
<div class="container">
    <h1>Lab 03</h1>

    <div class="panel panel-primary">
        <div class="panel-heading">List of entities</div>
        <div class="panel-body">
            <p>Here is the count of what we can find in your DB.</p>
        </div>
        <ul class="list-group" id="count"></ul>
        <div id="count-no-data" class="alert alert-danger">No data available</div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">Number of projects for each companies</div>
        <ul class="list-group" id="nbProjectsByCompany"></ul>
        <div id="nb-projects-no-data" class="alert alert-danger">No data available</div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-heading">Projects</div>
        <table class="table" >
            <tbody id="projects">
                <tr><th>Project Name</th><th>Customer</th><th>Company</th></tr>
            </tbody>
        </table>
        <div id="projects-no-data" class="alert alert-danger">No data available</div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
    $.ajax({
        crossOrigin: true,
        url: './api/counts',
        success: function (data) {
            var ul = document.getElementById("count");
            if (data) {
                $("#count-no-data").remove();
                var entities = data.split("\n");
                for (var i in entities) {
                    if (entities[i] != "") {
                        var entityInfo = entities[i].split(":");
                        var entityName = entityInfo[0];
                        var entityCount = entityInfo[1];
                        var li = createElement("li", {"class": "list-group-item"});
                        li.appendChild(createElement("span", undefined, entityName));
                        li.appendChild(createElement("span", {"class": "badge"}, entityCount));
                        ul.appendChild(li);

                    }
                }
            } else {
                ul.appendChild(createElement("div", {"class": "alert alert-danger"}, "No data!"));
            }
        }
    });

    $.ajax({
        crossOrigin: true,
        url: './api/nb-projects-by-company',
        success: function (data) {
            var ul = document.getElementById("nbProjectsByCompany");
            if (data) {
                $("#nb-projects-no-data").remove();
                var entities = data.split("\n");
                for (var i in entities) {
                    if (entities[i] != "") {
                        var entityInfo = entities[i].split(":");
                        var entityName = entityInfo[0];
                        var entityCount = entityInfo[1];
                        var li = createElement("li", {"class": "list-group-item"});
                        li.appendChild(createElement("span", undefined, entityName));
                        li.appendChild(createElement("span", {"class": "badge"}, entityCount));
                        ul.appendChild(li);

                    }
                }
            } else {
                ul.appendChild(createElement("div", {"class": "alert alert-danger"}, "No data!"));
            }
        }
    });
    $.ajax({
        crossOrigin: true,
        url: './api/projects',
        success: function (data) {
            var table = document.getElementById("projects");
            if (data) {
                $("#projects-no-data").remove();
                var projects = JSON.parse(data);
                for(var i in projects){
                    var tr = createElement("tr");
                    tr.appendChild(createElement("td",undefined,projects[i].name));
                    tr.appendChild(createElement("td",undefined,projects[i].customer.name + " ("+projects[i].customer.businessType.name+")"));
                    tr.appendChild(createElement("td",undefined,projects[i].company.name));
                    table.appendChild(tr);
                }
            } else {
                table.appendChild(createElement("div", {"class": "alert alert-danger"}, "No data!"));
            }
        }
    });

    function createElement(tagName, attributes, content) {
        var elt = document.createElement(tagName);
        if (attributes) {
            for (var i in attributes) {
                elt.setAttribute(i, attributes[i]);
            }
        }
        if (content) {
            elt.innerHTML = content;
        }
        return elt;
    }


</script>

</body>
</html>