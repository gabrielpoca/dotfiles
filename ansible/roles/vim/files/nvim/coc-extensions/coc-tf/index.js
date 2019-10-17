const { commands, workspace, languages } = require("coc.nvim");
const { Range, TextEdit } = require("vscode-languageserver-protocol");
const child_process = require("child_process");

let formatterHandler;

const fullDocumentRange = document => {
  const lastLineId = document.lineCount - 1;
  const doc = workspace.getDocument(document.uri);

  return Range.create(
    { character: 0, line: 0 },
    { character: doc.getline(lastLineId).length, line: lastLineId }
  );
};

const editProvider = {
  async provideDocumentFormattingEdits(document) {
    workspace.showMessage("1 ASDASD");

    const { stdout } = child_process.spawnSync(
      "terraform",
      ["fmt", "-write=false", "-"],
      {
        input: document.getText()
      }
    );

    return [TextEdit.replace(fullDocumentRange(document), stdout.toString())];
  }
};

function disposeHandlers() {
  if (formatterHandler) {
    formatterHandler.dispose();
  }

  formatterHandler = undefined;
}

exports.activate = context => {
  function registerFormatter() {
    disposeHandlers();

    formatterHandler = languages.registerDocumentFormatProvider(
      [
        { language: "terraform", scheme: "file" },
        { language: "terraform", scheme: "untitled" }
      ],
      editProvider,
      10
    );
  }

  registerFormatter();

  context.subscriptions.push(
    commands.registerCommand("tf.formatFile", async () => {
      const document = await workspace.document;
      const languageId = document.filetype;

      if (languageId !== "terraform") {
        return workspace.showMessage(
          `${languageId} not supported by tf`,
          "error"
        );
      }

      // FINISH THIS PART
    })
  );
};
