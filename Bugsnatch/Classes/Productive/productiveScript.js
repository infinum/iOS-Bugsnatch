var timeout;

function checkDOMChange() {
    let editorEl = document.querySelector(`.modal-container trix-editor`);

    if (editorEl && editorEl.editor) {
        populateBugText(editorEl.editor);
    } else {
        timeout = setTimeout(checkDOMChange, 200);
    }
}

checkDOMChange();

function populateBugText(editor) {
    editor.insertString(`%@`);
}
