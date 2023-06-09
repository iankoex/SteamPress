$(function () {
  var mdView = editormd.markdownToHTML("mdView", {
    htmlDecode: "style,script,iframe",
    tocm: true,
    tocContainer: "#custom-toc-container",
    taskList: true,
  });
});
