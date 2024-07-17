$(document).ready(function() {
    $('#loginButton').on('click', function() {
        var username = $('#username').val();
        var password = $('#password').val();
        
        $.ajax({
            type: 'POST',
            url: 'api/login/check/credientials',
            data: {
                userName: username,
                password: password
            },
            success: function(response) {
                var data = JSON.parse(response);
                if(data.status === 'success') {
                    window.location.href = 'dashboard.html'; // or the appropriate page
                } else {
                    $('#msg').text(data.message);
                }
            },
            error: function(xhr, status, error) {
                $('#msg').text('An error occurred. Please try again.');
            }
        });
    });
});
