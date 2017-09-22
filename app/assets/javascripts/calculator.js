var calculate_cost = function() {};

$(function () {
    $('a.scroll-down').on('click', function (e) {
        e.preventDefault();
        $('html, body').animate({scrollTop: $($(this).attr('href')).offset().top}, 500, 'linear');
    });

    $('#electricitySlider, #gasolineSlider').slider({
        formatter: function (value) {
            return 'Current value: ' + value;
        }
    });

    $('#electricity').on('slide', function (slideEvt) {
        $("#electricityCurrentSliderValLabel").text(slideEvt.value);
        var gas = $('#gasolineSlider').slider('getValue');
        $('.cost').html(window.calculate_cost(slideEvt.value, gas));
    });

    $('#gasoline').on('slide', function (slideEvt) {
        $("#gasolineCurrentSliderValLabel").text(slideEvt.value);
        var elec = $('#electricitySlider').slider('getValue');
        $('.cost').html(window.calculate_cost(elec, slideEvt.value));
    });

    $("#calculate_button, #calculate").click(function() {
        var form_values = $('#basic_questions_form').serialize();
        $('div.spending.explanation').hide();

        $.ajax({
            beforeSend: function() {$('.calculating').fadeIn('slow');},
            url: '/calculator/calculate',
            type: "POST",
            dataType: "script",
            data: form_values
        })
    })
});
