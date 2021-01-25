$(document).ready(function() {
    $("#text_modal").click(function() {
        $('.ui.modal').modal('show');
    })

    $("#sent_analysis").click(function() {
        var text = $("#sentiment_text").val();
        $.ajax({
            url: "/sentiment",
            type: "POST",
            contentType: 'application/json',
            data: JSON.stringify({"message": text}),
            dataType: 'json'
        })
        $('.ui.modal').modal('hide');
    })
    
});