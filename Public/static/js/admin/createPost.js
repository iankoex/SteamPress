$(function () {
  var spEditor = editormd("sp-editormd", {
    width: "100%",
    height: "90%",
    path: "https://cdn.jsdelivr.net/npm/editor.md@1.5.0/lib/",
    pluginPath: "https://cdn.jsdelivr.net/npm/editor.md@1.5.0/plugins/",
    placeholder: "Your text here....",
    autoLoadModules: true,
    autoFocus: true,
    autoCloseTags: true,
    autoCloseBrackets: true,
    theme: "default",
    previewTheme: "default",
    editorTheme: "xq-light",
    markdown: "",
    codeFold: true,
    syncScrolling: true,
    saveHTMLToTextarea: true,
    searchReplace: true,
    lineWrapping: true,
    autoCloseBrackets: true,
    showTrailingSpace: true,
    matchBrackets: true,
    indentWithTabs: true,
    styleSelectedText: true,
    matchWordHighlight: true,
    styleActiveLine: true,
    watch: false,
    htmlDecode: "style,script,iframe|on*",
    toolbar: true,
    previewCodeHighlight: true,
    sequenceDiagram: true,
    dialogLockScreen: true,
    dialogShowMask: false,
    dialogDraggable: false,
    dialogMaskOpacity: 0.4,
    dialogMaskBgColor: "#000",
    imageUpload: true,
    imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
    imageUploadURL: "../../uploadImages",
    fontSize: "12px",
    onload: function () {
      // this.fullscreen();
    },
    toolbarIcons: function () {
      return [
        "undo",
        "redo",
        "|",
        "bold",
        "del",
        "italic",
        "quote",
        "ucwords",
        "uppercase",
        "lowercase",
        "|",
        "h1",
        "h2",
        "h3",
        "h4",
        "h5",
        "h6",
        "|",
        "list-ul",
        "list-ol",
        "hr",
        "|",
        "link",
        "reference-link",
        "image",
        "code",
        "preformatted-text",
        "code-block",
        "table",
        "datetime",
        "html-entities",
        "pagebreak",
        "||",
        "goto-line",
        "watch",
        "preview",
        "fullscreen",
        "clear",
        "search",
      ];
    },
    lang: {
      name: "en",
      description: "Open source online Markdown editor.",
      tocTitle: "Table of Contents",
      toolbar: {
        undo: "Undo(Ctrl+Z)",
        redo: "Redo(Ctrl+Y)",
        bold: "Bold",
        del: "Strikethrough",
        italic: "Italic",
        quote: "Block quote",
        ucwords: "Words first letter convert to uppercase",
        uppercase: "Selection text convert to uppercase",
        lowercase: "Selection text convert to lowercase",
        h1: "Heading 1",
        h2: "Heading 2",
        h3: "Heading 3",
        h4: "Heading 4",
        h5: "Heading 5",
        h6: "Heading 6",
        "list-ul": "Unordered list",
        "list-ol": "Ordered list",
        hr: "Horizontal rule",
        link: "Link",
        "reference-link": "Reference link",
        image: "Image",
        code: "Code inline",
        "preformatted-text": "Preformatted text / Code block (Tab indent)",
        "code-block": "Code block (Multi-languages)",
        table: "Tables",
        datetime: "Datetime",
        emoji: "Emoji",
        "html-entities": "HTML Entities",
        pagebreak: "Page break",
        watch: "Unwatch",
        unwatch: "Watch",
        preview: "HTML Preview (Press Shift + ESC exit)",
        fullscreen: "Fullscreen (Press ESC exit)",
        clear: "Clear",
        search: "Search",
        help: "Help",
        info: "About " + editormd.title,
      },
      buttons: {
        enter: "Enter",
        cancel: "Cancel",
        close: "Close",
      },
      dialog: {
        link: {
          title: "Link",
          url: "Address",
          urlTitle: "Title",
          urlEmpty: "Error: Please fill in the link address.",
        },
        referenceLink: {
          title: "Reference link",
          name: "Name",
          url: "Address",
          urlId: "ID",
          urlTitle: "Title",
          nameEmpty: "Error: Reference name can't be empty.",
          idEmpty: "Error: Please fill in reference link id.",
          urlEmpty: "Error: Please fill in reference link url address.",
        },
        image: {
          title: "Image",
          url: "Address",
          link: "Link",
          alt: "Title",
          uploadButton: "Upload",
          imageURLEmpty: "Error: picture url address can't be empty.",
          uploadFileEmpty: "Error: upload pictures cannot be empty!",
          formatNotAllowed:
            "Error: only allows to upload pictures file, upload allowed image file format:",
        },
        preformattedText: {
          title: "Preformatted text / Codes",
          emptyAlert:
            "Error: Please fill in the Preformatted text or content of the codes.",
        },
        codeBlock: {
          title: "Code block",
          selectLabel: "Languages: ",
          selectDefaultText: "select a code language...",
          otherLanguage: "Other languages",
          unselectedLanguageAlert: "Error: Please select the code language.",
          codeEmptyAlert: "Error: Please fill in the code content.",
        },
        htmlEntities: {
          title: "HTML Entities",
        },
        help: {
          title: "Help",
        },
      },
    },
  });
});

$("#title").on("input", function (e) {
  if (allowEditingOfslugURL) {
    var title = $("#title").val();
    var slugURL = slugify(title);
    $("#slugURL").val(slugURL);
    if (editingPost && published) {
      if (title != originalTitle) {
        $("#blog-post-edit-title-warning").fadeIn();
      } else {
        $("#blog-post-edit-title-warning").fadeOut();
      }
    }
  }
});

$(function () {
  if ($("#edit-post-data").length) {
    editingPost = true;
    originalslugURL = $("#edit-post-data").data("originalslugURL");
    originalTitle = $("#edit-post-data").data("originalTitle");
    published = $("#edit-post-data").data("publishedPost");
  }
});

function slugify(text) {
  return punycode
    .toASCII(text)
    .toString()
    .toLowerCase()
    .replace(/\s+/g, "-") // Replace spaces with -
    .replace(/[^\w\-]+/g, "") // Remove all non-word chars
    .replace(/\-\-+/g, "-") // Replace multiple - with single -
    .replace(/^-+/, "") // Trim - from start of text
    .replace(/-+$/, ""); // Trim - from end of text
}

function keepPostOriginalslugURL() {
  allowEditingOfslugURL = false;
  $("#slugURL").val(originalslugURL);
  $("#blog-post-edit-title-warning").alert("close");
}
