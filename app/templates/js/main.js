$(document).ready(function() {
    $("#text_modal").click(function() {
        $('.ui.modal').modal('show');
    });

    $("#sent_analysis").click(function() {
        var text = $("#sentiment_text").val();
        if (text.length < 1) {
            alert("Please paste/write something.")
        }
        else if (text.length > 2500) {
            alert("Please reduce text to less than 2500 characters.")
        }
        else {
            $.ajax({
            url: "/sentiment",
            type: "POST",
            contentType: 'application/json',
            data: JSON.stringify({"input": text}),
            dataType: 'json',
            success: function(response, status, jqXHR) {
                var result = response
                window.location.href = "sentiment/"+result.output
            },
        });
    }
    $('.ui.modal').modal('hide');
    });
});