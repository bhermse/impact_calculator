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
});
