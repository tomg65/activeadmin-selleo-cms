CKEDITOR.on( 'instanceCreated', function( event ) {
    var editor = event.editor,
        element = editor.element;

    if ( element.getAttribute('data-toolbar') == 'Save' ) {
        editor.on( 'configLoaded', function() {
            editor.config.plugins = 'toolbar,floatingspace';
            editor.config.extraPlugins = 'inlinesave';
        });
    } else if ( element.getAttribute('data-toolbar') == 'Header' ) {
        editor.on( 'configLoaded', function() {
            editor.config.plugins = 'toolbar,floatingspace,basicstyles';
            editor.config.extraPlugins = 'inlinesave';
        });
    } else if ( element.getAttribute('data-toolbar') == 'Link' ) {
        editor.on( 'configLoaded', function() {
            editor.config.plugins = 'toolbar,floatingspace,basicstyles,link';
            editor.config.extraPlugins = 'inlinesave';
        });
    } else if ( element.getAttribute('data-toolbar') == 'Lite' ) {
        editor.on( 'configLoaded', function() {
            editor.config.plugins = "toolbar,floatingspace,basicstyles,stylescombo";
        });
    } else {
        editor.on( 'configLoaded', function() {
            editor.config.plugins = "dialogui,dialog,about,a11yhelp,dialogadvtab,basicstyles,bidi,blockquote,clipboard,button,panelbutton,panel,floatpanel,colorbutton,colordialog,templates,menu,contextmenu,div,resize,toolbar,elementspath,list,indent,enterkey,entities,popup,filebrowser,find,fakeobjects,flash,floatingspace,listblock,richcombo,font,format,htmlwriter,horizontalrule,iframe,wysiwygarea,image,smiley,justify,link,liststyle,magicline,maximize,newpage,pagebreak,pastetext,pastefromword,preview,print,removeformat,save,selectall,showblocks,showborders,sourcearea,specialchar,menubutton,scayt,stylescombo,tab,table,tabletools,undo,wsc";
        });
    }

//    editor.config.toolbarGroups = [
//        { name: 'editing',		groups: [ 'document', 'basicstyles', 'stylescombo', 'link' ] }
//    ];

});

// plugins "dialogui,dialog,about,a11yhelp,dialogadvtab,basicstyles,bidi,blockquote,clipboard,button,panelbutton,panel,floatpanel,colorbutton,colordialog,templates,menu,contextmenu,div,resize,toolbar,elementspath,list,indent,enterkey,entities,popup,filebrowser,find,fakeobjects,flash,floatingspace,listblock,richcombo,font,forms,format,htmlwriter,horizontalrule,iframe,wysiwygarea,image,smiley,justify,link,liststyle,magicline,maximize,newpage,pagebreak,pastetext,pastefromword,preview,print,removeformat,save,selectall,showblocks,showborders,sourcearea,specialchar,menubutton,scayt,stylescombo,tab,table,tabletools,undo,wsc"
