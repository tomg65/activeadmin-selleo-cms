var slug = function(str) {
    str = str.replace(/^\s+|\s+$/g, ''); // trim
    str = str.toLowerCase();

    // remove accents, swap ñ for n, etc
    var from = "ąãàáäâęẽèéëêìíïîõòóöôùúüûńñçćżźśł·/_,:;";
    var to   = "aaaaaaeeeeeeiiiiooooouuuunncczzsl------";
    for (var i=0, l=from.length ; i<l ; i++) {
        str = str.replace(new RegExp(from.charAt(i), 'g'), to.charAt(i));
    }

    str = str.replace(/[^a-z0-9 -]/g, '') // remove invalid chars
        .replace(/\s+/g, '-') // collapse whitespace and replace by -
        .replace(/-+/g, '-'); // collapse dashes

    return str;
};

function fileManager(url){
    $('#file-manager').html('').load(url, function() {
        $(this).dialog("option", "position", ['center', 'center'] );
    }).dialog('open');
}

function updateCrop(coords) {
    $('#image_crop_x').val(coords.x);
    $('#image_crop_y').val(coords.y);
    $('#image_crop_w').val(coords.w);
    $('#image_crop_h').val(coords.h);
}

function cropImage(asset_id, width, height) {
    $('#file-manager').html('').load('/admin/images/'+asset_id+'/crop.js', function() {
        $(this).dialog("option", "position", ['center', 'center'] );
        $(this).find('img').Jcrop({
            minSize: [ width, height ],
            aspectRatio: width/height,
            allowMove: true,
            allowResize: true,
            onChange: updateCrop,
            onSelect: updateCrop,
            setSelect: [0, 0, width, height]
        });
    }).dialog('open');
}

function editPage(page_id) {
    $('#file-manager').html('').load('/admin/pages/'+page_id+'/edit.js', function() {
        $(this).dialog("option", "position", ['center', 'center'] );
    }).dialog('open');
}

function delete_asset(asset_id) {
    if(confirm('Are you sure?')) {
        $.ajax({
            url: '/admin/assets/' + asset_id + '.js',
            type: 'DELETE'
        }).error(function(){
            alert('An error occured while trying to delete the asset');
        });
    }
}

function edit_attachment(attachment_id) {
    fileManager('/admin/attachments/' + attachment_id + '/edit.js');
}

function edit_image(image_id) {
    fileManager('/admin/images/' + image_id + '/edit.js');
}

function edit_related_item(related_item_id) {
    fileManager('/admin/related_items/' + related_item_id + '/edit.js');
}

function delete_related_item(related_item_id) {
    if(confirm('Are you sure?')) {
        $.ajax({
            url: '/admin/related_items/' + related_item_id + '.js',
            type: 'DELETE'
        }).error(function(){
                alert('An error occured while trying to delete the related item');
            });
    }
}

function update_positions(pagesArray) {
    $.ajax({
        url: '/admin/pages/update_positions.js',
        data: { 'page_ids': pagesArray },
        type: 'PUT'
    });
}

$(function(){
    $('#translations.index input').blur(function(evt){
        $.ajax({
            url: $(evt.target).data('route') + '.js',
            type: 'PUT',
            data: { 'value': $(evt.target).val(), 'locale': $(evt.target).data('locale'), 'key': $(evt.target).data('key') }
        })
    });

    $('input[type="checkbox"][data-route]').change(function(){
        _data = {}
        _data[$(this).data('resource')] = {};
        _data[$(this).data('resource')][$(this).data('attribute')] = $(this).is(':checked');

        that = this;

        $.ajax({
            url: $(this).data('route') + '.js',
            type: 'PUT',
            data: _data
        }).success(function(){
            $(that).closest('td').effect('highlight');
        });
    });

    $(document).ready(function(){
        $('input.ui-datetimepicker').datetimepicker({
            dateFormat: 'yy-mm-dd',
            timeFormat: 'HH:mm:ss'
        });
    });

    $('i.fold').click(function(){
        var form = $(this).closest('fieldset').find('ol');
        if (form.is(':visible')){
            $(this).text('Show');
        } else {
            $(this).text('Hide');
        }
      $(this).closest('fieldset').find('ol').toggle();
    });

    $('input[multiple]').each(function(){
        $(this).attr('name', $(this).attr('name').replace(/\[\]$/, '') );
    });

    $( ".sortable" ).sortable();
    $( ".sortable" ).disableSelection();

});

function savePage(){
    form = $('form[id*="_page_"]');
    $.ajax( {
        type: "POST",
        url: form.attr('action'),
        data: form.serialize(),
        success: function(resp) {
            $('body').effect('highlight')
        }
    } );
}