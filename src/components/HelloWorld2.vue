<template>
  <div>
    <div class="container">
      <textarea id="myTextarea"></textarea>
      <button @click="submit()">Submit Tiny Editor</button>
      <pre id="value"></pre>
    </div>
  </div>
</template>

<script>
import axios from "axios";
let _editor;
let postUrl;
let tokenUrl;
export default {
  props: {
    value: String,
    defaultValue: null
  },
  data() {
    return {
      id: "randomstring"
    };
  },
  mounted() {
    renderCKEditor(this.id, editor => {
      _editor = editor;
      if (this.defaultValue) editor.setData(this.defaultValue);
      editor.ui.focusTracker.on("change:isFocused", (evt, name, isFocused) => {
        if (!isFocused) {
          this.$emit("input", editor.getData());
        }
      });
    });
  },
  methods: {
    async submit() {
      // console.log('333', tinyMCE.activeEditor.getContent())
      return
      let data = _editor.getData();
      try {
        await axios.post(`https://app.api.elsoft.id/admin/api/v1/` + postUrl, { Content: data }, tokenUrl);
        setTimeout(() => {
          window.close();
        }, 1000);
      } catch (err) {
        console.log(err);
      }
    },
    getValue() {
      if (_editor) return _editor.getData();
    }
  }
};

function renderCKEditor(id, cb) {
  tinymce.init({
    selector: '#myTextarea',
    width: 1000,
    height: 300,
    plugins: [
      'advlist', 'autolink', 'link', 'image', 'lists', 'charmap', 'preview', 'anchor', 'pagebreak',
      'searchreplace', 'wordcount', 'visualblocks', 'visualchars', 'code', 'fullscreen', 'insertdatetime',
      'media', 'table', 'emoticons', 'template', 'help'
    ],
    toolbar: 'undo redo | styles | bold italic | alignleft aligncenter alignright alignjustify | ' +
      'bullist numlist outdent indent | link image | print preview media fullscreen | ' +
      'forecolor backcolor emoticons | help',
    menu: {
      favs: { title: 'My Favorites', items: 'code visualaid | searchreplace | emoticons' }
    },
    menubar: 'favs file edit view insert format tools table help',
    content_css: 'css/content.css'
  })
}
</script>

<style>
.ck-editor {
  padding: 8px !important;
}
.ck-content {
  padding: 30px !important;
}
.ck-editor__editable_inline {
  padding: 30px !important;
}
.ck-restricted-editing_mode_standard {
  padding: 30px !important;
}
.container {
  width: 1000px;
  margin: 20px auto;
}
.ck-editor__editable[role="textbox"] {
  /* editing area */
  min-height: 200px;
}
.ck-content .image {
  /* block images */
  max-width: 80%;
  margin: 20px auto;
}
.container {
  width: 1000px;
  margin: 20px auto;
}
</style>
