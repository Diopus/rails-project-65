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

document.addEventListener("turbo:load", loadFilePond);

function loadFilePond() {
  const imageInput = document.querySelector('#bulletin_image');

  const pond = FilePond.create(imageInput, {
    credits: {},
    storeAsFile: true,
    allowReorder: true,
    maxFileSize: '5MB',
    acceptedFileTypes: ['image/jpeg', 'image/png'],
    stylePanelLayout: 'integrated',
    stylePanelAspectRatio: '0.1',
    labelIdle: `
      <div class="text-center">
        <span class="text-muted">Перетащите изображение или <span class="text-primary">выберите файл</span></span>
        <br>
        <i class="bi bi-cloud-arrow-up text-primary" style="font-size: 2rem;"></i>
      </div>`,
  });
}
