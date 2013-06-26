/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

/**
 * @fileOverview Save plugin.
 */

(function() {
	var saveCmd = {
		exec: function( editor ) {
          if ( editor.element.getAttribute('data-id') != null ) {
              $.ajax({
                  url: '/admin/sections/' + editor.element.getAttribute('data-id') + '.js',
                  type: 'PUT',
                  data: {
                      'section': {
                          'body': editor.getData()
                      }
                  }
              });
          } else {
              alert('Section id not specified!');
          }
		}
	};

	var pluginName = 'inlinesave';

	// Register a plugin named "save".
	CKEDITOR.plugins.add( pluginName, {
		icons: 'save', // %REMOVE_LINE_CORE%
		init: function( editor ) {

			editor.addCommand( pluginName, saveCmd );

			editor.ui.addButton && editor.ui.addButton( 'Save', {
				label: 'Save',
				command: pluginName,
				toolbar: 'document'
			});
		}
	});
})();
