<template>
  <div :id="id" :value="defaultValue" class="ck"></div>
</template>

<script>
import axios from "axios";
let _editor;
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
    var params = window.navigation.currentEntry.url.split("&");
    var token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjJkOTZjMzliNTM4YTExOTY0YzM1MjEyNTI3ZjBjMjIzMWNlNTA5NmVjN2QzM2I5NTAyMGQwODEwNzQ5ZTUzOWY0YWY5NzNiMjkwMzJiYTQ2In0.eyJhdWQiOiI0IiwianRpIjoiMmQ5NmMzOWI1MzhhMTE5NjRjMzUyMTI1MjdmMGMyMjMxY2U1MDk2ZWM3ZDMzYjk1MDIwZDA4MTA3NDllNTM5ZjRhZjk3M2IyOTAzMmJhNDYiLCJpYXQiOjE2NzY1OTI3ODMsIm5iZiI6MTY3NjU5Mjc4MywiZXhwIjoxNzA4MTI4NzgzLCJzdWIiOiI0ZWQ4OTdiYS1jZjJmLTRjODYtYjZhOS02ZWIzNjllNmVhM2YiLCJzY29wZXMiOltdLCJjb21wIjoiMWQ0Yjk4ZGUtYzY1ZS00ZjBhLWEwMjktODM3YjE2MmEzMTYzIn0.n3N1lzR1Gl6cA3xFFQjBUUyQh539TFCMRrsk2pQbQikTSmPKrKDI8REIYiMwUIRuJGVN4uJ0R_Al3acHa32r_JXcW8oGfVK5rbZSlYNfSvexDpeDn1QwUGPWavh8BibW0G9cfdU59RDZqIiKqwwGBCaq4qx4P70rXtrg2H9QfxHt5HJ-hDcXo3jmCbCGO7j4WWLz4SZ1QBoEZZTwL_QeS3q9O9o3OhoUKM_LcSIRtW4YVVO8xbQaZuN7Mp9sZa8q6o5zuu3OYF0DdGoP16MM2b2sfAjspsFgiCss0QfUgqTsbzc_-tRNoDJVSU1NcPfTz-0MY77nY9CYPO2OGlF_nW2WEvz8xQuFpXxjyxhxF8uLigteBdP7pbXLe4TyRFilIg9Pkw6xDLoxkX-786_vFQVIUao6S0mZz2tn0IwlPoOSN_Cn4qHTG0NFMWC688PP85i5b5cFdfS1Iw54NHb2KWZ8o7reJbQ9RuFB2-ZbnyoNqWTpnvdom0Nr3XGt2v3O0F5y_wLwGsfvoZF9Ea9N6s05xZXgprIh_rC8-Lu0rNuHoLGHHg6XOdpVZ2LeK5ZGFTXNj13MOM3Wgv_vqJJQAnSBGU8WBkKnMD_Kpon5NvC__LQ4zR3-JORurqvPgxANw26NzJrPEm_Jomm0yYDLbAnYeYgEfhJePR6Kalf4Nyw";
    if (params) {
      // var params2 = params[0].split("?");
      // var params3 = params[1].split("token=");
      // var params4 = params2[1].split("url=data/");
      // console.log('2', params2)
      const config = { headers: { Authorization: `Bearer ${token}` } };
      axios
        .get(
          "https://app.api.elsoft.id/admin/api/v1/documentgroup/cd9165dd-d809-48f2-847b-4e3ca53afabc?field=view2",
          config
        )
        .then(function(res) {
          if (res.data.Content) editor.setData(res.data.Content);
        });
    }
    // editor.ui.focusTracker.on("change:isFocused", (evt, name, isFocused) => {
    //   if (!isFocused) {
    //     // console.log(editor.getData());
    //   }
    // });
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
</style>
