$(function () {
    $('a.scroll-down').on('click', function (e) {
        e.preventDefault();
        $('html, body').animate({scrollTop: $($(this).attr('href')).offset().top}, 500, 'linear');
    });
    $('#electricity, #gasoline').slider({
        formatter: function (value) {
            return 'Current value: ' + value;
        }
    });
    $('#electricity').on('slide', function (slideEvt) {
        $("#electricityCurrentSliderValLabel").text(slideEvt.value);
    });
    $('#gasoline').on('slide', function (slideEvt) {
        $("#gasolineCurrentSliderValLabel").text(slideEvt.value);
    });
    $("#calculate_button").click(function() {
        var form_values = $('#basic_questions_form').serialize();
        $.ajax({
            url: '/calculator/calculate',
            type: "POST",
            dataType: "JSON",
            data: form_values
        })
    })
});
