import * as FilePond from 'filepond';
import 'filepond/dist/filepond.min.css';
import 'filepond-plugin-image-preview/dist/filepond-plugin-image-preview.css';

// Add plugins
import FilePondPluginImagePreview from 'filepond-plugin-image-preview';
import FilePondPluginFileValidateSize from 'filepond-plugin-file-validate-size';
import FilePondPluginFileValidateType from 'filepond-plugin-file-validate-type';

FilePond.registerPlugin(
  FilePondPluginImagePreview,
  FilePondPluginFileValidateSize,
  FilePondPluginFileValidateType
);

// Use for all input fields with "file"
document.addEventListener('DOMContentLoaded', () => {
  const imageInput = document.querySelector('#bulletin_image');
  FilePond.create(imageInput, {
    maxFileSize: '5MB',
    acceptedFileTypes: ['image/jpeg', 'image/png'],
    server: '/rails/active_storage/direct_uploads'
  });
});
