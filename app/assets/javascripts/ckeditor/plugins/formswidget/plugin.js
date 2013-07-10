(function() {
    var pluginName = 'formswidget';

    CKEDITOR.plugins.add( pluginName, {
        icons: 'form',
        init: function( editor ) {
            CKEDITOR.dialog.add( 'formswidgetDialog', this.path + 'dialogs/formswidget.js' );

            editor.addCommand('formswidgetDialog', new CKEDITOR.dialogCommand('formswidgetDialog') );

            editor.ui.addButton( 'form', {
                label: 'Insert form',
                command: 'formswidgetDialog',
                toolbar: 'insert'
            });
        }
    });
})();
