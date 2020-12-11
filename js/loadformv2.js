function onSelectReportType(ele){
    var form = $(ele).parent().parent();
    var label = $(form).find(".additional_msg");
    var select = $(form).find(".additional_msg_select");

    switch (ele.value) {
        case "residential":
        case "commercial":
            label.text("Decoration Type:");
            select.find('option').remove();
            select.append($("<option></option>")
                .attr("value","")
                .text("Choose the decoration type"));
            selectValues = ['Lights', 'Inflatables', 'Pumpkin_Patch', 'Egg_Hunt', 'Lights_with_music'];
            $.each(selectValues, function(index,value) {
                select.append($("<option></option>")
                    .attr("value",value)
                    .text(value));
            });
            break;
        case "charity":
            label.text("Donation Type:");
            select.find('option').remove();
            select.append($("<option></option>")
                .attr("value","")
                .text("Choose the donation type"));
            selectValues = ['Canned_Goods', 'Clothing', 'Toys', 'Books'];
            $.each(selectValues, function(index,value) {
                select.append($("<option></option>")
                    .attr("value",value)
                    .text(value));
            });
            break;
        default:
            $(form).find(".additional_msg_div").css("visibility", "hidden");
            return;
    }
    $(form).find(".additional_msg_div").css("visibility", "visible");
}

function queryReport(event) {
    event.preventDefault(); // stop form from submitting normally

    var a = $("#query_report_form").serializeArray();
    a.push({ name: "tab_id", value: "1" });
    a = a.filter(function(item){return item.value != '';});
    $.ajax({
        url: 'HttpServlet',
        type: 'POST',
        data: a,
        success: function(reports) {
            mapInitialization(reports);
        },
        error: function(xhr, status, error) {
            alert("Status: " + status + "\nError: " + error);
        }
    });
}

function createReport(event) {
    event.preventDefault();
    var a = $("#create_report_form").serializeArray();
    a.push({ name: "tab_id", value: "0" }, {name: "longitude", value: place.geometry.location.lng().toString()},
        {name: "latitude", value: place.geometry.location.lat().toString()});
    a = a.filter(function(item){return item.value != '';});
    $.ajax({
        url: 'HttpServlet',
        type: 'POST',
        data: a,
        success: function() {
            console.log("success a: ", a);
            initialization();// Question 4: Call initialization function to reload the map content and show new marker
            alert("the report is successfully submitted!"); // Question 4: Alert on successful submission
            console.log(place.geometry.location.lng(), place.geometry.location.lat());
            map.setCenter(place.geometry.location.lng(), place.geometry.location.lat(), 11); // Question 4: Set the longitude and
            // latitude values to the place you selected
            document.getElementById("create_report_form").reset() // Qestion 4: Reset function
        },
        error: function(xhr, status, error) {
            alert("Status: " + status + "\nError: " + error);
        }
    });
}

$("#query_report_form").on("submit",queryReport);
$("#report_submit_btn").on("click",createReport);