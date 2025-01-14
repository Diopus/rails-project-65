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

function adjustAspectRatio(pond) {
  const width = window.innerWidth;
  const hasFile = pond.getFiles().length > 0;

  if (hasFile) {
    pond.setOptions({
      stylePanelAspectRatio: width > 768 ? '0.3' : '0.5',
    });
  } else {
    pond.setOptions({
      stylePanelAspectRatio: '0.1',
    });
  }
}

function loadFilePond() {
  const imageInput = document.querySelector('#bulletin_image');
  if (!imageInput) {
    return;
  }
 
  const labelIdle = imageInput.dataset.labelIdle || 'Drag image or choose file';
  const fileUrl = imageInput.dataset.fileUrl;

  const pond = FilePond.create(imageInput, {
    credits: {},
    storeAsFile: true,
    allowReorder: true,
    maxFileSize: '5MB',
    acceptedFileTypes: ['image/jpeg', 'image/png'],
    stylePanelLayout: 'integrated',
    stylePanelAspectRatio: '0.1',
    labelIdle,
  });

  if (fileUrl) {
    fetch(fileUrl, { method: "HEAD" })
      .then((response) => {
        if (response.ok) {
          pond.addFile(fileUrl).catch((error) =>
            console.error("Error loading file to FilePond:", error)
          );
        } else {
          console.warn("File URL is no longer valid:", fileUrl);
        }
      })
      .catch((error) => console.error("Error checking file URL:", error));
  }

  pond.on('addfile', () => adjustAspectRatio(pond));
  pond.on('removefile', () => adjustAspectRatio(pond));

  window.addEventListener('resize', () => adjustAspectRatio(pond));
}
