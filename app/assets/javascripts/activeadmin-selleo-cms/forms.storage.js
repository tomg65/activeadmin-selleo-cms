function setupCmsForm(form_id) {
    $('#'+form_id+' .required fieldset [type="radio"]:first,[type="checkbox"]:first').attr('required','true');
    $('#'+form_id).validate();

    $.each($('#' + form_id + ' input, textarea'), function(){
        if ( localStorage[$(this).attr('id')] != undefined ) {
            if ( ($(this).attr('type') == 'checkbox') || ($(this).attr('type') == 'radio') ) {
                $(this).attr('checked', (localStorage[$(this).attr('id')] == "true"));
            } else if ($(this).attr('type') == 'file') {
//            ??
            } else {
                $(this).val(localStorage[$(this).attr('id')]);
            }
        }
    });

    $('#' + form_id + ' input, textarea').change(function(){
        if ( ($(this).attr('type') == 'checkbox') || ($(this).attr('type') == 'radio') ) {
            localStorage[$(this).attr('id')] = $(this).is(':checked');
        } else if ($(this).attr('type') == 'file') {
//            ??
        } else {
            localStorage[$(this).attr('id')] = $(this).val();
        }
    });
}