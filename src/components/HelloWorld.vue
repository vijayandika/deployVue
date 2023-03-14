<template>
  <div>
    <div class="container">
      <div :id="id" :value="defaultValue" class="ck"></div>
      <div id="editor"></div>
      <button @click="submit()">Submit</button>
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
  CKEDITOR.ClassicEditor.create(document.getElementById(id), {
    toolbar: {
      items: [
        "exportPDF",
        "exportWord",
        "|",
        "findAndReplace",
        "selectAll",
        "|",
        "heading",
        "|",
        "bold",
        "italic",
        "strikethrough",
        "underline",
        "code",
        "subscript",
        "superscript",
        "removeFormat",
        "|",
        "bulletedList",
        "numberedList",
        "todoList",
        "|",
        "outdent",
        "indent",
        "|",
        "undo",
        "redo",
        "-",
        "fontSize",
        "fontFamily",
        "fontColor",
        "fontBackgroundColor",
        "highlight",
        "|",
        "alignment",
        "|",
        "link",
        "insertImage",
        "blockQuote",
        "insertTable",
        "mediaEmbed",
        "codeBlock",
        "htmlEmbed",
        "|",
        "specialCharacters",
        "horizontalLine",
        "pageBreak",
        "|",
        "textPartLanguage",
        "|",
        "sourceEditing"
      ],
      shouldNotGroupWhenFull: true
    },
    list: {
      properties: {
        styles: true,
        startIndex: true,
        reversed: true
      }
    },
    heading: {
      options: [
        {
          model: "paragraph",
          title: "Paragraph",
          class: "ck-heading_paragraph"
        },
        {
          model: "heading1",
          view: "h1",
          title: "Heading 1",
          class: "ck-heading_heading1"
        },
        {
          model: "heading2",
          view: "h2",
          title: "Heading 2",
          class: "ck-heading_heading2"
        },
        {
          model: "heading3",
          view: "h3",
          title: "Heading 3",
          class: "ck-heading_heading3"
        },
        {
          model: "heading4",
          view: "h4",
          title: "Heading 4",
          class: "ck-heading_heading4"
        },
        {
          model: "heading5",
          view: "h5",
          title: "Heading 5",
          class: "ck-heading_heading5"
        },
        {
          model: "heading6",
          view: "h6",
          title: "Heading 6",
          class: "ck-heading_heading6"
        }
      ]
    },
    placeholder: "Please typing here!",
    fontFamily: {
      options: [
        "default",
        "Arial, Helvetica, sans-serif",
        "Courier New, Courier, monospace",
        "Georgia, serif",
        "Lucida Sans Unicode, Lucida Grande, sans-serif",
        "Tahoma, Geneva, sans-serif",
        "Times New Roman, Times, serif",
        "Trebuchet MS, Helvetica, sans-serif",
        "Verdana, Geneva, sans-serif"
      ],
      supportAllValues: true
    },
    fontSize: {
      options: [10, 12, 14, "default", 18, 20, 22],
      supportAllValues: true
    },
    htmlSupport: {
      allow: [
        {
          name: /.*/,
          attributes: true,
          classes: true,
          styles: true
        }
      ]
    },
    htmlEmbed: {
      showPreviews: true
    },
    link: {
      decorators: {
        addTargetToExternalLinks: true,
        defaultProtocol: "https://",
        toggleDownloadable: {
          mode: "manual",
          label: "Downloadable",
          attributes: {
            download: "file"
          }
        }
      }
    },
    mention: {
      feeds: [
        {
          marker: "@",
          feed: [
            "@apple",
            "@bears",
            "@brownie",
            "@cake",
            "@cake",
            "@candy",
            "@canes",
            "@chocolate",
            "@cookie",
            "@cotton",
            "@cream",
            "@cupcake",
            "@danish",
            "@donut",
            "@dragée",
            "@fruitcake",
            "@gingerbread",
            "@gummi",
            "@ice",
            "@jelly-o",
            "@liquorice",
            "@macaroon",
            "@marzipan",
            "@oat",
            "@pie",
            "@plum",
            "@pudding",
            "@sesame",
            "@snaps",
            "@soufflé",
            "@sugar",
            "@sweet",
            "@topping",
            "@wafer"
          ],
          minimumCharacters: 1
        }
      ]
    },
    removePlugins: [
      "CKBox",
      "CKFinder",
      "EasyImage",
      "RealTimeCollaborativeComments",
      "RealTimeCollaborativeTrackChanges",
      "RealTimeCollaborativeRevisionHistory",
      "PresenceList",
      "Comments",
      "TrackChanges",
      "TrackChangesData",
      "RevisionHistory",
      "Pagination",
      "WProofreader",
      "MathType"
    ]
  }).then(cb => {
    let params = window.navigation.currentEntry.url.split("&");
    if (params) {
      let params2 = params[0].split("?");
      let params3 = params[1].split("token=");
      let params4 = params2[1].split("url=");
      params4[1] = params4[1].replace("%2F", "/");
      params4[1] = params4[1].replace("%3F", "?");
      params4[1] = params4[1].replace("%3D", "=");
      const config = { headers: { Authorization: `Bearer ${params3[1]}` } };
      tokenUrl = config;
      axios
        .get(`https://app.api.elsoft.id/admin/api/v1/${params4[1]}`, config)
        .then(function(res) {
          if (res.data.Content) {
            cb.setData(res.data.Content);
            postUrl = res.data.Post;
          }
          _editor = cb;
        });
    }
    cb.ui.focusTracker.on("change:isFocused", (evt, name, isFocused) => {
      if (!isFocused) {
        console.log(cb.getData());
      }
    });
  });
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
</style>
