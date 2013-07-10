CKEDITOR.dialog.add( 'formswidgetDialog', function ( editor ) {
    var items = [];
    $.ajax({
        url: '/admin/forms.json',
        type: 'GET',
        async: false,
        success: function(resp){
            items = [$.map(resp, function(obj, idx) {
                return [obj.title, obj.id]
            })]
        }
    });

    return {
        title: 'Insert form',
        minWidth: 400,
        minHeight: 70,

        contents: [
            {
                id: 'tab-select',
                label: 'Select form',
                elements: [
                    {
                        type: 'select',
                        id: 'form_id',
                        label: 'Select a form to insert',
                        items: items
                    }
                ]
            }
        ],

        onOk: function() {
            var dialog = this;
            var form = editor.document.createElement('form');

            var select = dialog.getContentElement('tab-select', 'form_id');
            var input = select.getInputElement().$;

            form.setAttribute('data-form-id', dialog.getValueOf('tab-select', 'form_id'));
            form.setAttribute('style', 'border: 1px dotted #990000');

            form.appendText( 'FORM: ' + input.options[ input.selectedIndex ].text );

            editor.insertElement(form);
        }
    };
});