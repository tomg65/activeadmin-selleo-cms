function generateUUID(){
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random()*16)%16 | 0;
        d = Math.floor(d/16);
        return (c=='x' ? r : (r&0x7|0x8)).toString(16);
    });
    return uuid;
};

function submitAnswer(form_id, input, value){
    $.post('/form_answers', {
        form_answer: {
            form_uuid: localStorage[form_id],
            dom_id: $(input).attr('id'),
            form_id: $(input).closest('form').data('form-id'),
            form_question_id: $(input).data('form-question-id'),
            value: value
        }
    })
}

function setupCmsForm(form_id) {
    $('#'+form_id+' .required fieldset [type="radio"]:first,[type="checkbox"]:first').attr('required','true');
    $('#'+form_id).validate();

    if (localStorage[form_id] == undefined) {
        localStorage[form_id] = generateUUID();
    }

    $.get('/form_answers.json', {
       form_uuid: localStorage[form_id]
    }).success(function(resp){
        $.each(resp, function(){
            if (this["value"] != null) {
                var form_elem = $('#'+this["dom_id"]);
                if ( ($(form_elem).attr('type') == 'checkbox') || ($(form_elem).attr('type') == 'radio') ) {
                    $(form_elem).attr('checked', true);
                } else if ($(form_elem).attr('type') == 'file') {
//                 ??
                } else {
                    $(form_elem).val(this["value"]);
                }
            }
        })
    });

    $('#' + form_id + ' input, textarea').change(function(){
      if ($(this).attr('type') == 'file') {
//            ??
      } else if ( ($(this).attr('type') == 'checkbox') || ($(this).attr('type') == 'radio') ) {
          submitAnswer(form_id, this, $(this).is(':checked'))
      } else {
          submitAnswer(form_id, this, $(this).val())
    }});
}